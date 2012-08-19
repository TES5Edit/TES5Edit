namespace TESVSnip.UI.Forms {
    partial class NewMediumLevelRecordEditor {
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NewMediumLevelRecordEditor));
            this.bSave = new System.Windows.Forms.Button();
            this.bCancel = new System.Windows.Forms.Button();
            this.fpanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.Error = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // bSave
            // 
            resources.ApplyResources(this.bSave, "bSave");
            this.bSave.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.Error.SetError(this.bSave, resources.GetString("bSave.Error"));
            this.Error.SetIconAlignment(this.bSave, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("bSave.IconAlignment"))));
            this.Error.SetIconPadding(this.bSave, ((int)(resources.GetObject("bSave.IconPadding"))));
            this.bSave.Name = "bSave";
            this.bSave.UseVisualStyleBackColor = true;
            this.bSave.Click += new System.EventHandler(this.bSave_Click);
            // 
            // bCancel
            // 
            resources.ApplyResources(this.bCancel, "bCancel");
            this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.Error.SetError(this.bCancel, resources.GetString("bCancel.Error"));
            this.Error.SetIconAlignment(this.bCancel, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("bCancel.IconAlignment"))));
            this.Error.SetIconPadding(this.bCancel, ((int)(resources.GetObject("bCancel.IconPadding"))));
            this.bCancel.Name = "bCancel";
            this.bCancel.UseVisualStyleBackColor = true;
            this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
            // 
            // fpanel1
            // 
            resources.ApplyResources(this.fpanel1, "fpanel1");
            this.Error.SetError(this.fpanel1, resources.GetString("fpanel1.Error"));
            this.Error.SetIconAlignment(this.fpanel1, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("fpanel1.IconAlignment"))));
            this.Error.SetIconPadding(this.fpanel1, ((int)(resources.GetObject("fpanel1.IconPadding"))));
            this.fpanel1.Name = "fpanel1";
            this.fpanel1.Resize += new System.EventHandler(this.fpanel1_Resize);
            // 
            // Error
            // 
            this.Error.ContainerControl = this;
            resources.ApplyResources(this.Error, "Error");
            // 
            // NewMediumLevelRecordEditor
            // 
            this.AcceptButton = this.bSave;
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.bCancel;
            this.Controls.Add(this.fpanel1);
            this.Controls.Add(this.bCancel);
            this.Controls.Add(this.bSave);
            this.Name = "NewMediumLevelRecordEditor";
            this.ShowInTaskbar = false;
            this.Load += new System.EventHandler(this.NewMediumLevelRecordEditor_Load);
            this.Shown += new System.EventHandler(this.NewMediumLevelRecordEditor_Shown);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button bSave;
        private System.Windows.Forms.Button bCancel;
        private System.Windows.Forms.FlowLayoutPanel fpanel1;
        private System.Windows.Forms.ErrorProvider Error;



    }
}