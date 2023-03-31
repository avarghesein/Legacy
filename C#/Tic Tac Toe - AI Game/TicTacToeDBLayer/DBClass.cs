using System;
using System.Collections.Generic;
using System.Text;
using System.Data.OleDb;
using System.Data;

using TicTacToeAI; 

namespace TicTacToeDBLayer
{
    /// <summary>
    /// Contains functions, to add,fetch, update data from the knowledge base [database]
    /// This the DB Layer for this project
    /// </summary>
    public class DBClass
    {
        private static OleDbConnection m_oCN = null;
        private static DataSet m_oDs = new DataSet();

        private static void CloseConnction()
        {
            try
            {
                m_oCN.Close(); ;
            }
            catch { }
        }

        private static bool OpenConnction()
        {
            try
            {
                if (m_oCN != null && m_oCN.State == ConnectionState.Open) return true;
  
                m_oCN = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=TicTacToeDBase.mdb;");
                m_oCN.Open();
                return true;
            }
            catch { return false; } 
        }

        /// <summary>
        /// Adds a new board state to the knowledge base
        /// </summary>
        /// <param name="Code">The new state code</param>
        /// <param name="Table">The data table also to update, to contain this state</param>
        private static void AddStateCode(uint Code,DataTable Table)
        {
            OleDbCommand cmd = new OleDbCommand("insert into BOARD_STATES(STATE_CODE) values (" + Code + ")", m_oCN);
            cmd.ExecuteNonQuery();
            if (Table != null)
            {
                Table.Rows.Add(Code);    
            }
        }

        /// <summary>
        /// Adds a new board state transition. ie. 2 board states and the move occured b/w them
        /// </summary>
        /// <param name="Src">The state before move</param>
        /// <param name="Tar">The state after move</param>
        /// <param name="Table">The datatable also to update, to contain the state link</param>
        /// <param name="WhiteMove">Specifies White moved or not?</param>
        private static void AddStateLink(uint Src, uint Tar, DataTable Table,bool WhiteMove)
        {
            try
            {
                OleDbCommand cmd = new OleDbCommand("insert into STATE_LINK(OLD_STATE,NEW_STATE,SUCCESS,WHITE_MOVED,STATE_COUNT) values (" + Src + "," + Tar + ",0," + (WhiteMove ? 1 : 2) + ",0)", m_oCN);
                cmd.ExecuteNonQuery();
                if (Table != null)
                {
                    Table.Rows.Add(Src, Tar, WhiteMove ? 1 : 2, 0,0);
                }
            }
            catch
            {
            }
        }

        /// <summary>
        /// Updates a State Transition information, Place where we add intelligence details
        /// </summary>
        /// <param name="Src">The state before move</param>
        /// <param name="Tar">The state after move</param>
        /// <param name="Table">The datatable also to update, to contain the state link updation</param>
        /// <param name="WhiteMoved">Specifies White moved or not?</param>
        /// <param name="SuccessProbability">
        /// The assumed success probability for this movement, We will also
        /// consider the number of times this state happened in different games played
        /// </param>
        private static void UpdateStateLink(uint Src, uint Tar, DataTable Table,bool WhiteMoved,float SuccessProbability)
        {
            OleDbCommand cmd = new OleDbCommand("UPDATE STATE_LINK SET STATE_COUNT = STATE_COUNT + 1, SUCCESS = SUCCESS + " + SuccessProbability + " WHERE OLD_STATE = " + Src + " AND NEW_STATE = " + Tar + " AND WHITE_MOVED = " + (WhiteMoved ? 1 : 2), m_oCN);
            //OleDbCommand cmd = new OleDbCommand("UPDATE STATE_LINK SET SUCCESS = SUCCESS + " + SuccessProbability + " WHERE OLD_STATE = " + Src + " AND NEW_STATE = " + Tar + " AND WHITE_MOVED = " + (WhiteMoved ? 1 : 2), m_oCN);
            cmd.ExecuteNonQuery();
            if (Table != null)
            {
                DataRow[] rows = Table.Select("WHITE_MOVED = " + (WhiteMoved ? 1 : 2) + "AND OLD_STATE = " + Src + " AND NEW_STATE = " + Tar);
                foreach (DataRow row in rows)
                {
                    row["SUCCESS"] = Convert.ToSingle(row["SUCCESS"]) + SuccessProbability;
                    row["STATE_COUNT"] = int.Parse(row["STATE_COUNT"].ToString()) + 1; 
                }
            }
        }

