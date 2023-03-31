using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.Data; 

namespace TicTacToeAI
{
    /// <summary>
    /// Data Structure used to specify a Board Transformation occured by a move [black/white]
    /// contains both the board states and the move occured, this is used to represent data 
    /// in the database
    /// </summary>
    /// 
    public struct EDBState
    {
        /// <summary>
        /// Board state before move
        /// </summary>
        public uint SrcState;
        /// <summary>
        /// Board state after move
        /// </summary>
        public uint TarState;
        /// <summary>
        /// Is White or black moved
        /// </summary>
        public bool IsWhiteMoved;

        public override bool Equals(object obj)
        {
            EDBState other = (EDBState)obj;
            return SrcState == other.SrcState && TarState == other.TarState && IsWhiteMoved == other.IsWhiteMoved;
        }

        public static bool operator ==(EDBState State1, EDBState State2)
        {
            return State1.Equals(State2);
        }


        public static bool operator !=(EDBState State1, EDBState State2)
        {
            return !State1.Equals(State2);
        }
    };

    public class ApplicationLogic
    {
        /// <summary>
        /// finds all symmetric moves for a given move, and adds to the list of states,
        /// if you have a board state, 4 symmetric state can be find, this intellect is 
        /// used for teaching symmetric locations
        /// 
        /// We use points rotations to find the other 3 symmetric states, we rotate 3 times by 90,180,270
        /// degrees to a given board state...We first translate the origin to 1,1 so that rotation
        /// will be based on the centre point means 1,1
        /// </summary>
        /// <param name="State">the move occured</param>
        /// <param name="ListOfStates">the list of states, to which the states to add</param>
        static public void AddAllSymmetricBoardStates(EDBState State,List<EDBState> ListOfStates)
        {
            int x = 0, y = 0, newX = 0, newY = 0, rotatedOffset = 0;
            int[] newSrcBoard = new int[9], newTarBoard = new int[9];
            int[] srcState = DecodeToBoardState(State.SrcState);
            int[] tarState = DecodeToBoardState(State.TarState);

            EDBState newRotatedState = new EDBState();
            const float RAD = (float)(3.141519F / 180.0F);

            newRotatedState.IsWhiteMoved = State.IsWhiteMoved;

            //add the state given
            ListOfStates.Add(State);
  
            //find the other 3 symmetric states
            for (int i = 1; i <= 3; ++i)
            {
                //rotate all locations to get the new board states
                for (int j = 0; j < 9; ++j)
                {
                    //create x,y from 1 dimmensional offset
                    CreateXYFromOffset(j, ref x, ref y);
                    //translate origin to 1,1
                    --x; --y;
                    //find the new rotated point by rotation formuls, newX = x * cos(angle) + y * sin(angle), newY = -x * sin(angle) + y * cos(angle)
                    newX = (int)(x * (int)Math.Round(Math.Cos((float)i * 90 * RAD), 0) + y * (int)Math.Round(Math.Sin((float)i * 90 * RAD), 0));
                    newY = (int)(-x * (int)Math.Round(Math.Sin((float)i * 90 * RAD),0) + y * (int)Math.Round(Math.Cos((float)i * 90 * RAD),0));
                    //translate origin back to 0,0
                    ++newX; ++newY;
                    //create 1 dimmensional offset from rotated x,y
                    CreateOffsetFromXY(newX, newY, ref rotatedOffset);
                    //update the rotated positions for both the rotated src and target board states
                    newSrcBoard[rotatedOffset] = srcState[j];
                    newTarBoard[rotatedOffset] = tarState[j];   
                }
                //convert board to uint representaions
                newRotatedState.SrcState = EncodeBoardState(newSrcBoard);
                newRotatedState.TarState = EncodeBoardState(newTarBoard);
                //add the rotated/symmetric states
                ListOfStates.Add(newRotatedState);  
            }
        }

