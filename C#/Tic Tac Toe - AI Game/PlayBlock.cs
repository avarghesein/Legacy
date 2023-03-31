using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;

namespace TicTacToe
{
    public partial class PlayBlock : UserControl
    {
        public PlayBlock()
        {
            InitializeComponent();
        }

        private Color m_BlockColor = Color.Black;    

        [Browsable(true)]  
        public Color BlockColor
        {
            set { m_BlockColor = value; }
            get { return m_BlockColor; } 
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            base.OnPaint(e);
            if (Parent != null) BackColor = Parent.BackColor;  
            e.Graphics.FillEllipse(new SolidBrush(m_BlockColor), (float)(0+2), (float)(0+2), (float)(Width - 6), (float)(Height - 6));
        }       
    };
};
