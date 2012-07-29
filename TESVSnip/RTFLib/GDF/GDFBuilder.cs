
namespace GDF
{
    using System;
    using System.Collections.Generic;
    using System.Drawing;
    using System.Text.RegularExpressions;
    using RTF;




    // ----------------------------------------------------------------------------------------
    //    _                ___        _..-._   Date: 12/11/08    23:27
    //    \`.|\..----...-'`   `-._.-'' _.-..'     
    //    /  ' `         ,       __.-'' 
    //    )/` _/     \   `-_,   /     Solution: RTFLib
    //    `-'" `"\_  ,_.-;_.-\_ ',    Project : RTFLib                                 
    //        _.-'_./   {_.'   ; /    Author  : Anton
    //       {_.-``-'         {_/     Assembly: 1.0.0.0
    //                                Copyright © 2005-2008, Rogue Trader/MWM
    //        Project Item Name:      GDFBuilder.cs - Code
    //        Purpose:                Graphics Based RichText Builder
    // ----------------------------------------------------------------------------------------
    /// <summary>
    /// Graphics Based RichText Builder
    /// </summary>
    public partial class GDFBuilder : RTFBuilderbase
    {
        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="GDFBuilder"/> class.
        /// </summary>
        /// <param name="manager">The manager.</param>
        public GDFBuilder(GDFPageManager manager) : base(RTFFont.Arial, 20F)
        {
            this.Manager = manager;
            _sf.FormatFlags |= StringFormatFlags.LineLimit;
        }

        #endregion

        #region Properties

        internal GDFPageManager Manager { get; set; }

        #endregion

        #region Override Methods

        /// <summary>
        /// Appends the internal.
        /// </summary>
        /// <param name="value">The value.</param>
        protected override void AppendInternal(string value)
        {
            if (string.IsNullOrEmpty(value))
            {
                return;
            }
            using (Font font = this.GenerateFont())
            {
                int chars;
                int lines = 1;
                string remaining = value;
                int pos = 0;
                while (pos < value.Length)
                {
                    SizeF layout = this.Manager.LineLayout();
                    SizeF size = this.Manager.CurrentPage.PageGraphics.MeasureString(remaining, font, layout, _sf, out chars, out lines);
                    //outputs nonwords if less than first word 
                    if (pos == 0 && chars < value.Length)
                    {
                        int index = value.LastIndexOf(' ', chars);
                        if (index > 0 && index < (chars - 1))
                        {
                            chars = index;
                        }
                        else if (index == -1)
                        {
                            //move on to next line if layout.Left != Bounds.Left
                            if (this.Manager.CurrentPage.Location.X != this.Manager.CurrentPage.Bounds.Left)
                            {
                                chars = 0;
                                this.Manager.NewLine();
                                continue;
                            }
                        }
                    }
                    if (chars > 0)
                    {
                        pos += chars;
                        if (!string.IsNullOrEmpty(remaining))
                        {
                            PointF loc = PointF.Empty;
                            switch (_sf.Alignment)
                            {
                                case StringAlignment.Center:
                                    loc = new PointF(this.Manager.CurrentPage.Bounds.Right - this.Manager.CurrentPage.Bounds.Width / 2, this.Manager.CurrentPage.Location.Y);
                                    break;
                                case StringAlignment.Far:
                                    loc = new PointF(this.Manager.CurrentPage.Bounds.Right, this.Manager.CurrentPage.Location.Y);
                                    break;
                                case StringAlignment.Near:
                                    loc = this.Manager.CurrentPage.Location;
                                    break;
                            }
                            if (_backcolor != DefaultBackColor)
                            {
                                RectangleF back = new RectangleF(loc, size);
                                using (Brush brush = new SolidBrush(_backcolor))
                                {
                                    this.Manager.CurrentPage.PageGraphics.FillRectangle(brush, back);
                                }
                            }
                            using (Brush brush = new SolidBrush(_forecolor))
                            {
                                this.Manager.CurrentPage.PageGraphics.DrawString(remaining.Substring(0, chars), font, brush, loc, _sf);
                            }
                        }
                    }
                    if (pos < value.Length)
                    {
                        remaining = value.Substring(pos);
                        this.Manager.NewFlowLine(size);
                    }
                    else
                    {
                        this.Manager.MoveLocationRight(size);
                    }
                }
            }
            this.ResetInternal();
        }