        /// <summary>
        /// checks whether a given set of points defines a winning state or not
        /// all 3 must be rowwise, columwise or diagonally equal
        /// </summary>
        /// <param name="Points">points to check</param>
        /// <returns>true if the points defines a winning position, false otherwise</returns>
        static public bool IsWon(List<Point> Points)
        {
            if (Points.Count != 3) return false;            
            int prevRow = Points[0].X, prevCol = Points[0].Y, row, col;
            bool colEqual = true, rowEqual = true, digLeftEqual = prevRow == prevCol, digRightEqual = (prevRow + prevCol) == 2;
            for (int i = 1; i < Points.Count; ++i)
            {
                row = Points[i].X; col = Points[i].Y;
                if (row != prevRow) rowEqual = false;
                if (col != prevCol) colEqual = false;
                if (row != col) digLeftEqual = false;
                if ((row + col) != 2) digRightEqual = false;
                if (!(rowEqual || colEqual || digLeftEqual || digRightEqual)) break;     
            }
            return rowEqual || colEqual || digLeftEqual || digRightEqual;
        }
        
        /// <summary>
        /// checks whether any coins are out side the board or not
        /// </summary>
        /// <param name="BoardState">the state of the board to check</param>
        /// <param name="IsWhite">check white coins/black coins</param>
        /// <returns>true if any one of the coins out side, false else</returns>
        static public bool IsPlayBlockOutSide(int[] BoardState, bool IsWhite)
        {
            int count = 0;
            for (int i = 0; i < BoardState.Length; ++i)
            {
                if (BoardState[i] == (IsWhite ? 1 : 2)) ++count;
                if (count == 3) return false; 
            }
            return count != 3;
        }

        /// <summary>
        /// Returns the unoccupied spaces on the board in 1 dimmensionl represention
        /// </summary>
        /// <param name="Board">board to process</param>
        /// <returns>free spaces on the board</returns>
        static public int[] GetFreeSpaces(int[] Board)
        {
            List<int> free = new List<int>();  
            for (int i = 0; i < Board.Length; ++i) if(Board[i] == 0) free.Add(i);
            int[] freeLocs = new int[free.Count];
            free.CopyTo(freeLocs);
            return freeLocs; 
        }

        /// <summary>
        /// Find out the coin locations for a given color on the board
        /// </summary>
        /// <param name="Board">the board state</param>
        /// <param name="IsWhite">find white coins or black</param>
        /// <returns>the coin locations on the board in 1 dimm offset</returns>
        static public int[] GetPlayBlockLocations(int[] Board, bool IsWhite)
        {
            List<int> locations = new List<int>();
            for (int i = 0; i < Board.Length; ++i) if (Board[i] == (IsWhite ? 1 : 2)) locations.Add(i);
            int[] locs = new int[locations.Count];
            locations.CopyTo(locs);
            return locs;
        }

        /// <summary>
        /// Finds out the locations of other coins, given a set of coins, for a specific color
        /// </summary>
        /// <param name="IsWhite">white coins or black</param>
        /// <param name="Board">the board state</param>
        /// <param name="CoinLocations">the coin locations as 1 dimm offset, so that 
        /// the locations of the other coins of the 
        /// same color to find</param>
        /// <returns></returns>
        static public int[] GetLocationOfNextCoins(bool IsWhite,int[] Board, params int[] CoinLocations)
        {
            List<int> locations = new List<int>(3 - CoinLocations.Length);
            for (int i = 1; i <= 3 - CoinLocations.Length; ++i) locations.Add(-1);
            int k = -1;
            for (int i = 0; i < Board.Length; ++i)
            {
                if(Board[i] == (IsWhite ? 1 : 2))
                {
                    bool flg = false; 
                    foreach (int j in CoinLocations)
                        if (i == j)
                        {
                            flg = true;
                            break;
                        }
                    if (!flg) locations[++k] = i;   
                }
            }
            int[] locs = new int[locations.Count];
            locations.CopyTo(locs);
            return locs;
        }

        /// <summary>
        /// checks whether a given move from a source position [in 1 dimm form] to a
        /// target position [in x,y] form is valid, if valid returns that board state
        /// in encoded form, else 0
        /// </summary>
        /// <param name="SrcOffset">the source state in 1 dimm form</param>
        /// <param name="DstX">target cell's x pos</param>
        /// <param name="DstY">targets cell's y pos</param>
        /// <param name="Board">the present board state</param>
        /// <param name="IsWhite">is white coin moved/ false for black coin</param>
        /// <returns>the target state</returns>
        static public uint NextMove(int SrcOffset,int DstX, int DstY, int[] Board,bool IsWhite)
        {
            int dstOffset = 0;
            CreateOffsetFromXY(DstX, DstY, ref dstOffset);
            if (IsValidMove(SrcOffset, dstOffset, IsWhite, Board))
            {
                if (SrcOffset >= 0) Board[SrcOffset] = 0;
                Board[dstOffset] = IsWhite ? 1 : 2;
                return EncodeBoardState(Board);
            }
            return 0;
        }

