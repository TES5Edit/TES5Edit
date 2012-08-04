#region License

//////////////////////////////////////////////////////////////////////////
// Navigational history (go back/forward) for WinForms controls
// www.codeproject.com/KB/miscctrl/​WinFormsHistory.aspx
//
//  Release under CPOL License
//  http://www.codeproject.com/info/cpol10.aspx
//////////////////////////////////////////////////////////////////////////

#endregion

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;

// RightToCopy & PublishAndPerish: OrlandoCurioso 2006

namespace OC.Windows.Forms
{
    /// <summary>Provides navigational history (go back/forward) in conjunction with 2 ToolStripSplitButtons</summary>
    public sealed class History<T> : IDisposable where T : class
    {
        #region Events & Delegates

        /// <summary>Occurs when user chose from menu or clicked button.</summary>
        public event EventHandler<HistoryEventArgs<T>> GotoItem;

        /// <summary>
        /// Represents the method which retrieves the menu text for an item.
        /// If delegate is null, item's ToString method is used.
        /// </summary>
        public delegate string GetHistoryMenuText(T item);

        /// <summary>
        /// Represents the method which retrieves the menu image for an item.
        /// If delegate is null, none is used.
        /// </summary>
        public delegate Image GetHistoryMenuImage(T item);

        #endregion

        /// <summary>
        /// forward button may be null.
        /// limitList == 0 for unlimited history.
        /// </summary>
        public History(ToolStripSplitButton back, ToolStripSplitButton forward, uint limitList)
        {
            list = new LinkedList<T>();

            cms = new ToolStripDropDownMenu();
            cms.Opening += cms_Opening;
            cms.Closed += cms_Closed;
            cms.ItemClicked += cms_ItemClicked;
            cms.RightToLeft = RightToLeft.No; // if buttons are mirrored

            ensureOpeningOfMenu();

            tssbBack = back;
            tssbForward = forward;
            assignButton(back);
            assignButton(forward);

            limit = (int) limitList;
            _Enabled = true;
        }

        #region Fields

        private T _CurrentItem;
        private readonly LinkedList<T> list;
        private LinkedListNode<T> current;

        private readonly ToolStripDropDownMenu cms;
        private readonly ToolStripSplitButton tssbBack;
        private readonly ToolStripSplitButton tssbForward;

        private bool _AllowDuplicates;
        private bool _Enabled;
        private bool inProc;
        private readonly int limit;

        private GetHistoryMenuText _GetMenuText;
        private GetHistoryMenuImage _GetMenuImage;

        #endregion

        #region Public Interface

        /// <summary></summary>
        public bool AllowDuplicates
        {
            get { return _AllowDuplicates; }
            set { _AllowDuplicates = value; }
        }

        /// <summary>Applies only to CurrentItem' set accessor.</summary>
        public bool Enabled
        {
            get { return _Enabled; }
            set { _Enabled = value; }
        }

        /// <summary></summary>
        public GetHistoryMenuText MenuTexts
        {
            get { return _GetMenuText; }
            set { _GetMenuText = value; }
        }

        /// <summary></summary>
        public GetHistoryMenuImage MenuImages
        {
            get { return _GetMenuImage; }
            set { _GetMenuImage = value; }
        }

        /// <summary>Assign new selected item on every change.</summary>
        public T CurrentItem
        {
            get { return _CurrentItem; }
            set
            {
                if (_Enabled)
                {
                    _CurrentItem = value;

                    if (!inProc && _CurrentItem != null)
                    {
                        truncateForward();
                        addCurrentItem(value);
                    }
                }
            }
        }

        /// <summary></summary>
        public void Clear()
        {
            _CurrentItem = default(T);
            current = null;
            list.Clear();
            ensureOpeningOfMenu();
            enableButtons();
        }

        /// <summary></summary>
        public void Remove(T item)
        {
            if (item != null)
            {
                if (current != null && item.Equals(current.Value))
                {
                    current = null;
                }

                if (list.Contains(item))
                {
                    list.Remove(item);
                }
            }
            enableButtons();
        }

