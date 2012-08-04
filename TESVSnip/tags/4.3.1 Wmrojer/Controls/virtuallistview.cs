using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Threading;
using System.Windows.Forms;

namespace TESVSnip.Windows.Controls
{

    #region VirtualListView Delegates

    public delegate void QueryItemTextHandler(int item, int subItem, out string text);

    public delegate void QueryItemImageHandler(int item, int subItem, out int imageIndex);

    public delegate void QueryItemIndentHandler(int item, out int itemIndent);

    public delegate void CustomDrawHandler(ref NMLVCUSTOMDRAW item, ref CustomDrawFlags flags);

    public delegate void CustomSortHandler(int iColumn);

    public delegate void CustomDragHandler(ref NMLISTVIEW item, bool begin);

    #endregion

    [Flags]
    internal enum ListViewItemMask : uint
    {
        LVIF_TEXT = 0x0001,
        LVIF_IMAGE = 0x0002,
        LVIF_PARAM = 0x0004,
        LVIF_STATE = 0x0008,
        LVIF_INDENT = 0x0010,
        LVIF_NORECOMPUTE = 0x0800,
        LVIF_GROUPID = 0x0100,
        LVIF_COLUMNS = 0x0200,
    }

    [Flags]
    internal enum ListViewItemStates : uint
    {
        LVIS_FOCUSED = 0x0001,
        LVIS_SELECTED = 0x0002,
        LVIS_CUT = 0x0004,
        LVIS_DROPHILITED = 0x0008,
        LVIS_GLOW = 0x0010,
        LVIS_ACTIVATING = 0x0020,
        LVIS_OVERLAYMASK = 0x0F00,
        LVIS_STATEIMAGEMASK = 0xF000,
    }

    [Flags]
    internal enum ListViewStyles : uint
    {
        LVS_ICON = 0x0000,
        LVS_REPORT = 0x0001,
        LVS_SMALLICON = 0x0002,
        LVS_LIST = 0x0003,
        LVS_TYPEMASK = 0x0003,
        LVS_SINGLESEL = 0x0004,
        LVS_SHOWSELALWAYS = 0x0008,
        LVS_SORTASCENDING = 0x0010,
        LVS_SORTDESCENDING = 0x0020,
        LVS_SHAREIMAGELISTS = 0x0040,
        LVS_NOLABELWRAP = 0x0080,
        LVS_AUTOARRANGE = 0x0100,
        LVS_EDITLABELS = 0x0200,
        LVS_OWNERDATA = 0x1000,
        LVS_NOSCROLL = 0x2000,
        LVS_TYPESTYLEMASK = 0xfc00,
        LVS_ALIGNTOP = 0x0000,
        LVS_ALIGNLEFT = 0x0800,
        LVS_ALIGNMASK = 0x0c00,
        LVS_OWNERDRAWFIXED = 0x0400,
        LVS_NOCOLUMNHEADER = 0x4000,
        LVS_NOSORTHEADER = 0x8000,
    }

    internal enum ListViewScroll : uint
    {
        LVSICF_DEFAULT = 0x00000000,
        LVSICF_NOINVALIDATEALL = 0x00000001,
        LVSICF_NOSCROLL = 0x00000002,
    }

    internal enum ListViewMessages
    {
        LVM_FIRST = 0x1000, // ListView messages
        LVM_SETITEM = (LVM_FIRST + 76),
        LVM_GETTOPINDEX = (LVM_FIRST + 39),
        LVM_SETITEMCOUNT = (LVM_FIRST + 47),
        LVM_SETITEMSTATE = (LVM_FIRST + 43),
        LVM_GETITEMSTATE = (LVM_FIRST + 44),
        LVM_GETNEXTITEM = (LVM_FIRST + 12),
        LVM_GETSELECTEDCOUNT = (LVM_FIRST + 50),
        LVM_SORTITEMS = (LVM_FIRST + 48),

        LVM_GETHEADER = (LVM_FIRST + 31),
        LVM_SETEXTENDEDLISTVIEWSTYLE = (LVM_FIRST + 54),
        LVM_GETEXTENDEDLISTVIEWSTYLE = (LVM_FIRST + 55),

        LVM_GETITEMTEXTA = (LVM_FIRST + 45),
        LVM_GETITEMTEXTW = (LVM_FIRST + 115),
        LVM_GETITEMTEXT = LVM_GETITEMTEXTW,

        LVM_GETITEMRECT = (LVM_FIRST + 14),

        LVM_HITTEST = (LVM_FIRST + 18),
    }

    #region LVS_EX