        /// <summary>
        /// Supportive function for 'CanWinOrBlockInOneMove
        /// </summary>
        /// <param name="ToWin">check for winning or blocking</param>
        /// <param name="IsWhite">white coins or black</param>
        /// <param name="Board">the board state</param>
        /// <param name="I1">No significance for a blocking movement.
        /// The x pos of the coin, exclude from the search, for a winning check</param>
        /// <param name="I2">No significance for a blocking movement.
        /// The y pos of the coin, exclude from the search, for a winning check</param>
        /// <returns>enumerable collections of positions in 1 dimm form</returns>
        static public IEnumerable<int> GetNextLocations(bool ToWin,bool IsWhite,int[] Board,int I1,int I2)
        {
            if (ToWin)
            {
                //only return the coin other than the coins specified, since they already in the same row,col or diagonal
                int[] playBlockLocs = GetPlayBlockLocations(Board, IsWhite);
                int nextLoc = GetLocationOfNextCoins(IsWhite, Board, playBlockLocs[I1], playBlockLocs[I2])[0];
                yield return nextLoc;
            }
            else
            {
                //return all the coin locations, since we can block the opponent with any one of our coin
                int[] playBlockLocs = GetPlayBlockLocations(Board, !IsWhite);
                for (int i = 0; i < playBlockLocs.Length; ++i)
                {
                    yield return playBlockLocs[i];  
                }
                for (int i = 1; i <= 3 - playBlockLocs.Length; ++i) yield return -1;    
            }
        }

        /// <summary>
        /// 2 purpose function, used to find whether the computer can win in the next move
        /// [black color], means it checks whether any 2 coins are in the same row,col or 
        /// diagonal. If so it checks whether the other coin can move the the other location
        /// so that 3 coins are in the same row,col or diagonal.....
        /// 
        /// the same fun can also used to check whether the opponent can win in the next move
        /// if so checks whether the computer can block the winning by moving one of it coins
        /// to block the opponents winning move
        /// </summary>
        /// <param name="IsWhite">true for process white coins</param>
        /// <param name="Board">present board state</param>
        /// <param name="ToWin">true for checking chance for winning, false for
        /// checking whether the opponent has chance to win and if so try find
        /// a blocking movement</param>
        /// <returns></returns>
        static public uint CanWinOrBlockInOneMove(bool IsWhite, int[] Board,bool ToWin)
        {
            int[] NewBoard = new int[Board.Length]; Board.CopyTo(NewBoard,0);
     
            int[] playBlockLocs = GetPlayBlockLocations(Board, IsWhite);
            if (playBlockLocs.Length < 2) return 0;

            //two FOR loops, for iterating all combinations of two coins of the specified color
            for (int i = 0; i < playBlockLocs.Length;++i)
            {
                for (int j = i + 1; j < playBlockLocs.Length;++j)
                {
                    uint nextState = 0;
                    int x0 = 0, x1 = 0, y0 = 0, y1 = 0;
                    CreateXYFromOffset(playBlockLocs[i], ref x0, ref y0);
                    CreateXYFromOffset(playBlockLocs[j], ref x1, ref y1);
                    //if rows of the coins are equal fing the other column in the same row
                    if (x0 == x1) //rows equal
                    {
                        foreach(int nextLoc in GetNextLocations(ToWin,IsWhite,NewBoard,i,j))
                        {
                            nextState = NextMove(nextLoc, x0, 3 - (y0 + y1), NewBoard, ToWin ? IsWhite : !IsWhite);
                            if (nextState > 0) return nextState;                              
                        }
                    }
                    //if columns are equal for the two coins find the other row in the same column
                    if (y0 == y1) //cols equal
                    {
                        foreach (int nextLoc in GetNextLocations(ToWin, IsWhite, NewBoard, i, j))
                        {
                            nextState = NextMove(nextLoc, 3 - (x0 + x1), y0, NewBoard, ToWin ? IsWhite : !IsWhite);
                            if (nextState > 0) return nextState;
                        }
                    }
                    //if diagonals are equal for the two coins, find the other cell in that diagonal
                    if ( (x0 == y0 && x1 == y1) || (x0 + y0 == 2 && x1 + y1 == 2)) //left or right diagnals equal
                    {
                        foreach (int nextLoc in GetNextLocations(ToWin, IsWhite, NewBoard, i, j))
                        {
                            nextState = NextMove(nextLoc, 3 - (x0 + x1), 3 - (y0 + y1), NewBoard, ToWin ? IsWhite : !IsWhite);
                            if (nextState > 0) return nextState;
                        }
                    }
                }
            }
            return 0;    
        }

