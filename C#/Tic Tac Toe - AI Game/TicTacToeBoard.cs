using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using TicTacToeDBLayer;
using TicTacToeAI; 

namespace TicTacToe
{
    public struct EMoveDetails
    {
        public UserControl SRC_CTRL;
        public UserControl TAR_CTRL;
        public UserControl BLOCK_CTRL;

        public int SRC;
        public int TAR;

        public int BLOCK;
        public bool IsWhite;
    };

    public partial class TicTacToeBoard : Form
    {
        private EMoveDetails m_eDetails,m_ePrevDetails;
        private int[] m_BoardState;
        private List<EDBState> m_StateList;
        EDBState m_NewState;

        private bool m_MoveWhiteFirst;

        public TicTacToeBoard(bool MoveWhiteFirst)
        {
            InitializeComponent();
            m_MoveWhiteFirst = MoveWhiteFirst;
            Initialize();
        }

        /// <summary>
        /// returns the place block control, given its index
        /// ex if 5 is the 1 dimm index, it is the 1,2 th block
        /// </summary>
        /// <param name="Offset">offset of the control, 1 dimm index</param>
        /// <returns>the control</returns>
        private UserControl GetPlaceBlockFromOffset(int Offset)
        {
            int x = 0, y = 0;
            TicTacToeAI.ApplicationLogic.CreateXYFromOffset(Offset, ref x, ref y);
            return GetType().GetField(string.Format("Board{0}{1}", x, y), System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance).GetValue(this) as UserControl;        

        }

        /// <summary>
        /// returns the 1 dimm index of the control desired: ie
        /// returns 5 if (1,2)th cell is the control
        /// </summary>
        /// <param name="Ctrl">the control to check</param>
        /// <returns>the 1 dimm offset</returns>
        private int GetOffsetFromControl(UserControl Ctrl)
        {
            string[] xyVals = Ctrl.Tag.ToString().Trim().Split(',');
            int x, y,offset = 0;
            x = int.Parse(xyVals[0]);
            y = int.Parse(xyVals[1]);
            TicTacToeAI.ApplicationLogic.CreateOffsetFromXY(x, y, ref offset);    
            return offset; 
        }

        private void PlayBlock_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                m_ePrevDetails = m_eDetails;
 
                PlayBlock ctrl = sender as PlayBlock;