    internal enum LVS_EX
    {
        LVS_EX_GRIDLINES = 0x00000001,
        LVS_EX_SUBITEMIMAGES = 0x00000002,
        LVS_EX_CHECKBOXES = 0x00000004,
        LVS_EX_TRACKSELECT = 0x00000008,
        LVS_EX_HEADERDRAGDROP = 0x00000010,
        LVS_EX_FULLROWSELECT = 0x00000020,
        LVS_EX_ONECLICKACTIVATE = 0x00000040,
        LVS_EX_TWOCLICKACTIVATE = 0x00000080,
        LVS_EX_FLATSB = 0x00000100,
        LVS_EX_REGIONAL = 0x00000200,
        LVS_EX_INFOTIP = 0x00000400,
        LVS_EX_UNDERLINEHOT = 0x00000800,
        LVS_EX_UNDERLINECOLD = 0x00001000,
        LVS_EX_MULTIWORKAREAS = 0x00002000,
        LVS_EX_LABELTIP = 0x00004000,
        LVS_EX_BORDERSELECT = 0x00008000,
        LVS_EX_DOUBLEBUFFER = 0x00010000,
        LVS_EX_HIDELABELS = 0x00020000,
        LVS_EX_SINGLEROW = 0x00040000,
        LVS_EX_SNAPTOGRID = 0x00080000,
        LVS_EX_SIMPLESELECT = 0x00100000
    }

    #endregion

    internal enum NotificationCodes
    {
        NM_FIRST = unchecked((int) (0U - 0U)), // generic to all controls
        NM_LAST = unchecked((int) (0U - 99U)),
        NM_RCLICK = (NM_FIRST - 5),
        NM_CUSTOMDRAW = (NM_FIRST - 12),
    }

    internal enum HeaderMessageCodes
    {
        HDM_FIRST = 0x1200,
        HDM_HITTEST = (HDM_FIRST + 6),
    }

    internal enum ListViewNotificationCodes
    {
        LVN_FIRST = unchecked((int) (0U - 100U)), // listview
        LVN_LAST = unchecked((int) (0U - 199U)),

        LVN_ITEMCHANGING = (LVN_FIRST - 0),
        LVN_ITEMCHANGED = (LVN_FIRST - 1),
        LVN_INSERTITEM = (LVN_FIRST - 2),
        LVN_DELETEITEM = (LVN_FIRST - 3),
        LVN_DELETEALLITEMS = (LVN_FIRST - 4),
        LVN_BEGINLABELEDITA = (LVN_FIRST - 5),
        LVN_BEGINLABELEDITW = (LVN_FIRST - 75),
        LVN_ENDLABELEDITA = (LVN_FIRST - 6),
        LVN_ENDLABELEDITW = (LVN_FIRST - 76),
        LVN_COLUMNCLICK = (LVN_FIRST - 8),
        LVN_BEGINDRAG = (LVN_FIRST - 9),
        LVN_BEGINRDRAG = (LVN_FIRST - 11),
        LVN_ODCACHEHINT = (LVN_FIRST - 13),
        LVN_ODFINDITEMA = (LVN_FIRST - 52),
        LVN_ODFINDITEMW = (LVN_FIRST - 79),
        LVN_ITEMACTIVATE = (LVN_FIRST - 14),
        LVN_ODSTATECHANGED = (LVN_FIRST - 15),
        LVN_HOTTRACK = (LVN_FIRST - 21),
        LVN_GETDISPINFOA = (LVN_FIRST - 50),
        LVN_GETDISPINFOW = (LVN_FIRST - 77),
        LVN_SETDISPINFOA = (LVN_FIRST - 51),
        LVN_SETDISPINFOW = (LVN_FIRST - 78),
    }

    internal enum HeaderNotificationCodes
    {
        HDN_FIRST = (0 - 300),
        HDN_LAST = (0 - 399),
        HDN_ITEMCHANGINGA = (HDN_FIRST - 0),
        HDN_ITEMCHANGINGW = (HDN_FIRST - 20),
        HDN_ITEMCHANGEDA = (HDN_FIRST - 1),
        HDN_ITEMCHANGEDW = (HDN_FIRST - 21),
        HDN_ITEMCLICKA = (HDN_FIRST - 2),
        HDN_ITEMCLICKW = (HDN_FIRST - 22),
        HDN_ITEMDBLCLICKA = (HDN_FIRST - 3),
        HDN_ITEMDBLCLICKW = (HDN_FIRST - 23),
        HDN_DIVIDERDBLCLICKA = (HDN_FIRST - 5),
        HDN_DIVIDERDBLCLICKW = (HDN_FIRST - 25),
        HDN_BEGINTRACKA = (HDN_FIRST - 6),
        HDN_BEGINTRACKW = (HDN_FIRST - 26),
        HDN_ENDTRACKA = (HDN_FIRST - 7),
        HDN_ENDTRACKW = (HDN_FIRST - 27),
        HDN_TRACKA = (HDN_FIRST - 8),
        HDN_TRACKW = (HDN_FIRST - 28),
        HDN_GETDISPINFOA = (HDN_FIRST - 9),
        HDN_GETDISPINFOW = (HDN_FIRST - 29),
        HDN_BEGINDRAG = (HDN_FIRST - 10),
        HDN_ENDDRAG = (HDN_FIRST - 11),
        HDN_FILTERCHANGE = (HDN_FIRST - 12),
        HDN_FILTERBTNCLICK = (HDN_FIRST - 13),
    }