        /// <summary>
        /// checks whether the board state is a winning state for a specified color
        /// </summary>
        /// <param name="BoardState">the board state to check</param>
        /// <param name="IsWhite">white or black to check</param>
        /// <returns>true if won , false if else</returns>
        static public bool IsWon(int[] BoardState, ref bool IsWhite)
        {
            List<Point> whitePoints = new List<Point>();
            List<Point> blackPoints = new List<Point>();
            int x = 0, y = 0;
            for (int i = 0; i < BoardState.Length; ++i)
            {
                if (BoardState[i] > 0)
                {
                    CreateXYFromOffset(i, ref x, ref y);
                    ((List<Point>)(BoardState[i] == 1 ? whitePoints : blackPoints)).Add(new Point(x, y));   
                }
            }
            if (IsWon(whitePoints))
            {
                IsWhite = true;
                return true; 
            }
            IsWhite = false;
            return IsWon(blackPoints);  
        }

        /// <summary>
        /// finds out the movable locations from any given point in the
        /// board, x,y
        /// </summary>
        /// <param name="X">the given x pos</param>
        /// <param name="Y">the given y pos</param>
        /// <returns>points to which we can have valild moves from x,y</returns>
        static public Point[] AllowableLocations(int X, int Y)
        {
            List<Point> points = new List<Point>();     
            int tmpX, tmpY;
            for(int i = -1; i <= 1; ++i)
                for (int j = -1; j <= 1; ++j)
                {
                    if ((X + Y) % 2 == 1) if (i != 0 && j != 0) continue; 

                    tmpX = X + i;
                    tmpY = Y + j;
                    if (tmpX >= 0 && tmpY >= 0 && tmpX < 3 && tmpY < 3 && !(tmpX == X && tmpY == Y))
                    {
                        points.Add(new Point(tmpX, tmpY));     
                    }
                }

            Point[] retPoints = new Point[points.Count];
            points.CopyTo(retPoints);

            return retPoints; 
        }

        /// <summary>
        /// checks whether a move from a source pos to a target pos is valid or not
        /// </summary>
        /// <param name="SrcX">source x</param>
        /// <param name="SrcY">source y</param>
        /// <param name="DstX">destinaion x</param>
        /// <param name="DstY">destination y</param>
        /// <returns>true if valid</returns>
        static public bool ValidMove(int SrcX, int SrcY, int DstX, int DstY)
        {
            Point dstPoint = new Point(DstX, DstY);
            foreach (Point pt in AllowableLocations(SrcX, SrcY))
            {
                if (pt == dstPoint) return true;  
            }
            return false;
        }

        /// <summary>
        /// checks whether a move from a source pos in 1 dimm rep, to a destination 
        /// pos in 1 dimm rep is valid
        /// </summary>
        /// <param name="Src">src pos in 1 dimm rep</param>
        /// <param name="Dst">dst pos in 1 dimm rep</param>
        /// <param name="IsWhite">movin white coin or black coin</param>
        /// <param name="BoardState">the present state of the board</param>
        /// <returns>true if the move is valid</returns>
        static public bool IsValidMove(int Src, int Dst, bool IsWhite, int[] BoardState)
        {
            int mvdBlock = IsWhite ? 1 : 2;

            if (BoardState[Dst] > 0) return false;
            if (Src <= -1) return true;

            if (IsPlayBlockOutSide(BoardState, IsWhite) && Src >= 0) return false;   

            int srcX = 0, srcY = 0;
            int dstX = 0, dstY = 0;

            CreateXYFromOffset(Src, ref srcX, ref srcY);
            CreateXYFromOffset(Dst, ref dstX, ref dstY);
   
            return ValidMove(srcX, srcY, dstX, dstY);                 
        }

        static public bool CreateOffsetFromXY(int X, int Y, ref int Offset)
        {
            Offset = X * 3 + Y;
            return true; 
        }

