/*
 * OLVListItem - A row in an ObjectListView
 *
 * Author: Phillip Piper
 * Date: 31-March-2011 5:53 pm
 *
 * Change log:
 * 2011-03-31  JPP  - Split into its own file
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
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;

namespace BrightIdeasSoftware
{
    /// <summary>
    /// OLVListItems are specialized ListViewItems that know which row object they came from,
    /// and the row index at which they are displayed, even when in group view mode. They
    /// also know the image they should draw against themselves
    /// </summary>
    public class OLVListItem : ListViewItem
    {
        #region Constructors

        /// <summary>
        /// Create a OLVListItem for the given row object
        /// </summary>
        public OLVListItem(object rowObject)
        {
            this.RowObject = rowObject;
        }

        /// <summary>
        /// Create a OLVListItem for the given row object
        /// </summary>
        public OLVListItem(object rowObject, OLVListSubItem[] subItems, int imageIndex) : base(subItems, imageIndex)
        {
            this.RowObject = null;
        }

        /// <summary>
        /// Create a OLVListItem for the given row object, represented by the given string and image
        /// </summary>
        public OLVListItem(object rowObject, string text, Object image)
            : base(text, -1)
        {
            this.RowObject = rowObject;
            imageSelector = image;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets the bounding rectangle of the item, including all subitems
        /// </summary>
        public new Rectangle Bounds
        {
            get
            {
                try
                {
                    return base.Bounds;
                }
                catch (ArgumentException)
                {
                    // If the item is part of a collapsed group, Bounds will throw an exception
                    return Rectangle.Empty;
                }
            }
        }

        /// <summary>
        /// Gets or sets the checkedness of this item.
        /// </summary>
        /// <remarks>
        /// Virtual lists don't handle checkboxes well, so we have to intercept attempts to change them
        /// through the items, and change them into something that will work.
        /// Unfortuneately, this won't work if this property is set through the base class, since
        /// the property is not declared as virtual.
        /// </remarks>
        public new bool Checked
        {
            get { return base.Checked; }
            set
            {
                if (Checked != value)
                {
                    if (value)
                        ((ObjectListView) ListView).CheckObject(RowObject);
                    else
                        ((ObjectListView) ListView).UncheckObject(RowObject);
                }
            }
        }

        /// <summary>
        /// Enable tri-state checkbox.
        /// </summary>
        /// <remarks>.NET's Checked property was not built to handle tri-state checkboxes,
        /// and will return True for both Checked and Indeterminate states.</remarks>
        public CheckState CheckState
        {
            get
            {
                switch (StateImageIndex)
                {
                    case 0:
                        return CheckState.Unchecked;
                    case 1:
                        return CheckState.Checked;
                    case 2:
                        return CheckState.Indeterminate;
                    default:
                        return CheckState.Unchecked;
                }
            }
            set
            {
                if (checkState == value)
                    return;

                checkState = value;

                //THINK: I don't think we need this, since the Checked property just uses StateImageIndex, which we are about to set.
                //this.Checked = (checkState == CheckState.Checked);

                // We have to specifically set the state image
                switch (value)
                {
                    case CheckState.Unchecked:
                        StateImageIndex = 0;
                        break;
                    case CheckState.Checked:
                        StateImageIndex = 1;
                        break;
                    case CheckState.Indeterminate:
                        StateImageIndex = 2;
                        break;
                }
            }
        }

        private CheckState checkState;

        /// <summary>
        /// Gets if this item has any decorations set for it.
        /// </summary>
        public bool HasDecoration
        {
            get { return decorations != null && decorations.Count > 0; }
        }

        /// <summary>
        /// Gets or sets the decoration that will be drawn over this item
        /// </summary>
        /// <remarks>Setting this replaces all other decorations</remarks>
        public IDecoration Decoration
        {
            get
            {
                if (HasDecoration)
                    return Decorations[0];
                else
                    return null;
            }
            set
            {
                Decorations.Clear();
                if (value != null)
                    Decorations.Add(value);
            }
        }

        /// <summary>
        /// Gets the collection of decorations that will be drawn over this item
        /// </summary>
        public IList<IDecoration> Decorations
        {
            get
            {
                if (decorations == null)
                    decorations = new List<IDecoration>();
                return decorations;
            }
        }

        private IList<IDecoration> decorations;

        /// <summary>
        /// Get or set the image that should be shown against this item
        /// </summary>
        /// <remarks><para>This can be an Image, a string or an int. A string or an int will
        /// be used as an index into the small image list.</para></remarks>
        public Object ImageSelector
        {
            get { return imageSelector; }
            set
            {
                imageSelector = value;
                if (value is Int32)
                    ImageIndex = (Int32) value;
                else if (value is String)
                    ImageKey = (String) value;
                else
                    ImageIndex = -1;
            }
        }

        private Object imageSelector;

        /// <summary>
        /// Gets or sets the the model object that is source of the data for this list item.
        /// </summary>
        public object RowObject { get; set; }

        #endregion

        #region Accessing

        /// <summary>
        /// Return the sub item at the given index
        /// </summary>
        /// <param name="index">Index of the subitem to be returned</param>
        /// <returns>An OLVListSubItem</returns>
        public virtual OLVListSubItem GetSubItem(int index)
        {
            if (index >= 0 && index < SubItems.Count)
                return (OLVListSubItem) SubItems[index];
            else
                return null;
        }


        /// <summary>
        /// Return bounds of the given subitem
        /// </summary>
        /// <remarks>This correctly calculates the bounds even for column 0.</remarks>
        public virtual Rectangle GetSubItemBounds(int subItemIndex)
        {
            if (subItemIndex == 0)
            {
                Rectangle r = Bounds;
                Point sides = NativeMethods.GetScrolledColumnSides(ListView, subItemIndex);
                r.X = sides.X + 1;
                r.Width = sides.Y - sides.X;
                return r;
            }
            else
            {
                OLVListSubItem subItem = GetSubItem(subItemIndex);
                if (subItem == null)
                    return new Rectangle();
                else
                    return subItem.Bounds;
            }
        }

        #endregion
    }
}