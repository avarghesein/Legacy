using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Threading;


namespace CreateTreeFromRoot
{
    public partial class CreateTreeFromRoot : Form
    {
        /// <summary>
        /// This variable is for avoiding duplicate user confirmation for closing the form.
        /// If user presses the close button and confirmed, on form closing we dont need another
        /// verification.
        /// </summary>
        private bool m_CloseAlreadyConfirmed = false;

        /// <summary>
        /// Options dialog member
        /// </summary>
        private Options m_DlgOptions = new Options();

        /// <summary>
        /// This variable value can be used to check whether any active threads are running or not
        /// </summary>
        private Thread m_ActiveChildProcessingThread = null;
        

        public CreateTreeFromRoot()
        {
            InitializeComponent();
        }

        private void CreateTreeFromRoot_Load(object sender, EventArgs e)
        {
            stsBarLabel.Text = "Ready";
            CCreateTreeFromRoot.TreeCreationNotificationEvent += new TreeNotificationHandler(TreeNotificationCallBack);
            chkTakeRootDrive.Checked = true;
            btnCancelOperation.Enabled = false;
        }

        void TreeNotificationCallBack(ETreeNotifications NotificationType, int Value, string sMessage)
        {
            try
            {
                //If this function is called from a seperate thread, invoke the parent thread to update the UI
                if (InvokeRequired)
                {
                    BeginInvoke(new TreeNotificationHandler(TreeNotificationCallBack) as Delegate, NotificationType, Value, sMessage);
                    return;
                }

                switch (NotificationType)
                {
                    case ETreeNotifications.ProgressMaxCount:
                        stsBarProgressBar.Maximum = Value;
                        stsBarProgressBar.Value = 0;
                        stsBarLabel.Text = sMessage;
                        break;

                    case ETreeNotifications.ProgressUpdate:
                        stsBarProgressBar.Value = Value;
                        stsBarLabel.Text = sMessage;
                        break;

                    case ETreeNotifications.ProgressEnd:
                        stsBarProgressBar.Value = Value;
                        stsBar.Refresh();
                        stsBarProgressBar.Value = 0;
                        stsBarLabel.Text = "Ready";
                        break;

                    case ETreeNotifications.ProgressAborted:
                        stsBarProgressBar.Maximum = 100;
                        stsBarProgressBar.Value = 0;
                        stsBarLabel.Text = "Ready";
                        break;
                }
                stsBar.Refresh();
                return;
            }
            catch
            { }
        }

        private void chkTakeRootDrive_CheckedChanged(object sender, EventArgs e)
        {
            btnCalculateRootFromList.Enabled = txtRoot.Enabled =
            btnSelectRoot.Enabled = !chkTakeRootDrive.Checked;
        }

        private void btnSelectRoot_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog dlgFolder = new FolderBrowserDialog();
            dlgFolder.SelectedPath = txtRoot.Text;
            if ( dlgFolder.ShowDialog(this) == DialogResult.OK )
            {
                txtRoot.Text = dlgFolder.SelectedPath; 
            }
        }