        static public bool CreateXYFromOffset(int Offset, ref int X, ref int Y)
        {
            X = Offset / 3;
            Y = Offset % 3;
            return true;
        }

        /// <summary>
        /// encode the board state into a UINT
        /// </summary>
        /// <param name="BoardState"></param>
        /// <returns></returns>
        static public uint EncodeBoardState(int[] BoardState)
        {
            uint encodedState = 0x00000000;
            for (int i = 0; i < 3 * 3; ++i)
            {
                encodedState |= (((uint)BoardState[i]) << (i * 2)); 
            }
            return encodedState;
        }

        /// <summary>
        /// decode board state from UINT to int[]
        /// </summary>
        /// <param name="State"></param>
        /// <returns></returns>
        static public int[] DecodeToBoardState(uint State)
        {
            int[] board = new int[9];
            uint oneone = 0x00000003;
            for (int i = 0; i < 3 * 3; ++i)
            {
                board[i] = (int)((State & (oneone << (i * 2))) >> (i*2));
            }
            return board; 
        }

        /// <summary>
        /// Toggles a given state of the board, means black coins positions
        /// become white and vice versa...empty locations remains empty
        /// </summary>
        /// <param name="State"></param>
        /// <returns></returns>
        static public uint ToggleBoardState(uint State)
        {
            uint tmp, res = 0;
            for (int i = 0; i < 3 * 3; ++i)
            {
                tmp = (State >> (i * 2)) & 0x00000003;
                if (tmp != 0) tmp = ~tmp & 0x00000003;
                res |= tmp << (i * 2);
            }
            return res;
        }

        /// <summary>
        /// Supporting functions for 'ReturnNextBoardState'
        /// </summary>
        /// <param name="Rows"></param>
        /// <param name="Prob"></param>
        /// <returns></returns>
        static public uint GetNewStateByProb(DataRow[] Rows, float Prob)
        {
            Prob = (float)Math.Round((double)Prob, 8); 
            foreach (DataRow row in Rows)
            {  
                float val = Convert.ToSingle(row["AVG_SUCCESS"]);
                val = (float)Math.Round((double)val, 8);
                if (Prob == val) return (uint)(int)row["NEW_STATE"];
            }
            return 0;
        }

        /// <summary>
        /// Supporting functions for 'ReturnNextBoardState'
        /// </summary>
        /// <param name="CurrentState"></param>
        /// <param name="StateTable"></param>
        /// <param name="ExtraFilter"></param>
        /// <returns></returns>
        static public uint GetMaxProbNextState(uint CurrentState, DataTable StateTable,string ExtraFilter)
        {
            float prob = 0;
            try
            {
                prob = Convert.ToSingle(StateTable.Compute("MAX(AVG_SUCCESS)", "OLD_STATE = " + CurrentState + ExtraFilter));
            }
            catch { }

            return GetNewStateByProb(StateTable.Select("OLD_STATE = " + CurrentState + ExtraFilter), prob);

        }

