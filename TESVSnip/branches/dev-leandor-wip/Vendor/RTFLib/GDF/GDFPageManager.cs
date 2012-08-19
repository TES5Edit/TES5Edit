namespace GDF
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Drawing;

    // ----------------------------------------------------------------------------------------
    //    _                ___        _..-._   Date: 12/11/08    23:31
    //    \`.|\..----...-'`   `-._.-'' _.-..'     
    //    /  ' `         ,       __.-'' 
    //    )/` _/     \   `-_,   /     Solution: RTFLib
    //    `-'" `"\_  ,_.-;_.-\_ ',    Project : RTFLib                                 
    //        _.-'_./   {_.'   ; /    Author  : Anton
    //       {_.-``-'         {_/     Assembly: 1.0.0.0
    //                                Copyright © 2005-2008, Rogue Trader/MWM
    //        Project Item Name:      GDFPageManager.cs - Code
    //        Purpose:                Manages GDFPages
    // ----------------------------------------------------------------------------------------
    /// <summary>
    /// Manages GDFPages
    /// </summary>
    public class GDFPageManager
    {
        #region Fields

        private readonly Color _defaultbackcolor;
        private readonly Size _pageSize;
        private int _index;

        #endregion

        #region Constructor

        public GDFPageManager(Size pageSize, Color defaultBackColor)
        {
            this.Pages = new List <GDFPage>();
            this._pageSize = pageSize;
            this._defaultbackcolor = defaultBackColor;
            this._index = 0;
            this.DefaultLineHeight = 20;
        }

        #endregion

        #region Public Properties

        public GDFPage CurrentPage
        {
            [DebuggerStepThrough]
            get
            {
                if (this._index > this.Pages.Count)
                {
                    throw new ApplicationException("Request invalid page");
                }
                if (this.Pages.Count == this._index)
                {
                    this.Pages.Add(new GDFPage(this._pageSize, this._defaultbackcolor));
                }
                return this.Pages[this._index];
            }
            [DebuggerStepThrough]
            set
            {
                int index = this.Pages.IndexOf(value);
                if (index < 0)
                {
                    throw new ApplicationException("Invalid page");
                }
                this._index = index;
            }
        }

        public float DefaultLineHeight { get; set; }

        public List <GDFPage> Pages { get; private set; }

        #endregion

        #region Public Methods

        [DebuggerStepThrough]
        public SizeF LineLayout()
        {
            GDFPage page = this.CurrentPage;
            SizeF layout = new SizeF(page.Bounds.Right - page.Location.X, page.Bounds.Bottom - page.Location.Y);
            return layout;
        }

        [DebuggerStepThrough]
        public void MoveLocationRight(SizeF size)
        {
            GDFPage page = this.CurrentPage;
            page.Location = new PointF(page.Location.X + size.Width, page.Location.Y);
            page.LastLineHeight = Math.Max(page.LastLineHeight, size.Height);
            //page.BottomRight = new PointF(Math.Max(page.BottomRight.X, page.Location.X + page.Bounds.Left ),
            //    Math.Max(page.BottomRight.Y, page.Bounds.Top + page.Location.Y + page.LastLineHeight));

            page.BottomRight = new PointF(Math.Max(page.BottomRight.X, page.Location.X), Math.Max(page.BottomRight.Y, page.Location.Y + page.LastLineHeight));
        }

        [DebuggerStepThrough]
        public void NewFlowLine(SizeF size)
        {
            GDFPage page = this.CurrentPage;
            if ((page.Location.Y + size.Height * 2) < page.PageSize.Height)
            {
                page.LastLineHeight = 0;
                page.BottomRight = new PointF(Math.Max(page.BottomRight.X, page.Location.X + size.Width), Math.Max(page.BottomRight.Y, page.Location.Y + size.Height));
                page.Location = new PointF(page.Bounds.Left, page.Location.Y + size.Height);
            }
            else
            {
                page.BottomRight = new PointF(Math.Max(page.BottomRight.X, page.Location.X + size.Width), Math.Max(page.BottomRight.Y, page.Location.Y + size.Height));
                RectangleF rec = page.Bounds;
                this._index++;
                rec.Location = new PointF(page.Bounds.X, this.CurrentPage.Bounds.Top);
                rec.Height = this.CurrentPage.Bounds.Height;
                this.CurrentPage.Bounds = rec;
                this.CurrentPage.Location = new PointF(rec.Left, rec.Top);
                this.CurrentPage.BottomRight = new PointF(Math.Max(this.CurrentPage.BottomRight.X, this.CurrentPage.Location.X),
                                                          Math.Max(this.CurrentPage.BottomRight.Y, this.CurrentPage.Location.Y));
            }
        }

        public void NewLine()
        {
            GDFPage page = this.CurrentPage;
            float lineheight = page.LastLineHeight == 0 ? this.DefaultLineHeight : page.LastLineHeight;

            if ((page.Location.Y + lineheight * 2) < page.PageSize.Height)
            {
                page.BottomRight = new PointF(Math.Max(page.BottomRight.X, page.Location.X), Math.Max(page.BottomRight.Y, page.Location.Y + lineheight));
                page.Location = new PointF(page.Bounds.Left, page.Location.Y + lineheight);

                page.LastLineHeight = 0;
            }
            else
            {
                RectangleF rec = page.Bounds;

                this._index++;
                rec.Location = new PointF(page.Bounds.X, this.CurrentPage.Bounds.Top);
                rec.Height = this.CurrentPage.Bounds.Height;

                this.CurrentPage.Bounds = rec;
                this.CurrentPage.Location = new PointF(rec.Left, rec.Top);
                this.CurrentPage.BottomRight = new PointF(Math.Max(this.CurrentPage.BottomRight.X, rec.Left), Math.Max(this.CurrentPage.BottomRight.Y, this.CurrentPage.Location.Y));
            }
        }

        [DebuggerStepThrough]
        public void NewPage()
        {
            this._index++;
        }

        [DebuggerStepThrough]
        public void NewPara()
        {
            this.NewLine();
            this.CurrentPage.Location = new PointF(10, this.CurrentPage.Location.Y);
        }

        #endregion
    }
}