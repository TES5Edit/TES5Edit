namespace TESVSnip.UI.ObjectControls
{
    partial class RecordEditor
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
            if (disposing && (this.components != null))
            {
                this.components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(RecordEditor));
            this.horizontalSplitContainer = new System.Windows.Forms.SplitContainer();
            this.verticalSplitContainer = new System.Windows.Forms.SplitContainer();
            this.comboBox1 = new TESVSnip.Windows.Controls.FlagComboBox();
            this.tbFlags3 = new System.Windows.Forms.TextBox();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.tbFlags2 = new System.Windows.Forms.TextBox();
            this.tbFormID = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.tbName = new System.Windows.Forms.TextBox();
            this.subrecordListEditor = new SubrecordListEditor();
            this.bCancel = new System.Windows.Forms.Button();
            this.bSave = new System.Windows.Forms.Button();
            this.elementEditor = new SubrecordEditor();
            this.horizontalSplitContainer.Panel1.SuspendLayout();
            this.horizontalSplitContainer.Panel2.SuspendLayout();
            this.horizontalSplitContainer.SuspendLayout();
            this.verticalSplitContainer.Panel1.SuspendLayout();
            this.verticalSplitContainer.Panel2.SuspendLayout();
            this.verticalSplitContainer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.subrecordListEditor)).BeginInit();
            this.SuspendLayout();
            // 
            // horizontalSplitContainer
            // 
            resources.ApplyResources(this.horizontalSplitContainer, "horizontalSplitContainer");
            this.horizontalSplitContainer.FixedPanel = System.Windows.Forms.FixedPanel.Panel1;
            this.horizontalSplitContainer.Name = "horizontalSplitContainer";
            // 
            // horizontalSplitContainer.Panel1
            // 
            this.horizontalSplitContainer.Panel1.Controls.Add(this.verticalSplitContainer);
            // 
            // horizontalSplitContainer.Panel2
            // 
            this.horizontalSplitContainer.Panel2.Controls.Add(this.bCancel);
            this.horizontalSplitContainer.Panel2.Controls.Add(this.bSave);
            this.horizontalSplitContainer.Panel2.Controls.Add(this.elementEditor);
            // 
            // verticalSplitContainer
            // 
            resources.ApplyResources(this.verticalSplitContainer, "verticalSplitContainer");
            this.verticalSplitContainer.FixedPanel = System.Windows.Forms.FixedPanel.Panel1;
            this.verticalSplitContainer.Name = "verticalSplitContainer";
            // 
            // verticalSplitContainer.Panel1
            // 
            this.verticalSplitContainer.Panel1.Controls.Add(this.comboBox1);
            this.verticalSplitContainer.Panel1.Controls.Add(this.tbFlags3);
            this.verticalSplitContainer.Panel1.Controls.Add(this.textBox1);
            this.verticalSplitContainer.Panel1.Controls.Add(this.tbFlags2);
            this.verticalSplitContainer.Panel1.Controls.Add(this.tbFormID);
            this.verticalSplitContainer.Panel1.Controls.Add(this.label3);
            this.verticalSplitContainer.Panel1.Controls.Add(this.label2);
            this.verticalSplitContainer.Panel1.Controls.Add(this.label1);
            this.verticalSplitContainer.Panel1.Controls.Add(this.label4);
            this.verticalSplitContainer.Panel1.Controls.Add(this.tbName);
            // 
            // verticalSplitContainer.Panel2
            // 
            this.verticalSplitContainer.Panel2.Controls.Add(this.subrecordListEditor);
            // 
            // comboBox1
            // 
            this.comboBox1.AllowResizeDropDown = true;
            resources.ApplyResources(this.comboBox1, "comboBox1");
            this.comboBox1.CheckOnClick = true;
            this.comboBox1.ControlSize = new System.Drawing.Size(47, 16);
            this.comboBox1.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawVariable;
            this.comboBox1.DropDownSizeMode = TESVSnip.Windows.Controls.CustomComboBox.SizeMode.UseDropDownSize;
            this.comboBox1.DropSize = new System.Drawing.Size(121, 106);
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.ValueSeparator = ",";
            this.comboBox1.ItemCheck += new System.Windows.Forms.ItemCheckEventHandler(this.comboBox1_ItemCheck);
            this.comboBox1.SelectionChangeCommitted += new System.EventHandler(this.comboBox1_SelectionChangeCommitted);
            // 
            // tbFlags3
            // 
            resources.ApplyResources(this.tbFlags3, "tbFlags3");
            this.tbFlags3.Name = "tbFlags3";
            this.tbFlags3.Validating += new System.ComponentModel.CancelEventHandler(this.tbFlags3_Validating);
            // 
            // textBox1
            // 
            resources.ApplyResources(this.textBox1, "textBox1");
            this.textBox1.Name = "textBox1";
            this.textBox1.Validating += new System.ComponentModel.CancelEventHandler(this.textBox1_Validating);
            // 
            // tbFlags2
            // 
            resources.ApplyResources(this.tbFlags2, "tbFlags2");
            this.tbFlags2.Name = "tbFlags2";
            this.tbFlags2.Validating += new System.ComponentModel.CancelEventHandler(this.tbFlags2_Validating);
            // 
            // tbFormID
            // 
            resources.ApplyResources(this.tbFormID, "tbFormID");
            this.tbFormID.Name = "tbFormID";
            this.tbFormID.Validating += new System.ComponentModel.CancelEventHandler(this.tbFormID_Validating);
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.Name = "label3";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.Name = "label4";
            // 
            // tbName
            // 
            resources.ApplyResources(this.tbName, "tbName");
            this.tbName.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.tbName.Name = "tbName";
            // 
            // subrecordListEditor
            // 
            resources.ApplyResources(this.subrecordListEditor, "subrecordListEditor");
            this.subrecordListEditor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.subrecordListEditor.MinimumSize = new System.Drawing.Size(200, 120);
            this.subrecordListEditor.Name = "subrecordListEditor";
            this.subrecordListEditor.SubRecords = null;
            // 
            // bCancel
            // 
            resources.ApplyResources(this.bCancel, "bCancel");
            this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.bCancel.Name = "bCancel";
            this.bCancel.UseVisualStyleBackColor = true;
            this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
            // 
            // bSave
            // 
            resources.ApplyResources(this.bSave, "bSave");
            this.bSave.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.bSave.Name = "bSave";
            this.bSave.UseVisualStyleBackColor = true;
            this.bSave.Click += new System.EventHandler(this.bSave_Click);
            // 
            // elementEditor
            // 
            resources.ApplyResources(this.elementEditor, "elementEditor");
            this.elementEditor.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.elementEditor.MinimumSize = new System.Drawing.Size(300, 200);
            this.elementEditor.Name = "elementEditor";
            // 
            // RecordEditor
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.horizontalSplitContainer);
            this.Name = "RecordEditor";
            this.horizontalSplitContainer.Panel1.ResumeLayout(false);
            this.horizontalSplitContainer.Panel2.ResumeLayout(false);
            this.horizontalSplitContainer.ResumeLayout(false);
            this.verticalSplitContainer.Panel1.ResumeLayout(false);
            this.verticalSplitContainer.Panel1.PerformLayout();
            this.verticalSplitContainer.Panel2.ResumeLayout(false);
            this.verticalSplitContainer.Panel2.PerformLayout();
            this.verticalSplitContainer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.subrecordListEditor)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.SplitContainer horizontalSplitContainer;
        private System.Windows.Forms.SplitContainer verticalSplitContainer;
        private SubrecordListEditor subrecordListEditor;
        private SubrecordEditor elementEditor;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tbName;
        private System.Windows.Forms.TextBox tbFormID;
        private TESVSnip.Windows.Controls.FlagComboBox comboBox1;
        private System.Windows.Forms.TextBox tbFlags3;
        private System.Windows.Forms.TextBox tbFlags2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button bCancel;
        private System.Windows.Forms.Button bSave;

    }
}
