using System.Windows.Forms;
using RTF;

namespace TESVSnip.Docking
{
    public partial class RichTextContent : BaseDockContent
    {
        public RichTextContent()
        {
            InitializeComponent();
        }

        public void UpdateRtf(string rtfText)
        {
            this.rtfInfo.Rtf = rtfText;
        }

        public void UpdateText(string text)
        {
            this.rtfInfo.Text = text;
        }

        public RichTextBox RtfInfo
        {
            get { return this.rtfInfo; }
        }

        public void UpdateRecord(BaseRecord sc)
        {
            if (sc == null)
            {
                UpdateText("");
                return;
            }
            FontLangInfo defLang;
            if (!Encoding.TryGetFontInfo(Properties.Settings.Default.LocalizationName, out defLang))
                defLang = new FontLangInfo(1252, 1033, 0);

            var rb = new RTFBuilder(RTFFont.Arial, 16, defLang.lcid, defLang.charset);
            sc.GetFormattedHeader(rb);
            sc.GetFormattedData(rb);
            this.rtfInfo.Rtf = rb.ToString();            
        }
    }
}