        /// <summary>
        /// Fetches the knowledge base details, into local datatables, for faster performance
        /// </summary>
        public static void FetchTables()
        {
            OleDbDataAdapter adapter = new OleDbDataAdapter();

            if (m_oDs == null || m_oDs.Tables["MAIN"] == null)
            {
                if (!OpenConnction()) return;
                if (m_oDs == null) m_oDs = new DataSet(); 
                adapter.SelectCommand = new OleDbCommand("SELECT STATE_CODE FROM BOARD_STATES", m_oCN);  
                adapter.Fill(m_oDs, "MAIN");
            }
            if (m_oDs == null || m_oDs.Tables["LINKS"] == null)
            {
                if (!OpenConnction()) return;
                if (m_oDs == null) m_oDs = new DataSet();
                adapter.SelectCommand = new OleDbCommand("SELECT OLD_STATE,NEW_STATE,WHITE_MOVED,SUCCESS,STATE_COUNT FROM STATE_LINK", m_oCN);
                adapter.Fill(m_oDs, "LINKS");
                //Add a field that calculates, average success...Total cumulative probability / Number of unique occurances for this state in games
                m_oDs.Tables["LINKS"].Columns.Add("AVG_SUCCESS", typeof(float), "SUCCESS/STATE_COUNT");  
            }
        }

        /// <summary>
        /// Returns the state transitions information from the knowledge base
        /// </summary>
        public static DataTable StateLinkTable
        {
            get
            {
                m_oDs = null; 
                FetchTables();
                return m_oDs.Tables["LINKS"];
            }
        }

        /// <summary>
        /// Add a board state to the knowledge base if it is not present there
        /// </summary>
        /// <param name="State">the board state to add</param>
        static private void AddStateCode(uint State)
        {
            DataSet ds = m_oDs;
            DataRow[] rowsSrc = ds.Tables["MAIN"].Select("STATE_CODE = " + State);
            if (rowsSrc.Length <= 0) AddStateCode(State, ds.Tables["MAIN"]);
        }

        /// <summary>
        /// Add a board transition to add to the knowledge base if it is not present
        /// </summary>
        /// <param name="Src">the state before move</param>
        /// <param name="Tar">the state after move</param>
        /// <param name="WhiteMove">is white moved? false for black movement</param>
        static private void AddStateLink(uint Src, uint Tar,bool WhiteMove)
        {
            DataRow[] rowsLink;
            DataSet ds = m_oDs;
            rowsLink = ds.Tables["LINKS"].Select("WHITE_MOVED = " + (WhiteMove ? 1 : 2) + " AND OLD_STATE = " + Src + " AND NEW_STATE = " + Tar);
            if (rowsLink.Length <= 0) AddStateLink(Src, Tar, ds.Tables["LINKS"], WhiteMove);
        }

        /// <summary>
        /// Adds different board states and board transitions to the knowledge base after a game is over
        /// , with probability of success computed for each transition
        /// </summary>
        /// <param name="StateList">the list contain the states in a game</param>
        /// <param name="IsWhiteWon">specifies whether white coins won, false for black won</param>
        public static void AddStates(List<EDBState> StateList,bool IsWhiteWon)
        {
            FetchTables();

            DataSet ds = m_oDs;

            try
            {
                ApplicationLogic.EluminateDuplicatestates(StateList);

                float P1ForDefeated = 0F,P2ForWinner = 0F;

                ApplicationLogic.ComputeProbabilities(ref P2ForWinner, ref P1ForDefeated, StateList); 

                float probForWhite = IsWhiteWon ? P2ForWinner : P1ForDefeated;   
                float probForBlack = !IsWhiteWon ? P2ForWinner : P1ForDefeated;   

                foreach (EDBState state in StateList)
                {
                    AddStateCode(state.SrcState);
                    AddStateCode(state.TarState);
                    AddStateCode(ApplicationLogic.ToggleBoardState(state.SrcState));
                    AddStateCode(ApplicationLogic.ToggleBoardState(state.TarState));

                    AddStateLink(state.SrcState, state.TarState, state.IsWhiteMoved);
                    AddStateLink(ApplicationLogic.ToggleBoardState(state.SrcState), ApplicationLogic.ToggleBoardState(state.TarState), !state.IsWhiteMoved);

                    UpdateStateLink(state.SrcState, state.TarState, ds.Tables["LINKS"], state.IsWhiteMoved, state.IsWhiteMoved ? probForWhite : probForBlack);
                    UpdateStateLink(ApplicationLogic.ToggleBoardState(state.SrcState), ApplicationLogic.ToggleBoardState(state.TarState), ds.Tables["LINKS"], !state.IsWhiteMoved, state.IsWhiteMoved ? probForWhite : probForBlack);
                }
            }
            catch { }
            CloseConnction();
        }
    };
};
