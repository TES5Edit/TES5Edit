/*
 * OlvListViewHitTestInfo - All information gathered during a OlvHitTest() operation
 *
 * Author: Phillip Piper
 * Date: 31-March-2011 5:53 pm
 *
 * Change log:
 * 2011-03-31  JPP  - Split into its own file
 * 
 * Copyright (C) 2011-2012 Phillip Piper
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
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

namespace BrightIdeasSoftware {

    /// <summary>
    /// An indication of where a hit was within ObjectListView cell
    /// </summary>
    public enum HitTestLocation {
        /// <summary>
        /// Nowhere
        /// </summary>
        Nothing,

        /// <summary>
        /// On the text
        /// </summary>
        Text,

        /// <summary>
        /// On the image
        /// </summary>
        Image,

        /// <summary>
        /// On the checkbox
        /// </summary>
        CheckBox,

        /// <summary>
        /// On the expand button (TreeListView)
        /// </summary>
        ExpandButton,

        /// <summary>
        /// in the cell but not in any more specific location
        /// </summary>
        InCell,

        /// <summary>
        /// UserDefined location1 (used for custom renderers)
        /// </summary>
        UserDefined,

        /// <summary>
        /// On the expand/collapse widget of the group
        /// </summary>
        GroupExpander,

        /// <summary>
        /// Somewhere on a group
        /// </summary>
        Group
    }

    [Flags]
    public enum HitTestLocationEx {
        LVHT_NOWHERE = 0x00000001,
        LVHT_ONITEMICON = 0x00000002,
        LVHT_ONITEMLABEL = 0x00000004,
        LVHT_ONITEMSTATEICON = 0x00000008,
        LVHT_ONITEM = (LVHT_ONITEMICON | LVHT_ONITEMLABEL | LVHT_ONITEMSTATEICON),

        LVHT_ABOVE = 0x00000008,
        LVHT_BELOW = 0x00000010,
        LVHT_TORIGHT = 0x00000020,
        LVHT_TOLEFT = 0x00000040,

        LVHT_EX_GROUP_HEADER = 0x10000000,
        LVHT_EX_GROUP_FOOTER = 0x20000000,
        LVHT_EX_GROUP_COLLAPSE = 0x40000000,
        LVHT_EX_GROUP_BACKGROUND = -2147483648, // 0x80000000
        LVHT_EX_GROUP_STATEICON = 0x01000000,
        LVHT_EX_GROUP_SUBSETLINK = 0x02000000,
        LVHT_EX_GROUP = (LVHT_EX_GROUP_BACKGROUND | LVHT_EX_GROUP_COLLAPSE | LVHT_EX_GROUP_FOOTER | LVHT_EX_GROUP_HEADER | LVHT_EX_GROUP_STATEICON | LVHT_EX_GROUP_SUBSETLINK),
        LVHT_EX_GROUP_MINUS_FOOTER_AND_BKGRD = (LVHT_EX_GROUP_COLLAPSE | LVHT_EX_GROUP_HEADER | LVHT_EX_GROUP_STATEICON | LVHT_EX_GROUP_SUBSETLINK),
        LVHT_EX_ONCONTENTS = 0x04000000, // On item AND not on the background
        LVHT_EX_FOOTER = 0x08000000,
    }

    /// <summary>
    /// Instances of this class encapsulate the information gathered during a OlvHitTest()
    /// operation.
    /// </summary>
    /// <remarks>Custom renderers can use HitTestLocation.UserDefined and the UserData
    /// object to store more specific locations for use during event handlers.</remarks>
    public class OlvListViewHitTestInfo {

        /// <summary>
        /// Create a OlvListViewHitTestInfo
        /// </summary>
        public OlvListViewHitTestInfo(OLVListItem olvListItem, OLVListSubItem subItem, int flags, OLVGroup group) {
            this.item = olvListItem;
            this.subItem = subItem;
            this.location = ConvertNativeFlagsToDotNetLocation(olvListItem, flags);
            this.HitTestLocationEx = (HitTestLocationEx)flags;
            this.Group = group;

            switch (location) {
                case ListViewHitTestLocations.StateImage:
                    this.HitTestLocation = HitTestLocation.CheckBox;
                    break;
                case ListViewHitTestLocations.Image:
                    this.HitTestLocation = HitTestLocation.Image;
                    break;
                case ListViewHitTestLocations.Label:
                    this.HitTestLocation = HitTestLocation.Text;
                    break;
                default:
                    if ((this.HitTestLocationEx & HitTestLocationEx.LVHT_EX_GROUP_COLLAPSE) == HitTestLocationEx.LVHT_EX_GROUP_COLLAPSE)
                        this.HitTestLocation = HitTestLocation.GroupExpander;
                    else if ((this.HitTestLocationEx & HitTestLocationEx.LVHT_EX_GROUP_MINUS_FOOTER_AND_BKGRD) != 0)
                        this.HitTestLocation = HitTestLocation.Group;
                    else
                        this.HitTestLocation = HitTestLocation.Nothing;
                    break;
            }
        }

        private static ListViewHitTestLocations ConvertNativeFlagsToDotNetLocation(OLVListItem hitItem, int flags)
        {
            // Untangle base .NET behaviour.

            // In Windows SDK, the value 8 can have two meanings here: LVHT_ONITEMSTATEICON or LVHT_ABOVE.
            // .NET changes these to be:
            // - LVHT_ABOVE becomes ListViewHitTestLocations.AboveClientArea (which is 0x100).
            // - LVHT_ONITEMSTATEICON becomes ListViewHitTestLocations.StateImage (which is 0x200).
            // So, if we see the 8 bit set in flags, we change that to either a state image hit
            // (if we hit an item) or to AboveClientAream if nothing was hit.

            if ((8 & flags) == 8)
                return (ListViewHitTestLocations)(0xf7 & flags | (hitItem == null ? 0x100 : 0x200));

            // Mask off the LVHT_EX_XXXX values since ListViewHitTestLocations doesn't have them
            return (ListViewHitTestLocations)(flags & 0xffff);
        }

        #region Public fields

        /// <summary>
        /// Where is the hit location?
        /// </summary>
        public HitTestLocation HitTestLocation;

        /// <summary>
        /// Where is the hit location?
        /// </summary>
        public HitTestLocationEx HitTestLocationEx;

        /// <summary>
        /// Which group was hit?
        /// </summary>
        public OLVGroup Group;

        /// <summary>
        /// Custom renderers can use this information to supply more details about the hit location
        /// </summary>
        public Object UserData;

        #endregion

        #region Public read-only properties

        /// <summary>
        /// Gets the item that was hit
        /// </summary>
        public OLVListItem Item {
            get { return item; }
            internal set { item = value; }
        }
        private OLVListItem item;

        /// <summary>
        /// Gets the subitem that was hit
        /// </summary>
        public OLVListSubItem SubItem {
            get { return subItem; }
            internal set { subItem = value; }
        }
        private OLVListSubItem subItem;

        /// <summary>
        /// Gets the part of the subitem that was hit
        /// </summary>
        public ListViewHitTestLocations Location {
            get { return location; }
            internal set { location = value; }
        }
        private ListViewHitTestLocations location;

        /// <summary>
        /// Gets the ObjectListView that was tested
        /// </summary>
        public ObjectListView ListView {
            get { return this.Item == null ? null : (ObjectListView)this.Item.ListView; }
        }

        /// <summary>
        /// Gets the model object that was hit
        /// </summary>
        public Object RowObject {
            get {
                return this.Item == null ? null : this.Item.RowObject;
            }
        }

        /// <summary>
        /// Gets the index of the row under the hit point or -1
        /// </summary>
        public int RowIndex {
            get { return this.Item == null ? -1 : this.Item.Index; }
        }

        /// <summary>
        /// Gets the index of the column under the hit point
        /// </summary>
        public int ColumnIndex {
            get {
                if (this.Item == null || this.SubItem == null)
                    return -1;
                
                return this.Item.SubItems.IndexOf(this.SubItem);
            }
        }

        /// <summary>
        /// Gets the column that was hit
        /// </summary>
        public OLVColumn Column {
            get {
                int index = this.ColumnIndex;
                return index < 0 ? null : this.ListView.GetColumn(index);
            }
        }

        #endregion

        public override string ToString()
        {
            return string.Format("HitTestLocation: {0}, HitTestLocationEx: {1}, Item: {2}, SubItem: {3}, Location: {4}, Group: {5}", this.HitTestLocation, this.HitTestLocationEx, this.item, this.subItem, this.location, this.Group);
        }
    }
}
