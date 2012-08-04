using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using TESVSnip.Collections.Generic;
using TESVSnip.RecordControls;

namespace TESVSnip.Forms
{
    public partial class SubrecordEditor : UserControl
    {
        private Record r;
        private SubRecord sr;
        private SubrecordStructure ss;
        private bool hexView;
        private string strWarnOnSave;

        private readonly OrderedDictionary<ElementStructure, IElementControl> controlMap =
            new OrderedDictionary<ElementStructure, IElementControl>();

        public SubrecordEditor()
        {
            InitializeComponent();
            if (DesignMode) return;
            ClearControl();
        }


        /// <summary>
        /// Clear any state
        /// </summary>
        public void ClearControl()
        {
            r = null;
            sr = null;
            ss = null;
            controlMap.Clear();
            fpanel1.Controls.Clear();
            Enabled = false;
        }

        private Plugin GetPluginFromNode(BaseRecord node)
        {
            BaseRecord tn = node;
            var pluginFromNode = tn as Plugin;
            if (pluginFromNode != null) return pluginFromNode;
            while (!(tn is Plugin) && tn != null) tn = tn.Parent;
            if (tn != null) return tn as Plugin;
            return null;
        }

        public void SetContext(Record r, SubRecord sr, bool hexView)
        {
            if (this.r == r && this.sr == sr && this.hexView == hexView)
                return;

            if (r == null || sr == null)
            {
                ClearControl();
                return;
            }

            // walk each element in standard fashion
            int panelOffset = 0;
            try
            {
                BeginUpdate();

                ClearControl();
                SuspendLayout();
                fpanel1.SuspendLayout();
                fpanel1.Width = Parent.Width;
                controlMap.Clear();

                this.hexView = hexView;
                this.r = r;
                this.sr = sr;
                var p = GetPluginFromNode(r);
                ss = sr.Structure;

                // default to blob if no elements
                if (ss == null || ss.elements == null || hexView)
                {
                    var c = new HexElement();
                    c.Left = 8;
                    c.Width = fpanel1.Width - 16;
                    c.Top = panelOffset;
                    c.Anchor = c.Anchor | AnchorStyles.Left | AnchorStyles.Right;

                    var elem = r.EnumerateElements(sr, true).FirstOrDefault();
                    if (elem != null)
                    {
                        controlMap.Add(elem.Structure, c);
                        fpanel1.Controls.Add(c);
                        c.Data = elem.Data;
                    }
                }
                else
                {
                    foreach (var elem in ss.elements)
                    {
                        Control c = null;
                        if (elem.options != null && elem.options.Length > 1)
                        {
                            c = new OptionsElement();
                        }
                        else if (elem.flags != null && elem.flags.Length > 1)
                        {
                            c = new FlagsElement();
                        }
                        else
                        {
                            switch (elem.type)
                            {
                                case ElementValueType.LString:
                                    c = new LStringElement();
                                    break;
                                case ElementValueType.FormID:
                                    c = new FormIDElement();
                                    break;
                                case ElementValueType.Blob:
                                    c = new HexElement();
                                    break;
                                default:
                                    c = new TextElement();
                                    break;
                            }
                        }
                        if (c is IElementControl)
                        {
                            var ec = c as IElementControl;
                            ec.formIDLookup = p.GetRecordByID;
                            ec.formIDScan = p.EnumerateRecords;
                            ec.strIDLookup = p.LookupFormStrings;
                            ec.Element = elem;

                            if (elem.repeat > 0)
                            {
                                var ge = new RepeatingElement();
                                c = ge;
                                c.Left = 8;
                                c.Width = fpanel1.Width - 16;
                                c.Top = panelOffset;
                                c.Anchor = c.Anchor | AnchorStyles.Left | AnchorStyles.Right;

                                ge.InnerControl = ec;
                                ge.Element = elem;
                                ec = ge;
                            }
                            else if (elem.optional)
                            {
                                var re = new OptionalElement();
                                c = re;
                                c.Left = 8;
                                c.Width = fpanel1.Width - 16;
                                c.Top = panelOffset;
                                c.Anchor = c.Anchor | AnchorStyles.Left | AnchorStyles.Right;

                                re.InnerControl = ec;
                                re.Element = elem;
                                ec = re;
                                c = re;
                            }
                            else
                            {
                                c.Left = 8;
                                c.Width = fpanel1.Width - 16;
                                c.Top = panelOffset;
                                c.Anchor = c.Anchor | AnchorStyles.Left | AnchorStyles.Right;
                            }
                            c.MinimumSize = c.Size;

                            controlMap.Add(elem, ec);
                            fpanel1.Controls.Add(c);
                            panelOffset = c.Bottom;
                        }
                    }

                    foreach (Element elem in r.EnumerateElements(sr, true))
                    {
                        var es = elem.Structure;

                        IElementControl c;
                        if (controlMap.TryGetValue(es, out c))
                        {
                            if (c is IGroupedElementControl)
                            {
                                var gc = c as IGroupedElementControl;
                                gc.Elements.Add(elem.Data);
                            }
                            else
                            {
                                c.Data = elem.Data;
                            }
                        }
                    }
                }
                Enabled = true;
            }
            catch
            {
                strWarnOnSave =
                    "The subrecord doesn't appear to conform to the expected structure.\nThe formatted information may be incorrect.";
            }
            finally
            {
                fpanel1.ResumeLayout();
                ResumeLayout();
                EndUpdate();
                Refresh();
            }
        }