    [Flags]
    internal enum ListViewNextItemCodes
    {
        LVNI_ALL = 0x0000,
        LVNI_FOCUSED = 0x0001,
        LVNI_SELECTED = 0x0002,
        LVNI_CUT = 0x0004,
        LVNI_DROPHILITED = 0x0008,
        LVNI_ABOVE = 0x0100,
        LVNI_BELOW = 0x0200,
        LVNI_TOLEFT = 0x0400,
        LVNI_TORIGHT = 0x0800,
    }

    public enum ListViewImageRect
    {
        BOUNDS = 0,
        ICON = 1,
        LABEL = 2,
        SELECTBOUNDS = 3,
    }

    [Flags]
    public enum CustomDrawStage
    {
        // drawstage flags
        // values under 0x00010000 are reserved for global custom draw values.
        // above that are for specific controls
        CDDS_PREPAINT = 0x00000001,
        CDDS_POSTPAINT = 0x00000002,
        CDDS_PREERASE = 0x00000003,
        CDDS_POSTERASE = 0x00000004,
        // the 0x000010000 bit means it's individual item specific
        CDDS_ITEM = 0x00010000,
        CDDS_ITEMPREPAINT = (CDDS_ITEM | CDDS_PREPAINT),
        CDDS_ITEMPOSTPAINT = (CDDS_ITEM | CDDS_POSTPAINT),
        CDDS_ITEMPREERASE = (CDDS_ITEM | CDDS_PREERASE),
        CDDS_ITEMPOSTERASE = (CDDS_ITEM | CDDS_POSTERASE),
        CDDS_SUBITEM = 0x00020000,
    }


    //NMHDR structure used to get data from WM_NOTIFY messages.
    [StructLayout(LayoutKind.Sequential)]
    public struct NMHDR
    {
        public int HWND;
        public int idFrom;
        public int code;
    }

    [StructLayout(LayoutKind.Sequential)]
    internal struct LVITEMA
    {
        public ListViewItemMask mask;
        public int iItem;
        public int iSubItem;
        public uint state;
        public ListViewItemStates stateMask;
        /*[MarshalAs(UnmanagedType.LPStr)]*/
        public IntPtr pszText;
        public int cchTextMax;
        public int iImage;
        public IntPtr lParam;
        public int iIndent;
        public int iGroupId;
        public uint cColumns; // tile view columns
        public UIntPtr puColumns;
    }

    [StructLayout(LayoutKind.Sequential)]
    internal struct LVITEMW
    {
        public ListViewItemMask mask;
        public int iItem;
        public int iSubItem;
        public uint state;
        public ListViewItemStates stateMask;
        // [MarshalAs(UnmanagedType.LPWStr)] public System.Text.StringBuilder pszText;
        public IntPtr pszText;
        public int cchTextMax;
        public int iImage;
        public IntPtr lParam;
        public int iIndent;
        public int iGroupId;
        public uint cColumns; // tile view columns
        public UIntPtr puColumns;
    }

    [StructLayout(LayoutKind.Sequential)]
    internal struct HDHITTESTINFO
    {
        public Point pt;
        public uint flags;
        public int iItem;
    };

    [Flags]
    public enum ListViewHitTestFlags : uint
    {
        LVHT_EMPTY = 0,
        LVHT_NOWHERE = 0x0001,
        LVHT_ONITEMICON = 0x0002,
        LVHT_ONITEMLABEL = 0x0004,
        LVHT_ONITEMSTATEICON = 0x0008,
        LVHT_ONITEM = (LVHT_ONITEMICON | LVHT_ONITEMLABEL | LVHT_ONITEMSTATEICON),
        LVHT_ABOVE = 0x0008,
        LVHT_BELOW = 0x0010,
        LVHT_TORIGHT = 0x0020,
        LVHT_TOLEFT = 0x0040,
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct LVHITTESTINFO
    {
        public Point pt;
        public ListViewHitTestFlags flags;
        public int iItem;
        public int iSubItem;
    };

    [StructLayout(LayoutKind.Sequential)]
    internal struct NMLVDISPINFOA
    {
        public NMHDR hdr;
        public LVITEMA item;
    }

