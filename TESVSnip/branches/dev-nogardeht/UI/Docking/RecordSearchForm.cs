namespace TESVSnip.UI.Docking
{
    using System;

    using TESVSnip.Domain.Model;

    public partial class RecordSearchForm : BaseDockContent
    {
        public RecordSearchForm()
        {
            this.InitializeComponent();
        }

        internal void ReferenceSearch(uint formid)
        {
            this.subrecordPanel.ReferenceSearch(formid);
        }

        internal void SetSearchCriteria(SearchCriteriaSettings settings, bool doSearch)
        {
            this.subrecordPanel.SetSearchCriteria(settings, doSearch);
        }

        private void RecordSearchForm_Load(object sender, EventArgs e)
        {
        }

        private void RecordSearchForm_Shown(object sender, EventArgs e)
        {
            this.subrecordPanel.FocusText();
        }
    }
}