        public void Save()
        {
            if (controlMap.Count <= 0) return;

            // warn user about data corruption.  But this may be case of fixing using tesvsnip to fix corruption so still allow
            if (strWarnOnSave != null)
            {
                if (DialogResult.Yes !=
                    MessageBox.Show(this,
                                    strWarnOnSave + "\n\nData maybe lost if saved. Do you want to continue saving?"
                                    , "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Warning,
                                    MessageBoxDefaultButton.Button2))
                {
                    return;
                }
            }

            using (var str = new MemoryStream())
            {
                foreach (KeyValuePair<ElementStructure, IElementControl> kvp in controlMap)
                {
                    var c = kvp.Value;
                    if (c is IGroupedElementControl)
                    {
                        var gc = c as IGroupedElementControl;
                        foreach (var elem in gc.Elements.Where(elem => elem.Count > 0))
                            str.Write(elem.Array, elem.Offset, elem.Count);
                    }
                    else
                    {
                        var elem = c.Data;
                        if (elem.Count > 0)
                            str.Write(elem.Array, elem.Offset, elem.Count);
                    }
                }
                byte[] newData = str.ToArray();
#if DEBUG
                byte[] originalData = sr.GetReadonlyData();
                if (!ByteArrayCompare(originalData, newData))
                    MessageBox.Show("Data Changed", "Debug", MessageBoxButtons.OK);
#endif
                sr.SetData(newData);
            }
        }

        [DllImport("msvcrt.dll")]
        private static extern int memcmp(byte[] b1, byte[] b2, long count);

        private static bool ByteArrayCompare(byte[] b1, byte[] b2)
        {
            // Validate buffers are the same length.
            // This also ensures that the count does not exceed the length of either buffer.  
            return b1.Length == b2.Length && memcmp(b1, b2, b1.Length) == 0;
        }

        private void fpanel1_Resize(object sender, EventArgs e)
        {
            fpanel1.SuspendLayout();
            foreach (Control c in fpanel1.Controls)
            {
                c.MinimumSize = new Size(Width - c.Left - 30, c.MinimumSize.Height);
            }
            fpanel1.ResumeLayout();
        }

        private void NewMediumLevelRecordEditor_Load(object sender, EventArgs e)
        {
            // If more elements than default panel size then allow increasing overall form to 3/4 current monitor size

            //if (this.fpanel1.PreferredSize.Height > this.fpanel1.Height)
            //{
            //    var screen = Screen.FromPoint(this.Location);
            //    int maxHeight = this.Owner == null ? screen.WorkingArea.Height : this.Owner.Height;
            //    int workingSize = Math.Min(maxHeight, screen.WorkingArea.Height * 3 / 4);
            //    int offset = this.fpanel1.PreferredSize.Height - this.fpanel1.Height + 40; // height of scrollbar?
            //    this.Height = Math.Min(workingSize, this.Height + offset);

            //    if (this.Owner != null)
            //    {
            //        int yOff = (this.Owner.Height - this.Height) / 2;
            //        this.Top = this.Owner.Top + yOff;
            //    }
            //}
        }

        private bool FocusFirstControl(Control c)
        {
            if (c.CanFocus && c.CanSelect)
            {
                c.Focus();
                return true;
            }
            foreach (Control child in c.Controls)
            {
                if (FocusFirstControl(child))
                    return true;
            }
            return false;
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

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        private static extern IntPtr SendMessage(IntPtr hWnd, int msg, IntPtr wParam, IntPtr lParam);
    }
}