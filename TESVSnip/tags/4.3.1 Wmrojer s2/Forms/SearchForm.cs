using System;
using System.Windows.Forms;
using System.Collections.Generic;

namespace TESVSnip {
    partial class SearchForm : Form {
        private TreeView tv;
        private TreeNode[] foundNodes;
        private int pos;
        private string searchString;
        private uint searchID;

        public bool InSearch { get { return bReset.Enabled; } }

        public SearchForm(TreeView list) {
            InitializeComponent();
            this.Icon=Properties.Resources.tesv_ico;
            bReset.Enabled=false;
            tv=list;
        }

        private void RecurseFullSearch(List<TreeNode> matches, TreeNode node) {
            Record rec=node.Tag as Record;
            if(rec!=null) {
                foreach(SubRecord sr in rec.SubRecords) {
                    if(cbPartial.Checked) {
                        if(sr.GetStrData().ToLowerInvariant().Contains(searchString)) matches.Add(node);
                    } else {
                        if(sr.GetStrData().ToLowerInvariant()==searchString) matches.Add(node);
                    }
                }
            } else {
                for(int i=0;i<node.Nodes.Count;i++) RecurseFullSearch(matches, node.Nodes[i]);
            }
        }

        private void RecurseSearch(List<TreeNode> matches, TreeNode node) {
            Record rec=node.Tag as Record;
            if(rec!=null) {
                if(rbFormID.Checked) {
                    if(rec.FormID==searchID) matches.Add(node);
                } else if(rec.descriptiveName!=null) {
                    if(cbPartial.Checked) {
                        if(rec.descriptiveName.ToLowerInvariant().Contains(searchString)) matches.Add(node);
                    } else {
                        if(rec.descriptiveName.ToLowerInvariant().Substring(2, rec.descriptiveName.Length-3)==searchString) matches.Add(node);
                    }
                }
            } else {
                for(int i=0;i<node.Nodes.Count;i++) RecurseSearch(matches, node.Nodes[i]);
            }
        }

        private bool PerformSearch() {
            if(rbFormID.Checked) {
                if(!uint.TryParse(tbSearch.Text, System.Globalization.NumberStyles.AllowHexSpecifier, null, out searchID)) {
                    MessageBox.Show("Invalid FormID");
                    return false;
                }
            } else {
                searchString=tbSearch.Text.ToLowerInvariant();
            }
            List<TreeNode> matches=new List<TreeNode>();

            if(cbSelectedNode.Checked) {
                if(tv.SelectedNode==null) {
                    MessageBox.Show("No node selected");
                    return false;
                }
                if(rbAll.Checked) {
                    RecurseFullSearch(matches, tv.SelectedNode);
                } else {
                    RecurseSearch(matches, tv.SelectedNode);
                }
            } else {
                for(int i=0;i<tv.Nodes.Count;i++) {
                    if(rbAll.Checked) {
                        RecurseFullSearch(matches, tv.Nodes[i]);
                    } else {
                        RecurseSearch(matches, tv.Nodes[i]);
                    }
                }
            }

            if(matches.Count==0) {
                MessageBox.Show("No match found");
                return false;
            } else {
                foundNodes=matches.ToArray();
                return true;
            }
        }

        private void bFind_Click(object sender, EventArgs e) {
            if(foundNodes==null) {
                if(PerformSearch()) {
                    cbPartial.Enabled=false;
                    cbSelectedNode.Enabled=false;
                    bReset.Enabled=true;
                    bFind.Text="Next";
                    tbSearch.Enabled=false;
                    tv.SelectedNode=foundNodes[0];
                    pos=0;
                }
            } else {
                pos++;
                if(pos==foundNodes.Length) pos=0;
                tv.SelectedNode=foundNodes[pos];
            }
        }

        private void bReset_Click(object sender, EventArgs e) {
            foundNodes=null;
            cbPartial.Enabled=true;
            cbSelectedNode.Enabled=true;
            bReset.Enabled=false;
            bFind.Text="Find";
            tbSearch.Enabled=true;
        }

        private void cbFormID_CheckedChanged(object sender, EventArgs e) {
            cbPartial.Enabled=!rbFormID.Checked;
        }
    }
}