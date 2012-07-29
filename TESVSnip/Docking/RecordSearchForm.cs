using System;
using System.Windows.Forms;
using TESVSnip.Model;
using WeifenLuo.WinFormsUI.Docking;

namespace TESVSnip.Docking
{
    public partial class RecordSearchForm : BaseDockContent
    {
        public RecordSearchForm()
        {
            InitializeComponent();
        }

        private void RecordSearchForm_Shown(object sender, EventArgs e)
        {
            this.subrecordPanel.FocusText();
        }

        private void RecordSearchForm_Load(object sender, EventArgs e)
        {

        }

        internal void SetSearchCriteria(SearchCriteriaSettings settings, bool doSearch)
        {
            this.subrecordPanel.SetSearchCriteria(settings, doSearch);
        }

        internal void ReferenceSearch(uint formid)
        {
            this.subrecordPanel.ReferenceSearch(formid);
        }
    }
}
