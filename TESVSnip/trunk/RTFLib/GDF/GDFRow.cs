


namespace GDF
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Drawing;
    using RTF;

    public partial class GDFBuilder
    {
        #region Nested type: GDFRow

        // ----------------------------------------------------------------------------------------
        //    _                ___        _..-._   Date: 12/11/08    23:32
        //    \`.|\..----...-'`   `-._.-'' _.-..'     
        //    /  ' `         ,       __.-'' 
        //    )/` _/     \   `-_,   /     Solution: RTFLib
        //    `-'" `"\_  ,_.-;_.-\_ ',    Project : RTFLib                                 
        //        _.-'_./   {_.'   ; /    Author  : Anton
        //       {_.-``-'         {_/     Assembly: 1.0.0.0
        //                                Copyright © 2005-2008, Rogue Trader/MWM
        //        Project Item Name:      GDFRow.cs - Code
        //        Purpose:                Table Row
        // ----------------------------------------------------------------------------------------
        /// <summary>
        /// Table Row
        /// </summary>
        private class GDFRow : IRTFRow
        {
            #region Fields

            private readonly RTFCellDefinition[] _cellDefinitions;
            private readonly PointF _location;
            private RectangleF _initrowBounds;
            private RTFRowDefinition _rowDefinition;

            #endregion

            #region Constructor

            internal GDFRow(GDFBuilder builder, RTFRowDefinition rowDefinition, RTFCellDefinition[] cellDefinitions)
            {
                if (builder == null)
                {
                    throw new ArgumentNullException("builder");
                }
                if (cellDefinitions == null)
                {
                    throw new ArgumentNullException("cellDefinitions");
                }
                if (rowDefinition.RowWidth == 0)
                {
                    throw new ArgumentNullException("rowDefinition.RowWidth");
                }
                if (cellDefinitions.Length == 0)
                {
                    throw new ArgumentNullException("cellDefinitions.Length");
                }
                this._rowDefinition = rowDefinition;
                this._cellDefinitions = cellDefinitions;
                this.Builder = builder;
                this.Builder.Alignment(StringAlignment.Near);


                this._location = this.Builder.Manager.CurrentPage.Location;

                // New Line if needed
                if (this._location.X != this.Builder.Manager.CurrentPage.Bounds.X)
                {
                    this.Builder.Manager.NewLine();
                }

                this.Pages = new List <GDFPage>();
                this.Pages.Add(this.Builder.Manager.CurrentPage);

                this._initrowBounds = new RectangleF(this.Pages[0].Location,
                                                     new SizeF((this._rowDefinition.RowWidth / 100F) * this.Pages[0].Bounds.Width,
                                                               this.Pages[0].Bounds.Height - this.Pages[0].Location.Y));
            }

            #endregion

            #region Public Properties

            public GDFBuilder Builder { get; private set; }

            public List <GDFPage> Pages { get; private set; }

            #endregion

            #region Override Methods

            ~GDFRow()
            {
                this.Dispose(false);
            }

            #endregion

            #region Methods

            protected void Dispose(bool disposing)
            {
                if (disposing)
                {
                    bool first = true;
                    foreach (GDFPage  item in this.Pages)
                    {
                        PointF p = new PointF(0, item.Location.Y);
                        if (first)
                        {
                            p = this._location;
                            first = false;
                        }

                        float height = item.BottomRight.Y - p.Y;
                        foreach (RTFCellDefinition celldef in this._cellDefinitions)
                        {
                            using (Pen pen = new Pen(celldef.BorderColor))
                            {
                                float cellwidth = celldef.CellWidthRaw / 100F * ((this._rowDefinition.RowWidth / 100F) * this.Pages[0].Bounds.Width);
                                RectangleF CellBounds = new RectangleF(p, new SizeF(cellwidth, height));

                                item.PageGraphics.DrawRectangle(pen, Rectangle.Ceiling(CellBounds));
                                p.X += cellwidth;
                            }
                        }

                        item.Location = new PointF(0, item.BottomRight.Y + 1);
                        item.LastLineHeight = 0;
                    }
                    this.Builder.Manager.CurrentPage = this.Pages[this.Pages.Count - 1];
                    this.Builder.Reset();
                    this.Builder = null;
                    GC.SuppressFinalize(this);
                }
            }

            #endregion

            #region IRTFRow Members

            public IEnumerator <IBuilderContent> GetEnumerator()
            {
                float xpos = this._initrowBounds.Left;
                foreach (RTFCellDefinition item in this._cellDefinitions)
                {
                    float cellwidth = (item.CellWidthRaw) / 100F * this._initrowBounds.Width;
                    RectangleF initCellBounds = new RectangleF(new PointF(this._initrowBounds.Left + xpos, this._initrowBounds.Top),
                                                               new SizeF(cellwidth, this._initrowBounds.Height));
                    xpos += cellwidth;
                    this.Builder.Manager.CurrentPage = this.Pages[0];
                    using (GDFCell cell = new GDFCell(this, initCellBounds))
                    {
                        yield return cell;
                    }
                }
            }

            IEnumerator IEnumerable.GetEnumerator()
            {
                return this.GetEnumerator();
            }

            public void Dispose()
            {
                this.Dispose(true);
            }

            #endregion
        }

        #endregion
    }
}