        #endregion

        #region Private Interface

        private void truncateForward()
        {
            if (current != null && current.Previous != null)
            {
                while (list.First != null && list.First != current.Previous)
                    list.RemoveFirst();
                if (current.Previous != null)
                    list.Remove(current.Previous);
            }
        }

        private void addCurrentItem(T item)
        {
            if (!_AllowDuplicates && list.Contains(item))
            {
                list.Remove(item);
            }

            list.AddFirst(item);

            current = list.First;
            limitList();
            enableButtons();
        }

        private void tssb_ButtonClick(object sender, EventArgs e)
        {
            LinkedListNode<T> node = sender.Equals(tssbBack) ? current.Next : current.Previous;

            OnGotoItem(node);

            current = node;
            limitList();
            enableButtons();
        }

        private void cms_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            var node = (LinkedListNode<T>) e.ClickedItem.Tag;

            OnGotoItem(node);

            current = node;
            limitList();
            enableButtons();
        }

        // dynamic filling of menu
        private void cms_Opening(object sender, CancelEventArgs e)
        {
            Debug.Assert(list.Count != 0 && current != null);

            cms.Items.Clear();

            ToolStripItem tssb = ((ToolStripDropDownMenu) sender).OwnerItem;
            bool isBackMenu = tssb.Equals(tssbBack);

            LinkedListNode<T> node = isBackMenu ? current.Next : current.Previous;

            while (node != null)
            {
                var tsmi = new ToolStripMenuItem();
                tsmi.Tag = node;

                if (_GetMenuText != null)
                    tsmi.Text = _GetMenuText(node.Value);
                else
                    tsmi.Text = node.Value.ToString();

                if (_GetMenuImage != null)
                    tsmi.Image = _GetMenuImage(node.Value);

                cms.Items.Add(tsmi);

                node = isBackMenu ? node.Next : node.Previous;
            }
        }

        private void cms_Closed(object sender, ToolStripDropDownClosedEventArgs e)
        {
            ensureOpeningOfMenu();
        }

        private void ensureOpeningOfMenu()
        {
            cms.Items.Clear();
            cms.Items.Add("dummy");
        }

        // limiting Back history is sufficient (by design Forward is less or equal to Back)
        private void limitList()
        {
            if (limit != 0 && list.Count > limit)
            {
                LinkedListNode<T> node = current.Next;
                int count = 0;

                while (node != null)
                {
                    if (++count > limit)
                    {
                        list.RemoveLast();
                    }
                    node = node.Next;
                }
            }
        }

        private void assignButton(ToolStripSplitButton tssb)
        {
            if (tssb != null)
            {
                tssb.ButtonClick += tssb_ButtonClick;
                tssb.DropDown = cms;
                tssb.Enabled = false;
            }
        }

        private void enableButtons()
        {
            if (tssbBack != null)
                tssbBack.Enabled = (current != null && current.Next != null);
            if (tssbForward != null)
                tssbForward.Enabled = (current != null && current.Previous != null);
        }

        private void OnGotoItem(LinkedListNode<T> node)
        {
            Debug.Assert(node != null && node.Value != null);

            T item = node.Value;

            // block client setting CurrentItem
            inProc = true;

            if (GotoItem != null)
            {
                GotoItem(this, new HistoryEventArgs<T>(item));
            }
            inProc = false;
        }

        #endregion

        #region IDisposable Members

        /// <summary></summary>
        public void Dispose()
        {
            if (cms != null && !cms.Disposing)
            {
                cms.Dispose();
            }
        }

        #endregion
    }

    /// <summary>Provides data for the History{T}.GotoItem event</summary>
    public class HistoryEventArgs<T> : EventArgs
    {
        public HistoryEventArgs(T item)
        {
            _Item = item;
        }

        private readonly T _Item;

        public T Item
        {
            get { return _Item; }
        }
    }
}