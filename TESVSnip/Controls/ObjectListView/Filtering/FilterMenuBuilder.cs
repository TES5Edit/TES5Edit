/*
 * FilterMenuBuilder - Responsible for creating a Filter menu
 *
 * Author: Phillip Piper
 * Date: 4-March-2011 11:59 pm
 *
 * Change log:
 * 2011-04-12  JPP  - Added some images to menu
 * 2011-03-04  JPP  - First version
 * 
 * Copyright (C) 2011 Phillip Piper
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * If you wish to use this code in a closed source application, please contact phillip_piper@bigfoot.com.
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using TESVSnip.Properties;

namespace BrightIdeasSoftware
{
    /// <summary>
    /// Instances of this class know how to build a Filter menu.
    /// It is responsible for clustering the values in the target column,
    /// build a menu that shows those clusters, and then constructing
    /// a filter that will enact the users choices.
    /// </summary>
    /// <remarks>
    /// Almost all of the methods in this class are declared as "virtual protected"
    /// so that subclasses can provide alternative behaviours.
    /// </remarks>
    public class FilterMenuBuilder
    {
        #region Static properties

        /// <summary>
        /// Gets or sets the string that labels the Apply button.
        /// Exposed so it can be localized.
        /// </summary>
        public static string APPLY_LABEL = "Apply";

        /// <summary>
        /// Gets or sets the string that labels the Clear All menu item.
        /// Exposed so it can be localized.
        /// </summary>
        public static string CLEAR_ALL_FILTERS_LABEL = "Clear All Filters";

        /// <summary>
        /// Gets or sets the string that labels the Filtering menu as a whole..
        /// Exposed so it can be localized.
        /// </summary>
        public static string FILTERING_LABEL = "Filtering";

        /// <summary>
        /// Gets or sets the string that represents Select All values.
        /// If this is set to null or empty, no Select All option will be included.
        /// Exposed so it can be localized.
        /// </summary>
        public static string SELECT_ALL_LABEL = "Select All";

        /// <summary>
        /// Gets or sets the image that will be placed next to the Clear Filtering menu item
        /// </summary>
        public static Bitmap ClearFilteringImage = Resources.ClearFiltering;

        /// <summary>
        /// Gets or sets the image that will be placed next to all "Apply" menu items on the filtering menu
        /// </summary>
        public static Bitmap FilteringImage = Resources.Filtering;

        #endregion

        #region Public properties

        /// <summary>
        /// Gets or sets whether null should be considered as a valid data value.
        /// If this is true (the default), then a cluster will null as a key will be allow.
        /// If this is false, object that return a cluster key of null will ignored.
        /// </summary>
        public bool TreatNullAsDataValue
        {
            get { return treatNullAsDataValue; }
            set { treatNullAsDataValue = value; }
        }

        private bool treatNullAsDataValue = true;

        /// <summary>
        /// Gets or sets the maximum number of objects that the clustering strategy
        /// will consider. This should be large enough to collect all unique clusters,
        /// but small enough to finish in a reasonable time.
        /// </summary>
        /// <remarks>The default value is 10,000. This should be perfectly
        /// acceptable for almost all lists.</remarks>
        public int MaxObjectsToConsider
        {
            get { return maxObjectsToConsider; }
            set { maxObjectsToConsider = value; }
        }

        private int maxObjectsToConsider = 10000;

        #endregion

        /// <summary>
        /// Create a Filter menu on the given tool tip for the given column in the given ObjectListView.
        /// </summary>
        /// <remarks>This is the main entry point into this class.</remarks>
        /// <param name="strip"></param>
        /// <param name="listView"></param>
        /// <param name="column"></param>
        /// <returns>The strip that should be shown to the user</returns>
        public virtual ToolStripDropDown MakeFilterMenu(ToolStripDropDown strip, ObjectListView listView,
                                                        OLVColumn column)
        {
            if (strip == null) throw new ArgumentNullException("strip");
            if (listView == null) throw new ArgumentNullException("listView");
            if (column == null) throw new ArgumentNullException("column");

            if (!column.UseFiltering || column.ClusteringStrategy == null)
                return strip;

            List<ICluster> clusters = Cluster(column.ClusteringStrategy, listView, column);
            if (clusters.Count > 0)
            {
                SortClusters(column.ClusteringStrategy, clusters);
                strip.Items.Add(CreateFilteringMenuItem(column, clusters));
            }

            return strip;
        }

        /// <summary>
        /// Create a collection of clusters that should be presented to the user
        /// </summary>
        /// <param name="strategy"></param>
        /// <param name="listView"></param>
        /// <param name="column"></param>
        /// <returns></returns>
        protected virtual List<ICluster> Cluster(IClusteringStrategy strategy, ObjectListView listView, OLVColumn column)
        {
            // Build a map that correlates cluster key to clusters
            var map = new NullableDictionary<object, ICluster>();
            int count = 0;
            foreach (object model in listView.Objects)
            {
                object key = strategy.GetClusterKey(model);
                if (key == DBNull.Value)
                    key = null;
                if (key == null && !TreatNullAsDataValue)
                    continue;
                if (map.ContainsKey(key))
                    map[key].Count += 1;
                else
                    map[key] = strategy.CreateCluster(key);

                // Check our limit
                count += 1;
                if (count > MaxObjectsToConsider)
                    break;
            }

            // Now that we know exactly how many items are in each cluster, create a label for it
            foreach (ICluster cluster in map.Values)
                cluster.DisplayLabel = strategy.GetClusterDisplayLabel(cluster);

            return new List<ICluster>(map.Values);
        }

        /// <summary>
        /// Order the given list of clusters in the manner in which they should be presented to the user.
        /// </summary>
        /// <param name="strategy"></param>
        /// <param name="clusters"></param>
        protected virtual void SortClusters(IClusteringStrategy strategy, List<ICluster> clusters)
        {
            clusters.Sort();
        }

        /// <summary>
        /// Do the work of making a menu that shows the clusters to the users
        /// </summary>
        /// <param name="column"></param>
        /// <param name="clusters"></param>
        /// <returns></returns>
        protected virtual ToolStripMenuItem CreateFilteringMenuItem(OLVColumn column, List<ICluster> clusters)
        {
            var checkedList = new ToolStripCheckedListBox();
            checkedList.Tag = column;
            foreach (ICluster cluster in clusters)
                checkedList.AddItem(cluster, column.ValuesChosenForFiltering.Contains(cluster.ClusterKey));
            if (!String.IsNullOrEmpty(SELECT_ALL_LABEL))
            {
                int checkedCount = checkedList.CheckedItems.Count;
                if (checkedCount == 0)
                    checkedList.AddItem(SELECT_ALL_LABEL, CheckState.Unchecked);
                else
                    checkedList.AddItem(SELECT_ALL_LABEL,
                                        checkedCount == clusters.Count ? CheckState.Checked : CheckState.Indeterminate);
            }
            checkedList.ItemCheck += HandleItemCheckedWrapped;

            var clearAll = new ToolStripMenuItem(CLEAR_ALL_FILTERS_LABEL, ClearFilteringImage,
                                                 delegate { ClearAllFilters(column); });
            var apply = new ToolStripMenuItem(APPLY_LABEL, FilteringImage,
                                              delegate { EnactFilter(checkedList, column); });
            var subMenu = new ToolStripMenuItem(FILTERING_LABEL, null, new ToolStripItem[]
                                                                           {
                                                                               clearAll, new ToolStripSeparator(),
                                                                               checkedList, apply
                                                                           });
            return subMenu;
        }

        /// <summary>
        /// Wrap a protected section around the real HandleItemChecked method, so that if
        /// that method tries to change a "checkedness" of an item, we don't get a recursive 
        /// stack error. Effectively, this ensure that HandleItemChecked is only called
        /// in response to a user action.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void HandleItemCheckedWrapped(object sender, ItemCheckEventArgs e)
        {
            if (alreadyInHandleItemChecked)
                return;

            try
            {
                alreadyInHandleItemChecked = true;
                HandleItemChecked(sender, e);
            }
            finally
            {
                alreadyInHandleItemChecked = false;
            }
        }

        private bool alreadyInHandleItemChecked;

        /// <summary>
        /// Handle a user-generated ItemCheck event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected virtual void HandleItemChecked(object sender, ItemCheckEventArgs e)
        {
            var checkedList = (ToolStripCheckedListBox) sender;
            var column = (OLVColumn) checkedList.Tag;
            var listView = (ObjectListView) column.ListView;

            // Sanity
            if (checkedList == null || column == null || listView == null)
                return;

            // Deal with the "Select All" item if there is one
            int selectAllIndex = checkedList.Items.IndexOf(SELECT_ALL_LABEL);
            if (selectAllIndex >= 0)
                HandleSelectAllItem(e, checkedList, selectAllIndex);
        }

        /// <summary>
        /// Handle any checking/unchecking of the Select All option, and keep
        /// its checkedness in sync with everything else that is checked.
        /// </summary>
        /// <param name="e"></param>
        /// <param name="checkedList"></param>
        /// <param name="selectAllIndex"></param>
        protected virtual void HandleSelectAllItem(ItemCheckEventArgs e, ToolStripCheckedListBox checkedList,
                                                   int selectAllIndex)
        {
            // Did they check/uncheck the "Select All"?
            if (e.Index == selectAllIndex)
            {
                if (e.NewValue == CheckState.Checked)
                    checkedList.CheckAll();
                if (e.NewValue == CheckState.Unchecked)
                    checkedList.UncheckAll();
                return;
            }

            // OK. The user didn't check/uncheck SelectAll. Now we have to update it's
            // checkedness to reflect the state of everything else
            // If all clusters are checked, we check the Select All.
            // If no clusters are checked, the uncheck the Select All.
            // For everything else, Select All is set to indeterminate.

            // How many items are currenty checked? 
            int count = checkedList.CheckedItems.Count;

            // First complication.
            // The value of the Select All itself doesn't count
            if (checkedList.GetItemCheckState(selectAllIndex) != CheckState.Unchecked)
                count -= 1;

            // Another complication.
            // CheckedItems does not yet know about the item the user has just
            // clicked, so we have to adjust the count of checked items to what
            // it is going to be
            if (e.NewValue != e.CurrentValue)
            {
                if (e.NewValue == CheckState.Checked)
                    count += 1;
                else
                    count -= 1;
            }

            // Update the state of the Select All item
            if (count == 0)
                checkedList.SetItemState(selectAllIndex, CheckState.Unchecked);
            else if (count == checkedList.Items.Count - 1)
                checkedList.SetItemState(selectAllIndex, CheckState.Checked);
            else
                checkedList.SetItemState(selectAllIndex, CheckState.Indeterminate);
        }

        /// <summary>
        /// Clear all the filters that are applied to the given column
        /// </summary>
        /// <param name="column">The column from which filters are to be removed</param>
        protected virtual void ClearAllFilters(OLVColumn column)
        {
            var olv = column.ListView as ObjectListView;
            if (olv == null || olv.IsDisposed)
                return;

            olv.ResetColumnFiltering();
        }

        /// <summary>
        /// Apply the selected values from the given list as a filter on the given column
        /// </summary>
        /// <param name="checkedList">A list in which the checked items should be used as filters</param>
        /// <param name="column">The column for which a filter should be generated</param>
        protected virtual void EnactFilter(ToolStripCheckedListBox checkedList, OLVColumn column)
        {
            var olv = column.ListView as ObjectListView;
            if (olv == null || olv.IsDisposed)
                return;

            // Collect all the checked values
            var chosenValues = new ArrayList();
            foreach (object x in checkedList.CheckedItems)
            {
                var cluster = x as ICluster;
                if (cluster != null)
                {
                    chosenValues.Add(cluster.ClusterKey);
                }
            }
            column.ValuesChosenForFiltering = chosenValues;

            olv.UpdateColumnFiltering();
        }
    }
}