        private void btnSelectTargetDir_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog dlgFolder = new FolderBrowserDialog();
            dlgFolder.SelectedPath = txtTargetDir.Text;
            if (dlgFolder.ShowDialog(this) == DialogResult.OK)
            {
                txtTargetDir.Text = dlgFolder.SelectedPath;
            }
        }

        private void btnSelectFolder_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog dlgFolder = new FolderBrowserDialog();
            dlgFolder.SelectedPath = txtFileFolderSelected.Text;
            if (dlgFolder.ShowDialog(this) == DialogResult.OK)
            {
                txtFileFolderSelected.Text = dlgFolder.SelectedPath;
            }
        }

        private void btnSelectFile_Click(object sender, EventArgs e)
        {
            OpenFileDialog dlgFile = new OpenFileDialog();
            dlgFile.Filter = "All Files (*.*)|*.*";
            dlgFile.FileName = txtFileFolderSelected.Text;
            if ( dlgFile.ShowDialog(this) == DialogResult.OK )
            {
                txtFileFolderSelected.Text = dlgFile.FileName;
            }
        }

        private void btnAddToList_Click(object sender, EventArgs e)
        {
            if (txtFileFolderSelected.Text == string.Empty)
            {
                MessageBox.Show("Please specify a File or Folder", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            string sPath = txtFileFolderSelected.Text;
            if (lstSelectedFilesOrFolders.Items.Contains(sPath))
            {
                MessageBox.Show("List of items already contains this File/Folder", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            lstSelectedFilesOrFolders.Items.Add(sPath);
        }

        private void btnDeleteSelection_Click(object sender, EventArgs e)
        {
            string[] sItemArray = new string[lstSelectedFilesOrFolders.SelectedItems.Count];
            lstSelectedFilesOrFolders.SelectedItems.CopyTo(sItemArray, 0);
            foreach (string sItem in sItemArray)
            {
                lstSelectedFilesOrFolders.Items.Remove(sItem);
            }
        }

        private void btnRemoveAll_Click(object sender, EventArgs e)
        {
            if (DialogResult.No == MessageBox.Show("This will clear all the items in the list\n" +
                "Are you sure to continue?", "Information", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
            {
                return;
            }
            lstSelectedFilesOrFolders.Items.Clear();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            if (DialogResult.No == MessageBox.Show("Are you sure to exit?", "Information",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question))
            {
                return;
            }
            m_CloseAlreadyConfirmed = true;
            Close();
        }     

        private void lstSelectedFilesOrFolders_DragEnter(object sender, DragEventArgs e)
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

        private void FileFolderName_DragDrop(object sender, DragEventArgs e)
        {
            IDataObject obj = e.Data;
            object[] objects = e.Data.GetData("FileNameW") as object[];
            if (null != objects && objects.Length > 0)
            {
                string sTmp = objects[0] as string;
                // If we have the target folder/root folder text boxes at hand, get the directory name, if user
                // dragged a file into the text box
                if (sender != txtFileFolderSelected)
                {
                    if (File.Exists(sTmp))
                    {
                        sTmp = Path.GetDirectoryName(sTmp);
                    }
                }
                (sender as TextBox).Text = sTmp;
            }
        }

        private void FileFolderName_DragEnter(object sender, DragEventArgs e)
        {
            lstSelectedFilesOrFolders_DragEnter(sender, e);
        }

        private void btnOptions_Click(object sender, EventArgs e)
        {
            m_DlgOptions.AlwaysOnTop = TopMost;
            m_DlgOptions.ShowDialog(this);
            TopMost = m_DlgOptions.AlwaysOnTop;
        }

        private delegate void AddItemToListDelegate(string sItem);

        private void AddItemToList(string sItem_i)
        {
            if (InvokeRequired)
            {
                Invoke(new AddItemToListDelegate(AddItemToList) as Delegate, sItem_i);
                return;
            }
            if (lstSelectedFilesOrFolders.Items.Contains(sItem_i))
            {
                return;
            }
            lstSelectedFilesOrFolders.Items.Add(sItem_i);
        }

        /// <summary>
        /// Thread procedure for handling drag drop on the list box
        /// </summary>
        /// <param name="Arg">IDataObject</param>
        private void DragDropOnListThreadProc(object Arg)
        {
            IDataObject obj = Arg as IDataObject;
            object[] objects = obj.GetData("FileDrop") as object[];
            if (null != objects && objects.Length > 0)
            {
                TreeNotificationCallBack(ETreeNotifications.ProgressMaxCount, objects.Length, "Start Drap Drop Operation...");
                string sTmp = txtFileFolderSelected.Text;
                for (int nIndex = 0; nIndex < objects.Length; ++nIndex)
                {
                    if (CCreateTreeFromRoot.CancelOperations)
                    {
                        break;
                    }
                    string sItem = objects[nIndex] as string;
                    AddItemToList(sItem);
                    if (0 == nIndex % 50)
                    {
                        TreeNotificationCallBack(ETreeNotifications.ProgressUpdate, nIndex + 1, "Processed " + sItem);
                    }
                }
                TreeNotificationCallBack(ETreeNotifications.ProgressEnd, objects.Length, "Drag Drop Operation Completed.");
            }
            EnableCancelOperation(false);
            m_ActiveChildProcessingThread = null;
        }

        private void lstSelectedFilesOrFolders_DragDrop(object sender, DragEventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            CCreateTreeFromRoot.CancelOperations = false;
            // Start the drag drop operation thread, so that user can cancel it
            m_ActiveChildProcessingThread = new Thread(new ParameterizedThreadStart(DragDropOnListThreadProc));
            m_ActiveChildProcessingThread.Start(e.Data);
            EnableCancelOperation(true);
            Cursor.Current = Cursors.Default;
        }

        /// <summary>
        /// Thread Procedure for calculating the root of the tree
        /// </summary>
        /// <param name="Arg">List<string></param>
        private void RootCalculationThreadProc(object Arg)
        {
            CCreateTreeFromRoot.CancelOperations = false;

            string sRoot = string.Empty;
            string sErr = string.Empty;
            List<string> PathList = Arg as List<string>;
            bool bSucc = CCreateTreeFromRoot.CommonRootFromPaths(PathList, ref sRoot, ref sErr);
            EnableCancelOperation(false);
            m_ActiveChildProcessingThread = null;
            if (bSucc)
            {
                BeginInvoke((EventHandler)delegate(object obj, EventArgs arg) { txtRoot.Text = obj.ToString(); } as Delegate, sRoot, null);
            }
            else
            {
                MessageBox.Show(sErr, "Error During Root Calculation!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }            
        }

        /// <summary>
        /// Thread Procedure for creating the tree
        /// </summary>
        /// <param name="Arg">Multvalues, See the invoke place of this thread</param>
        private void CreateTreeFormRootThreadProc(object Arg)
        {
            CCreateTreeFromRoot.CancelOperations = false;

            object[] Args = Arg as object[];

            string sErr = string.Empty;
            List<string> PathList = Args[0] as List<string>;
            string sRoot = Args[1] as string;
            string sTargetDir = Args[2] as string;

            CCreateTreeFromRoot.OverWriteTargetFiles = (EFilesOverwriteOptions)Args[3];
            bool bSucc = CCreateTreeFromRoot.CreateTreeFromRoot(PathList, sRoot, txtTargetDir.Text, ref sErr);
            EnableCancelOperation(false);
            m_ActiveChildProcessingThread = null;
            if (bSucc)
            {
                if (DialogResult.No == MessageBox.Show("Tree Creation Success...\nDo You want to check out it right now?", "Success: Tree Creation!!!", MessageBoxButtons.YesNo, MessageBoxIcon.Information))
                {
                    return;
                }
                System.Diagnostics.Process.Start("explorer.exe", "\"" + txtTargetDir.Text + "\"");
            }
            else
            {
                MessageBox.Show(sErr, "Error During Tree Creation", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }            
        }

        private void btnCalculateRootFromList_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;            
            List<string> PathList = new List<string>();
            foreach (string sItem in lstSelectedFilesOrFolders.Items)
            {
                PathList.Add( sItem ); 
            }            
            m_ActiveChildProcessingThread = new Thread(new ParameterizedThreadStart(RootCalculationThreadProc));
            m_ActiveChildProcessingThread.Start(PathList);
            EnableCancelOperation(true);
            Cursor.Current = Cursors.Default;
        }

        private void btnCreateTree_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            List<string> PathList = new List<string>();
            foreach (string sItem in lstSelectedFilesOrFolders.Items)
            {
                PathList.Add(sItem);
            }
            string sRoot = chkTakeRootDrive.Checked ? string.Empty : txtRoot.Text;                        
            m_ActiveChildProcessingThread = new Thread(new ParameterizedThreadStart(CreateTreeFormRootThreadProc));
            m_ActiveChildProcessingThread.Start(new object[] { PathList, sRoot, txtTargetDir.Text, m_DlgOptions.FileOverWriteOptions });
            EnableCancelOperation(true);
            Cursor.Current = Cursors.Default;
        }

        private void lstSelectedFilesOrFolders_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Delete)
            {
                btnDeleteSelection_Click(sender, e);
            }
        }

        private void CreateTreeFromRoot_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (m_ActiveChildProcessingThread != null)
            {
                e.Cancel = true;
                MessageBox.Show("You should cancel the current operation before exiting", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            if (m_CloseAlreadyConfirmed) return;

            if (DialogResult.No == MessageBox.Show("Are you sure to exit?", "Information",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question))
            {
                e.Cancel = true;
            }
        }

        private delegate void EnableOperationDelegate(bool bEnable);

        private void EnableCancelOperation(bool bEnableCancelOperation)
        {
            if (InvokeRequired)
            {
                BeginInvoke(new EnableOperationDelegate(EnableCancelOperation) as Delegate, bEnableCancelOperation);
                return;
            }

            if (bEnableCancelOperation)
            {
                foreach (Control ctrl in Controls)
                {
                    ctrl.Tag = ctrl.Enabled;
                    ctrl.Enabled = false;
                }
                btnCancelOperation.Enabled = true;
                stsBar.Enabled = true;
            }
            else
            {
                foreach (Control ctrl in Controls)
                {
                    if (ctrl.Tag != null)
                    {
                        ctrl.Enabled = (bool)ctrl.Tag;
                    }
                    else
                    {
                        ctrl.Enabled = true;
                    }
                }
                btnCancelOperation.Enabled = false;
                stsBar.Enabled = true;
            }
        }

        private void btnCancelOperation_Click(object sender, EventArgs e)
        {
            if (DialogResult.No == MessageBox.Show("Are you sure to cancel the operation?", "Warning",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question))
            {
                return;
            }
            CCreateTreeFromRoot.CancelOperations = true;
            btnCancelOperation.Enabled = false;
        }

    };
};