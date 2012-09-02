namespace TESVSnip.UI.Controls
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Linq;
    using System.Windows.Forms;

    using BrightIdeasSoftware;

    using TESVSnip.Domain.Model;

    internal class CustomTreeView : TreeListView
    {
        private int _contextMenuSet = -1;

        protected override void WndProc(ref Message m)
        {
            base.WndProc(ref m);
            switch (m.Msg)
            {
                case 0x210: //WM_PARENTNOTIFY
                    this._contextMenuSet = 1;
                    break;
                case 0x21: //WM_MOUSEACTIVATE
                    this._contextMenuSet++;
                    break;
                case 0x7b: //WM_CONTEXTMENU
                    if (this._contextMenuSet == 1) // ignore mouse activate
                        if (this.OnContextMenuKey != null)
                            this.OnContextMenuKey(this, EventArgs.Empty);
                    break;
            }
        }

        public event EventHandler OnContextMenuKey;

        //protected new TreeNode SelectedNode { get { return base.SelectedNode; } set { base.SelectedNode = value; } }

        public BaseRecord SelectedRecord
        {
            get { return base.SelectedObject as BaseRecord; }
            set
            {
                if (value != null)
                    this.EnsureModelVisible(value);
                base.SelectObject(value, true);
            }
        }

        public IEnumerable<BaseRecord> SelectedRecords
        {
            get { return SelectedObjects.OfType<BaseRecord>(); }
            set
            {
                foreach (var r in value)
                    this.EnsureModelVisible(r);
                base.SelectObjects(value.ToList());
            }
        }


        public override void Expand(object model)
        {
            var rec = model as IRecord;
            var parent = rec != null ? rec.Parent : null;
            if (parent != null) this.Expand(parent);
            base.Expand(model);
        }

        public override void EnsureModelVisible(object modelObject)
        {
            if (modelObject == null || modelObject is PluginList)
                return;

            var rec = modelObject as IRecord;
            var parent = rec != null ? rec.Parent : null;
            if (parent != null) this.Expand(parent);
            base.EnsureModelVisible(modelObject);
        }

        /// <summary>
        /// Remove any sorting and revert to the given order of the model objects
        /// </summary>
        public override void Unsort()
        {
            ShowGroups = false;
            PrimarySortColumn = null;
            PrimarySortOrder = SortOrder.None;
            TreeModel.Unsort();
            this.Roots = this._baseRoots;
            RebuildAll(true);
            ShowSortIndicator(LastSortColumn, LastSortOrder);
        }

        private object[] _baseRoots = new object[0];

        public override IEnumerable Roots
        {
            get { return base.Roots; }
            set
            {
                this._baseRoots = value.OfType<object>().ToArray();
                base.Roots = this._baseRoots;
            }
        }
    }

    //class CustomTreeView : BrightIdeasSoftware.TreeListView
    //{

    //}
}