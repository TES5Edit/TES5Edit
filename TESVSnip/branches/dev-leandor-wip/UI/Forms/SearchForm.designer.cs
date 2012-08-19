namespace TESVSnip {
    partial class SearchForm {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if(disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
            this.tbSearch = new System.Windows.Forms.TextBox();
            this.cbPartial = new System.Windows.Forms.CheckBox();
            this.cbSelectedNode = new System.Windows.Forms.CheckBox();
            this.bFind = new System.Windows.Forms.Button();
            this.bReset = new System.Windows.Forms.Button();
            this.rbEDID = new System.Windows.Forms.RadioButton();
            this.rbFormID = new System.Windows.Forms.RadioButton();
            this.rbAll = new System.Windows.Forms.RadioButton();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // tbSearch
            // 
            this.tbSearch.Location = new System.Drawing.Point(12, 12);
            this.tbSearch.Name = "tbSearch";
            this.tbSearch.Size = new System.Drawing.Size(205, 20);
            this.tbSearch.TabIndex = 0;
            // 
            // cbPartial
            // 
            this.cbPartial.AutoSize = true;
            this.cbPartial.Location = new System.Drawing.Point(12, 107);
            this.cbPartial.Name = "cbPartial";
            this.cbPartial.Size = new System.Drawing.Size(120, 17);
            this.cbPartial.TabIndex = 1;
            this.cbPartial.Text = "Find partial matches";
            this.cbPartial.UseVisualStyleBackColor = true;
            // 
            // cbSelectedNode
            // 
            this.cbSelectedNode.AutoSize = true;
            this.cbSelectedNode.Location = new System.Drawing.Point(12, 130);
            this.cbSelectedNode.Name = "cbSelectedNode";
            this.cbSelectedNode.Size = new System.Drawing.Size(182, 17);
            this.cbSelectedNode.TabIndex = 2;
            this.cbSelectedNode.Text = "Search under selected node only";
            this.cbSelectedNode.UseVisualStyleBackColor = true;
            // 
            // bFind
            // 
            this.bFind.Location = new System.Drawing.Point(142, 153);
            this.bFind.Name = "bFind";
            this.bFind.Size = new System.Drawing.Size(75, 23);
            this.bFind.TabIndex = 3;
            this.bFind.Text = "Find";
            this.bFind.UseVisualStyleBackColor = true;
            this.bFind.Click += new System.EventHandler(this.bFind_Click);
            // 
            // bReset
            // 
            this.bReset.Location = new System.Drawing.Point(12, 153);
            this.bReset.Name = "bReset";
            this.bReset.Size = new System.Drawing.Size(75, 23);
            this.bReset.TabIndex = 4;
            this.bReset.Text = "Reset";
            this.bReset.UseVisualStyleBackColor = true;
            this.bReset.Click += new System.EventHandler(this.bReset_Click);
            // 
            // rbEDID
            // 
            this.rbEDID.AutoSize = true;
            this.rbEDID.Checked = true;
            this.rbEDID.Location = new System.Drawing.Point(12, 38);
            this.rbEDID.Name = "rbEDID";
            this.rbEDID.Size = new System.Drawing.Size(71, 17);
            this.rbEDID.TabIndex = 5;
            this.rbEDID.TabStop = true;
            this.rbEDID.Text = "Editor IDs";
            this.rbEDID.UseVisualStyleBackColor = true;
            this.rbEDID.CheckedChanged += new System.EventHandler(this.cbFormID_CheckedChanged);
            // 
            // rbFormID
            // 
            this.rbFormID.AutoSize = true;
            this.rbFormID.Location = new System.Drawing.Point(12, 61);
            this.rbFormID.Name = "rbFormID";
            this.rbFormID.Size = new System.Drawing.Size(64, 17);
            this.rbFormID.TabIndex = 6;
            this.rbFormID.TabStop = true;
            this.rbFormID.Text = "FormIDs";
            this.rbFormID.UseVisualStyleBackColor = true;
            // 
            // rbAll
            // 
            this.rbAll.AutoSize = true;
            this.rbAll.Location = new System.Drawing.Point(12, 84);
            this.rbAll.Name = "rbAll";
            this.rbAll.Size = new System.Drawing.Size(91, 17);
            this.rbAll.TabIndex = 7;
            this.rbAll.TabStop = true;
            this.rbAll.Text = "All subrecords";
            this.rbAll.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(139, 65);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 13);
            this.label1.TabIndex = 8;
            this.label1.Text = "Search type";
            // 
            // SearchForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(229, 187);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.rbAll);
            this.Controls.Add(this.rbFormID);
            this.Controls.Add(this.rbEDID);
            this.Controls.Add(this.bReset);
            this.Controls.Add(this.bFind);
            this.Controls.Add(this.cbSelectedNode);
            this.Controls.Add(this.cbPartial);
            this.Controls.Add(this.tbSearch);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "SearchForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "SearchForm";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox tbSearch;
        private System.Windows.Forms.CheckBox cbPartial;
        private System.Windows.Forms.CheckBox cbSelectedNode;
        private System.Windows.Forms.Button bFind;
        private System.Windows.Forms.Button bReset;
        private System.Windows.Forms.RadioButton rbEDID;
        private System.Windows.Forms.RadioButton rbFormID;
        private System.Windows.Forms.RadioButton rbAll;
        private System.Windows.Forms.Label label1;
    }
}