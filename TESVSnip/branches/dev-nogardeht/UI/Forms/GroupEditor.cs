namespace TESVSnip.UI.Forms
{
    using System;
    using System.Globalization;
    using System.Windows.Forms;

    using TESVSnip.Domain.Model;
    using TESVSnip.Framework;
    using TESVSnip.Framework.Services;
    using TESVSnip.Properties;

    internal partial class GroupEditor : Form
    {
        private readonly GroupRecord gr;

        public GroupEditor(GroupRecord gr)
        {
            this.gr = gr;
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
            this.cmbGroupType.ContextMenu = new ContextMenu();
            this.cmbGroupType.SelectedIndex = (int)gr.groupType;
            this.tbRecType.Text = gr.ContentsType;
            byte[] data = gr.GetData();
            this.tbX.Text = TypeConverter.h2ss(data[2], data[3]).ToString();
            this.tbY.Text = TypeConverter.h2ss(data[0], data[1]).ToString();
            this.tbBlock.Text = TypeConverter.h2i(data[0], data[1], data[2], data[3]).ToString();
            this.tbParent.Text = TypeConverter.h2i(data[0], data[1], data[2], data[3]).ToString("X8");
            this.tbDateStamp.Text = gr.dateStamp.ToString("X8");
            this.tbFlags.Text = gr.flags.ToString("X8");
        }

        public static DialogResult Display(GroupRecord gr)
        {
            var ge = new GroupEditor(gr);
            return ge.ShowDialog();
        }

        private void bCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            this.bSave.Focus();
            uint flags, datestamp;
            if (!uint.TryParse(this.tbDateStamp.Text, NumberStyles.AllowHexSpecifier, null, out datestamp))
            {
                this.tbDateStamp.Focus();
                MessageBox.Show("Invalid value specified for datestamp");
                return;
            }

            if (!uint.TryParse(this.tbFlags.Text, NumberStyles.AllowHexSpecifier, null, out flags))
            {
                this.tbFlags.Focus();
                MessageBox.Show("Invalid value specified for flags");
                return;
            }

            var grouptype = (uint)this.cmbGroupType.SelectedIndex;
            byte[] data;
            switch (this.cmbGroupType.SelectedIndex)
            {
                case 0:
                    if (this.tbRecType.TextLength != 4)
                    {
                        this.tbRecType.Focus();
                        MessageBox.Show("Invalid parent record type. Needs to be 4 characters!");
                        return;
                    }

                    data = new byte[4];
                    Encoding.Instance.GetBytes(this.tbRecType.Text, 0, 4, data, 0);
                    break;
                case 2:
                case 3:
                    uint block;
                    if (!uint.TryParse(this.tbBlock.Text, out block))
                    {
                        this.tbBlock.Focus();
                        MessageBox.Show("Invalid value specified for block id");
                        return;
                    }

                    data = TypeConverter.i2h(block);
                    break;
                case 4:
                case 5:
                    short x, y;
                    if (!short.TryParse(this.tbX.Text, out x))
                    {
                        this.tbX.Focus();
                        MessageBox.Show("Invalid value specified for x coord");
                        return;
                    }

                    if (!short.TryParse(this.tbY.Text, out y))
                    {
                        this.tbY.Focus();
                        MessageBox.Show("Invalid value specified for y coord");
                        return;
                    }

                    data = new byte[4];
                    TypeConverter.ss2h(x, data, 2);
                    TypeConverter.ss2h(y, data, 0);
                    break;
                case 1:
                case 6:
                case 7:
                case 8:
                case 9:
                case 10:
                    uint parent;
                    if (!uint.TryParse(this.tbParent.Text, NumberStyles.AllowHexSpecifier, null, out parent))
                    {
                        this.tbParent.Focus();
                        MessageBox.Show("Invalid value specified for parent");
                        return;
                    }

                    data = TypeConverter.i2h(parent);
                    break;
                default:
                    this.cmbGroupType.Focus();
                    MessageBox.Show("Sanity check failed; invalid group type");
                    return;
            }

            this.gr.flags = flags;
            this.gr.dateStamp = datestamp;
            this.gr.groupType = grouptype;
            this.gr.SetData(data);
            this.gr.UpdateShortDescription();
            DialogResult = DialogResult.OK;
        }

        private void cmbGroupType_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }

        private void cmbGroupType_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (this.cmbGroupType.SelectedIndex)
            {
                case 0:
                    this.tbRecType.Enabled = true;
                    this.tbX.Enabled = false;
                    this.tbY.Enabled = false;
                    this.tbParent.Enabled = false;
                    this.tbBlock.Enabled = false;
                    break;
                case 2:
                case 3:
                    this.tbRecType.Enabled = false;
                    this.tbX.Enabled = false;
                    this.tbY.Enabled = false;
                    this.tbParent.Enabled = false;
                    this.tbBlock.Enabled = true;
                    break;
                case 4:
                case 5:
                    this.tbRecType.Enabled = false;
                    this.tbX.Enabled = true;
                    this.tbY.Enabled = true;
                    this.tbParent.Enabled = false;
                    this.tbBlock.Enabled = false;
                    break;
                case 1:
                case 6:
                case 7:
                case 8:
                case 9:
                case 10:
                    this.tbRecType.Enabled = false;
                    this.tbX.Enabled = false;
                    this.tbY.Enabled = false;
                    this.tbParent.Enabled = true;
                    this.tbBlock.Enabled = false;
                    break;
            }
        }

        private void tbRecType_Leave(object sender, EventArgs e)
        {
            if (this.tbRecType.Text.Length < 4)
            {
                this.tbRecType.Text = this.tbRecType.Text.PadRight(4, '_');
            }
        }
    }
}
