namespace user_interface
{
    partial class Dashboard
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Dashboard));
            this.dgvStudentRecords = new System.Windows.Forms.DataGridView();
            this.bnRunTransactions = new System.Windows.Forms.Button();
            this.bnRefreshData = new System.Windows.Forms.Button();
            this.tbExecResults = new System.Windows.Forms.TextBox();
            this.bnReadSeqFile = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvStudentRecords)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvStudentRecords
            // 
            this.dgvStudentRecords.AllowUserToDeleteRows = false;
            this.dgvStudentRecords.BackgroundColor = System.Drawing.SystemColors.ControlDark;
            this.dgvStudentRecords.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvStudentRecords.Location = new System.Drawing.Point(12, 12);
            this.dgvStudentRecords.Name = "dgvStudentRecords";
            this.dgvStudentRecords.RowHeadersWidth = 51;
            this.dgvStudentRecords.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvStudentRecords.ShowEditingIcon = false;
            this.dgvStudentRecords.Size = new System.Drawing.Size(1084, 453);
            this.dgvStudentRecords.TabIndex = 0;
            this.dgvStudentRecords.CellFormatting += new System.Windows.Forms.DataGridViewCellFormattingEventHandler(this.dgvStudentRecords_CellFormatting);
            this.dgvStudentRecords.CellPainting += new System.Windows.Forms.DataGridViewCellPaintingEventHandler(this.dgvStudentRecords_CellPainting);
            // 
            // bnRunTransactions
            // 
            this.bnRunTransactions.Location = new System.Drawing.Point(12, 483);
            this.bnRunTransactions.Name = "bnRunTransactions";
            this.bnRunTransactions.Size = new System.Drawing.Size(193, 38);
            this.bnRunTransactions.TabIndex = 1;
            this.bnRunTransactions.Text = "Run Transactions";
            this.bnRunTransactions.UseVisualStyleBackColor = true;
            this.bnRunTransactions.Click += new System.EventHandler(this.bnRunTransactions_Click);
            // 
            // bnRefreshData
            // 
            this.bnRefreshData.Location = new System.Drawing.Point(225, 483);
            this.bnRefreshData.Name = "bnRefreshData";
            this.bnRefreshData.Size = new System.Drawing.Size(193, 38);
            this.bnRefreshData.TabIndex = 2;
            this.bnRefreshData.Text = "Refresh Data";
            this.bnRefreshData.UseVisualStyleBackColor = true;
            this.bnRefreshData.Click += new System.EventHandler(this.bnRefreshData_Click);
            // 
            // tbExecResults
            // 
            this.tbExecResults.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.tbExecResults.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(64)))), ((int)(((byte)(0)))));
            this.tbExecResults.Location = new System.Drawing.Point(444, 483);
            this.tbExecResults.Multiline = true;
            this.tbExecResults.Name = "tbExecResults";
            this.tbExecResults.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tbExecResults.Size = new System.Drawing.Size(652, 220);
            this.tbExecResults.TabIndex = 3;
            // 
            // bnReadSeqFile
            // 
            this.bnReadSeqFile.Location = new System.Drawing.Point(12, 540);
            this.bnReadSeqFile.Name = "bnReadSeqFile";
            this.bnReadSeqFile.Size = new System.Drawing.Size(193, 38);
            this.bnReadSeqFile.TabIndex = 4;
            this.bnReadSeqFile.Text = "Read Sequential File";
            this.bnReadSeqFile.UseVisualStyleBackColor = true;
            this.bnReadSeqFile.Click += new System.EventHandler(this.bnReadSeqFile_Click);
            // 
            // Dashboard
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Green;
            this.ClientSize = new System.Drawing.Size(1108, 715);
            this.Controls.Add(this.bnReadSeqFile);
            this.Controls.Add(this.tbExecResults);
            this.Controls.Add(this.bnRefreshData);
            this.Controls.Add(this.bnRunTransactions);
            this.Controls.Add(this.dgvStudentRecords);
            this.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Dashboard";
            this.Text = "Green Screen - COBOL User Interface";
            this.Load += new System.EventHandler(this.Dashboard_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvStudentRecords)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvStudentRecords;
        private System.Windows.Forms.Button bnRunTransactions;
        private System.Windows.Forms.Button bnRefreshData;
        private System.Windows.Forms.TextBox tbExecResults;
        private System.Windows.Forms.Button bnReadSeqFile;
    }
}

