
namespace GDF
{
    using System;
    using System.Drawing;
    using RTF;

    public partial class GDFBuilder
    {
        #region Nested type: GDFCell

        // ----------------------------------------------------------------------------------------
        //    _                ___        _..-._   Date: 12/11/08    23:29
        //    \`.|\..----...-'`   `-._.-'' _.-..'     
        //    /  ' `         ,       __.-'' 
        //    )/` _/     \   `-_,   /     Solution: RTFLib
        //    `-'" `"\_  ,_.-;_.-\_ ',    Project : RTFLib                                 
        //        _.-'_./   {_.'   ; /    Author  : Anton
        //       {_.-``-'         {_/     Assembly: 1.0.0.0
        //                                Copyright © 2005-2008, Rogue Trader/MWM
        //        Project Item Name:      GDFCell.cs - Code
        //        Purpose:                Cell within Table Row
        // ----------------------------------------------------------------------------------------
        /// <summary>
        /// Cell within Table Row
        /// </summary>
        private class GDFCell : IBuilderContent
        {
            #region Fields

            private readonly GDFPage _page;
            private readonly GDFRow _row;

            #endregion

            #region Constructor

            public GDFCell(GDFRow row, RectangleF initCellBounds)
            {
                this._row = row;
                //Store page
                this._page = this._row.Builder.Manager.CurrentPage;
                //Set Bounds and Location
                this._page.Location = initCellBounds.Location;
                this._page.Bounds = initCellBounds;
            }

            #endregion

            #region Override Methods

            ~GDFCell()
            {
                this.Dispose(false);
            }

            #endregion

            #region Methods

            protected void Dispose(bool disposing)
            {
                if (disposing)
                {
                    //Set Current page omn manager
                    this._row.Builder.Manager.CurrentPage = this._page;

                    for (int i = this._row.Builder.Manager.Pages.IndexOf(this._page); i < this._row.Builder.Manager.Pages.Count; i++)
                    {
                        //Register Page
                        if (!this._row.Pages.Contains(this._row.Builder.Manager.Pages[i]))
                        {
                            this._row.Pages.Add(this._row.Builder.Manager.Pages[i]);
                        }

                        //move loccation right by width of bounds
                        this._row.Builder.Manager.Pages[i].Location =
                            new PointF(this._row.Builder.Manager.Pages[i].Bounds.Location.X + this._row.Builder.Manager.Pages[i].Bounds.Width,
                                       this._row.Builder.Manager.Pages[i].Bounds.Location.Y);
                        //Reset Bounds
                        this._row.Builder.Manager.Pages[i].ResetBounds();
                    }

                    this._row.Builder.Reset();
                }

                if (disposing)
                {
                    GC.SuppressFinalize(this);
                }
            }

            #endregion

            #region IBuilderContent Members

            public void Dispose()
            {
                this.Dispose(true);
            }

            public RTFBuilderbase Content
            {
                get { return this._row.Builder; }
            }

            #endregion
        }

        #endregion
    }
}