//using CurrentPatient.Properties;


using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;

namespace RTF
{
    // ----------------------------------------------------------------------------------------
    //    _                ___        _..-._   Date: 12/11/08    23:34
    //    \`.|\..----...-'`   `-._.-'' _.-..'     
    //    /  ' `         ,       __.-'' 
    //    )/` _/     \   `-_,   /     Solution: RTFLib
    //    `-'" `"\_  ,_.-;_.-\_ ',    Project : RTFLib                                 
    //        _.-'_./   {_.'   ; /    Author  : Anton
    //       {_.-``-'         {_/     Assembly: 1.0.0.0
    //                                Copyright © 2005-2008, Rogue Trader/MWM
    //        Project Item Name:      RTFBuilder.cs - Code
    //        Purpose:                Rich Text Generator
    // ----------------------------------------------------------------------------------------
    /// <summary>
    /// Rich Text Generator
    /// </summary>
    public partial class RTFBuilder : RTFBuilderbase
    {
        #region Fields

        private static readonly char[] toHex = "0123456789ABCDEF".ToCharArray();
        private static readonly char[][] charEscape;
        private static Encoding CP1252;
        private readonly StringBuilder _sb;

        #endregion

        #region Constructor

        static RTFBuilder()
        {
            charEscape = new char[256][];
            for (int i = 0x00; i < 0x20; ++i) charEscape[i] = new[] {'\\', '\'', toHex[i >> 4], toHex[(i & 0xF)]};
            for (int i = 0x20; i < 0x80; ++i) charEscape[i] = new[] {(char) i};
            for (int i = 0x80; i < 0x100; ++i) charEscape[i] = new[] {'\\', '\'', toHex[i >> 4], toHex[(i & 0xF)]};
            charEscape[0x5C] = new[] {'\\', '\'', toHex[0x5], toHex[0xC]};
            charEscape[0x7B] = new[] {'\\', '\'', toHex[0x7], toHex[0xB]};
            charEscape[0x7D] = new[] {'\\', '\'', toHex[0x7], toHex[0xD]};
            charEscape['\n'] = @"\line ".ToCharArray();
            charEscape['\r'] = new char[0];
            CP1252 = Encoding.GetEncoding(1252);
        }

        public RTFBuilder()
            : base(RTFFont.Arial, 20F)
        {
            _sb = new StringBuilder();
        }

        public RTFBuilder(RTFFont defaultFont) : base(defaultFont, 20F)
        {
            _sb = new StringBuilder();
        }

        public RTFBuilder(float defaultFontSize) : base(RTFFont.Arial, defaultFontSize)
        {
            _sb = new StringBuilder();
        }

        public RTFBuilder(RTFFont defaultFont, float defaultFontSize) : base(defaultFont, defaultFontSize)
        {
            _sb = new StringBuilder();
        }

        public RTFBuilder(RTFFont defaultFont, float defaultFontSize, ushort codepage, byte charset)
            : base(defaultFont, defaultFontSize, codepage, charset)
        {
            _sb = new StringBuilder();
        }

        #endregion

        #region Override Methods

        protected override void AppendInternal(string value)
        {
            if (!string.IsNullOrEmpty(value))
            {
                using (new RTFFormatWrap(this))
                {
                    foreach (char c in value)
                    {
                        if (c > 0xFF)
                            _sb.Append("\\u").Append((int) c).Append("?");
                        else
                            _sb.Append(charEscape[c]);
                    }
                }
            }
        }

        protected override void AppendLevelInternal(int level)
        {
            _sb.AppendFormat("\\level{0} ", level);
        }

        protected override void AppendLineInternal(string value)
        {
            using (new RTFParaWrap(this))
            {
                Append(value);
                _sb.AppendLine("\\line");
            }
        }

        protected override void AppendLineInternal()
        {
            _sb.AppendLine("\\line");
        }

        protected override void AppendPageInternal()
        {
            using (new RTFParaWrap(this))
            {
                _sb.AppendLine("\\page");
            }
        }

        protected override void AppendParaInternal()
        {
            using (new RTFParaWrap(this))
            {
                _sb.AppendLine("\\par ");
            }
        }

        protected override void AppendRTFInternal(string rtf)
        {
            if (!string.IsNullOrEmpty(rtf))
            {
                _sb.Append(rtf);
            }
        }

        protected override IEnumerable<RTFBuilderbase> EnumerateCellsInternal(RTFRowDefinition rowDefinition,
                                                                              IEnumerable<RTFCellDefinition>
                                                                                  cellDefinitions)
        {
            using (IRTFRow ie = CreateRow(rowDefinition, cellDefinitions))
            {
                IEnumerator<IBuilderContent> ie2 = ie.GetEnumerator();
                while (ie2.MoveNext())
                {
                    using (IBuilderContent item = ie2.Current)
                    {
                        yield return item.Content;
                    }
                }
            }
        }

        public override IDisposable FormatLock()
        {
            return new RTFBuilderUnWrapped(this);
        }

        protected override void InsertImageInternal(Image image)
        {
            try
            {
                var rti = new RTFImage(this);
                rti.InsertImage(image);
            }
            catch
            {
                _sb.AppendLine("[Insert image error]");
            }
        }

        protected override int LengthInternal()
        {
            throw new NotImplementedException();
        }

        protected override void ResetInternal()
        {
            _sb.AppendLine("\\pard");
        }

        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("{\\rtf1\\ansi\\ansicpg1252\\deff0\\deflang").Append(DefLang);
            sb.Append("{\\fonttbl");

            for (int i = 0; i < _rawFonts.Count; i++)
            {
                try
                {
                    sb.Append(string.Format(_rawFonts[i], i));
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            sb.AppendLine("}");

            sb.Append("{\\colortbl ;");

            foreach (Color item in _colortbl)
            {
                sb.AppendFormat("\\red{0}\\green{1}\\blue{2};", item.R, item.G, item.B);
            }

            sb.AppendLine("}");


            sb.Append("\\viewkind4\\uc1\\pard\\plain\\f0");

            sb.AppendFormat("\\fs{0} ", DefaultFontSize);
            sb.AppendLine();

            sb.Append(_sb.ToString());
            sb.Append("}");


            return sb.ToString();
        }

        #endregion

        #region Public Methods

        public IRTFRow CreateRow(RTFRowDefinition rowDefinition, IEnumerable<RTFCellDefinition> cellDefinitions)
        {
            return new RTFRow(this, rowDefinition, cellDefinitions);
        }

        #endregion
    }
}