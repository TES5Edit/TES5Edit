
namespace GDF
{
    using System;
    using System.Collections.Generic;
    using System.Windows.Forms;

    // ----------------------------------------------------------------------------------------
    //    _                ___        _..-._   Date: 12/11/08    23:29
    //    \`.|\..----...-'`   `-._.-'' _.-..'     
    //    /  ' `         ,       __.-'' 
    //    )/` _/     \   `-_,   /     Solution: RTFLib
    //    `-'" `"\_  ,_.-;_.-\_ ',    Project : RTFLib                                 
    //        _.-'_./   {_.'   ; /    Author  : Anton
    //       {_.-``-'         {_/     Assembly: 1.0.0.0
    //                                Copyright © 2005-2008, Rogue Trader/MWM
    //        Project Item Name:      GDFDisplayBox.cs - UserControl
    //        Purpose:                Displays GDF Output
    // ----------------------------------------------------------------------------------------
    /// <summary>
    /// Displays GDF Output
    /// </summary>
    public partial class GDFDisplayBox : UserControl
    {
        #region Fields

        private readonly BindingSource bindingsource;

        #endregion

        #region Constructor

        public GDFDisplayBox()
        {
            this.InitializeComponent();
            this.bindingsource = new BindingSource(this.components);
            this.bindingNavigator1.BindingSource = this.bindingsource;
            this.bindingsource.CurrentItemChanged += this.BindingSource_CurrentItemChanged;
            this.bindingsource.DataSourceChanged += this.bindingsource_DataSourceChanged;
        }

        #endregion

        #region Event Handlers

        private void BindingSource_CurrentItemChanged(object sender, EventArgs e)
        {
            GDFPage page = this.bindingNavigator1.BindingSource.Current as GDFPage;
            if (page != null)
            {
                this.pictureBox1.Size = page.PageImage.Size;
                this.pictureBox1.Image = page.PageImage;
            }
        }

        private void bindingsource_DataSourceChanged(object sender, EventArgs e)
        {
            GDFPage page = this.bindingNavigator1.BindingSource.Current as GDFPage;
            if (page != null)
            {
                this.pictureBox1.Size = page.PageImage.Size;
                this.pictureBox1.Image = page.PageImage;
            }
        }

        private void GDFDisplayBox_Load(object sender, EventArgs e)
        {
        }

        #endregion

        #region Public Methods

        public void SetPages(List <GDFPage> pages)
        {
            this.bindingNavigator1.BindingSource.DataSource = pages;
        }

        #endregion
    }
}