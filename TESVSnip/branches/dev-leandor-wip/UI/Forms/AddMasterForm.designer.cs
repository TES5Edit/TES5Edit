namespace TESVSnip.UI.Forms
{
	partial class AddMasterForm
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

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(AddMasterForm));
            this.label1 = new System.Windows.Forms.Label();
            this.tbxMaster = new System.Windows.Forms.TextBox();
            this.butChooseMaster = new System.Windows.Forms.Button();
            this.butOK = new System.Windows.Forms.Button();
            this.butCancel = new System.Windows.Forms.Button();
            this.ofdChooseMaster = new System.Windows.Forms.OpenFileDialog();
            this.SuspendLayout();
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // tbxMaster
            // 
            resources.ApplyResources(this.tbxMaster, "tbxMaster");
            this.tbxMaster.Name = "tbxMaster";
            // 
            // butChooseMaster
            // 
            resources.ApplyResources(this.butChooseMaster, "butChooseMaster");
            this.butChooseMaster.Name = "butChooseMaster";
            this.butChooseMaster.UseVisualStyleBackColor = true;
            this.butChooseMaster.Click += new System.EventHandler(this.butChooseMaster_Click);
            // 
            // butOK
            // 
            resources.ApplyResources(this.butOK, "butOK");
            this.butOK.Name = "butOK";
            this.butOK.UseVisualStyleBackColor = true;
            this.butOK.Click += new System.EventHandler(this.butOK_Click);
            // 
            // butCancel
            // 
            resources.ApplyResources(this.butCancel, "butCancel");
            this.butCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.butCancel.Name = "butCancel";
            this.butCancel.UseVisualStyleBackColor = true;
            // 
            // ofdChooseMaster
            // 
            this.ofdChooseMaster.DefaultExt = "esp";
            this.ofdChooseMaster.FileName = "openFileDialog1";
            resources.ApplyResources(this.ofdChooseMaster, "ofdChooseMaster");
            // 
            // AddMasterForm
            // 
            this.AcceptButton = this.butOK;
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.butCancel;
            this.Controls.Add(this.butCancel);
            this.Controls.Add(this.butOK);
            this.Controls.Add(this.butChooseMaster);
            this.Controls.Add(this.tbxMaster);
            this.Controls.Add(this.label1);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "AddMasterForm";
            this.ShowInTaskbar = false;
            this.ResumeLayout(false);
            this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox tbxMaster;
		private System.Windows.Forms.Button butChooseMaster;
		private System.Windows.Forms.Button butOK;
		private System.Windows.Forms.Button butCancel;
		private System.Windows.Forms.OpenFileDialog ofdChooseMaster;
	}
}