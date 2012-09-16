namespace TESVSnip.UI.Forms
{
    using System;
    using System.Drawing;
    using System.IO;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Framework.Collections;
    using TESVSnip.Properties;
    using TESVSnip.UI.RecordControls;

    internal partial class NewMediumLevelRecordEditor : Form
    {
        private readonly OrderedDictionary<ElementStructure, IElementControl> controlMap = new OrderedDictionary<ElementStructure, IElementControl>();

        private readonly SubRecord sr;

        private readonly string strWarnOnSave;

        private Plugin p;

        private Record r;

        private SubrecordStructure ss;

        public NewMediumLevelRecordEditor(Plugin p, Record r, SubRecord sr, SubrecordStructure ss)
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
            SuspendLayout();
            this.sr = sr;
            this.ss = ss;
            this.p = p;
            this.r = r;

            // walk each element in standard fashion
            int panelOffset = 0;
            try
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
                            c.Width = this.fpanel1.Width - 16;
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
                            c.Width = this.fpanel1.Width - 16;
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
                            c.Width = this.fpanel1.Width - 16;
                            c.Top = panelOffset;
                            c.Anchor = c.Anchor | AnchorStyles.Left | AnchorStyles.Right;
                        }

                        c.MinimumSize = c.Size;

                        this.controlMap.Add(elem, ec);
                        this.fpanel1.Controls.Add(c);
                        panelOffset = c.Bottom;
                    }
                }

                foreach (Element elem in r.EnumerateElements(sr, true))
                {
                    var es = elem.Structure;

                    IElementControl c;
                    if (this.controlMap.TryGetValue(es, out c))
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
            catch
            {
                this.strWarnOnSave = "The subrecord doesn't appear to conform to the expected structure.\nThe formatted information may be incorrect.";
                this.Error.SetError(this.bSave, this.strWarnOnSave);
                this.Error.SetIconAlignment(this.bSave, ErrorIconAlignment.MiddleLeft);
                AcceptButton = this.bCancel; // remove save as default button when exception occurs
                CancelButton = this.bCancel;
                UpdateDefaultButton();
            }

            ResumeLayout();
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
                if (this.FocusFirstControl(child))
                {
                    return true;
                }
            }

            return false;
        }

        private void NewMediumLevelRecordEditor_Load(object sender, EventArgs e)
        {
            // If more elements than default panel size then allow increasing overall form to 3/4 current monitor size
            if (this.fpanel1.PreferredSize.Height > this.fpanel1.Height)
            {
                var screen = Screen.FromPoint(Location);
                int maxHeight = Owner == null ? screen.WorkingArea.Height : Owner.Height;
                int workingSize = Math.Min(maxHeight, screen.WorkingArea.Height * 3 / 4);
                int offset = this.fpanel1.PreferredSize.Height - this.fpanel1.Height + 40; // height of scrollbar?
                Height = Math.Min(workingSize, Height + offset);

                if (Owner != null)
                {
                    int yOff = (Owner.Height - Height) / 2;
                    Top = Owner.Top + yOff;
                }
            }
        }

        private void NewMediumLevelRecordEditor_Shown(object sender, EventArgs e)
        {
            // forward focus to first child control
            this.FocusFirstControl(this.fpanel1);
        }

        private void bCancel_Click(object sender, EventArgs e)
        {
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            // warn user about data corruption.  But this may be case of fixing using tesvsnip to fix corruption so still allow
            if (this.strWarnOnSave != null)
            {
                if (DialogResult.Yes
                    !=
                    MessageBox.Show(
                        this, 
                        this.strWarnOnSave + "\n\nData maybe lost if saved. Do you want to continue saving?", 
                        "Warning", 
                        MessageBoxButtons.YesNo, 
                        MessageBoxIcon.Warning, 
                        MessageBoxDefaultButton.Button2))
                {
                    return;
                }
            }

            using (var str = new MemoryStream())
            {
                foreach (var kvp in this.controlMap)
                {
                    var c = kvp.Value;
                    if (c is IGroupedElementControl)
                    {
                        var gc = c as IGroupedElementControl;
                        foreach (var elem in gc.Elements)
                        {
                            str.Write(elem.Array, elem.Offset, elem.Count);
                        }
                    }
                    else
                    {
                        var elem = c.Data;
                        if (elem.Count > 0 && elem.Array != null)
                        {
                            str.Write(elem.Array, elem.Offset, elem.Count);
                        }
                    }
                }

                byte[] newData = str.ToArray();
                this.sr.SetData(newData);
            }
        }

        private void fpanel1_Resize(object sender, EventArgs e)
        {
            this.fpanel1.SuspendLayout();
            foreach (Control c in this.fpanel1.Controls)
            {
                c.MinimumSize = new Size(Width - c.Left - 30, c.MinimumSize.Height);
            }

            this.fpanel1.ResumeLayout();
        }
    }
}
