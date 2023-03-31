namespace CreateTreeFromRoot
{
    partial class CreateTreeFromRoot
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
            this.lblRootFolder = new System.Windows.Forms.Label();
            this.chkTakeRootDrive = new System.Windows.Forms.CheckBox();
            this.txtRoot = new System.Windows.Forms.TextBox();
            this.btnSelectRoot = new System.Windows.Forms.Button();
            this.btnSelectTargetDir = new System.Windows.Forms.Button();
            this.txtTargetDir = new System.Windows.Forms.TextBox();
            this.lblTargetDir = new System.Windows.Forms.Label();
            this.lblLine2 = new System.Windows.Forms.Label();
            this.btnSelectFile = new System.Windows.Forms.Button();
            this.txtFileFolderSelected = new System.Windows.Forms.TextBox();
            this.lblSelectFileFolder = new System.Windows.Forms.Label();
            this.btnSelectFolder = new System.Windows.Forms.Button();
            this.btnAddToList = new System.Windows.Forms.Button();
            this.lstSelectedFilesOrFolders = new System.Windows.Forms.ListBox();
            this.btnDeleteSelection = new System.Windows.Forms.Button();
            this.btnRemoveAll = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.btnCreateTree = new System.Windows.Forms.Button();
            this.btnCalculateRootFromList = new System.Windows.Forms.Button();
            this.btnOptions = new System.Windows.Forms.Button();
            this.stsBar = new System.Windows.Forms.StatusStrip();
            this.stsBarLabel = new System.Windows.Forms.ToolStripStatusLabel();
            this.stsBarProgressBar = new System.Windows.Forms.ToolStripProgressBar();
            this.btnCancelOperation = new System.Windows.Forms.Button();
            this.stsBar.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblRootFolder
            // 
            this.lblRootFolder.Location = new System.Drawing.Point(38, 37);
            this.lblRootFolder.Name = "lblRootFolder";
            this.lblRootFolder.Size = new System.Drawing.Size(73, 13);
            this.lblRootFolder.TabIndex = 2;
            this.lblRootFolder.Text = "Root Folder :";
            // 
            // chkTakeRootDrive
            // 
            this.chkTakeRootDrive.AutoSize = true;
            this.chkTakeRootDrive.Location = new System.Drawing.Point(10, 9);
            this.chkTakeRootDrive.Name = "chkTakeRootDrive";
            this.chkTakeRootDrive.Size = new System.Drawing.Size(136, 17);
            this.chkTakeRootDrive.TabIndex = 3;
            this.chkTakeRootDrive.Text = "Root Up To Drive Level";
            this.chkTakeRootDrive.UseVisualStyleBackColor = true;
            this.chkTakeRootDrive.CheckedChanged += new System.EventHandler(this.chkTakeRootDrive_CheckedChanged);
            // 
            // txtRoot
            // 
            this.txtRoot.AllowDrop = true;
            this.txtRoot.Location = new System.Drawing.Point(114, 37);
            this.txtRoot.Name = "txtRoot";
            this.txtRoot.Size = new System.Drawing.Size(372, 21);
            this.txtRoot.TabIndex = 4;
            this.txtRoot.DragDrop += new System.Windows.Forms.DragEventHandler(this.FileFolderName_DragDrop);
            this.txtRoot.DragEnter += new System.Windows.Forms.DragEventHandler(this.FileFolderName_DragEnter);
            // 
            // btnSelectRoot
            // 
            this.btnSelectRoot.Location = new System.Drawing.Point(492, 36);
            this.btnSelectRoot.Name = "btnSelectRoot";
            this.btnSelectRoot.Size = new System.Drawing.Size(33, 21);
            this.btnSelectRoot.TabIndex = 5;
            this.btnSelectRoot.Text = "...";
            this.btnSelectRoot.UseVisualStyleBackColor = true;
            this.btnSelectRoot.Click += new System.EventHandler(this.btnSelectRoot_Click);
            // 
            // btnSelectTargetDir
            // 
            this.btnSelectTargetDir.Location = new System.Drawing.Point(492, 63);
            this.btnSelectTargetDir.Name = "btnSelectTargetDir";
            this.btnSelectTargetDir.Size = new System.Drawing.Size(33, 21);
            this.btnSelectTargetDir.TabIndex = 8;
            this.btnSelectTargetDir.Text = "...";
            this.btnSelectTargetDir.UseVisualStyleBackColor = true;
            this.btnSelectTargetDir.Click += new System.EventHandler(this.btnSelectTargetDir_Click);
            // 
            // txtTargetDir
            // 
            this.txtTargetDir.AllowDrop = true;
            this.txtTargetDir.Location = new System.Drawing.Point(114, 64);
            this.txtTargetDir.Name = "txtTargetDir";
            this.txtTargetDir.Size = new System.Drawing.Size(372, 21);
            this.txtTargetDir.TabIndex = 7;
            this.txtTargetDir.DragDrop += new System.Windows.Forms.DragEventHandler(this.FileFolderName_DragDrop);
            this.txtTargetDir.DragEnter += new System.Windows.Forms.DragEventHandler(this.FileFolderName_DragEnter);
            // 
            // lblTargetDir
            // 
            this.lblTargetDir.Location = new System.Drawing.Point(10, 64);
            this.lblTargetDir.Name = "lblTargetDir";
            this.lblTargetDir.Size = new System.Drawing.Size(98, 13);
            this.lblTargetDir.TabIndex = 6;
            this.lblTargetDir.Text = "Target Directory :";
            // 
            // lblLine2
            // 
            this.lblLine2.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.lblLine2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.lblLine2.Location = new System.Drawing.Point(7, 101);
            this.lblLine2.Name = "lblLine2";
            this.lblLine2.Size = new System.Drawing.Size(523, 2);
            this.lblLine2.TabIndex = 9;
            // 
            // btnSelectFile
            // 
            this.btnSelectFile.Location = new System.Drawing.Point(405, 147);
            this.btnSelectFile.Name = "btnSelectFile";
            this.btnSelectFile.Size = new System.Drawing.Size(57, 21);
            this.btnSelectFile.TabIndex = 12;
            this.btnSelectFile.Text = "File...";
            this.btnSelectFile.UseVisualStyleBackColor = true;
            this.btnSelectFile.Click += new System.EventHandler(this.btnSelectFile_Click);
            // 
            // txtFileFolderSelected
            // 
            this.txtFileFolderSelected.AllowDrop = true;
            this.txtFileFolderSelected.Location = new System.Drawing.Point(114, 120);
            this.txtFileFolderSelected.Name = "txtFileFolderSelected";
            this.txtFileFolderSelected.Size = new System.Drawing.Size(411, 21);
            this.txtFileFolderSelected.TabIndex = 11;
            this.txtFileFolderSelected.DragDrop += new System.Windows.Forms.DragEventHandler(this.FileFolderName_DragDrop);
            this.txtFileFolderSelected.DragEnter += new System.Windows.Forms.DragEventHandler(this.FileFolderName_DragEnter);
            // 
            // lblSelectFileFolder
            // 
            this.lblSelectFileFolder.Location = new System.Drawing.Point(10, 128);
            this.lblSelectFileFolder.Name = "lblSelectFileFolder";
            this.lblSelectFileFolder.Size = new System.Drawing.Size(73, 13);
            this.lblSelectFileFolder.TabIndex = 10;
            this.lblSelectFileFolder.Text = "File / Folder :";
            // 
            // btnSelectFolder
            // 
            this.btnSelectFolder.Location = new System.Drawing.Point(468, 147);
            this.btnSelectFolder.Name = "btnSelectFolder";
            this.btnSelectFolder.Size = new System.Drawing.Size(57, 21);
            this.btnSelectFolder.TabIndex = 13;
            this.btnSelectFolder.Text = "Folder...";
            this.btnSelectFolder.UseVisualStyleBackColor = true;
            this.btnSelectFolder.Click += new System.EventHandler(this.btnSelectFolder_Click);
            // 
            // btnAddToList
            // 
            this.btnAddToList.Location = new System.Drawing.Point(308, 147);
            this.btnAddToList.Name = "btnAddToList";
            this.btnAddToList.Size = new System.Drawing.Size(91, 21);
            this.btnAddToList.TabIndex = 14;
            this.btnAddToList.Text = "Add To List";
            this.btnAddToList.UseVisualStyleBackColor = true;
            this.btnAddToList.Click += new System.EventHandler(this.btnAddToList_Click);
            // 
            // lstSelectedFilesOrFolders
            // 
            this.lstSelectedFilesOrFolders.AllowDrop = true;
            this.lstSelectedFilesOrFolders.FormattingEnabled = true;
            this.lstSelectedFilesOrFolders.HorizontalScrollbar = true;
            this.lstSelectedFilesOrFolders.Location = new System.Drawing.Point(10, 189);
            this.lstSelectedFilesOrFolders.Name = "lstSelectedFilesOrFolders";
            this.lstSelectedFilesOrFolders.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.lstSelectedFilesOrFolders.Size = new System.Drawing.Size(515, 225);
            this.lstSelectedFilesOrFolders.TabIndex = 15;
            this.lstSelectedFilesOrFolders.DragEnter += new System.Windows.Forms.DragEventHandler(this.lstSelectedFilesOrFolders_DragEnter);
            this.lstSelectedFilesOrFolders.DragDrop += new System.Windows.Forms.DragEventHandler(this.lstSelectedFilesOrFolders_DragDrop);
            this.lstSelectedFilesOrFolders.KeyDown += new System.Windows.Forms.KeyEventHandler(this.lstSelectedFilesOrFolders_KeyDown);
            // 
            // btnDeleteSelection
            // 
            this.btnDeleteSelection.Location = new System.Drawing.Point(7, 420);
            this.btnDeleteSelection.Name = "btnDeleteSelection";
            this.btnDeleteSelection.Size = new System.Drawing.Size(98, 21);
            this.btnDeleteSelection.TabIndex = 16;
            this.btnDeleteSelection.Text = "Delete Selected";
            this.btnDeleteSelection.UseVisualStyleBackColor = true;
            this.btnDeleteSelection.Click += new System.EventHandler(this.btnDeleteSelection_Click);
            // 
            // btnRemoveAll
            // 
            this.btnRemoveAll.Location = new System.Drawing.Point(111, 420);
            this.btnRemoveAll.Name = "btnRemoveAll";
            this.btnRemoveAll.Size = new System.Drawing.Size(98, 21);
            this.btnRemoveAll.TabIndex = 17;
            this.btnRemoveAll.Text = "Remove All";
            this.btnRemoveAll.UseVisualStyleBackColor = true;
            this.btnRemoveAll.Click += new System.EventHandler(this.btnRemoveAll_Click);
            // 
            // btnClose
            // 
            this.btnClose.Location = new System.Drawing.Point(427, 469);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(98, 21);
            this.btnClose.TabIndex = 18;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // label1
            // 
            this.label1.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.label1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.label1.Location = new System.Drawing.Point(7, 457);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(523, 2);
            this.label1.TabIndex = 19;
            // 
            // btnCreateTree
            // 
            this.btnCreateTree.AllowDrop = true;
            this.btnCreateTree.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCreateTree.ForeColor = System.Drawing.Color.Green;
            this.btnCreateTree.Location = new System.Drawing.Point(7, 469);
            this.btnCreateTree.Name = "btnCreateTree";
            this.btnCreateTree.Size = new System.Drawing.Size(152, 21);
            this.btnCreateTree.TabIndex = 20;
            this.btnCreateTree.Text = "Create Tree From List";
            this.btnCreateTree.UseVisualStyleBackColor = true;
            this.btnCreateTree.Click += new System.EventHandler(this.btnCreateTree_Click);
            // 
            // btnCalculateRootFromList
            // 
            this.btnCalculateRootFromList.AllowDrop = true;
            this.btnCalculateRootFromList.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCalculateRootFromList.ForeColor = System.Drawing.Color.Green;
            this.btnCalculateRootFromList.Location = new System.Drawing.Point(215, 420);
            this.btnCalculateRootFromList.Name = "btnCalculateRootFromList";
            this.btnCalculateRootFromList.Size = new System.Drawing.Size(125, 21);
            this.btnCalculateRootFromList.TabIndex = 21;
            this.btnCalculateRootFromList.Text = "Find Root From List";
            this.btnCalculateRootFromList.UseVisualStyleBackColor = true;
            this.btnCalculateRootFromList.Click += new System.EventHandler(this.btnCalculateRootFromList_Click);
            // 
            // btnOptions
            // 
            this.btnOptions.Location = new System.Drawing.Point(427, 420);
            this.btnOptions.Name = "btnOptions";
            this.btnOptions.Size = new System.Drawing.Size(98, 21);
            this.btnOptions.TabIndex = 22;
            this.btnOptions.Text = "Options...";
            this.btnOptions.UseVisualStyleBackColor = true;
            this.btnOptions.Click += new System.EventHandler(this.btnOptions_Click);
            // 
            // stsBar
            // 
            this.stsBar.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.stsBarLabel,
            this.stsBarProgressBar});
            this.stsBar.Location = new System.Drawing.Point(0, 500);
            this.stsBar.Name = "stsBar";
            this.stsBar.Size = new System.Drawing.Size(537, 23);
            this.stsBar.TabIndex = 23;
            // 
            // stsBarLabel
            // 
            this.stsBarLabel.AutoSize = false;
            this.stsBarLabel.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.stsBarLabel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.stsBarLabel.Name = "stsBarLabel";
            this.stsBarLabel.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            this.stsBarLabel.Size = new System.Drawing.Size(320, 18);
            this.stsBarLabel.Spring = true;
            this.stsBarLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // stsBarProgressBar
            // 
            this.stsBarProgressBar.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.stsBarProgressBar.Name = "stsBarProgressBar";
            this.stsBarProgressBar.Size = new System.Drawing.Size(200, 17);
            this.stsBarProgressBar.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            // 
            // btnCancelOperation
            // 
            this.btnCancelOperation.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCancelOperation.ForeColor = System.Drawing.Color.Green;
            this.btnCancelOperation.Location = new System.Drawing.Point(165, 469);
            this.btnCancelOperation.Name = "btnCancelOperation";
            this.btnCancelOperation.Size = new System.Drawing.Size(152, 21);
            this.btnCancelOperation.TabIndex = 24;
            this.btnCancelOperation.Text = "Cancel Operation";
            this.btnCancelOperation.UseVisualStyleBackColor = true;
            this.btnCancelOperation.Click += new System.EventHandler(this.btnCancelOperation_Click);
            // 
            // CreateTreeFromRoot
            // 
            this.AllowDrop = true;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(537, 523);
            this.Controls.Add(this.btnCancelOperation);
            this.Controls.Add(this.stsBar);
            this.Controls.Add(this.btnOptions);
            this.Controls.Add(this.btnCalculateRootFromList);
            this.Controls.Add(this.btnCreateTree);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnRemoveAll);
            this.Controls.Add(this.btnDeleteSelection);
            this.Controls.Add(this.lstSelectedFilesOrFolders);
            this.Controls.Add(this.btnAddToList);
            this.Controls.Add(this.btnSelectFolder);
            this.Controls.Add(this.btnSelectFile);
            this.Controls.Add(this.txtFileFolderSelected);
            this.Controls.Add(this.lblSelectFileFolder);
            this.Controls.Add(this.lblLine2);
            this.Controls.Add(this.btnSelectTargetDir);
            this.Controls.Add(this.txtTargetDir);
            this.Controls.Add(this.lblTargetDir);
            this.Controls.Add(this.btnSelectRoot);
            this.Controls.Add(this.txtRoot);
            this.Controls.Add(this.chkTakeRootDrive);
            this.Controls.Add(this.lblRootFolder);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "CreateTreeFromRoot";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Create File/Folder Tree From Root";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.CreateTreeFromRoot_FormClosing);
            this.Load += new System.EventHandler(this.CreateTreeFromRoot_Load);
            this.stsBar.ResumeLayout(false);
            this.stsBar.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblRootFolder;
        private System.Windows.Forms.CheckBox chkTakeRootDrive;
        private System.Windows.Forms.TextBox txtRoot;
        private System.Windows.Forms.Button btnSelectRoot;
        private System.Windows.Forms.Button btnSelectTargetDir;
        private System.Windows.Forms.TextBox txtTargetDir;
        private System.Windows.Forms.Label lblTargetDir;
        private System.Windows.Forms.Label lblLine2;
        private System.Windows.Forms.Button btnSelectFile;
        private System.Windows.Forms.TextBox txtFileFolderSelected;
        private System.Windows.Forms.Label lblSelectFileFolder;
        private System.Windows.Forms.Button btnSelectFolder;
        private System.Windows.Forms.Button btnAddToList;
        private System.Windows.Forms.ListBox lstSelectedFilesOrFolders;
        private System.Windows.Forms.Button btnDeleteSelection;
        private System.Windows.Forms.Button btnRemoveAll;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnCreateTree;
        private System.Windows.Forms.Button btnCalculateRootFromList;
        private System.Windows.Forms.Button btnOptions;
        private System.Windows.Forms.StatusStrip stsBar;
        private System.Windows.Forms.ToolStripProgressBar stsBarProgressBar;
        private System.Windows.Forms.ToolStripStatusLabel stsBarLabel;
        private System.Windows.Forms.Button btnCancelOperation;
    }
}

