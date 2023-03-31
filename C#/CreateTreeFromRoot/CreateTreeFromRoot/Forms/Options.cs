using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace CreateTreeFromRoot
{
    public partial class Options : Form
    {
        public Options()
        {
            InitializeComponent();
        }

        public bool AlwaysOnTop
        {
            get
            {
                return chkAlwaysOnTop.Checked;
            }
            set
            {
                chkAlwaysOnTop.Checked = value;
            }
        }

        public EFilesOverwriteOptions FileOverWriteOptions
        {
            get
            {
                if (rdoOverwriteFiles.Checked) 
                    return EFilesOverwriteOptions.OverwriteFiles;
                if (rdoUnchangeFiles.Checked)
                    return EFilesOverwriteOptions.SkipFiles;
                return EFilesOverwriteOptions.ShowError;
            }
            set
            {
                if (value == EFilesOverwriteOptions.OverwriteFiles)
                    rdoOverwriteFiles.Checked = true;
                else 
                    if (value ==EFilesOverwriteOptions.SkipFiles)
                        rdoUnchangeFiles.Checked = true;
                    else
                        rdoShowError.Checked = true;
            }
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            Close();
        }
    };
};