
namespace RTF
{
    using System.Drawing;
    using System.IO;
    using System.Text;

    public class RTFBuilderParser
    {
        #region Fields

        private const int Eof = -1;
        private readonly RTFBuilderbase _builder;

        #endregion

        #region Constructor

        public RTFBuilderParser(RTFBuilderbase builder)
        {
            this._builder = builder;
        }

        #endregion

        #region Public Methods

        public void AppendRTF(string rtf)
        {
            StringReader sr = new StringReader(rtf);
            int c = sr.Peek();
            if (c == '\\')
            {
                sr.Read();
            }

            using (this._builder.FormatLock())
            {
                while (c != Eof)
                {
                    switch (c)
                    {
                        case '\\':
                            c = this.TokenAction(sr);
                            break;
                        default:
                            c = this.ReadString(sr, c);
                            break;
                    }
                }
            }
        }

        #endregion

        #region Methods

        private void Action(string rtfcode)
        {
            switch (rtfcode)
            {
                case "b":
                    this._builder.FontStyleOR(FontStyle.Bold);
                    break;
                case "par":
                case "line":
                    this._builder.AppendLine();
                    break;
                case "bullet":
                    this._builder.Append('\u25A0');
                    break;
                case "lquote":
                case "rquote":
                    this._builder.Append("\'");
                    break;
                default:
                    break;
            }
        }

        private void Action(string rtfcode, int rtfparam)
        {
            switch (rtfcode)
            {
                case "b":
                    this._builder.FontStyleNOT(FontStyle.Bold);
                    break;
                case "fs":
                    this._builder.FontSize(rtfparam);
                    break;
                case "cf":
                    this._builder.ForeColor(rtfparam);
                    break;
                case "f":
                    this._builder.Font(rtfparam);
                    break;
                default:
                    break;
            }
        }

        private int ReadString(StringReader sr, int c)
        {
            StringBuilder sb = new StringBuilder();

            while (c != Eof)
            {
                if (c == '\\')
                {
                    int cc = sr.Peek();
                    if (cc == '\\' || cc == '}' || cc == '{')
                    {
                        c = cc;
                    }
                    else
                    {
                        break;
                    }
                }
                sb.Append((char) c);
                c = sr.Read();
                while (c == '\r' || c == '\n' || c == '\t' || c == '\0')
                {
                    c = sr.Read();
                }
            }

            if (sb.Length > 0)
            {
                this._builder.Append(sb.ToString());
            }
            return c;
        }


        /// <summary>
        /// runs when / found
        /// </summary>
        /// <param name="sr"></param>
        /// <returns></returns>
        private int TokenAction(StringReader sr)
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sb2 = new StringBuilder();
            int c = sr.Read();
            while (char.IsLetter((char) c))
            {
                sb.Append((char) c);
                c = sr.Read();
            }
            while (char.IsDigit((char) c))
            {
                sb2.Append((char) c);
                c = sr.Read();
            }
            //if (c == ' ')
            //{
            //    c = sr.Read();
            //}
            if (sb.Length > 0)
            {
                if (sb2.Length > 0)
                {
                    int num;
                    if (int.TryParse(sb2.ToString(), out num))
                    {
                        this.Action(sb.ToString(), num);
                        return c;
                    }
                }
                this.Action(sb.ToString());
            }

            return c;
        }

        #endregion
    }
}