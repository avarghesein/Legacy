using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace TicTacToe
{
    static class Program
    {
        /// <summary>
        /// WHITE COINS = PLAYER
        /// BLACK COINS = COMPUTER
        /// 
        /// May the color of the coins in the GUI is different from black or white,
        /// left side is the player side and right side is the computer side
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new TicTacToeBoard(MessageBox.Show("First Move White?", "Confirm!", MessageBoxButtons.YesNo) == DialogResult.Yes));
        }
    };
};