                int mveBlock = ctrl.Tag.ToString().Trim().StartsWith("W", StringComparison.OrdinalIgnoreCase) ? 1 : 2;
                //create the structure for the current move
                if (mveBlock == m_eDetails.BLOCK) return;
                m_eDetails.BLOCK = mveBlock;
                m_eDetails.BLOCK_CTRL = ctrl;
                m_NewState.IsWhiteMoved = m_eDetails.IsWhite = m_eDetails.BLOCK == 1;
                m_NewState.SrcState = TicTacToeAI.ApplicationLogic.EncodeBoardState(m_BoardState);    
                m_eDetails.SRC_CTRL = ctrl.Parent as PlaceBlock;
                m_eDetails.SRC = -1;
                if (m_eDetails.SRC_CTRL != null) m_eDetails.SRC = GetOffsetFromControl(m_eDetails.SRC_CTRL); 
                m_eDetails.TAR = -1;
                m_eDetails.TAR_CTRL = null;
                //start drag
                ctrl.DoDragDrop(m_eDetails, DragDropEffects.Copy);
            }
        }

        private void Board_DragEnter(object sender, DragEventArgs e)
        {
            // If ALT is pressed
            if ((e.KeyState & 32) == 32)
            {
                // It shows a cursor with an arrow
                e.Effect = DragDropEffects.Link;
            }
            // If CTRL is pressed
            else if ((e.KeyState & 8) == 8)
            {
                // It shows a cursor with a plus sign
                e.Effect = DragDropEffects.Copy;
            }
            // If SHIFT is pressed
            else if ((e.KeyState & 4) == 4)
            {
                // It shows an unavailable cursor
                e.Effect = DragDropEffects.None;
            }
            // If neither one is pressed
            else
            {
                // It shows the rectangle
                e.Effect = DragDropEffects.Copy;
            }
        }

        /// <summary>
        /// recreates the board in GUI, given the board state
        /// </summary>
        /// <param name="BoardState">the bord state</param>
        private void ReCreateBoard(int[] BoardState)
        {             
            //clear the play board by moving blocks to the
            //left or right panel if present
            foreach (Control ctrl in pnlBoard.Controls)
            {
                if (ctrl is PlaceBlock)
                {
                    foreach (Control subCtrl in ctrl.Controls)
                    {
                        if (subCtrl is PlayBlock)
                        {
                            ctrl.Controls.Remove(subCtrl);
                            ((subCtrl.Tag.ToString().Trim().StartsWith("W", StringComparison.OrdinalIgnoreCase) ? pnlBlocksWhite : pnlBlocksBlack) as Panel).Controls.Add(subCtrl);       
                            break;
                        }
                    }
                }
            }

            //recreate the play board
            for (int i = 0; i < BoardState.Length; ++i)
            {
                UserControl ctrl = (BoardState[i] == 0 ? null : BoardState[i] == 1 ? pnlBlocksWhite.Controls[0] : pnlBlocksBlack.Controls[0]) as UserControl;
                if (ctrl != null)
                {
                    PlaceBlock newParent = GetPlaceBlockFromOffset(i) as PlaceBlock;
                    ctrl.Location = new Point((int)((newParent.Width - ctrl.Width) / 2.0), (int)((newParent.Height - ctrl.Height) / 2.0));
                    newParent.Controls.Add(ctrl);    
                }
            }
            
        }

        /// <summary>
        /// creates the board state from the GUI, state
        /// </summary>
        /// <returns></returns>
        private int[] CreateBoardState()
        {
            int[] board = new int[9];

            foreach (Control ctrl in pnlBoard.Controls)
            {
                if (ctrl is PlaceBlock)
                {
                    int offset = GetOffsetFromControl(ctrl as UserControl);
                    board[offset] = 0;
                    foreach (Control subCtrl in ctrl.Controls)
                    {
                        if (subCtrl is PlayBlock)
                        {
                            int mveBlock = subCtrl.Tag.ToString().Trim().StartsWith("W", StringComparison.OrdinalIgnoreCase) ? 1 : 2;
                            board[offset] = mveBlock;
                            break;
                        }
                    }
                }
            }
            return board;
        }

        private void UpdateBoardState(int Src, int Dst,bool IsWhite)
        {
            if(Src >= 0) m_BoardState[Src] = 0;
            if(Dst >= 0) m_BoardState[Dst] = IsWhite ? 1 : 2;  
        }

        private void Board_DragDrop(object sender, DragEventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;

            EMoveDetails ctrlDtls = (EMoveDetails)e.Data.GetData(typeof(EMoveDetails));

            UserControl target = sender as UserControl;

            m_eDetails.TAR_CTRL = target;
            if (m_eDetails.TAR_CTRL != null) m_eDetails.TAR = GetOffsetFromControl(m_eDetails.TAR_CTRL);

            bool isValidMove = false;

            if (e.Data.GetData(typeof(EMoveDetails)) != null)
            {
                //finish the move details
                if ((isValidMove = TicTacToeAI.ApplicationLogic.IsValidMove(m_eDetails.SRC, m_eDetails.TAR, m_eDetails.IsWhite, m_BoardState)) == true)
                {
                    UserControl srcCtrl = ctrlDtls.BLOCK_CTRL;
                    srcCtrl.Parent.Controls.Remove(srcCtrl);
                    srcCtrl.Location = new Point((int)((target.Width - srcCtrl.Width) / 2.0), (int)((target.Height - srcCtrl.Height) / 2.0));
                    target.Controls.Add(srcCtrl);
                    UpdateBoardState(m_eDetails.SRC, m_eDetails.TAR, m_eDetails.IsWhite);
                    m_NewState.TarState = TicTacToeAI.ApplicationLogic.EncodeBoardState(m_BoardState);
                    ApplicationLogic.AddAllSymmetricBoardStates(m_NewState, m_StateList);   
                    //m_StateList.Add(m_NewState);   
                }
                else
                {
                    m_eDetails = m_ePrevDetails; 
                }
            }
            
            if (!ProcessWinner())
            {
                MoveBlack(isValidMove);
            }

            Cursor.Current = Cursors.Default; 
        }

        private bool MoveBlack(bool IsPrevMoveValid)
        {
            if (IsPrevMoveValid && m_eDetails.IsWhite)
            {
                m_NewState.SrcState = TicTacToeAI.ApplicationLogic.EncodeBoardState(m_BoardState);
                DataTable linkTable = TicTacToeDBLayer.DBClass.StateLinkTable;
                uint nextState = TicTacToeAI.ApplicationLogic.ReturnNextBoardState(m_NewState.TarState, linkTable);
                m_BoardState = TicTacToeAI.ApplicationLogic.DecodeToBoardState(nextState);
                ReCreateBoard(m_BoardState);
                m_NewState.TarState = TicTacToeAI.ApplicationLogic.EncodeBoardState(m_BoardState);
                m_NewState.IsWhiteMoved = false;
                ApplicationLogic.AddAllSymmetricBoardStates(m_NewState, m_StateList);   
                //m_StateList.Add(m_NewState);

                if (!ProcessWinner()) m_eDetails.BLOCK = 2;
                return true;
            }
            return false;
        }

        private bool ProcessWinner()
        {
            bool isWhite = false;
            if (TicTacToeAI.ApplicationLogic.IsWon(m_BoardState, ref isWhite))
            {
                MessageBox.Show((isWhite ? "Red" : "Blue") + " Won!!!....\n\nCongrats");
                TicTacToeDBLayer.DBClass.AddStates(m_StateList, isWhite);
                Initialize();
                return true;
            }
            return false;
        }

        private void Initialize()
        {
            Cursor.Current = Cursors.WaitCursor;
   
            foreach (Control ctrl in pnlBoard.Controls)
            {
                if (ctrl is PlaceBlock)
                {
                    foreach (Control subCtrl in ctrl.Controls)
                    {
                        if (subCtrl is PlayBlock)
                        {
                            bool isWhite = subCtrl.Tag.ToString().Trim().StartsWith("W", StringComparison.OrdinalIgnoreCase);
                            ctrl.Controls.Remove(subCtrl);
                            ((isWhite ? pnlBlocksWhite : pnlBlocksBlack) as Panel).Controls.Add(subCtrl);       
                            break;
                        }
                    }
                }
            }
            m_StateList = new List<EDBState>();
            m_NewState = new EDBState();

            m_NewState.IsWhiteMoved = false;
            m_NewState.SrcState = 0;
            m_NewState.TarState = 0;  

            m_eDetails = new EMoveDetails();
            m_ePrevDetails = new EMoveDetails();
            m_ePrevDetails.BLOCK = m_eDetails.BLOCK = -1;
            m_ePrevDetails.IsWhite = m_eDetails.IsWhite = false;
            m_ePrevDetails.SRC = m_eDetails.SRC = -1;
            m_ePrevDetails.TAR = m_eDetails.TAR = -1;

            m_eDetails.BLOCK_CTRL = m_eDetails.SRC_CTRL = m_eDetails.TAR_CTRL = null;
            m_ePrevDetails.BLOCK_CTRL = m_ePrevDetails.SRC_CTRL = m_ePrevDetails.TAR_CTRL = null; 

            m_BoardState = CreateBoardState();

            if (!m_MoveWhiteFirst)
            {
                m_eDetails.IsWhite = true;
                MoveBlack(true); 
            }

            Cursor.Current = Cursors.Default; 
        }

    };
};