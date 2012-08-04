#region License

//////////////////////////////////////////////////////////////////////////
// RichTextBoxEx
// http://www.codeproject.com/KB/string/RTFBuilder.aspx
//
//  Release under CPOL License
//  http://www.codeproject.com/info/cpol10.aspx
//////////////////////////////////////////////////////////////////////////

#endregion

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace RichTextBoxLinks
{
    public class RichTextBoxEx : RichTextBox
    {
        #region Interop-Defines

        [StructLayout(LayoutKind.Sequential)]
        private struct CHARFORMAT2_STRUCT
        {
            public UInt32 cbSize;
            public UInt32 dwMask;
            public UInt32 dwEffects;
            public readonly Int32 yHeight;
            public readonly Int32 yOffset;
            public readonly Int32 crTextColor;
            public readonly byte bCharSet;
            public readonly byte bPitchAndFamily;
            [MarshalAs(UnmanagedType.ByValArray, SizeConst = 32)] public char[] szFaceName;
            public readonly UInt16 wWeight;
            public readonly UInt16 sSpacing;
            public readonly int crBackColor; // Color.ToArgb() -> int
            public readonly int lcid;
            public readonly int dwReserved;
            public readonly Int16 sStyle;
            public readonly Int16 wKerning;
            public readonly byte bUnderlineType;
            public readonly byte bAnimation;
            public readonly byte bRevAuthor;
            public readonly byte bReserved1;
        }

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        private static extern IntPtr SendMessage(IntPtr hWnd, int msg, IntPtr wParam, IntPtr lParam);

        private const int WM_USER = 0x0400;
        private const int EM_GETCHARFORMAT = WM_USER + 58;
        private const int EM_SETCHARFORMAT = WM_USER + 68;

        private const int SCF_SELECTION = 0x0001;
        private const int SCF_WORD = 0x0002;
        private const int SCF_ALL = 0x0004;

        #region CHARFORMAT2 Flags

        private const UInt32 CFE_BOLD = 0x0001;
        private const UInt32 CFE_ITALIC = 0x0002;
        private const UInt32 CFE_UNDERLINE = 0x0004;
        private const UInt32 CFE_STRIKEOUT = 0x0008;
        private const UInt32 CFE_PROTECTED = 0x0010;
        private const UInt32 CFE_LINK = 0x0020;
        private const UInt32 CFE_AUTOCOLOR = 0x40000000;
        private const UInt32 CFE_SUBSCRIPT = 0x00010000; /* Superscript and subscript are */
        private const UInt32 CFE_SUPERSCRIPT = 0x00020000; /*  mutually exclusive			 */

        private const int CFM_SMALLCAPS = 0x0040; /* (*)	*/
        private const int CFM_ALLCAPS = 0x0080; /* Displayed by 3.0	*/
        private const int CFM_HIDDEN = 0x0100; /* Hidden by 3.0 */
        private const int CFM_OUTLINE = 0x0200; /* (*)	*/
        private const int CFM_SHADOW = 0x0400; /* (*)	*/
        private const int CFM_EMBOSS = 0x0800; /* (*)	*/
        private const int CFM_IMPRINT = 0x1000; /* (*)	*/
        private const int CFM_DISABLED = 0x2000;
        private const int CFM_REVISED = 0x4000;

        private const int CFM_BACKCOLOR = 0x04000000;
        private const int CFM_LCID = 0x02000000;
        private const int CFM_UNDERLINETYPE = 0x00800000; /* Many displayed by 3.0 */
        private const int CFM_WEIGHT = 0x00400000;
        private const int CFM_SPACING = 0x00200000; /* Displayed by 3.0	*/
        private const int CFM_KERNING = 0x00100000; /* (*)	*/
        private const int CFM_STYLE = 0x00080000; /* (*)	*/
        private const int CFM_ANIMATION = 0x00040000; /* (*)	*/
        private const int CFM_REVAUTHOR = 0x00008000;


        private const UInt32 CFM_BOLD = 0x00000001;
        private const UInt32 CFM_ITALIC = 0x00000002;
        private const UInt32 CFM_UNDERLINE = 0x00000004;
        private const UInt32 CFM_STRIKEOUT = 0x00000008;
        private const UInt32 CFM_PROTECTED = 0x00000010;
        private const UInt32 CFM_LINK = 0x00000020;
        private const UInt32 CFM_SIZE = 0x80000000;
        private const UInt32 CFM_COLOR = 0x40000000;
        private const UInt32 CFM_FACE = 0x20000000;
        private const UInt32 CFM_OFFSET = 0x10000000;
        private const UInt32 CFM_CHARSET = 0x08000000;
        private const UInt32 CFM_SUBSCRIPT = CFE_SUBSCRIPT | CFE_SUPERSCRIPT;
        private const UInt32 CFM_SUPERSCRIPT = CFM_SUBSCRIPT;

        private const byte CFU_UNDERLINENONE = 0x00000000;
        private const byte CFU_UNDERLINE = 0x00000001;
        private const byte CFU_UNDERLINEWORD = 0x00000002; /* (*) displayed as ordinary underline	*/
        private const byte CFU_UNDERLINEDOUBLE = 0x00000003; /* (*) displayed as ordinary underline	*/
        private const byte CFU_UNDERLINEDOTTED = 0x00000004;
        private const byte CFU_UNDERLINEDASH = 0x00000005;
        private const byte CFU_UNDERLINEDASHDOT = 0x00000006;
        private const byte CFU_UNDERLINEDASHDOTDOT = 0x00000007;
        private const byte CFU_UNDERLINEWAVE = 0x00000008;
        private const byte CFU_UNDERLINETHICK = 0x00000009;
        private const byte CFU_UNDERLINEHAIRLINE = 0x0000000A; /* (*) displayed as ordinary underline	*/

        #endregion

        #endregion

        public RichTextBoxEx()
        {
            // Otherwise, non-standard links get lost when user starts typing
            // next to a non-standard link
            base.DetectUrls = false;
            detectUrls = true;
        }


        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);

            const int ENM_SELCHANGE = 0x80000;
            const int ENM_LINK = 0x4000000;
            SetEventMask(ENM_SELCHANGE | ENM_LINK);
        }

        private static IntPtr moduleHandle;

        protected override CreateParams CreateParams
        {
            get
            {
                //if (!global::TESVSnip.Properties.Settings.Default.UseMsftEdit)
                //    return base.CreateParams;

                if (moduleHandle == IntPtr.Zero)
                {
                    moduleHandle = LoadLibrary("msftedit.dll");
                    if ((long) moduleHandle < 0x20) // default to original
                    {
                        return base.CreateParams;
                    }
                }
                CreateParams createParams = base.CreateParams;
                createParams.ClassName = "RichEdit50W";
                if (Multiline)
                {
                    if (((ScrollBars & RichTextBoxScrollBars.Horizontal) != RichTextBoxScrollBars.None) &&
                        !base.WordWrap)
                    {
                        createParams.Style |= 0x100000;
                        if ((ScrollBars & ((RichTextBoxScrollBars) 0x10)) != RichTextBoxScrollBars.None)
                        {
                            createParams.Style |= 0x2000;
                        }
                    }
                    if ((ScrollBars & RichTextBoxScrollBars.Vertical) != RichTextBoxScrollBars.None)
                    {
                        createParams.Style |= 0x200000;
                        if ((ScrollBars & ((RichTextBoxScrollBars) 0x10)) != RichTextBoxScrollBars.None)
                        {
                            createParams.Style |= 0x2000;
                        }
                    }
                }
                if ((BorderStyle.FixedSingle == base.BorderStyle) && ((createParams.Style & 0x800000) != 0))
                {
                    createParams.Style &= -8388609;
                    createParams.ExStyle |= 0x200;
                }
                return createParams;
            }
        }

        // P/Invoke declarations
        [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        private static extern IntPtr LoadLibrary(string path);


        private bool detectUrls;

        [DefaultValue(true)]
        public new bool DetectUrls
        {
            get { return detectUrls; }
            set { detectUrls = value; }
        }

        /// <summary>
        /// Insert a given text as a link into the RichTextBox at the current insert position.
        /// </summary>
        /// <param name="text">Text to be inserted</param>
        public void InsertLink(string text)
        {
            InsertLink(text, SelectionStart);
        }

        /// <summary>
        /// Insert a given text at a given position as a link. 
        /// </summary>
        /// <param name="text">Text to be inserted</param>
        /// <param name="position">Insert position</param>
        public void InsertLink(string text, int position)
        {
            if (position < 0 || position > Text.Length)
                throw new ArgumentOutOfRangeException("position");

            SelectionStart = position;
            SelectedText = text;
            Select(position, text.Length);
            SetSelectionLink(true);
            Select(position + text.Length, 0);
        }

        /// <summary>
        /// Insert a given text at at the current input position as a link.
        /// The link text is followed by a hash (#) and the given hyperlink text, both of
        /// them invisible.
        /// When clicked on, the whole link text and hyperlink string are given in the
        /// LinkClickedEventArgs.
        /// </summary>
        /// <param name="text">Text to be inserted</param>
        /// <param name="hyperlink">Invisible hyperlink string to be inserted</param>
        public void InsertLink(string text, string hyperlink)
        {
            InsertLink(text, hyperlink, SelectionStart);
        }

        /// <summary>
        /// Insert a given text at a given position as a link. The link text is followed by
        /// a hash (#) and the given hyperlink text, both of them invisible.
        /// When clicked on, the whole link text and hyperlink string are given in the
        /// LinkClickedEventArgs.
        /// </summary>
        /// <param name="text">Text to be inserted</param>
        /// <param name="hyperlink">Invisible hyperlink string to be inserted</param>
        /// <param name="position">Insert position</param>
        public void InsertLink(string text, string hyperlink, int position)
        {
            if (position < 0 || position > Text.Length)
                throw new ArgumentOutOfRangeException("position");

            SelectionStart = position;
            SelectedRtf = @"{\rtf1\ansi " + text + @"\v #" + hyperlink + @"\v0}";
            Select(position, text.Length + hyperlink.Length + 1);
            SetSelectionLink(true);
            Select(position + text.Length + hyperlink.Length + 1, 0);
        }

        /// <summary>
        /// Assign a link to the text at the given position
        /// </summary>
        /// <param name="hyperlink">link to assign</param>
        /// <param name="position"></param>
        /// <param name="length"></param>
        public void SetLink(string hyperlink, int position, int length)
        {
            var originalSelection = SelectionStart;
            SelectionStart = position;
            Select(position, length);
            string text = SelectedText;
            SelectedRtf = @"{\rtf1\ansi " + SelectedText + @"\v #" + hyperlink + @"\v0}";
            Select(position, text.Length + hyperlink.Length + 1);
            SetSelectionLink(true);
            Select(position + text.Length + hyperlink.Length + 1, 0);
            SelectionStart = originalSelection;
        }

        /// <summary>
        /// Set the current selection's link style
        /// </summary>
        /// <param name="link">true: set link style, false: clear link style</param>
        public void SetSelectionLink(bool link)
        {
            SetSelectionStyle(CFM_LINK, link ? CFE_LINK : 0);
        }

        /// <summary>
        /// Get the link style for the current selection
        /// </summary>
        /// <returns>0: link style not set, 1: link style set, -1: mixed</returns>
        public int GetSelectionLink()
        {
            return GetSelectionStyle(CFM_LINK, CFE_LINK);
        }


        private void SetSelectionStyle(UInt32 mask, UInt32 effect)
        {
            var cf = new CHARFORMAT2_STRUCT();
            cf.cbSize = (UInt32) Marshal.SizeOf(cf);
            cf.dwMask = mask;
            cf.dwEffects = effect;

            var wpar = new IntPtr(SCF_SELECTION);
            IntPtr lpar = Marshal.AllocCoTaskMem(Marshal.SizeOf(cf));
            Marshal.StructureToPtr(cf, lpar, false);

            IntPtr res = SendMessage(Handle, EM_SETCHARFORMAT, wpar, lpar);

            Marshal.FreeCoTaskMem(lpar);
        }

        private int GetSelectionStyle(UInt32 mask, UInt32 effect)
        {
            var cf = new CHARFORMAT2_STRUCT();
            cf.cbSize = (UInt32) Marshal.SizeOf(cf);
            cf.szFaceName = new char[32];

            var wpar = new IntPtr(SCF_SELECTION);
            IntPtr lpar = Marshal.AllocCoTaskMem(Marshal.SizeOf(cf));
            Marshal.StructureToPtr(cf, lpar, false);

            IntPtr res = SendMessage(Handle, EM_GETCHARFORMAT, wpar, lpar);

            cf = (CHARFORMAT2_STRUCT) Marshal.PtrToStructure(lpar, typeof (CHARFORMAT2_STRUCT));

            int state;
            // dwMask holds the information which properties are consistent throughout the selection:
            if ((cf.dwMask & mask) == mask)
            {
                if ((cf.dwEffects & effect) == effect)
                    state = 1;
                else
                    state = 0;
            }
            else
            {
                state = -1;
            }

            Marshal.FreeCoTaskMem(lpar);
            return state;
        }


        public new string Rtf
        {
            get { return base.Rtf; }
            set { SetRtfText(value); }
        }

        public void BeginUpdate()
        {
            SendMessage(Handle, WM_SETREDRAW, (IntPtr) 0, IntPtr.Zero);
        }

        public void EndUpdate()
        {
            SendMessage(Handle, WM_SETREDRAW, (IntPtr) 1, IntPtr.Zero);
        }

        private const int WM_SETREDRAW = 0x0b;

        private int lastSetHashCode;

        private static readonly Regex linkRegex = new Regex(
            @"\{\\field\s+\{\\\*\\fldinst\s+HYPERLINK\s+\u0022?(?<link>[^\u0022}]+)\u0022?\s*\}\s*\{\\fldrslt(?:\\cf[0-9]+\\ul)\s+(?<name>[^}]+)\s*\}\s*\}"
            );

        private void SetRtfText(string value)
        {
            bool oldReadOnly = ReadOnly;

            // if moduleHandle is zero we are using legacy rtf and need this link code
            if (!detectUrls || moduleHandle != IntPtr.Zero)
            {
                ReadOnly = false;
                base.Rtf = value;
                ReadOnly = oldReadOnly;
                return;
            }
            if (value == null)
            {
                ReadOnly = false;
                Text = "";
                ReadOnly = oldReadOnly;
                return;
            }

            // Quick check to see if current text equals last text to be set
            int hashCode = value.GetHashCode();
            if (hashCode == lastSetHashCode)
                return;
            lock (this)
            {
                lastSetHashCode = hashCode;
                try
                {
                    Cursor.Hide();
                    BeginUpdate();
                    ReadOnly = false;
                    var sb = new StringBuilder(value);
                    var matches = new List<LinkMatch>();
                    int idx = 0;
                    while (true)
                    {
                        var match = linkRegex.Match(sb.ToString(), idx);
                        if (!match.Success) break;
                        var link = match.Groups["link"];
                        var name = match.Groups["name"];
                        var m2 = new LinkMatch(link.Value, name.Value, match.Index, name.Length);
                        sb.Remove(match.Index, match.Length);
                        string linkText = string.Format("#:@{0}@:#", matches.Count.ToString());
                        sb.Insert(match.Index, linkText);
                        matches.Add(m2);
                        idx = match.Index + linkText.Length;
                    }
                    base.Rtf = sb.ToString();
                    idx = 0;
                    try
                    {
                        while (true)
                        {
                            int start = base.Find("#:@", idx, RichTextBoxFinds.NoHighlight);
                            if (start == -1) break;
                            int end = base.Find("@:#", start + 3, RichTextBoxFinds.NoHighlight);
                            if (end == -1) break; // Error?

                            base.Select(start, end - start + 3);
                            string text = base.SelectedText;
                            int link = int.Parse(text.Substring(3, text.Length - 6));
                            var match = matches[link];
                            base.SelectedText = "";
                            InsertLink(match.name, match.link, start);
                        }
                    }
                    catch
                    {
                    }
                    base.SelectionStart = 0;
                    //Point factored = new Point(0,0);
                    //SendMessage(this.Handle, (int)WindowsMessages.EM_SETSCROLLPOS, 0, ref factored);
                    //base.ScrollToCaret();
                }
                catch
                {
                    base.Rtf = value;
                }
                finally
                {
                    try
                    {
                        ReadOnly = oldReadOnly;
                        EndUpdate();
                        Invalidate();
                        Update();
                        Cursor.Show();
                    }
                    catch
                    {
                    }
                }
            }
        }

        private struct LinkMatch
        {
            public LinkMatch(string link, string name, int index, int length)
            {
                this.link = link;
                this.name = name;
                this.index = index;
                this.length = length;
            }

            public readonly string link;
            public readonly string name;
            public readonly int index;
            public readonly int length;
        }

        protected uint SetEventMask(uint dwEventMask)
        {
            const int EM_SETEVENTMASK = 0x445;
            return SendMessage(new HandleRef(this, base.Handle), EM_SETEVENTMASK, 0, dwEventMask);
        }

        [DllImport("user32.dll", SetLastError = true)]
        private static extern uint SendMessage(HandleRef hWnd, int Msg, uint wParam, uint lParam);

        protected override void WndProc(ref Message m)
        {
            const int WM_NOTIFY = 0x004E;
            switch (m.Msg)
            {
                    // case (int)WindowsMessage.WM_REFLECT + (int)WindowsMessage.WM_NOTIFY:
                case (0x0400 + 0x1c00 + WM_NOTIFY):
                    WmReflectNotify(ref m);
                    return;
                default:
                    base.WndProc(ref m);
                    break;
            }
        }

        //NMHDR structure used to get data from WM_NOTIFY messages.
        [StructLayout(LayoutKind.Sequential)]
        public struct NMHDR
        {
            public IntPtr hwndFrom;
            public IntPtr idFrom;
            public int code;
        }

        [StructLayout(LayoutKind.Sequential)]
        public class ENLINK
        {
            public NMHDR nmhdr;
            public int msg;
            public IntPtr wParam = IntPtr.Zero;
            public IntPtr lParam = IntPtr.Zero;
            public CHARRANGE charrange;
        }

        [StructLayout(LayoutKind.Sequential)]
        public class CHARRANGE
        {
            public int cpMin;
            public int cpMax;
        }

        [StructLayout(LayoutKind.Sequential)]
        public class TEXTRANGE
        {
            public CHARRANGE chrg;
            public IntPtr lpstrText;
        }

        [StructLayout(LayoutKind.Sequential)]
        public class ENLINK64
        {
            [MarshalAs(UnmanagedType.ByValArray, SizeConst = 0x38)] public byte[] contents = new byte[0x38];
        }

        internal void WmReflectNotify(ref Message m)
        {
            const int EN_LINK = 0x70b;
            if (!(m.HWnd == base.Handle))
            {
                base.WndProc(ref m);
            }
            else
            {
                var lParam = (NMHDR) m.GetLParam(typeof (NMHDR));
                int code = lParam.code;
                switch (code)
                {
                    case EN_LINK:
                        if (!EnLinkMsgHandler(ref m))
                            base.WndProc(ref m);
                        break;
                    default:
                        base.WndProc(ref m);
                        break;
                }
            }
        }

        private static unsafe ENLINK ConvertFromENLINK64(ENLINK64 es64)
        {
            var enlink = new ENLINK();
            fixed (byte* numRef = es64.contents)
            {
                enlink.nmhdr = new NMHDR();
                enlink.charrange = new CHARRANGE();
                enlink.nmhdr.hwndFrom = Marshal.ReadIntPtr((IntPtr) numRef);
                enlink.nmhdr.idFrom = Marshal.ReadIntPtr((IntPtr) (numRef + 8));
                enlink.nmhdr.code = Marshal.ReadInt32((IntPtr) (numRef + 0x10));
                enlink.msg = Marshal.ReadInt32((IntPtr) (numRef + 0x18));
                enlink.wParam = Marshal.ReadIntPtr((IntPtr) (numRef + 0x1c));
                enlink.lParam = Marshal.ReadIntPtr((IntPtr) (numRef + 0x24));
                enlink.charrange.cpMin = Marshal.ReadInt32((IntPtr) (numRef + 0x2c));
                enlink.charrange.cpMax = Marshal.ReadInt32((IntPtr) (numRef + 0x30));
            }
            return enlink;
        }

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr SendMessage(HandleRef hWnd, int msg, int wParam, TEXTRANGE lParam);

        public abstract class CharBuffer
        {
            public class AnsiCharBuffer : CharBuffer
            {
                // Fields
                internal byte[] buffer;
                internal int offset;

                // Methods
                public AnsiCharBuffer(int size)
                {
                    buffer = new byte[size];
                }

                public override IntPtr AllocCoTaskMem()
                {
                    IntPtr destination = Marshal.AllocCoTaskMem(buffer.Length);
                    Marshal.Copy(buffer, 0, destination, buffer.Length);
                    return destination;
                }

                public override string GetString()
                {
                    int offset = this.offset;
                    while ((offset < buffer.Length) && (buffer[offset] != 0))
                    {
                        offset++;
                    }
                    string str = Encoding.Default.GetString(buffer, this.offset, offset - this.offset);
                    if (offset < buffer.Length)
                    {
                        offset++;
                    }
                    this.offset = offset;
                    return str;
                }

                public override void PutCoTaskMem(IntPtr ptr)
                {
                    Marshal.Copy(ptr, buffer, 0, buffer.Length);
                    offset = 0;
                }

                public override void PutString(string s)
                {
                    byte[] bytes = Encoding.Default.GetBytes(s);
                    int length = Math.Min(bytes.Length, buffer.Length - offset);
                    Array.Copy(bytes, 0, buffer, offset, length);
                    offset += length;
                    if (offset < buffer.Length)
                    {
                        buffer[offset++] = 0;
                    }
                }
            }

            public class UnicodeCharBuffer : CharBuffer
            {
                // Fields
                internal char[] buffer;
                internal int offset;

                // Methods
                public UnicodeCharBuffer(int size)
                {
                    buffer = new char[size];
                }

                public override IntPtr AllocCoTaskMem()
                {
                    IntPtr destination = Marshal.AllocCoTaskMem(buffer.Length*2);
                    Marshal.Copy(buffer, 0, destination, buffer.Length);
                    return destination;
                }

                public override string GetString()
                {
                    int offset = this.offset;
                    while ((offset < buffer.Length) && (buffer[offset] != '\0'))
                    {
                        offset++;
                    }
                    var str = new string(buffer, this.offset, offset - this.offset);
                    if (offset < buffer.Length)
                    {
                        offset++;
                    }
                    this.offset = offset;
                    return str;
                }

                public override void PutCoTaskMem(IntPtr ptr)
                {
                    Marshal.Copy(ptr, buffer, 0, buffer.Length);
                    offset = 0;
                }

                public override void PutString(string s)
                {
                    int count = Math.Min(s.Length, buffer.Length - offset);
                    s.CopyTo(0, buffer, offset, count);
                    offset += count;
                    if (offset < buffer.Length)
                    {
                        buffer[offset++] = '\0';
                    }
                }
            }

            // Methods

            public abstract IntPtr AllocCoTaskMem();

            public static CharBuffer CreateBuffer(int size)
            {
                if (Marshal.SystemDefaultCharSize == 1)
                {
                    return new AnsiCharBuffer(size);
                }
                return new UnicodeCharBuffer(size);
            }

            public abstract string GetString();
            public abstract void PutCoTaskMem(IntPtr ptr);
            public abstract void PutString(string s);
        }


        private string CharRangeToString(CHARRANGE c)
        {
            var lParam = new TEXTRANGE();
            lParam.chrg = c;
            //if ((c.cpMax > this.Text.Length) || ((c.cpMax - c.cpMin) <= 0))
            //{
            //    return string.Empty;
            //}
            int size = (c.cpMax - c.cpMin) + 1;
            CharBuffer buffer = CharBuffer.CreateBuffer(size);
            IntPtr ptr = buffer.AllocCoTaskMem();
            if (ptr == IntPtr.Zero)
            {
                throw new OutOfMemoryException("OutOfMemory");
            }
            lParam.lpstrText = ptr;
            var num1 = (int) SendMessage(new HandleRef(this, base.Handle), 0x44b, 0, lParam);
            buffer.PutCoTaskMem(ptr);
            if (lParam.lpstrText != IntPtr.Zero)
            {
                Marshal.FreeCoTaskMem(ptr);
            }
            return buffer.GetString();
        }


        private bool EnLinkMsgHandler(ref Message m)
        {
            ENLINK lParam;
            if (IntPtr.Size == 8)
            {
                lParam = ConvertFromENLINK64((ENLINK64) m.GetLParam(typeof (ENLINK64)));
            }
            else
            {
                lParam = (ENLINK) m.GetLParam(typeof (ENLINK));
            }
            switch (lParam.msg)
            {
                case 0x20:
                    //this.LinkCursor = true;
                    m.Result = (IntPtr) 1;
                    return false;

                case 0x201:
                    {
                        string str = CharRangeToString(lParam.charrange);
                        if (!string.IsNullOrEmpty(str))
                        {
                            OnLinkClicked(new LinkClickedEventArgs(str));
                        }
                        m.Result = (IntPtr) 1;
                        return true;
                    }
            }
            m.Result = IntPtr.Zero;
            return false;
        }
    }
}