#region License

// Original Source:
//  http://www.codeproject.com/KB/combobox/checkedcombobox.aspx
//
// The Code Project Open License (CPOL) 1.02
//   http://www.codeproject.com/info/cpol10.aspx

#endregion

using System;
using System.ComponentModel;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TESVSnip.Windows.Controls
{
    public class CheckedComboBox : CustomComboBox
    {
        #region Dropdown Form

        /// <summary>
        /// Internal class to represent the dropdown list of the CheckedComboBox
        /// </summary>
        internal class Dropdown : UserControl
        {
            // ---------------------------------- internal class CCBoxEventArgs --------------------------------------------
            /// <summary>
            /// Custom EventArgs encapsulating value as to whether the combo box value(s) should be assignd to or not.
            /// </summary>
            internal class CCBoxEventArgs : EventArgs
            {
                public bool AssignValues { get; set; }

                public EventArgs EventArgs { get; set; }

                public CCBoxEventArgs(EventArgs e, bool assignValues)
                {
                    this.EventArgs = e;
                    this.AssignValues = assignValues;
                }
            }

            // ---------------------------------- internal class CustomCheckedListBox --------------------------------------------

            /// <summary>
            /// A custom CheckedListBox being shown within the dropdown form representing the dropdown list of the CheckedComboBox.
            /// </summary>
            internal class CustomCheckedListBox : CheckedListBox
            {
                private int curSelIndex = -1;

                public CustomCheckedListBox()
                {
                    SelectionMode = SelectionMode.One;
                    HorizontalScrollbar = true;
                }

                /// <summary>
                /// Intercepts the keyboard input, [Enter] confirms a selection and [Esc] cancels it.
                /// </summary>
                /// <param name="e">The Key event arguments</param>
                protected override void OnKeyDown(KeyEventArgs e)
                {
                    if (e.KeyCode == Keys.Enter)
                    {
                        // Enact selection.
                        //((CheckedComboBox.Dropdown) Parent).OnDeactivate(new CCBoxEventArgs(null, true));
                        ((Dropdown) Parent).Accept();
                        (Parent).Hide();
                        e.Handled = true;
                    }
                    else if (e.KeyCode == Keys.Escape)
                    {
                        // Cancel selection.
                        ((Dropdown) Parent).Reject();
                        (Parent).Hide();
                        //((CheckedComboBox.Dropdown) Parent).OnDeactivate(new CCBoxEventArgs(null, false));
                        e.Handled = true;
                    }
                    else if (e.KeyCode == Keys.Delete)
                    {
                        // Delete unckecks all, [Shift + Delete] checks all.
                        for (int i = 0; i < Items.Count; i++)
                        {
                            SetItemChecked(i, e.Shift);
                        }
                        e.Handled = true;
                    }
                    // If no Enter or Esc keys presses, let the base class handle it.
                    base.OnKeyDown(e);
                }

                protected override void OnMouseMove(MouseEventArgs e)
                {
                    base.OnMouseMove(e);
                    int index = IndexFromPoint(e.Location);
                    if ((index >= 0) && (index != curSelIndex))
                    {
                        curSelIndex = index;
                        SetSelected(index, true);
                    }
                }
            }

            // end internal class CustomCheckedListBox

            // --------------------------------------------------------------------------------------------------------

            // ********************************************* Data *********************************************

            private readonly CheckedComboBox ccbParent;

            // Keeps track of whether checked item(s) changed, hence the value of the CheckedComboBox as a whole changed.
            // This is simply done via maintaining the old string-representation of the value(s) and the new one and comparing them!
            private string oldStrValue = "";

            public bool ValueChanged
            {
                get
                {
                    string newStrValue = ccbParent.Text;
                    if ((oldStrValue.Length > 0) && (newStrValue.Length > 0))
                    {
                        return (oldStrValue.CompareTo(newStrValue) != 0);
                    }
                    else
                    {
                        return (oldStrValue.Length != newStrValue.Length);
                    }
                }
            }

            // Array holding the checked states of the items. This will be used to reverse any changes if user cancels selection.
            private bool[] checkedStateArr;

            // Whether the dropdown is closed.
            private bool dropdownClosed = true;

            private CustomCheckedListBox cclb;

            public CustomCheckedListBox List
            {
                get { return cclb; }
                set { cclb = value; }
            }

            // ********************************************* Construction *********************************************

            public Dropdown(CheckedComboBox ccbParent)
            {
                this.ccbParent = ccbParent;
                InitializeComponent();
                // Add a handler to notify our parent of ItemCheck events.
                cclb.ItemCheck += cclb_ItemCheck;
            }

            public void Reject()
            {
                CloseDropdown(false);
            }

            public void Accept()
            {
                CloseDropdown(true);
            }

            protected override void OnVisibleChanged(EventArgs e)
            {
                base.OnVisibleChanged(e);

                if (Visible)
                {
                    dropdownClosed = false;
                    // Assign the old string value to compare with the new value for any changes.
                    oldStrValue = ccbParent.Text;
                    // Make a copy of the checked state of each item, in cace caller cancels selection.
                    checkedStateArr = new bool[cclb.Items.Count];
                    for (int i = 0; i < cclb.Items.Count; i++)
                    {
                        checkedStateArr[i] = cclb.GetItemChecked(i);
                    }
                }
                //else
                //{
                //    Accept();
                //}
            }

            // ********************************************* Methods *********************************************

            // Create a CustomCheckedListBox which fills up the entire form area.
            private void InitializeComponent()
            {
                cclb = new CustomCheckedListBox();
                SuspendLayout();
                // 
                // cclb
                // 
                cclb.BorderStyle = BorderStyle.None;
                cclb.Dock = DockStyle.Fill;
                cclb.FormattingEnabled = true;
                cclb.Location = new Point(0, 0);
                cclb.Name = "cclb";
                cclb.Size = new Size(47, 15);
                cclb.TabIndex = 0;
                cclb.IntegralHeight = false;
                cclb.CheckOnClick = true;
                // 
                // Dropdown
                // 
                AutoScaleDimensions = new SizeF(6F, 13F);
                AutoScaleMode = AutoScaleMode.Font;
                BackColor = SystemColors.Menu;
                ClientSize = new Size(47, 16);
                Controls.Add(cclb);
                ForeColor = SystemColors.ControlText;
                Name = "ccbParent";
                ResumeLayout(false);
            }

            public string GetCheckedItemsStringValue()
            {
                return ccbParent.GetCheckedItemsStringValue();
            }

            public bool IsClosed
            {
                get { return dropdownClosed; }
            }

            /// <summary>
            /// Closes the dropdown portion and enacts any changes according to the specified boolean parameter.
            /// NOTE: even though the caller might ask for changes to be enacted, this doesn't necessarily mean
            ///       that any changes have occurred as such. Caller should check the ValueChanged property of the
            ///       CheckedComboBox (after the dropdown has closed) to determine any actual value changes.
            /// </summary>
            /// <param name="enactChanges"></param>
            public void CloseDropdown(bool enactChanges)
            {
                if (dropdownClosed)
                {
                    return;
                }
                // From now on the dropdown is considered closed. We set the flag here to prevent OnDeactivate() calling
                // this method once again after hiding this window.
                dropdownClosed = true;

                // Perform the actual selection and display of checked items.
                if (enactChanges)
                {
                    ccbParent.SelectedIndex = -1;
                    // Set the text portion equal to the string comprising all checked items (if any, otherwise empty!).
                    ccbParent.Text = GetCheckedItemsStringValue();
                }
                else
                {
                    // Caller cancelled selection - need to restore the checked items to their original state.
                    for (int i = 0; i < cclb.Items.Count; i++)
                    {
                        cclb.SetItemChecked(i, checkedStateArr[i]);
                    }
                }
                // Notify CheckedComboBox that its dropdown is closed. (NOTE: it does not matter which parameters we pass to
                // OnDropDownClosed() as long as the argument is CCBoxEventArgs so that the method knows the notification has
                // come from our code and not from the framework).
                ccbParent.HideDropDown();
            }

            private void cclb_ItemCheck(object sender, ItemCheckEventArgs e)
            {
                if (ccbParent.ItemCheck != null)
                {
                    try
                    {
                        if (IsHandleCreated)
                            BeginInvoke(new ItemCheckEventHandler((o, args) => ccbParent.ItemCheck(o, args)),
                                        new[] {sender, e});
                    }
                    catch
                    {
                    }
                }
            }
        }

        // end internal class Dropdown

        #endregion

        // ******************************** Data ********************************
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private readonly IContainer components = null;

        // A form-derived object representing the drop-down list of the checked combo box.
        internal readonly Dropdown dropdown;

        // The valueSeparator character(s) between the ticked elements as they appear in the 
        // text portion of the CheckedComboBox.
        public string ValueSeparator { get; set; }

        public bool CheckOnClick
        {
            get { return dropdown.List.CheckOnClick; }
            set { dropdown.List.CheckOnClick = value; }
        }

        public new string DisplayMember
        {
            get { return dropdown.List.DisplayMember; }
            set { dropdown.List.DisplayMember = value; }
        }

        public new CheckedListBox.ObjectCollection Items
        {
            get { return dropdown.List.Items; }
        }

        public CheckedListBox.CheckedItemCollection CheckedItems
        {
            get { return dropdown.List.CheckedItems; }
        }

        public CheckedListBox.CheckedIndexCollection CheckedIndices
        {
            get { return dropdown.List.CheckedIndices; }
        }

        public bool ValueChanged
        {
            get { return dropdown.ValueChanged; }
        }

        // Event handler for when an item check state changes.
        public event ItemCheckEventHandler ItemCheck;

        // ******************************** Construction ********************************

        public CheckedComboBox()
        {
            // We want to do the drawing of the dropdown.
            DrawMode = DrawMode.OwnerDrawVariable;
            // Default value separator.
            ValueSeparator = ", ";
            // This prevents the actual ComboBox dropdown to show, although it's not strickly-speaking necessary.
            // But including this remove a slight flickering just before our dropdown appears (which is caused by
            // the empty-dropdown list of the ComboBox which is displayed for fractions of a second).
            DropDownHeight = 1;
            // This is the default setting - text portion is editable and user must click the arrow button
            // to see the list portion. Although we don't want to allow the user to edit the text portion
            // the DropDownList style is not being used because for some reason it wouldn't allow the text
            // portion to be programmatically set. Hence we set it as editable but disable keyboard input (see below).
            DropDownStyle = ComboBoxStyle.DropDown;
            dropdown = new Dropdown(this);
            // CheckOnClick style for the dropdown (NOTE: must be set after dropdown is created).
            CheckOnClick = true;

            DropDownControl = dropdown;
            AllowResizeDropDown = true;
            IntegralHeight = false;
            DropDownSizeMode = SizeMode.UseDropDownSize;
        }

        // ******************************** Operations ********************************

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        public override void ShowDropDown()
        {
            base.ShowDropDown();
        }

        public override void HideDropDown(HideCloseReason reason)
        {
            if (!dropdown.IsClosed)
            {
                if (reason == HideCloseReason.AppFocusChange || reason == HideCloseReason.Keyboard)
                    dropdown.CloseDropdown(false);
                else
                    dropdown.CloseDropdown(true);
            }
            base.HideDropDown(reason);
        }

        protected override void OnKeyDown(KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Down)
            {
                // Signal that the dropdown is "down". This is required so that the behaviour of the dropdown is the same
                // when it is a result of user pressing the Down_Arrow (which we handle and the framework wouldn't know that
                // the list portion is down unless we tell it so).
                // NOTE: all that so the DropDownClosed event fires correctly!
                if (!IsDroppedDown)
                    ShowDropDown();
            }
            // Make sure that certain keys or combinations are not blocked.
            e.Handled = !e.Alt && !(e.KeyCode == Keys.Tab) &&
                        !((e.KeyCode == Keys.Left) || (e.KeyCode == Keys.Right) || (e.KeyCode == Keys.Home) ||
                          (e.KeyCode == Keys.End));

            base.OnKeyDown(e);
        }

        protected override void OnKeyPress(KeyPressEventArgs e)
        {
            e.Handled = true;
            base.OnKeyPress(e);
        }

        public bool GetItemChecked(int index)
        {
            if (index < 0 || index >= Items.Count)
            {
                throw new ArgumentOutOfRangeException("index", "value out of range");
            }
            else
            {
                return dropdown.List.GetItemChecked(index);
            }
        }

        public void SetItemChecked(int index, bool isChecked)
        {
            if (index < 0 || index >= Items.Count)
            {
                throw new ArgumentOutOfRangeException("index", "value out of range");
            }
            else
            {
                if (isChecked != dropdown.List.GetItemChecked(index))
                {
                    dropdown.List.SetItemChecked(index, isChecked);
                    UpdateText();
                }
            }
        }

        public CheckState GetItemCheckState(int index)
        {
            if (index < 0 || index >= Items.Count)
            {
                throw new ArgumentOutOfRangeException("index", "value out of range");
            }
            else
            {
                return dropdown.List.GetItemCheckState(index);
            }
        }

        public void SetItemCheckState(int index, CheckState state)
        {
            if (index < 0 || index >= Items.Count)
            {
                throw new ArgumentOutOfRangeException("index", "value out of range");
            }
            else
            {
                dropdown.List.SetItemCheckState(index, state);
                UpdateText();
            }
        }

        public void UpdateText()
        {
            Text = dropdown.GetCheckedItemsStringValue();
        }

        public virtual string GetCheckedItemsStringValue()
        {
            var sb = new StringBuilder("");
            var cclb = dropdown.List;
            foreach (object t in cclb.CheckedItems)
            {
                if (sb.Length > 0) sb.Append(this.ValueSeparator);
                sb.Append(cclb.GetItemText(t));
            }
            return sb.ToString();            
        }
    }

    // end public class CheckedComboBox
}