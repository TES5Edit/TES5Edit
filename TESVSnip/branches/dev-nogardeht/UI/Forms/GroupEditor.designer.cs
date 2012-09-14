namespace TESVSnip.UI.Forms {
    partial class GroupEditor {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if(disposing && (this.components != null)) {
                this.components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(GroupEditor));
            this.cmbGroupType = new System.Windows.Forms.ComboBox();
            this.tbRecType = new System.Windows.Forms.TextBox();
            this.tbBlock = new System.Windows.Forms.TextBox();
            this.tbX = new System.Windows.Forms.TextBox();
            this.tbY = new System.Windows.Forms.TextBox();
            this.tbParent = new System.Windows.Forms.TextBox();
            this.tbDateStamp = new System.Windows.Forms.TextBox();
            this.tbFlags = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.bCancel = new System.Windows.Forms.Button();
            this.bSave = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // cmbGroupType
            // 
            this.cmbGroupType.FormattingEnabled = true;
            this.cmbGroupType.Items.AddRange(new object[] {
            resources.GetString("cmbGroupType.Items"),
            resources.GetString("cmbGroupType.Items1"),
            resources.GetString("cmbGroupType.Items2"),
            resources.GetString("cmbGroupType.Items3"),
            resources.GetString("cmbGroupType.Items4"),
            resources.GetString("cmbGroupType.Items5"),
            resources.GetString("cmbGroupType.Items6"),
            resources.GetString("cmbGroupType.Items7"),
            resources.GetString("cmbGroupType.Items8"),
            resources.GetString("cmbGroupType.Items9"),
            resources.GetString("cmbGroupType.Items10")});
            resources.ApplyResources(this.cmbGroupType, "cmbGroupType");
            this.cmbGroupType.Name = "cmbGroupType";
            this.cmbGroupType.SelectedIndexChanged += new System.EventHandler(this.cmbGroupType_SelectedIndexChanged);
            this.cmbGroupType.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.cmbGroupType_KeyPress);
            // 
            // tbRecType
            // 
            this.tbRecType.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            resources.ApplyResources(this.tbRecType, "tbRecType");
            this.tbRecType.Name = "tbRecType";
            this.tbRecType.Leave += new System.EventHandler(this.tbRecType_Leave);
            // 
            // tbBlock
            // 
            resources.ApplyResources(this.tbBlock, "tbBlock");
            this.tbBlock.Name = "tbBlock";
            // 
            // tbX
            // 
            resources.ApplyResources(this.tbX, "tbX");
            this.tbX.Name = "tbX";
            // 
            // tbY
            // 
            resources.ApplyResources(this.tbY, "tbY");
            this.tbY.Name = "tbY";
            // 
            // tbParent
            // 
            resources.ApplyResources(this.tbParent, "tbParent");
            this.tbParent.Name = "tbParent";
            // 
            // tbDateStamp
            // 
            resources.ApplyResources(this.tbDateStamp, "tbDateStamp");
            this.tbDateStamp.Name = "tbDateStamp";
            // 
            // tbFlags
            // 
            resources.ApplyResources(this.tbFlags, "tbFlags");
            this.tbFlags.Name = "tbFlags";
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.Name = "label3";
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.Name = "label4";
            // 
            // label5
            // 
            resources.ApplyResources(this.label5, "label5");
            this.label5.Name = "label5";
            // 
            // label6
            // 
            resources.ApplyResources(this.label6, "label6");
            this.label6.Name = "label6";
            // 
            // label7
            // 
            resources.ApplyResources(this.label7, "label7");
            this.label7.Name = "label7";
            // 
            // bCancel
            // 
            this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            resources.ApplyResources(this.bCancel, "bCancel");
            this.bCancel.Name = "bCancel";
            this.bCancel.UseVisualStyleBackColor = true;
            this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
            // 
            // bSave
            // 
            resources.ApplyResources(this.bSave, "bSave");
            this.bSave.Name = "bSave";
            this.bSave.UseVisualStyleBackColor = true;
            this.bSave.Click += new System.EventHandler(this.bSave_Click);
            // 
            // GroupEditor
            // 
            this.AcceptButton = this.bSave;
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.bCancel;
            this.Controls.Add(this.bSave);
            this.Controls.Add(this.bCancel);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tbFlags);
            this.Controls.Add(this.tbDateStamp);
            this.Controls.Add(this.tbParent);
            this.Controls.Add(this.tbY);
            this.Controls.Add(this.tbX);
            this.Controls.Add(this.tbBlock);
            this.Controls.Add(this.tbRecType);
            this.Controls.Add(this.cmbGroupType);
            this.Name = "GroupEditor";
            this.ShowInTaskbar = false;
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox cmbGroupType;
        private System.Windows.Forms.TextBox tbRecType;
        private System.Windows.Forms.TextBox tbBlock;
        private System.Windows.Forms.TextBox tbX;
        private System.Windows.Forms.TextBox tbY;
        private System.Windows.Forms.TextBox tbParent;
        private System.Windows.Forms.TextBox tbDateStamp;
        private System.Windows.Forms.TextBox tbFlags;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Button bCancel;
        private System.Windows.Forms.Button bSave;
    }
}