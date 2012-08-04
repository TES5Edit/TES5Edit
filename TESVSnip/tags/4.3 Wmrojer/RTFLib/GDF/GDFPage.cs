


namespace GDF
{
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Drawing;
    using System.Drawing.Drawing2D;
    using System.Drawing.Imaging;
    using System.Drawing.Text;
    using System.Windows.Forms;

    // ----------------------------------------------------------------------------------------
    //    _                ___        _..-._   Date: 12/11/08    23:31
    //    \`.|\..----...-'`   `-._.-'' _.-..'     
    //    /  ' `         ,       __.-'' 
    //    )/` _/     \   `-_,   /     Solution: RTFLib
    //    `-'" `"\_  ,_.-;_.-\_ ',    Project : RTFLib                                 
    //        _.-'_./   {_.'   ; /    Author  : Anton
    //       {_.-``-'         {_/     Assembly: 1.0.0.0
    //                                Copyright © 2005-2008, Rogue Trader/MWM
    //        Project Item Name:      GDFPage.cs - Code
    //        Purpose:                Page of GDF Output
    // ----------------------------------------------------------------------------------------
    /// <summary>
    /// Page of GDF Output
    /// </summary>
    public class GDFPage
    {
        #region Fields

        private Graphics _graphics;
        private Image _pageImage;

        #endregion

        #region Constructor

        public GDFPage(Size pageSize) : this(pageSize, SystemColors.Window )
        {
        }

        public GDFPage(Size pageSize, Color defaultBackColor)
        {
            this.PageSize = pageSize;
            this.DefaultBackColor = defaultBackColor;
            this.DefaultForeColor = SystemColors.WindowText;
            this.CellsWritten = new List <RectangleF>();
            this.Bounds = new RectangleF(new PointF(0, 0), pageSize);
        }

        #endregion

        #region Public Properties

        public Image PageImage
        {
            [DebuggerStepThrough]
            get
            {
                if (this._pageImage == null)
                {
                    this._pageImage = new Bitmap(this.PageSize.Width, this.PageSize.Height, PixelFormat.Format32bppArgb);
                }
                return this._pageImage;
            }
        }

        public Graphics PageGraphics
        {
            [DebuggerStepThrough]
            get
            {
                if (this._graphics == null)
                {
                    this._graphics = Graphics.FromImage(this.PageImage);
                    this._graphics.Clear(this.DefaultBackColor);
                    this._graphics.CompositingQuality = CompositingQuality.HighQuality;
                    this._graphics.SmoothingMode = SmoothingMode.AntiAlias;
                    this._graphics.TextRenderingHint = TextRenderingHint.ClearTypeGridFit;
                }

                return this._graphics;
            }
        }

        public PointF Location { get; set; }
        public float LastLineHeight { get; set; }
        public List <RectangleF> CellsWritten { get; set; }
        public Color DefaultBackColor { get; set; }
        public Color DefaultForeColor { get; set; }
        public Size PageSize { get; set; }
        public PointF BottomRight { get; set; }
        public RectangleF Bounds { get; set; }
        public Padding Margins { get; set; }

        #endregion

        #region Public Methods

        public void ResetBounds()
        {
            this.Bounds = new RectangleF(new PointF(0, 0), this.PageSize);
        }

        public void ToGraphics(Graphics graphics)
        {
            graphics.DrawImageUnscaled(this.PageImage, new Point(0, 0));
        }

        public void ToGraphicsClipped(Graphics graphics)
        {
            if (this.BottomRight.X > 0 && this.BottomRight.Y > 0)
            {
                graphics.DrawImage(this.PageImage, new RectangleF(new PointF(0, 0), new SizeF(this.BottomRight.X, this.BottomRight.Y)),
                                   new RectangleF(new PointF(0, 0), new SizeF(this.BottomRight.X, this.BottomRight.Y)), GraphicsUnit.Pixel);
            }
        }

        #endregion
    }
}