namespace CreateTreeFromRoot
{
    partial class Options
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
            this.chkAlwaysOnTop = new System.Windows.Forms.CheckBox();
            this.gbxFileOverwriteOptions = new System.Windows.Forms.GroupBox();
            this.rdoShowError = new System.Windows.Forms.RadioButton();
            this.rdoUnchangeFiles = new System.Windows.Forms.RadioButton();
            this.rdoOverwriteFiles = new System.Windows.Forms.RadioButton();
            this.btnClose = new System.Windows.Forms.Button();
            this.gbxFileOverwriteOptions.SuspendLayout();
            this.SuspendLayout();
            // 
            // chkAlwaysOnTop
            // 
            this.chkAlwaysOnTop.AutoSize = true;
            this.chkAlwaysOnTop.Location = new System.Drawing.Point(27, 119);
            this.chkAlwaysOnTop.Name = "chkAlwaysOnTop";
            this.chkAlwaysOnTop.Size = new System.Drawing.Size(98, 17);
            this.chkAlwaysOnTop.TabIndex = 1;
            this.chkAlwaysOnTop.Text = "Always On Top";
            this.chkAlwaysOnTop.UseVisualStyleBackColor = true;
            // 
            // gbxFileOverwriteOptions
            // 
            this.gbxFileOverwriteOptions.Controls.Add(this.rdoShowError);
            this.gbxFileOverwriteOptions.Controls.Add(this.rdoUnchangeFiles);
            this.gbxFileOverwriteOptions.Controls.Add(this.rdoOverwriteFiles);
            this.gbxFileOverwriteOptions.Location = new System.Drawing.Point(27, 12);
            this.gbxFileOverwriteOptions.Name = "gbxFileOverwriteOptions";
            this.gbxFileOverwriteOptions.Size = new System.Drawing.Size(227, 101);
            this.gbxFileOverwriteOptions.TabIndex = 2;
            this.gbxFileOverwriteOptions.TabStop = false;
            this.gbxFileOverwriteOptions.Text = "When Same Files Found On Target Folder";
            // 
            // rdoShowError
            // 
            this.rdoShowError.AutoSize = true;
            this.rdoShowError.Location = new System.Drawing.Point(45, 72);
            this.rdoShowError.Name = "rdoShowError";
            this.rdoShowError.Size = new System.Drawing.Size(78, 17);
            this.rdoShowError.TabIndex = 2;
            this.rdoShowError.Text = "Show Error";
            this.rdoShowError.UseVisualStyleBackColor = true;
            // 
            // rdoUnchangeFiles
            // 
            this.rdoUnchangeFiles.AutoSize = true;
            this.rdoUnchangeFiles.Location = new System.Drawing.Point(45, 49);
            this.rdoUnchangeFiles.Name = "rdoUnchangeFiles";
            this.rdoUnchangeFiles.Size = new System.Drawing.Size(135, 17);
            this.rdoUnchangeFiles.TabIndex = 1;
            this.rdoUnchangeFiles.Text = "Keep Them Unchanged";
            this.rdoUnchangeFiles.UseVisualStyleBackColor = true;
            // 
            // rdoOverwriteFiles
            // 
            this.rdoOverwriteFiles.AutoSize = true;
            this.rdoOverwriteFiles.Checked = true;
            this.rdoOverwriteFiles.Location = new System.Drawing.Point(45, 26);
            this.rdoOverwriteFiles.Name = "rdoOverwriteFiles";
            this.rdoOverwriteFiles.Size = new System.Drawing.Size(137, 17);
            this.rdoOverwriteFiles.TabIndex = 0;
            this.rdoOverwriteFiles.TabStop = true;
            this.rdoOverwriteFiles.Text = "Overwrite Existing Files";
            this.rdoOverwriteFiles.UseVisualStyleBackColor = true;
            // 
            // btnClose
            // 
            this.btnClose.Location = new System.Drawing.Point(156, 119);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(98, 21);
            this.btnClose.TabIndex = 19;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // Options
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(281, 150);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.gbxFileOverwriteOptions);
            this.Controls.Add(this.chkAlwaysOnTop);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Options";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Create File/Folder Tree From Root - Options";
            this.gbxFileOverwriteOptions.ResumeLayout(false);
            this.gbxFileOverwriteOptions.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.CheckBox chkAlwaysOnTop;
        private System.Windows.Forms.GroupBox gbxFileOverwriteOptions;
        private System.Windows.Forms.RadioButton rdoShowError;
        private System.Windows.Forms.RadioButton rdoUnchangeFiles;
        private System.Windows.Forms.RadioButton rdoOverwriteFiles;
        private System.Windows.Forms.Button btnClose;
    }
}