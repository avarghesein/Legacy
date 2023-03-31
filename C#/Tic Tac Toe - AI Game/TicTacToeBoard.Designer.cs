namespace TicTacToe
{
    partial class TicTacToeBoard
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.pnlVerticalMain = new System.Windows.Forms.SplitContainer();
            this.pnlBlocksWhite = new System.Windows.Forms.FlowLayoutPanel();
            this.pnlVerticalSub = new System.Windows.Forms.SplitContainer();
            this.pnlBoard = new System.Windows.Forms.FlowLayoutPanel();
            this.pnlBlocksBlack = new System.Windows.Forms.FlowLayoutPanel();
            this.WhiteBlock0 = new TicTacToe.PlayBlock();
            this.WhiteBlock1 = new TicTacToe.PlayBlock();
            this.WhiteBlock2 = new TicTacToe.PlayBlock();
            this.Board00 = new TicTacToe.PlaceBlock();
            this.Board01 = new TicTacToe.PlaceBlock();
            this.Board02 = new TicTacToe.PlaceBlock();
            this.Board10 = new TicTacToe.PlaceBlock();
            this.Board11 = new TicTacToe.PlaceBlock();
            this.Board12 = new TicTacToe.PlaceBlock();
            this.Board20 = new TicTacToe.PlaceBlock();
            this.Board21 = new TicTacToe.PlaceBlock();
            this.Board22 = new TicTacToe.PlaceBlock();
            this.BlackBlock0 = new TicTacToe.PlayBlock();
            this.BlackBlock1 = new TicTacToe.PlayBlock();
            this.BlackBlock2 = new TicTacToe.PlayBlock();
            this.pnlVerticalMain.Panel1.SuspendLayout();
            this.pnlVerticalMain.Panel2.SuspendLayout();
            this.pnlVerticalMain.SuspendLayout();
            this.pnlBlocksWhite.SuspendLayout();
            this.pnlVerticalSub.Panel1.SuspendLayout();
            this.pnlVerticalSub.Panel2.SuspendLayout();
            this.pnlVerticalSub.SuspendLayout();
            this.pnlBoard.SuspendLayout();
            this.pnlBlocksBlack.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlVerticalMain
            // 
            this.pnlVerticalMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlVerticalMain.Location = new System.Drawing.Point(0, 0);
            this.pnlVerticalMain.Name = "pnlVerticalMain";
            // 
            // pnlVerticalMain.Panel1
            // 
            this.pnlVerticalMain.Panel1.Controls.Add(this.pnlBlocksWhite);
            // 
            // pnlVerticalMain.Panel2
            // 
            this.pnlVerticalMain.Panel2.Controls.Add(this.pnlVerticalSub);
            this.pnlVerticalMain.Size = new System.Drawing.Size(429, 283);
            this.pnlVerticalMain.SplitterDistance = 55;
            this.pnlVerticalMain.TabIndex = 0;
            // 
            // pnlBlocksWhite
            // 
            this.pnlBlocksWhite.Controls.Add(this.WhiteBlock0);
            this.pnlBlocksWhite.Controls.Add(this.WhiteBlock1);
            this.pnlBlocksWhite.Controls.Add(this.WhiteBlock2);
            this.pnlBlocksWhite.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlBlocksWhite.Location = new System.Drawing.Point(0, 0);
            this.pnlBlocksWhite.Name = "pnlBlocksWhite";
            this.pnlBlocksWhite.Size = new System.Drawing.Size(55, 283);
            this.pnlBlocksWhite.TabIndex = 0;
            // 
            // pnlVerticalSub
            // 
            this.pnlVerticalSub.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlVerticalSub.Location = new System.Drawing.Point(0, 0);
            this.pnlVerticalSub.Name = "pnlVerticalSub";
            // 
            // pnlVerticalSub.Panel1
            // 
            this.pnlVerticalSub.Panel1.Controls.Add(this.pnlBoard);
            // 
            // pnlVerticalSub.Panel2
            // 
            this.pnlVerticalSub.Panel2.Controls.Add(this.pnlBlocksBlack);
            this.pnlVerticalSub.Size = new System.Drawing.Size(370, 283);
            this.pnlVerticalSub.SplitterDistance = 311;
            this.pnlVerticalSub.TabIndex = 0;
            // 
            // pnlBoard
            // 
            this.pnlBoard.Controls.Add(this.Board00);
            this.pnlBoard.Controls.Add(this.Board01);
            this.pnlBoard.Controls.Add(this.Board02);
            this.pnlBoard.Controls.Add(this.Board10);
            this.pnlBoard.Controls.Add(this.Board11);
            this.pnlBoard.Controls.Add(this.Board12);
            this.pnlBoard.Controls.Add(this.Board20);
            this.pnlBoard.Controls.Add(this.Board21);
            this.pnlBoard.Controls.Add(this.Board22);
            this.pnlBoard.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlBoard.Location = new System.Drawing.Point(0, 0);
            this.pnlBoard.Name = "pnlBoard";
            this.pnlBoard.Size = new System.Drawing.Size(311, 283);
            this.pnlBoard.TabIndex = 0;
            // 
            // pnlBlocksBlack
            // 
            this.pnlBlocksBlack.Controls.Add(this.BlackBlock0);
            this.pnlBlocksBlack.Controls.Add(this.BlackBlock1);
            this.pnlBlocksBlack.Controls.Add(this.BlackBlock2);
            this.pnlBlocksBlack.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlBlocksBlack.Location = new System.Drawing.Point(0, 0);
            this.pnlBlocksBlack.Name = "pnlBlocksBlack";
            this.pnlBlocksBlack.Size = new System.Drawing.Size(55, 283);
            this.pnlBlocksBlack.TabIndex = 1;
            // 
            // WhiteBlock0
            // 
            this.WhiteBlock0.BackColor = System.Drawing.SystemColors.Control;
            this.WhiteBlock0.BlockColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.WhiteBlock0.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.WhiteBlock0.Location = new System.Drawing.Point(3, 3);
            this.WhiteBlock0.Name = "WhiteBlock0";
            this.WhiteBlock0.Size = new System.Drawing.Size(50, 43);
            this.WhiteBlock0.TabIndex = 0;
            this.WhiteBlock0.Tag = "W0";
            this.WhiteBlock0.MouseDown += new System.Windows.Forms.MouseEventHandler(this.PlayBlock_MouseDown);
            // 
            // WhiteBlock1
            // 
            this.WhiteBlock1.BackColor = System.Drawing.SystemColors.Control;
            this.WhiteBlock1.BlockColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.WhiteBlock1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.WhiteBlock1.Location = new System.Drawing.Point(3, 52);
            this.WhiteBlock1.Name = "WhiteBlock1";
            this.WhiteBlock1.Size = new System.Drawing.Size(50, 43);
            this.WhiteBlock1.TabIndex = 1;
            this.WhiteBlock1.Tag = "W1";
            this.WhiteBlock1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.PlayBlock_MouseDown);
            // 
            // WhiteBlock2
            // 
            this.WhiteBlock2.BackColor = System.Drawing.SystemColors.Control;
            this.WhiteBlock2.BlockColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.WhiteBlock2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.WhiteBlock2.Location = new System.Drawing.Point(3, 101);
            this.WhiteBlock2.Name = "WhiteBlock2";
            this.WhiteBlock2.Size = new System.Drawing.Size(50, 43);
            this.WhiteBlock2.TabIndex = 2;
            this.WhiteBlock2.Tag = "W2";
            this.WhiteBlock2.MouseDown += new System.Windows.Forms.MouseEventHandler(this.PlayBlock_MouseDown);
            // 
            // Board00
            // 
            this.Board00.AllowDrop = true;
            this.Board00.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board00.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board00.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board00.Location = new System.Drawing.Point(3, 3);
            this.Board00.Name = "Board00";
            this.Board00.Size = new System.Drawing.Size(97, 87);
            this.Board00.TabIndex = 0;
            this.Board00.Tag = "0,0";
            this.Board00.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board00.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // Board01
            // 
            this.Board01.AllowDrop = true;
            this.Board01.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board01.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board01.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board01.Location = new System.Drawing.Point(106, 3);
            this.Board01.Name = "Board01";
            this.Board01.Size = new System.Drawing.Size(97, 87);
            this.Board01.TabIndex = 1;
            this.Board01.Tag = "0,1";
            this.Board01.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board01.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // Board02
            // 
            this.Board02.AllowDrop = true;
            this.Board02.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board02.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board02.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board02.Location = new System.Drawing.Point(209, 3);
            this.Board02.Name = "Board02";
            this.Board02.Size = new System.Drawing.Size(97, 87);
            this.Board02.TabIndex = 2;
            this.Board02.Tag = "0,2";
            this.Board02.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board02.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // Board10
            // 
            this.Board10.AllowDrop = true;
            this.Board10.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board10.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board10.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board10.Location = new System.Drawing.Point(3, 96);
            this.Board10.Name = "Board10";
            this.Board10.Size = new System.Drawing.Size(97, 87);
            this.Board10.TabIndex = 3;
            this.Board10.Tag = "1,0";
            this.Board10.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board10.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // Board11
            // 
            this.Board11.AllowDrop = true;
            this.Board11.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board11.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board11.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board11.Location = new System.Drawing.Point(106, 96);
            this.Board11.Name = "Board11";
            this.Board11.Size = new System.Drawing.Size(97, 87);
            this.Board11.TabIndex = 4;
            this.Board11.Tag = "1,1";
            this.Board11.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board11.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // Board12
            // 
            this.Board12.AllowDrop = true;
            this.Board12.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board12.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board12.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board12.Location = new System.Drawing.Point(209, 96);
            this.Board12.Name = "Board12";
            this.Board12.Size = new System.Drawing.Size(97, 87);
            this.Board12.TabIndex = 5;
            this.Board12.Tag = "1,2";
            this.Board12.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board12.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // Board20
            // 
            this.Board20.AllowDrop = true;
            this.Board20.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board20.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board20.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board20.Location = new System.Drawing.Point(3, 189);
            this.Board20.Name = "Board20";
            this.Board20.Size = new System.Drawing.Size(97, 87);
            this.Board20.TabIndex = 6;
            this.Board20.Tag = "2,0";
            this.Board20.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board20.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // Board21
            // 
            this.Board21.AllowDrop = true;
            this.Board21.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board21.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board21.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board21.Location = new System.Drawing.Point(106, 189);
            this.Board21.Name = "Board21";
            this.Board21.Size = new System.Drawing.Size(97, 87);
            this.Board21.TabIndex = 7;
            this.Board21.Tag = "2,1";
            this.Board21.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board21.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // Board22
            // 
            this.Board22.AllowDrop = true;
            this.Board22.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Board22.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Board22.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Board22.Location = new System.Drawing.Point(209, 189);
            this.Board22.Name = "Board22";
            this.Board22.Size = new System.Drawing.Size(97, 87);
            this.Board22.TabIndex = 8;
            this.Board22.Tag = "2,2";
            this.Board22.DragDrop += new System.Windows.Forms.DragEventHandler(this.Board_DragDrop);
            this.Board22.DragEnter += new System.Windows.Forms.DragEventHandler(this.Board_DragEnter);
            // 
            // BlackBlock0
            // 
            this.BlackBlock0.BackColor = System.Drawing.SystemColors.Control;
            this.BlackBlock0.BlockColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.BlackBlock0.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BlackBlock0.Location = new System.Drawing.Point(3, 3);
            this.BlackBlock0.Name = "BlackBlock0";
            this.BlackBlock0.Size = new System.Drawing.Size(50, 43);
            this.BlackBlock0.TabIndex = 3;
            this.BlackBlock0.Tag = "B0";
            this.BlackBlock0.MouseDown += new System.Windows.Forms.MouseEventHandler(this.PlayBlock_MouseDown);
            // 
            // BlackBlock1
            // 
            this.BlackBlock1.BackColor = System.Drawing.SystemColors.Control;
            this.BlackBlock1.BlockColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.BlackBlock1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BlackBlock1.Location = new System.Drawing.Point(3, 52);
            this.BlackBlock1.Name = "BlackBlock1";
            this.BlackBlock1.Size = new System.Drawing.Size(50, 43);
            this.BlackBlock1.TabIndex = 4;
            this.BlackBlock1.Tag = "B1";
            this.BlackBlock1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.PlayBlock_MouseDown);
            // 
            // BlackBlock2
            // 
            this.BlackBlock2.BackColor = System.Drawing.SystemColors.Control;
            this.BlackBlock2.BlockColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.BlackBlock2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BlackBlock2.Location = new System.Drawing.Point(3, 101);
            this.BlackBlock2.Name = "BlackBlock2";
            this.BlackBlock2.Size = new System.Drawing.Size(50, 43);
            this.BlackBlock2.TabIndex = 5;
            this.BlackBlock2.Tag = "B2";
            this.BlackBlock2.MouseDown += new System.Windows.Forms.MouseEventHandler(this.PlayBlock_MouseDown);
            // 
            // TicTacToeBoard
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(429, 283);
            this.Controls.Add(this.pnlVerticalMain);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "TicTacToeBoard";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Tic Tac Toe";
            this.pnlVerticalMain.Panel1.ResumeLayout(false);
            this.pnlVerticalMain.Panel2.ResumeLayout(false);
            this.pnlVerticalMain.ResumeLayout(false);
            this.pnlBlocksWhite.ResumeLayout(false);
            this.pnlVerticalSub.Panel1.ResumeLayout(false);
            this.pnlVerticalSub.Panel2.ResumeLayout(false);
            this.pnlVerticalSub.ResumeLayout(false);
            this.pnlBoard.ResumeLayout(false);
            this.pnlBlocksBlack.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.SplitContainer pnlVerticalMain;
        private System.Windows.Forms.SplitContainer pnlVerticalSub;
        private System.Windows.Forms.FlowLayoutPanel pnlBoard;
        private System.Windows.Forms.FlowLayoutPanel pnlBlocksWhite;
        private PlaceBlock Board00;
        private PlaceBlock Board01;
        private PlaceBlock Board02;
        private PlaceBlock Board10;
        private PlaceBlock Board11;
        private PlaceBlock Board12;
        private PlaceBlock Board20;
        private PlaceBlock Board21;
        private PlaceBlock Board22;
        private System.Windows.Forms.FlowLayoutPanel pnlBlocksBlack;
        private PlayBlock WhiteBlock0;
        private PlayBlock WhiteBlock1;
        private PlayBlock WhiteBlock2;
        private PlayBlock BlackBlock0;
        private PlayBlock BlackBlock1;
        private PlayBlock BlackBlock2;

    }
}