        /// <summary>
        /// Core functions that calculates the next move to done, so that computer can win
        /// </summary>
        /// <param name="CurrentState">the current state of the board</param>
        /// <param name="StateTable">states already stored in the knowledge base</param>
        /// <returns>the encoded next state/move</returns>
        static public uint ReturnNextBoardState(uint CurrentState, DataTable StateTable)
        {
            uint retState = 0;
            int[] board = DecodeToBoardState(CurrentState);

            //if computer can win in next move, return the winning state
            retState = CanWinOrBlockInOneMove(false, board, true);  
            if (retState > 0) return retState;

            //if user is goin to win and computer can block that move, return that block state
            retState = CanWinOrBlockInOneMove(true, board, false);
            if (retState > 0) return retState;

            uint state = CurrentState;
            DataRow[] stateRows;
            List<uint> omittableStates = new List<uint>();  
            //fetch all the movemets from knowledge base, where the board state prior to move is same as the
            //current board statw
            stateRows = StateTable.Select("WHITE_MOVED = 2 AND OLD_STATE = " + state);
            if (stateRows.Length > 0)
            {
                foreach (DataRow row in stateRows)
                {
                    //checks whether any move is in the knowledge base, that having a average probability of success >= .75
                    //if so return that target state, else add that move to the list of moves to omit
                    if ((float.Parse(row["SUCCESS"].ToString()) / float.Parse(row["STATE_COUNT"].ToString())) <= 0.75)
                    {
                        omittableStates.Add((uint)(int)row["NEW_STATE"]); 
                        continue;
                    }
                    uint nextState = (uint)(int)row["NEW_STATE"];
                    return nextState;
                }
            }
            bool allIterated;
            //Any coin of the desired color is out side?
            if (IsPlayBlockOutSide(board, false))
            {
                allIterated = true;
                //omit any moves from the possible movements having probability <= .75 [already we build that
                //list above]
                foreach(int freeSpace in GetFreeSpaces(board))
                {
                    retState = (uint)(CurrentState | ((uint)0x00000002 << (2 * freeSpace)));
                    if (omittableStates.Count > 0 && omittableStates.Contains(retState)) continue;
                    allIterated = false;
                    break;
                }
                //if we have a untried move return it, else if we iterated all the moves and all are in omitable
                //list return the move having the highest probability of success
                return allIterated ? GetMaxProbNextState(CurrentState, StateTable, " AND WHITE_MOVED = 2") : retState; 
            }
            allIterated = true;
            int[] locs = GetPlayBlockLocations(board, false);
            bool breakOuter = false;
            //Two for loops for finding all the next available movements for all the coins of desired color
            foreach(int i in locs)
            {
                for (int j = 0; j < 3 * 3; ++j)
                {
                    if (i == j) continue;
                    board = DecodeToBoardState(CurrentState);
                    //checks this move is valid or not
                    if(IsValidMove(i,j,false,board))
                    {
                        board[i] = 0;
                        board[j] = 2;
                        retState = EncodeBoardState(board);
                        //omit any moves from the possible movements having probability <= .75 [already we build that
                        //list above]
                        if (omittableStates.Count > 0 && omittableStates.Contains(retState)) continue;
                        allIterated = false;
                        breakOuter = true;
                        break; 
                    }
                }
                if (breakOuter) break; 
            }
            //if we have a untried move return it, else if we iterated all the moves and all are in omitable
            //list return the move having the highest probability of success
            return allIterated ? GetMaxProbNextState(CurrentState, StateTable," AND WHITE_MOVED = 2") : retState; 
        }

        /// <summary>
        /// Eliminate duplicate states from a gamen, so that the list after
        /// processing will contain only unique states
        /// </summary>
        /// <param name="StateList">The board states in a game, to process</param>
        public static void EluminateDuplicatestates(List<EDBState> StateList)
        {
            int i = 0, j = 0;
            while (i < StateList.Count)
            {
                j = i + 1;
                while (j < StateList.Count)
                {
                    if (StateList[i] == StateList[j])
                    {
                        StateList.RemoveAt(j);
                    }
                    else ++j;
                }
                ++i;
            }
        }

        /// <summary>
        /// Computes success probability for movements in a given game represented by
        /// list of move states
        /// </summary>
        /// <param name="ForWinner">probability for winner</param>
        /// <param name="ForLooser">probability for looser</param>
        /// <param name="StateList">the list of distict board states in a game</param>
        public static void ComputeProbabilities(ref float ForWinner, ref float ForLooser, List<EDBState> StateList)
        {
            //More number of moves means the looser played pretty well and 
            //almost he played to the best...Less number of moves means looser 
            //played poor or may be winner played well....

            //so the logic is, Let if 'Y' be the number moves in the game and 'T' be the
            //maximum distict states for the board...T will be approx equal to 276 * 2
            //after doing some permutaions and combinations and eliminationg symmetric
            //board states

            //so probability for Looser  will be      L = -(1 - Y/T)
            //and probability for winner              W =  (1 - Y/T)

            //so you can see that if number of movements are more only a small value will be
            //subtracted from looser's success rate in the knowledge base and if number of 
            //movements are less a very high value get subtracted from looser's success rate
            //in the knowledge base

            //similarly if the number of movements are more only a very small value will be
            //added to the winners success rate in the knowledge base, since the looser 
            //played well and a very high value will get added to success rate in the knowledge base
            //if the number of movements are less and that may be because of winner's good moves
            ForLooser = (float)StateList.Count / (float)(276 * 2);
            ForLooser = -((float)1 - ForLooser);
            ForWinner = ForLooser * -1;
        }

    };
};