    [StructLayout(LayoutKind.Sequential)]
    internal struct NMLVDISPINFOW
    {
        public NMHDR hdr;
        public LVITEMW item;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct NMCUSTOMDRAW
    {
        public NMHDR hdr;
        public CustomDrawStage dwDrawStage;
        public IntPtr hdc;
        public Rectangle rc;
        public UIntPtr dwItemSpec;
        public uint uItemState;
        public IntPtr lItemlParam;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct NMLVCUSTOMDRAW
    {
        public NMCUSTOMDRAW nmcd;
        public uint clrText;
        public uint clrTextBk;
        public int iSubItem;
        public uint dwItemType;
        // Item Custom Draw	
        public uint clrFace;
        public int iIconEffect;
        public int iIconPhase;
        public int iPartId;
        public int iStateId;
        // Group Custom Draw
        public Rectangle rcText;
        public uint uAlign;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct NMLISTVIEW
    {
        public NMHDR hdr;
        public int iItem;
        public int iSubItem;
        public uint uNewState;
        public uint uOldState;
        public uint uChanged;
        public Point ptAction;
        public IntPtr lParam;
    };

    [StructLayout(LayoutKind.Sequential)]
    public struct NMLVODSTATECHANGE
    {
        public NMHDR hdr;
        public int iFrom;
        public int iTo;
        public int uNewState;
        public int uOldState;
    }

    [Flags]
    public enum CustomDrawFlags
    {
        // custom draw return flags
        // values under 0x00010000 are reserved for global custom draw values.
        // above that are for specific controls
        CDRF_DODEFAULT = 0x00000000,
        CDRF_NEWFONT = 0x00000002,
        CDRF_SKIPDEFAULT = 0x00000004,
        CDRF_NOTIFYPOSTPAINT = 0x00000010,
        CDRF_NOTIFYITEMDRAW = 0x00000020,
        CDRF_NOTIFYSUBITEMDRAW = 0x00000020, // flags are the same, we can distinguish by context
        CDRF_NOTIFYPOSTERASE = 0x00000040,
    }

    /// <summary>
    /// Summary description for VirtualListViewControl.
    /// </summary>
    public class VirtualListView : ListView
    {
        private Bitmap internalBitmap;
        private Graphics internalGraphics;

        private delegate int SetSizeHandler(int n);

        private static readonly FieldInfo virtualListSize;
        private readonly object syncObject = new object();
        private IAsyncResult setSizeResult;

        static VirtualListView()
        {
            virtualListSize = typeof (ListView).GetField("virtualListSize",
                                                         BindingFlags.GetField | BindingFlags.SetField |
                                                         BindingFlags.Instance | BindingFlags.NonPublic |
                                                         BindingFlags.Public);
        }

        // store the item count to prevent the call to SendMessage(LVM_GETITEMCOUNT)
        private int itemCount;

        public int ItemCount
        {
            get { return itemCount; }
            set
            {
                if (itemCount != value)
                {
                    int oldValue = itemCount;
                    itemCount = value;
                    if (InvokeRequired)
                    {
                        if (Monitor.TryEnter(syncObject))
                        {
                            if (setSizeResult == null)
                                setSizeResult = BeginInvoke(new SetSizeHandler(SetSizeToItemCount), itemCount);
                            Monitor.Exit(syncObject);
                        }
                    }
                    else
                    {
                        VirtualListSize = value;
                    }
                }
            }
        }

        public new int VirtualListSize
        {
            get { return base.VirtualListSize; }
            set
            {
                if (value < 0)
                {
                    throw new ArgumentException("Invalid Size", "value");
                }
                if (value != VirtualListSize)
                {
                    virtualListSize.SetValue(this, value);
                    if ((base.IsHandleCreated && VirtualMode) && !base.DesignMode)
                    {
                        PostMessage(Handle, (uint) ListViewMessages.LVM_SETITEMCOUNT, new UIntPtr((uint) value),
                                    new IntPtr((int) ListViewScroll.LVSICF_NOSCROLL));
                    }
                    if (autoScroll && value > 0)
                    {
                        EnsureVisible(value - 1);
                    }
                }
            }
        }

        private int SetSizeToItemCount(int state)
        {
            lock (syncObject)
            {
                VirtualListSize = ItemCount;
                if (setSizeResult != null)
                    EndInvoke(setSizeResult);
                setSizeResult = null;
            }
            return itemCount;
        }

        private bool autoScroll;

        public bool AutoScroll
        {
            get { return autoScroll; }
            set
            {
                if (autoScroll != value)
                {
                    if (AutoScrollChanged != null)
                    {
                        autoScroll = value;
                        AutoScrollChanged(this, EventArgs.Empty);
                    }
                    else
                    {
                        autoScroll = value;
                    }
                }
            }
        }

        public event EventHandler AutoScrollChanged;

        public VirtualListView()
        {
            // virtual listviews must be Details or Listview with no sorting
            View = View.Details;
            Sorting = SortOrder.None;
            VirtualMode = true;
            base.ColumnClick += VirtualListView_ColumnClick;
        }

        private void DisposeInternal()
        {
            if (internalGraphics != null)
                internalGraphics.Dispose();
            if (internalBitmap != null)
                internalBitmap.Dispose();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
                DisposeInternal();
            base.Dispose(disposing);
        }

        protected override CreateParams CreateParams
        {
            get
            {
                CreateParams cp = base.CreateParams;
                // LVS_OWNERDATA style must be set when the control is created
                cp.Style |= (int) ListViewStyles.LVS_OWNERDATA;
                return cp;
            }
        }

        public new View View
        {
            get { return View.Details; }
            set { base.View = View.Details; }
        }

        #region Display query callbacks

        [Category("Draw")]
        public event QueryItemTextHandler QueryItemText;

        [Category("Draw")]
        public event QueryItemImageHandler QueryItemImage;

        [Category("Draw")]
        public event QueryItemIndentHandler QueryItemIndent;

        [Category("Draw")]
        public event CustomDrawHandler CustomDraw;

        [Category("Action")]
        public event CustomSortHandler CustomSort;

        [Category("Action")]
        public event ColumnClickEventHandler ColumnRightClick;

        [Category("Action")]
        public event CustomDragHandler CustomDrag;

        #endregion

        #region void OnDispInfoNotice

        private void OnDispInfoNotice(ref Message m, bool useAnsi)
        {
            var info = (NMLVDISPINFOW) m.GetLParam(typeof (NMLVDISPINFOW));
            string lvtext = null;

            if ((info.item.mask & ListViewItemMask.LVIF_TEXT) > 0)
            {
                if (QueryItemText != null)
                {
                    QueryItemText(info.item.iItem, info.item.iSubItem, out lvtext);
                    if (lvtext != null)
                    {
                        try
                        {
                            int maxIndex = Math.Min(info.item.cchTextMax - 1,
                                                    lvtext.Length);

                            var data = new char[maxIndex + 1];

                            lvtext.CopyTo(0, data, 0, Math.Min(maxIndex, lvtext.Length));

                            data[maxIndex] = '\0';

                            Marshal.Copy(data,
                                         0, info.item.pszText, data.Length);
                        }
                        catch (Exception e)
                        {
                            Debug.WriteLine("Failed to copy text name from client: " + e,
                                            "VirtualListView.OnDispInfoNotice");
                        }
                    }
                }
            }

            if ((info.item.mask & ListViewItemMask.LVIF_IMAGE) > 0)
            {
                int imageIndex = 0;
                if (QueryItemImage != null)
                {
                    QueryItemImage(info.item.iItem,
                                   info.item.iSubItem, out imageIndex);
                }
                info.item.iImage = imageIndex;
                Marshal.StructureToPtr(info, m.LParam, false);
            }

            if ((info.item.mask & ListViewItemMask.LVIF_INDENT) > 0)
            {
                int itemIndent = 0;
                if (QueryItemIndent != null)
                {
                    QueryItemIndent(info.item.iItem, out
                                                         itemIndent);
                }
                info.item.iIndent = itemIndent;
                Marshal.StructureToPtr(info, m.LParam, false);
            }
            m.Result = new IntPtr(0);
        }

        #endregion

        #region CustomDrawing

        private unsafe CustomDrawFlags OnCustomDraw(ref Message m)
        {
            if (CustomDraw != null)
            {
                var nmlvcustomdrawPtr = (NMLVCUSTOMDRAW*) m.LParam;
                CustomDrawFlags flags = CustomDrawFlags.CDRF_DODEFAULT;
                CustomDraw(ref *nmlvcustomdrawPtr, ref flags);
                if (flags != CustomDrawFlags.CDRF_DODEFAULT)
                    return flags;
            }
            return CustomDrawFlags.CDRF_DODEFAULT;
        }

        #endregion

        #region CustomSorting

        private unsafe bool OnCustomSort(ref Message m)
        {
            if (CustomSort != null)
            {
                var nmlvPtr = (NMLISTVIEW*) m.LParam;
                CustomSort((*nmlvPtr).iItem);
                return true;
            }
            return false;
        }

        #endregion

        #region CustomSorting

        private unsafe bool OnBeginDrag(ref Message m)
        {
            if (CustomDrag != null)
            {
                var nmlvPtr = (NMLISTVIEW*) m.LParam;
                CustomDrag(ref *nmlvPtr, true);
                return true;
            }
            return false;
        }

        #endregion

        protected override void OnHandleDestroyed(EventArgs e)
        {
            ItemCount = 0; // set count to zero to avoid ListView problems
            base.OnHandleDestroyed(e);
        }

        protected virtual void
            OnColumnRightClick(ColumnClickEventArgs e)
        {
            if (ColumnRightClick != null)
                ColumnRightClick(this, e);
        }

        /// <summary>Occurs when a Windows message is dispatched.</summary>
        /// <param name="message">Message to process.</param>
        /// <remarks>Overrides WM_PAINT, WM_ERASEBKGND.</remarks>
        protected override void WndProc(ref Message m)
        {
            const int WM_PAINT = 0x000F;
            const int WM_PRINTCLIENT = 0x0318;
            const int WM_ERASEBKGND = 0x0014;
            const int WM_MOUSEHOVER = 0x02A1;

            const int WM_NOTIFY = 0x004E;

            NMHDR nm1;
            bool messageProcessed = false;
            switch (m.Msg)
            {
                case 7: // WM_SETFOCUS
                    //try { base.WndProc(ref m); } // skip immediate parent to avoid focus problems
                    //catch{}
                    m.Result = IntPtr.Zero;
                    messageProcessed = true;
                    break;

                    // case (int)WindowsMessage.WM_REFLECT + (int)WindowsMessage.WM_NOTIFY:
                case (0x0400 + 0x1c00 + WM_NOTIFY):
                    m.Result = IntPtr.Zero;
                    nm1 = (NMHDR) m.GetLParam(typeof (NMHDR));
                    switch (nm1.code)
                    {
                        case (int) ListViewNotificationCodes.LVN_ITEMCHANGED:
                            messageProcessed = true;
                            break;

                        case (int) ListViewNotificationCodes.LVN_GETDISPINFOW:
                            OnDispInfoNotice(ref m, false);
                            messageProcessed = true;
                            break;

                            // ignore dragging as we are virtual and ListView doesnt like it.
                        case (int) ListViewNotificationCodes.LVN_BEGINDRAG:
                            OnBeginDrag(ref m);
                            messageProcessed = true;
                            break;

                        case (int) ListViewNotificationCodes.LVN_BEGINRDRAG:
                            OnBeginDrag(ref m);
                            messageProcessed = true;
                            break;

                        case (int) NotificationCodes.NM_CUSTOMDRAW:
                            m.Result = new IntPtr((int) OnCustomDraw(ref m));
                            messageProcessed = true;
                            break;

                        case (int) ListViewNotificationCodes.LVN_ODSTATECHANGED:
                            {
                                messageProcessed = true;
                                var lvod = (NMLVODSTATECHANGE) m.GetLParam(typeof (NMLVODSTATECHANGE));
                                int num1 = lvod.uOldState & (int) ListViewItemStates.LVIS_SELECTED;
                                int num2 = lvod.uNewState & (int) ListViewItemStates.LVIS_SELECTED;
                                if (num2 == num1)
                                    return;
                                OnSelectedIndexChanged(EventArgs.Empty);
                                break;
                            }

                        default:
                            break;
                    }
                    break;

                case WM_NOTIFY:
                    nm1 = (NMHDR) m.GetLParam(typeof (NMHDR));
                    if (nm1.code == (int) NotificationCodes.NM_RCLICK)
                    {
                        IntPtr header = SendMessage(Handle, (int) ListViewMessages.LVM_GETHEADER, IntPtr.Zero,
                                                    IntPtr.Zero);
                        uint curpos = GetMessagePos();
                        Point ptheader = PointToClient(new Point((short) curpos, (int) curpos >> 16));
                        var hdhti = new HDHITTESTINFO();
                        hdhti.pt = ptheader;
                        SendMessage(header, HeaderMessageCodes.HDM_HITTEST, IntPtr.Zero, ref hdhti);
                        OnColumnRightClick(new ColumnClickEventArgs(hdhti.iItem));
                    }
                    else if (nm1.code == (int) HeaderNotificationCodes.HDN_ITEMCLICKW)
                    {
                        if (OnCustomSort(ref m))
                        {
                            m.Result = IntPtr.Zero;
                            messageProcessed = true;
                        }
                    }
                    break;

                case WM_ERASEBKGND:
                    //removes flicker
                    return;

                case WM_MOUSEHOVER:
                    messageProcessed = true;
                    break;

                case WM_PAINT:
                    // The designer host does not call OnResize()                    
                    if (internalGraphics == null)
                        OnResize(EventArgs.Empty);

                    //Set up 
                    var updateRect = new RECT();
                    if (GetUpdateRect(m.HWnd, ref updateRect, false) == 0)
                        break;

                    var paintStruct = new PAINTSTRUCT();
                    IntPtr screenHdc = BeginPaint(m.HWnd, ref paintStruct);
                    using (Graphics screenGraphics = Graphics.FromHdc(screenHdc))
                    {
                        //Draw Internal Graphics
                        internalGraphics.Clear(BackColor);
                        IntPtr hdc = internalGraphics.GetHdc();
                        Message printClientMessage = Message.Create(Handle, WM_PRINTCLIENT, hdc, IntPtr.Zero);
                        DefWndProc(ref printClientMessage);
                        internalGraphics.ReleaseHdc(hdc);

                        //Add the missing OnPaint() call
                        OnPaint(new PaintEventArgs(internalGraphics, Rectangle.FromLTRB(
                            updateRect.left,
                            updateRect.top,
                            updateRect.right,
                            updateRect.bottom)));

                        //Draw Screen Graphics
                        screenGraphics.DrawImage(internalBitmap, 0, 0);
                    }

                    //Tear down
                    EndPaint(m.HWnd, ref paintStruct);
                    return;

                default:
                    break;
            }
            if (!messageProcessed)
            {
                try
                {
                    base.WndProc(ref m);
                }
                catch
                {
                }
            }
        }

        protected override void OnCreateControl()
        {
            base.OnCreateControl();

            // Activate double buffering
            SetStyle(ControlStyles.AllPaintingInWmPaint
                     | ControlStyles.OptimizedDoubleBuffer
                     | ControlStyles.ResizeRedraw, true);

            var styles = (LVS_EX) SendMessage(Handle,
                                              (int) ListViewMessages.LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0).ToInt32();
            styles |= LVS_EX.LVS_EX_DOUBLEBUFFER | LVS_EX.LVS_EX_BORDERSELECT;
            SendMessage(Handle,
                        (int) ListViewMessages.LVM_SETEXTENDEDLISTVIEWSTYLE, 0, (int) styles);

            // Allows for catching the WM_ERASEBKGND message
            SetStyle(ControlStyles.EnableNotifyMessage, true);
        }

        protected override void OnNotifyMessage(Message m)
        {
            // filter WM_ERASEBKGND
            if (m.Msg != 0x14)
            {
                base.OnNotifyMessage(m);
            }
        }

        protected override void OnPaintBackground(PaintEventArgs pevent)
        {
            // do nothing here since this event is now handled by OnPaint
        }

        public bool IsItemSelected(int index)
        {
            return (0 !=
                    SendMessage(Handle, ListViewMessages.LVM_GETITEMSTATE, index, (int) ListViewItemStates.LVIS_SELECTED));
        }

        public bool IsItemFocused(int index)
        {
            return (0 !=
                    SendMessage(Handle, ListViewMessages.LVM_GETITEMSTATE, index, (int) ListViewItemStates.LVIS_FOCUSED));
        }

        internal void SetItemState(int index, uint data, ListViewItemStates mask)
        {
            var _ms_lvi = new LVITEMA();
            _ms_lvi.stateMask = mask;
            _ms_lvi.state = data;
            SendMessage(Handle, ListViewMessages.LVM_SETITEMSTATE, index, ref _ms_lvi);
        }

        public void ClearSelection()
        {
            int next = -1;
            while (true)
            {
                next = SendMessage(Handle, ListViewMessages.LVM_GETNEXTITEM, next,
                                   (int) ListViewNextItemCodes.LVNI_SELECTED);
                if (next == -1) break;
                SetItemState(next, 0, ListViewItemStates.LVIS_SELECTED);
            }
        }

        public int[] GetSelectionIndices()
        {
            var sel = new List<int>();
            int next = -1;
            while (true)
            {
                next = SendMessage(Handle, ListViewMessages.LVM_GETNEXTITEM, next,
                                   (int) ListViewNextItemCodes.LVNI_SELECTED);
                if (next == -1) break;
                sel.Add(next);
                SetItemState(next, 0, ListViewItemStates.LVIS_SELECTED);
            }
            return sel.ToArray();
        }

        public void SelectItem(int index)
        {
            SetItemState(index, (unchecked((uint) -1)), ListViewItemStates.LVIS_SELECTED);
        }

        public int GetFocusedItem()
        {
            return SendMessage(Handle, ListViewMessages.LVM_GETNEXTITEM, -1, 1);
        }

        public void FocusItem(int index)
        {
            SetItemState(index, (unchecked((uint) -1)), ListViewItemStates.LVIS_FOCUSED);
        }

        public bool HasSelection()
        {
            return (0 != SendMessage(Handle, ListViewMessages.LVM_GETSELECTEDCOUNT, 0, 0));
        }

        public string GetItemText(int item, int subItem)
        {
            if (QueryItemText != null)
            {
                string lvtext;
                QueryItemText(item, subItem, out lvtext);
                if (lvtext != null)
                    return lvtext;
            }

            var _ms_lvi = new LVITEMW();
            _ms_lvi.mask = ListViewItemMask.LVIF_TEXT;
            _ms_lvi.iSubItem = subItem;
            _ms_lvi.cchTextMax = 512;
            _ms_lvi.pszText = Marshal.AllocCoTaskMem((_ms_lvi.cchTextMax)*2 /*Marshal.SizeOf(typeof(char))*/);
            try
            {
                SendMessage(Handle, ListViewMessages.LVM_GETITEMTEXT, item, ref _ms_lvi);
                return Marshal.PtrToStringAuto(_ms_lvi.pszText, _ms_lvi.cchTextMax);
            }
            finally
            {
                Marshal.FreeCoTaskMem(_ms_lvi.pszText);
            }
        }

        public Font GetItemFont(int item)
        {
            return Font;
        }

        public Color GetItemBackColor(int item)
        {
            return BackColor;
        }

        public Color GetItemForeColor(int item)
        {
            return ForeColor;
        }

        public Rectangle GetItemRect(int item, ListViewImageRect lvir)
        {
            var rect = new Rectangle(0, 0, 0, 0);
            SendMessage(Handle, ListViewMessages.LVM_GETITEMRECT, item, ref rect);
            return rect;
        }

        /// <summary>
        /// Autofit column header width for lists
        /// </summary>
        public void AutoFitColumnHeaders()
        {
            // Autofit all selection columns
            foreach (ColumnHeader heading in Columns)
                heading.Width = -2; // Use Heading
        }

        public void SelectAll()
        {
            int next = -1;
            while (true)
            {
                next = SendMessage(Handle, ListViewMessages.LVM_GETNEXTITEM, next, (int) ListViewNextItemCodes.LVNI_ALL);
                if (next == -1) break;
                SetItemState(next, (unchecked((uint) -1)), ListViewItemStates.LVIS_SELECTED);
            }
        }

        public void SetSubItemImage(int itemIndex, int subItemIndex, int imageIndex)
        {
            var lvItem = new LVITEMA();
            lvItem.mask = ListViewItemMask.LVIF_IMAGE;
            lvItem.iItem = itemIndex;
            lvItem.iSubItem = subItemIndex;
            lvItem.iImage = imageIndex;
            SendMessageLVI(Handle, (int) ListViewMessages.LVM_SETITEM, 0, ref lvItem);
        }

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        private static extern IntPtr SendMessage(IntPtr hWnd, int msg,
                                                 int wParam, int lParam);


        public void EnableSubImages()
        {
            SendMessage(Handle, ListViewMessages.LVM_SETEXTENDEDLISTVIEWSTYLE,
                        (int) LVS_EX.LVS_EX_SUBITEMIMAGES, (int) LVS_EX.LVS_EX_SUBITEMIMAGES);
        }

        public LVHITTESTINFO RawHitTest(Point pt)
        {
            var lvhti = new LVHITTESTINFO();
            lvhti.pt = pt;
            lvhti.iItem = -1;
            lvhti.iSubItem = -1;
            lvhti.flags = ListViewHitTestFlags.LVHT_EMPTY;
            SendMessage(Handle, ListViewMessages.LVM_HITTEST, 0, ref lvhti);
            return lvhti;
        }

        #region SendMessage Variations

        [DllImport("user32.dll", SetLastError = true)]
        private static extern int SendMessage(IntPtr hWnd, ListViewMessages Msg, int wParam, ref LVHITTESTINFO lvhti);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern int SendMessage(IntPtr hWnd, ListViewMessages Msg, int wParam, ref LVITEMA lvitem);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern int SendMessage(IntPtr hWnd, ListViewMessages Msg, int wParam, ref LVITEMW lvitem);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern int SendMessage(IntPtr hWnd, ListViewMessages Msg, int wParam, ref Rectangle lvitem);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern int SendMessage(IntPtr hWnd, ListViewMessages Msg, int wParam, int lvitem);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

        [DllImport("user32.dll", EntryPoint = "SendMessage", CharSet = CharSet.Auto)]
        private static extern IntPtr SendMessageLVI(IntPtr hWnd, int msg,
                                                    int wParam, ref LVITEMA lvi);

        [DllImport("User32.dll")]
        private static extern int SendMessage(IntPtr hWnd, HeaderMessageCodes uMsg, IntPtr wParam,
                                              ref HDHITTESTINFO lParam);

        [DllImport("User32.dll")]
        private static extern uint GetMessagePos();

        #endregion

        #region PostMessage Variations

        [DllImport("user32.dll", SetLastError = true)]
        private static extern IntPtr PostMessage(IntPtr hWnd, uint Msg, UIntPtr wParam, IntPtr lParam);

        #endregion

        #region OnResize

        /// <summary>Occurs when window is resized.</summary>
        /// <param name="e">A System.EventArgs.Empty.</param>
        /// <remarks>Recreates internal Graphics object. </remarks>
        protected override void OnResize(EventArgs e)
        {
            if (internalBitmap == null ||
                internalBitmap.Width != Width || internalBitmap.Height != Height)
            {
                if (Width != 0 && Height != 0)
                {
                    DisposeInternal();
                    internalBitmap = new Bitmap(Width, Height);
                    internalGraphics = Graphics.FromImage(internalBitmap);
                }
            }
        }

        #endregion

        #region Win32

        [DllImport("User32.dll")]
        public static extern int GetUpdateRect(IntPtr hwnd, ref RECT rect, bool erase);

        [DllImport("User32.dll", SetLastError = true)]
        public static extern bool GetWindowRect(IntPtr handle, ref RECT rect);

        [DllImport("User32.dll")]
        public static extern IntPtr BeginPaint(IntPtr hWnd, ref PAINTSTRUCT paintStruct);

        [DllImport("User32.dll")]
        public static extern bool EndPaint(IntPtr hWnd, ref PAINTSTRUCT paintStruct);

        [StructLayout(LayoutKind.Sequential)]
        public struct RECT
        {
            public int left;
            public int top;
            public int right;
            public int bottom;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct PAINTSTRUCT
        {
            public IntPtr hdc;
            public int fErase;
            public RECT rcPaint;
            public int fRestore;
            public int fIncUpdate;
            public int Reserved1;
            public int Reserved2;
            public int Reserved3;
            public int Reserved4;
            public int Reserved5;
            public int Reserved6;
            public int Reserved7;
            public int Reserved8;
        }

        #endregion

        #region Clipboard Format

        public void Copy()
        {
            SelectedIndexCollection indices = SelectedIndices;
            int nItems = indices.Count;
            int nCols = Columns.Count;
            var illegal = new[] {'\t', '\n'};
            var items = new string[nItems + 1];
            var colvals = new string[nCols];
            for (int j = 0; j < nCols; j++)
            {
                ColumnHeader header = Columns[j];
                colvals[header.Index] = header.Text;
            }
            items[0] = string.Join("\t", colvals);
            for (int i = 0; i < nItems; i++)
            {
                int idx = indices[i];
                for (int j = 0; j < nCols; j++)
                {
                    int col = Columns[j].Index;
                    string text = GetItemText(idx, col);
                    if (-1 != text.IndexOfAny(illegal))
                        text = '\"' + text + '\"';
                    colvals[col] = text;
                }
                items[i + 1] = string.Join("\t", colvals);
            }
            Clipboard.SetDataObject(string.Join("\r\n", items));
        }

        #endregion

        private void VirtualListView_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (CustomSort != null)
            {
                CustomSort(e.Column);
            }
        }
    }
}