        protected override void AppendLevelInternal(int level)
        {
            throw new NotImplementedException();
        }

        protected override void AppendLineInternal(string value)
        {
            Append(value);
            this.Manager.NewLine();
        }

        protected override void AppendLineInternal()
        {
            this.Manager.NewLine();
            this.ResetInternal();
        }

        protected override void AppendPageInternal()
        {
            this.Manager.NewPage();
            this.ResetInternal();
        }

        protected override void AppendParaInternal()
        {
            this.Manager.NewPara();
            this.ResetInternal();
        }

        protected override void AppendRTFInternal(string rtf)
        {
            RTFBuilderParser parser = new RTFBuilderParser(this);
            parser.AppendRTF(rtf);
        }

        protected override IEnumerable <RTFBuilderbase> EnumerateCellsInternal(RTFRowDefinition rowDefinition, RTFCellDefinition[] cellDefinitions)
        {
            using (GDFRow row = new GDFRow(this, rowDefinition, cellDefinitions))
            {
                foreach (GDFCell cell in row)
                {
                    using (cell)
                    {
                        yield return cell.Content;
                    }
                }
            }
        }

        public override IDisposable FormatLock()
        {
            return new UnWrapped(this);
        }

        protected override void InsertImageInternal(Image image)
        {
            this.Manager.CurrentPage.PageGraphics.DrawImageUnscaled(image, (Point.Ceiling(this.Manager.CurrentPage.Location)));
            this.Manager.CurrentPage.LastLineHeight = Math.Max(this.Manager.CurrentPage.LastLineHeight, image.Height);
            this.Manager.CurrentPage.Location = new PointF(this.Manager.CurrentPage.Location.X + image.Width, this.Manager.CurrentPage.Location.Y);
            this.Manager.CurrentPage.BottomRight = new PointF(Math.Max(this.Manager.CurrentPage.BottomRight.X, this.Manager.CurrentPage.Location.X),
                                                              Math.Max(this.Manager.CurrentPage.BottomRight.Y, this.Manager.CurrentPage.Location.X + image.Height));
        }

        protected override int LengthInternal()
        {
            throw new NotImplementedException();
        }

        protected override void ResetInternal()
        {
            if (base._unwrapped)
            {
                return;
            }

            _forecolor = Defaultforecolor;
            _fontSize = DefaultFontSize;
            _sf.Alignment = StringAlignment.Near;
            if (_forecolor != Defaultforecolor)
            {
                int cind = IndexOf(_forecolor);
                _forecolor = Defaultforecolor;
            }
            if (_backcolor != DefaultBackColor)
            {
                int cind = IndexOf(DefaultBackColor);
                _backcolor = DefaultBackColor;
            }
            _fontSize = DefaultFontSize;
            _sf.Alignment = StringAlignment.Near;
            _fontStyle = System.Drawing.FontStyle.Regular;
            _font = 0;
        }

        #endregion

        #region Methods

        private Font GenerateFont()
        {
            Font font = null;
            string raw = base._rawFonts[_font];
            string ResultString = null;
            try
            {
                string reg =
                    "(\\\\fcharset(?<fcharset>\\d{1,3}) (?<FONT>[\\w -]+);\\})";
                Match m = Regex.Match(raw, reg,RegexOptions.Singleline);
                if (m.Success)
                {
                    Group g = m.Groups["FONT"];


                    string FONT = g.Value;
                    font = new Font(FONT, _fontSize * 0.6F, _fontStyle, GraphicsUnit.Pixel);
                }
                else
                {
                    font = new Font("Arial", _fontSize * 0.6F, _fontStyle, GraphicsUnit.Pixel);
                }
            }
            catch (ArgumentException ex)
            {
                font = new Font("Arial", _fontSize * 0.6F, _fontStyle, GraphicsUnit.Pixel);
            }
   
       

            return font;
        }

        #endregion
    }
}