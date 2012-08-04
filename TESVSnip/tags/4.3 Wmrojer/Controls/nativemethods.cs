using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Text;
using System.Windows.Forms;

namespace TESVSnip.Windows.Controls
{

    #region Native Helper Methods

    public sealed class NativeMethods
    {
        public const string TOOLTIPS_CLASS = "tooltips_class32";

        public const int WM_NOTIFY = 0x004E;
        public const int WM_USER = 0x0400;

        public const int GWL_STYLE = -16;
        public const int GCL_STYLE = -26;
        public const int CS_DROPSHADOW = 0x00020000;

        public const int HWND_TOPMOST = -1;

        public const int LPSTR_TEXTCALLBACKW = -1;

        // ToolTip Icons
        public const int TTI_NONE = 0;
        public const int TTI_INFO = 1;
        public const int TTI_WARNING = 2;
        public const int TTI_ERROR = 3;

        //
        public const int TTN_FIRST = -520;
        public const int TTN_NEEDTEXT = (TTN_FIRST - 10);
        public const int NM_FIRST = 0;
        public const int NM_CUSTOMDRAW = NM_FIRST - 12;

        //
        public const int SWP_NOSIZE = 0x0001;
        public const int SWP_NOMOVE = 0x0002;
        public const int SWP_NOACTIVATE = 0x0010;

        public const int TTS_ALWAYSTIP = 0x01;
        public const int TTS_BALLOON = 0x40;

        public const int TTF_IDISHWND = 0x0001;
        public const int TTF_SUBCLASS = 0x0010;
        public const int TTF_TRANSPARENT = 0x0100;

        public const int TTM_ACTIVATE = WM_USER + 1;
        public const int TTM_SETMAXTIPWIDTH = WM_USER + 24;
        public const int TTM_SETTITLE = WM_USER + 33;
        public const int TTM_ADDTOOL = WM_USER + 50;
        public const int TTM_DELTOOL = WM_USER + 51;

        public const int CDRF_DODEFAULT = 0x00000000;
        public const int CDRF_NEWFONT = 0x00000002;
        public const int CDRF_SKIPDEFAULT = 0x00000004;
        public const int CDRF_NOTIFYPOSTPAINT = 0x00000010;
        public const int CDRF_NOTIFYITEMDRAW = 0x00000020;
        public const int CDRF_NOTIFYPOSTERASE = 0x00000040;


        // Windows Messages defines
        public const Int32 EM_FORMATRANGE = WM_USER + 57;
        public const Int32 EM_GETCHARFORMAT = WM_USER + 58;
        public const Int32 EM_SETCHARFORMAT = WM_USER + 68;

        // Defines for EM_SETCHARFORMAT/EM_GETCHARFORMAT
        public const Int32 SCF_SELECTION = 0x0001;
        public const Int32 SCF_WORD = 0x0002;
        public const Int32 SCF_ALL = 0x0004;

        // Defines for CHARFORMAT member dwMask
        public const UInt32 CFM_BOLD = 0x00000001;
        public const UInt32 CFM_ITALIC = 0x00000002;
        public const UInt32 CFM_UNDERLINE = 0x00000004;
        public const UInt32 CFM_STRIKEOUT = 0x00000008;
        public const UInt32 CFM_PROTECTED = 0x00000010;
        public const UInt32 CFM_LINK = 0x00000020;
        public const UInt32 CFM_SIZE = 0x80000000;
        public const UInt32 CFM_COLOR = 0x40000000;
        public const UInt32 CFM_FACE = 0x20000000;
        public const UInt32 CFM_OFFSET = 0x10000000;
        public const UInt32 CFM_CHARSET = 0x08000000;

        // Defines for CHARFORMAT member dwEffects
        public const UInt32 CFE_BOLD = 0x00000001;
        public const UInt32 CFE_ITALIC = 0x00000002;
        public const UInt32 CFE_UNDERLINE = 0x00000004;
        public const UInt32 CFE_STRIKEOUT = 0x00000008;
        public const UInt32 CFE_PROTECTED = 0x00000010;
        public const UInt32 CFE_LINK = 0x00000020;
        public const UInt32 CFE_AUTOCOLOR = 0x40000000;

        public const int VK_CONTROL = 0x11;

        #region Structures

        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
        public class TOOLINFO
        {
            public int cbSize;
            public int uFlags;
            public IntPtr hwnd;
            public IntPtr uId;
            public RECT rect;
            public IntPtr hinst;
            //[MarshalAs(UnmanagedType.LPTStr)]
            public int lpszText;
            public IntPtr lParam;

            public TOOLINFO()
            {
                cbSize = Marshal.SizeOf(typeof (TOOLINFO));
                rect = new RECT(0, 0, 0, 0);
                hinst = IntPtr.Zero;
                lParam = IntPtr.Zero;
            }
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct RECT
        {
            public int left;
            public int top;
            public int right;
            public int bottom;

            public RECT(int left, int top, int right, int bottom)
            {
                this.left = left;
                this.top = top;
                this.right = right;
                this.bottom = bottom;
            }

            public static RECT FromXYWH(int x, int y, int width, int height)
            {
                return new RECT(x, y, x + width, y + height);
            }
        }

        [StructLayout(LayoutKind.Sequential, Pack = 1)]
        public class INITCOMMONCONTROLSEX
        {
            public int dwSize;
            public int dwICC;

            public INITCOMMONCONTROLSEX()
            {
                dwSize = 8;
            }
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct NMTTDISPINFO
        {
            public NMHDR hdr;
            [MarshalAs(UnmanagedType.LPTStr)] public string lpszText;
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 80)] public string szText;
            public IntPtr hinst;
            public int uFlags;
            public IntPtr lParam;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct NMHDR
        {
            public IntPtr hwndFrom;
            public int idFrom;
            public int code;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct NMTTCUSTOMDRAW
        {
            public NMHDR hdr;
            public int dwDrawStage;
            public IntPtr hdc;
            public RECT rc;
            public int dwItemSpec;
            public int uItemState;
            public IntPtr lItemlParam;
            public int uDrawFlags;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct CHARRANGE
        {
            public Int32 cpMin;
            public Int32 cpMax;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct FORMATRANGE
        {
            public IntPtr hdc;
            public IntPtr hdcTarget;
            public RECT rc;
            public RECT rcPage;
            public CHARRANGE chrg;
        }


        [StructLayout(LayoutKind.Sequential)]
        public struct CHARFORMAT
        {
            public int cbSize;
            public UInt32 dwMask;
            public UInt32 dwEffects;
            public Int32 yHeight;
            public Int32 yOffset;
            public Int32 crTextColor;
            public byte bCharSet;
            public byte bPitchAndFamily;
            [MarshalAs(UnmanagedType.ByValArray, SizeConst = 32)] public char[] szFaceName;
        }

        #endregion

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr SendMessage(HandleRef hWnd, int msg, int wParam, TOOLINFO lParam);

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr SendMessage(HandleRef hWnd, int msg, int wParam, string lParam);

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr SendMessage(HandleRef hWnd, int msg, int wParam, int lParam);

        [DllImport("user32.dll")]
        public static extern Int32 SendMessage(IntPtr hWnd, Int32 msg, Int32 wParam, IntPtr lParam);

        [DllImport("user32.dll")]
        public static extern Int32 SendMessage(IntPtr hWnd, Int32 msg, Int32 wParam, Int32 lParam);

        [DllImport("comctl32.dll")]
        public static extern bool InitCommonControlsEx(INITCOMMONCONTROLSEX icc);

        [DllImport("Kernel32.dll")]
        public static extern int GetLastError();

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool SetWindowPos(HandleRef hWnd, int hWndInsertAfter, int x, int y, int cx, int cy,
                                               int flags);

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern Int16 GetAsyncKeyState(int key);


        // Methods
        [StructLayout(LayoutKind.Sequential)]
        public class TRACKMOUSEEVENT
        {
            public int cbSize = Marshal.SizeOf(typeof (TRACKMOUSEEVENT));
            public int dwFlags;
            public IntPtr hwndTrack;
            public int dwHoverTime;
        }

        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
        public class TEXTMETRIC
        {
            public int tmHeight;
            public int tmAscent;
            public int tmDescent;
            public int tmInternalLeading;
            public int tmExternalLeading;
            public int tmAveCharWidth;
            public int tmMaxCharWidth;
            public int tmWeight;
            public int tmOverhang;
            public int tmDigitizedAspectX;
            public int tmDigitizedAspectY;
            public char tmFirstChar;
            public char tmLastChar;
            public char tmDefaultChar;
            public char tmBreakChar;
            public byte tmItalic;
            public byte tmUnderlined;
            public byte tmStruckOut;
            public byte tmPitchAndFamily;
            public byte tmCharSet;
        }

        [StructLayout(LayoutKind.Sequential)]
        public class COMRECT
        {
            public int left;
            public int top;
            public int right;
            public int bottom;

            public COMRECT()
            {
            }

            public COMRECT(Rectangle r)
            {
                left = r.X;
                top = r.Y;
                right = r.Right;
                bottom = r.Bottom;
            }

            public COMRECT(int left, int top, int right, int bottom)
            {
                this.left = left;
                this.top = top;
                this.right = right;
                this.bottom = bottom;
            }

            public static COMRECT FromXYWH(int x, int y, int width, int height)
            {
                return new COMRECT(x, y, x + width, y + height);
            }

            public override string ToString()
            {
                return
                    string.Concat(new object[] {"Left = ", left, " Top ", top, " Right = ", right, " Bottom = ", bottom});
            }
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct WINDOWPOS
        {
            public IntPtr hwnd;
            public IntPtr hwndInsertAfter;
            public int x;
            public int y;
            public int cx;
            public int cy;
            public int flags;
        }

        [DllImport("comctl32.dll", ExactSpelling = true)]
        private static extern bool _TrackMouseEvent(TRACKMOUSEEVENT tme);

        [DllImport("gdi32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool BitBlt(IntPtr hDC, int x, int y, int nWidth, int nHeight, IntPtr hSrcDC, int xSrc,
                                         int ySrc, int dwRop);

        [DllImport("gdi32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern IntPtr CreateSolidBrush(int crColor);

        [DllImport("gdi32.dll", CharSet = CharSet.Auto, SetLastError = true, ExactSpelling = true)]
        public static extern bool DeleteObject(HandleRef hObject);

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int DrawText(HandleRef hDC, string lpszString, int nCount, ref RECT lpRect, int nFormat);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern int GetCurrentProcessId();

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern int GetMessagePos();

        [DllImport("gdi32.dll", CharSet = CharSet.Auto)]
        public static extern bool GetTextMetrics(HandleRef hdc, TEXTMETRIC tm);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern int GetTickCount();

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int GetWindowTextLength(HandleRef hWnd);

        [DllImport("gdi32.dll", EntryPoint = "CreatePen", CharSet = CharSet.Auto, ExactSpelling = true)]
        private static extern IntPtr IntCreatePen(int nStyle, int nWidth, int crColor);

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool IsChild(HandleRef parent, HandleRef child);

        [DllImport("gdi32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool Rectangle(HandleRef hdc, int left, int top, int right, int bottom);

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool RedrawWindow(IntPtr hwnd, COMRECT rcUpdate, IntPtr hrgnUpdate, int flags);

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int RegisterWindowMessage(string msg);

        [DllImport("gdi32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool RoundRect(HandleRef hDC, int left, int top, int right, int bottom, int width,
                                            int height);

        [DllImport("gdi32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern IntPtr SelectObject(HandleRef hDC, HandleRef hObject);

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int x, int y, int cx, int cy,
                                               int flags);

        public static bool TrackMouseEvent(TRACKMOUSEEVENT tme)
        {
            return _TrackMouseEvent(tme);
        }

        #region User32

        #region public Enums

        #region enum indices

        public enum indices
        {
            GWL_USERDATA = -21,
            GWL_EXSTYLE = -20,
            GWL_STYLE = -16,
            GWL_ID = -12,
            GWL_HWNDPARENT = -8,
            GWL_HINSTANCE = -6,
            GWL_WNDPROC = -4,

            userData = GWL_USERDATA,
            exStyle = GWL_EXSTYLE,
            style = GWL_STYLE,
            id = GWL_ID,
            hwndParent = GWL_HWNDPARENT,
            instance = GWL_HINSTANCE,
            wndProc = GWL_WNDPROC,
        }

        #endregion

        #region styles

        public enum styles : uint
        {
            WS_OVERLAPPED = 0x00000000,
            WS_MAXIMIZEBOX = 0x00010000,
            WS_TABSTOP = 0x00010000,
            WS_MINIMIZEBOX = 0x00020000,
            WS_GROUP = 0x00020000,
            WS_THICKFRAME = 0x00040000,
            WS_SYSMENU = 0x00080000,
            WS_VSCROLL = 0x00200000,
            WS_HSCROLL = 0x00100000,
            WS_DLGFRAME = 0x00400000,
            WS_BORDER = 0x00800000,
            WS_CAPTION = WS_BORDER | WS_DLGFRAME,
            WS_MAXIMIZE = 0x01000000,
            WS_CLIPCHILDREN = 0x02000000,
            WS_CLIPSIBLINGS = 0x04000000,
            WS_DISABLED = 0x08000000,
            WS_VISIBLE = 0x10000000,
            WS_MINIMIZE = 0x20000000,
            WS_CHILD = 0x40000000,
            WS_POPUP = 0x80000000,

            WS_TILED = WS_OVERLAPPED,
            WS_ICONIC = WS_MINIMIZE,
            WS_SIZEBOX = WS_THICKFRAME,
            WS_TILEDWINDOW = WS_OVERLAPPEDWINDOW,

            // Common Window Styles
            WS_OVERLAPPEDWINDOW = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU |
                                  WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
            WS_POPUPWINDOW = WS_POPUP | WS_BORDER | WS_SYSMENU,
            WS_CHILDWINDOW = WS_CHILD,


            none = 0x00000000,
            all = 0xFFFFFFFF,
            overlapped = WS_OVERLAPPED,
            maximizeBox = WS_MAXIMIZEBOX,
            tabStop = WS_TABSTOP,
            minimizeBox = WS_MINIMIZEBOX,
            group = WS_GROUP,
            thickFrame = WS_THICKFRAME,
            sysMenu = WS_SYSMENU,
            vScroll = WS_VSCROLL,
            hScroll = WS_HSCROLL,
            dlgFrame = WS_DLGFRAME,
            border = WS_BORDER,
            caption = WS_CAPTION,
            maximize = WS_MAXIMIZE,
            clipChildren = WS_CLIPCHILDREN,
            clipSiblings = WS_CLIPSIBLINGS,
            disabled = WS_DISABLED,
            visible = WS_VISIBLE,
            minimize = WS_MINIMIZE,
            child = WS_CHILD,
            popup = WS_POPUP,
            tiled = WS_TILED,
            iconic = WS_ICONIC,
            sizeBox = WS_SIZEBOX,
            tiledWindow = WS_TILEDWINDOW,
            overlappedWindow = WS_OVERLAPPEDWINDOW,
            popupWindow = WS_POPUPWINDOW,
            childWindow = WS_CHILDWINDOW,
        }

        #endregion

        #region exStyles

        public enum exStyles : uint
        {
            WS_EX_LEFT = 0x00000000,
            WS_EX_RIGHTSCROLLBAR = 0x00000000,
            WS_EX_LTRREADING = 0x00000000,
            WS_EX_DLGMODALFRAME = 0x00000001,
            WS_EX_NOPARENTNOTIFY = 0x00000004,
            WS_EX_TOPMOST = 0x00000008,
            WS_EX_ACCEPTFILES = 0x00000010,
            WS_EX_TRANSPARENT = 0x00000020,
            WS_EX_MDICHILD = 0x00000040,
            WS_EX_TOOLWINDOW = 0x00000080,
            WS_EX_WINDOWEDGE = 0x00000100,
            WS_EX_CLIENTEDGE = 0x00000200,
            WS_EX_CONTEXTHELP = 0x00000400,
            WS_EX_RIGHT = 0x00001000,
            WS_EX_RTLREADING = 0x00002000,
            WS_EX_LEFTSCROLLBAR = 0x00004000,
            WS_EX_CONTROLPARENT = 0x00010000,
            WS_EX_STATICEDGE = 0x00020000,
            WS_EX_APPWINDOW = 0x00040000,
            WS_EX_OVERLAPPEDWINDOW = WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE,

            WS_EX_PALETTEWINDOW = WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW |
                                  WS_EX_TOPMOST,
            WS_EX_LAYERED = 0x00080000,
            WS_EX_NOINHERITLAYOUT = 0x00100000, // Disable inheritence of mirroring by children
            WS_EX_LAYOUTRTL = 0x00400000, // Right to left mirroring
            WS_EX_COMPOSITED = 0x02000000,
            WS_EX_NOACTIVATE = 0x08000000,

            none = 0x00000000,
            all = 0xFFFFFFFF,

            left = WS_EX_LEFT,
            ltrReading = WS_EX_LTRREADING,
            rightScrollBar = WS_EX_RIGHTSCROLLBAR,
            dlgModalFrame = WS_EX_DLGMODALFRAME,
            noParentNotify = WS_EX_NOPARENTNOTIFY,
            topMost = WS_EX_TOPMOST,
            acceptFiles = WS_EX_ACCEPTFILES,
            transparent = WS_EX_TRANSPARENT,
            mdiChild = WS_EX_MDICHILD,
            toolWindow = WS_EX_TOOLWINDOW,
            windowEdge = WS_EX_WINDOWEDGE,
            clientEdge = WS_EX_CLIENTEDGE,
            contextHelp = WS_EX_CONTEXTHELP,
            right = WS_EX_RIGHT,
            rtlReading = WS_EX_RTLREADING,
            leftScrollBar = WS_EX_LEFTSCROLLBAR,
            controlParent = WS_EX_CONTROLPARENT,
            staticEdge = WS_EX_STATICEDGE,
            appWindow = WS_EX_APPWINDOW,
            overlappedWindow = WS_EX_OVERLAPPEDWINDOW,
            paletteWindow = WS_EX_PALETTEWINDOW,
            layered = WS_EX_LAYERED,
            noInheritLayout = WS_EX_NOINHERITLAYOUT, // Disable inheritence of mirroring by children
            layoutRtl = WS_EX_LAYOUTRTL, // Right to left mirroring
            composited = WS_EX_COMPOSITED,
            noActivate = WS_EX_NOACTIVATE,
        }

        #endregion

        #region posFlags

        /*
		* SetWindowPos Flags
		*/

        public enum posFlags : uint
        {
            SWP_NOSIZE = 0x0001,
            SWP_NOMOVE = 0x0002,
            SWP_NOZORDER = 0x0004,
            SWP_NOREDRAW = 0x0008,
            SWP_NOACTIVATE = 0x0010,
            SWP_FRAMECHANGED = 0x0020, /* The frame changed: send WM_NCCALCSIZE */
            SWP_SHOWWINDOW = 0x0040,
            SWP_HIDEWINDOW = 0x0080,
            SWP_NOCOPYBITS = 0x0100,
            SWP_NOOWNERZORDER = 0x0200, /* Don't do owner Z ordering */
            SWP_NOSENDCHANGING = 0x0400, /* Don't send WM_WINDOWPOSCHANGING */
            SWP_DRAWFRAME = SWP_FRAMECHANGED,
            SWP_NOREPOSITION = SWP_NOOWNERZORDER,
            SWP_DEFERERASE = 0x2000,
            SWP_ASYNCWINDOWPOS = 0x4000,
        }

        #endregion

        #region Messages

        public enum Messages
        {
            WM_DRAWCLIPBOARD = 0x308,
            WM_CHANGECBCHAIN = 0x30D,
        }

        #endregion

        #region SysColor

        public enum SysColor
        {
            COLOR_SCROLLBAR = 0,
            COLOR_BACKGROUND = 1,
            COLOR_ACTIVECAPTION = 2,
            COLOR_INACTIVECAPTION = 3,
            COLOR_MENU = 4,
            COLOR_WINDOW = 5,
            COLOR_WINDOWFRAME = 6,
            COLOR_MENUTEXT = 7,
            COLOR_WINDOWTEXT = 8,
            COLOR_CAPTIONTEXT = 9,
            COLOR_ACTIVEBORDER = 10,
            COLOR_INACTIVEBORDER = 11,
            COLOR_APPWORKSPACE = 12,
            COLOR_HIGHLIGHT = 13,
            COLOR_HIGHLIGHTTEXT = 14,
            COLOR_BTNFACE = 15,
            COLOR_BTNSHADOW = 16,
            COLOR_GRAYTEXT = 17,
            COLOR_BTNTEXT = 18,
            COLOR_INACTIVECAPTIONTEXT = 19,
            COLOR_BTNHIGHLIGHT = 20,
            COLOR_3DDKSHADOW = 21,
            COLOR_3DLIGHT = 22,
            COLOR_INFOTEXT = 23,
            COLOR_INFOBK = 24,
            COLOR_HOTLIGHT = 26,
            COLOR_GRADIENTACTIVECAPTION = 27,
            COLOR_GRADIENTINACTIVECAPTION = 28,
            COLOR_MENUHILIGHT = 29,
            COLOR_MENUBAR = 30,
            COLOR_DESKTOP = COLOR_BACKGROUND,
            COLOR_3DFACE = COLOR_BTNFACE,
            COLOR_3DSHADOW = COLOR_BTNSHADOW,
            COLOR_3DHIGHLIGHT = COLOR_BTNHIGHLIGHT,
            COLOR_3DHILIGHT = COLOR_BTNHIGHLIGHT,
            COLOR_BTNHILIGHT = COLOR_BTNHIGHLIGHT,
        }

        #endregion

        #region MonitorInfoFlags

        [Flags]
        public enum MonitorInfoFlags
        {
            None = 0,
            Primary = 1,
        }

        #endregion

        #region enum MonitorDefaultTo

        public enum MonitorDefaultTo
        {
            Null = 0x00000000,
            Primary = 0x00000001,
            Nearest = 0x00000002,
        }

        #endregion

        #endregion

        #region public Structs

        [StructLayout(LayoutKind.Sequential)]
        public struct MONITORINFO
        {
            public int cbSize;
            public Rectangle rcMonitor;
            public Rectangle rcWork;
            public MonitorInfoFlags dwFlags;
        }

        #endregion

        [DllImport("USER32.DLL")]
        public static extern int SetParent(IntPtr hWndChild, IntPtr hWndNewParent);

        [DllImport("USER32.DLL")]
        public static extern bool IsWindow(IntPtr hWnd);

        [DllImport("USER32.DLL")]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndNext, int X, int Y, int cx, int cy,
                                               posFlags uFlags);

        [DllImport("USER32.DLL")]
        public static extern uint GetWindowLong(IntPtr hWnd, indices nIndex);

        [DllImport("USER32.DLL")]
        public static extern uint SetWindowLong(IntPtr hWnd, indices nIndex, uint val);

        #region HasStyle

        public static bool HasStyle(IntPtr hWnd, styles styleVal)
        {
            uint dwStyle = GetWindowLong(hWnd, indices.GWL_STYLE);
            return (((uint) styleVal & dwStyle) == (uint) styleVal) ? true : false;
        }

        public static bool IsDisabled(IntPtr hWnd)
        {
            return HasStyle(hWnd, styles.disabled);
        }

        #endregion

        #region ModifyStyle

        public static bool ModifyStyle(IntPtr hWnd, styles dwRemove, styles dwAdd)
        {
            return ModifyStyle(hWnd, dwRemove, dwAdd, 0);
        }

        public static bool ModifyStyle(IntPtr hWnd, styles dwRemove, styles dwAdd, uint nFlags)
        {
            Trace.Assert(IsWindow(hWnd));
            uint dwStyle = GetWindowLong(hWnd, indices.GWL_STYLE);
            uint dwNewStyle = (dwStyle & ~(uint) dwRemove) | (uint) dwAdd;
            if (dwStyle == dwNewStyle)
                return false;

            SetWindowLong(hWnd, indices.GWL_STYLE, dwNewStyle);
            if (nFlags != 0)
            {
                SetWindowPos(hWnd, IntPtr.Zero, 0, 0, 0, 0,
                             posFlags.SWP_NOSIZE | posFlags.SWP_NOMOVE |
                             posFlags.SWP_NOZORDER | posFlags.SWP_NOACTIVATE | (posFlags) nFlags);
            }
            return true;
        }

        public static bool ModifyStyleEx(IntPtr hWnd, exStyles dwRemove, exStyles dwAdd)
        {
            return ModifyStyleEx(hWnd, dwRemove, dwAdd, 0);
        }

        public static bool ModifyStyleEx(IntPtr hWnd, exStyles dwRemove, exStyles dwAdd, uint nFlags)
        {
            Trace.Assert(IsWindow(hWnd));
            uint dwStyle = GetWindowLong(hWnd, indices.GWL_EXSTYLE);
            uint dwNewStyle = (dwStyle & ~(uint) dwRemove) | (uint) dwAdd;
            if (dwStyle == dwNewStyle)
                return false;

            SetWindowLong(hWnd, indices.GWL_EXSTYLE, dwNewStyle);
            if (nFlags != 0)
            {
                SetWindowPos(hWnd, IntPtr.Zero, 0, 0, 0, 0,
                             posFlags.SWP_NOSIZE | posFlags.SWP_NOMOVE |
                             posFlags.SWP_NOZORDER | posFlags.SWP_NOACTIVATE | (posFlags) nFlags);
            }
            return true;
        }

        #endregion

        [DllImport("USER32.DLL")]
        public static extern IntPtr WindowFromPoint(Point pt);

        [DllImport("USER32.DLL")]
        public static extern bool IsChild(IntPtr hWndParent, IntPtr hWnd);

        private delegate bool EnumWindowsProc(int hwnd, int lParam);

        [DllImport("user32")]
        private static extern int EnumWindows(EnumWindowsProc x, int y);

        [DllImport("user32")]
        private static extern uint GetWindowThreadProcessId(int hWnd, out int ProcessId);

        [DllImport("user32")]
        private static extern int GetClassName(int hWnd, [Out] StringBuilder lpClassName, int nMaxCount);

        /// <summary>Workspace static functions for calling enum.  Use a lock to prevent </summary>
        private static IntPtr wrkspc_hwnd;

        private static string wrkspc_classid;

        public static IntPtr FindMainWindow(int processid, string classname)
        {
            IntPtr retval = IntPtr.Zero;
            lock (typeof (NativeMethods))
            {
                wrkspc_classid = classname;
                wrkspc_hwnd = Marshal.AllocHGlobal(Marshal.SizeOf(typeof (uint)));
                try
                {
                    EnumWindowsProc myCallBack = FindTopWindowByProcessId;
                    EnumWindows(myCallBack, processid);

                    var hwnd = (int) Marshal.PtrToStructure(wrkspc_hwnd, typeof (int));
                    retval = new IntPtr(hwnd);
                }
                finally
                {
                    if (wrkspc_hwnd != IntPtr.Zero)
                    {
                        Marshal.FreeHGlobal(wrkspc_hwnd);
                        wrkspc_hwnd = IntPtr.Zero;
                    }
                    wrkspc_classid = string.Empty;
                }
            }
            return retval;
        }

        private static bool FindTopWindowByProcessId(int hwnd, int lParam)
        {
            try
            {
                int procid = 0;
                GetWindowThreadProcessId(hwnd, out procid);
                if (procid == lParam)
                {
                    var sb = new StringBuilder(64);
                    GetClassName(hwnd, sb, 64);
                    string sClass = sb.ToString();
                    if (string.Compare(sClass, wrkspc_classid, true) == 0)
                    {
                        Marshal.StructureToPtr(hwnd, wrkspc_hwnd, false);
                        return false; // stop enumerating
                    }
                }
            }
            catch
            {
            }

            return true;
        }

        [DllImport("user32.dll")]
        public static extern bool GetClientRect(int hWnd, out Rectangle lpRect);

        [DllImport("user32.dll")]
        public static extern bool GetWindowRect(int hWnd, out Rectangle lpRect);

        /// <summary>
        /// The LockWindowUpdate function disables or enables drawing in the specified window. Only one window can be locked at a time.
        /// </summary>
        /// <param name="hwnd">Specifies the window in which drawing will be disabled. If this parameter is NULL, drawing in the locked window is enabled. </param>
        /// <returns>If the function succeeds, the return value is nonzero.</returns>
        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool LockWindowUpdate(IntPtr hwnd);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, UIntPtr wParam, IntPtr lParam);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern IntPtr SetFocus(IntPtr hWnd);

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern IntPtr GetFocus();

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern IntPtr SetActiveWindow(IntPtr hWnd);

        public enum LockSetForegroundWindowFlags : uint
        {
            Lock = 1,
            Unlock = 2,
        }

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool LockSetForegroundWindow(LockSetForegroundWindowFlags lockCode);

        public static void SetRedraw(IntPtr hWnd, bool redraw)
        {
            SendMessage(hWnd, 0x000B /*WM_SETREDRAW*/, (redraw) ? new UIntPtr(1) : UIntPtr.Zero, IntPtr.Zero);
        }

        public static Color GetSysColor(SysColor color)
        {
            return FromRGB(GetSysColor((int) color));
        }

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        private static extern int GetSysColor(int nIndex);

        private static uint ToRGB(Color color)
        {
            // Format the value of color - 0x00bbggrr
            return ((((color.R) | ((uint) (color.G) << 8)) | (((uint) (color.B)) << 16)));
        }

        private static Color FromRGB(int color)
        {
            return Color.FromArgb(color & 0xFF, (color & 0xFF00) >> 8, (color & 0xFF0000) >> 16);
        }

        [DllImport("user32.dll")]
        public static extern short GetAsyncKeyState(Keys vKey);

        #region Clipboard Functions

        /// <summary>
        /// The SetClipboardViewer function adds the specified window to the chain of clipboard viewers. Clipboard viewer windows receive a WM_DRAWCLIPBOARD message whenever the content of the clipboard changes. 
        /// </summary>
        /// <param name="hWndNewViewer">Handle to the window to be added to the clipboard chain. </param>
        /// <returns>If the function succeeds, the return value identifies the next window in the clipboard viewer chain. If an error occurs or there are no other windows in the clipboard viewer chain, the return value is NULL. To get extended error information, call GetLastError. </returns>
        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr SetClipboardViewer(IntPtr hWndNewViewer);

        /// <summary>
        /// The ChangeClipboardChain function removes a specified window from the chain of clipboard viewers. 
        /// </summary>
        /// <param name="hWndNewNext">Handle to the window to be removed from the chain. The handle must have been passed to the SetClipboardViewer function. </param>
        /// <param name="hWndRemove">Handle to the window that follows the hWndRemove window in the clipboard viewer chain. (This is the handle returned by SetClipboardViewer, unless the sequence was changed in response to a WM_CHANGECBCHAIN message.)</param>
        /// <returns>The return value indicates the result of passing the WM_CHANGECBCHAIN message to the windows in the clipboard viewer chain. Because a window in the chain typically returns FALSE when it processes WM_CHANGECBCHAIN, the return value from ChangeClipboardChain is typically FALSE. If there is only one window in the chain, the return value is typically TRUE.</returns>
        [DllImport("user32.dll")]
        public static extern int ChangeClipboardChain(IntPtr hWndRemove, IntPtr hWndNewNext);

        [DllImport("user32.dll")]
        public static extern bool CloseClipboard();

        [DllImport("user32.dll")]
        public static extern bool OpenClipboard(IntPtr hWndNewOwner);

        [DllImport("user32.dll")]
        public static extern bool IsClipboardFormatAvailable(uint format);

        [DllImport("user32.dll")]
        public static extern int GetPriorityClipboardFormat(uint[] paFormatPriorityList, int cFormats);

        [DllImport("user32.dll")]
        public static extern uint RegisterClipboardFormat(string lpszFormat);

        [DllImport("user32.dll")]
        public static extern int GetClipboardFormatName(uint format, [Out] StringBuilder lpszFormatName, int nMaxCount);

        [DllImport("user32.dll")]
        public static extern int SetClipboardData(uint format, IntPtr hMem);

        [DllImport("user32.dll")]
        public static extern IntPtr GetClipboardData(uint format);

        [DllImport("user32.dll")]
        public static extern bool EmptyClipboard();

        #endregion

        [DllImport("kernel32.dll")]
        public static extern int GlobalSize(IntPtr hMem);

        [DllImport("user32.dll")]
        private static extern IntPtr MonitorFromPoint(Point pt, MonitorDefaultTo dwFlags);

        [DllImport("user32.dll")]
        private static extern bool GetMonitorInfo(IntPtr hMonitor, ref MONITORINFO lpmi);

        #region FitRectOnDesktop

        public static bool FitRectOnDesktop(ref Rectangle rect)
        {
            bool modified = false;
            try
            {
                Point pt = rect.Location;
                Size sz = rect.Size;

                IntPtr hMonitor = MonitorFromPoint(pt, MonitorDefaultTo.Primary);
                var mi = new MONITORINFO();
                mi.cbSize = Marshal.SizeOf(typeof (MONITORINFO));
                if (GetMonitorInfo(hMonitor, ref mi))
                {
                    Rectangle rcWork = mi.rcWork;
                    if (!rcWork.Contains(pt))
                    {
                        if (rect.Y < mi.rcWork.Top)
                            rect.Y = mi.rcWork.Top;
                        if (rect.X < mi.rcWork.Left)
                            rect.X = mi.rcWork.Left;
                        if (rect.Y >= mi.rcWork.Bottom)
                            rect.Y = mi.rcWork.Bottom - rect.Height;
                        if (rect.X >= mi.rcWork.Bottom)
                            rect.X = mi.rcWork.Right - rect.Width;
                        pt = rect.Location;
                        sz = rect.Size;
                        modified = true;
                    }
                }
                else if (hMonitor == IntPtr.Zero)
                {
                    pt.X = pt.Y = 0;
                    modified = true;
                }
            }
            catch
            {
            }
            return modified;
        }

        #endregion

        #endregion

        private const int FACILITY_WINDOWS = 8;
        private const int FACILITY_STORAGE = 3;
        private const int FACILITY_RPC = 1;
        private const int FACILITY_SSPI = 9;
        private const int FACILITY_WIN32 = 7;
        private const int FACILITY_CONTROL = 10;
        private const int FACILITY_NULL = 0;
        private const int FACILITY_ITF = 4;
        private const int FACILITY_DISPATCH = 2;

        public static int HRESULT_FACILITY(int hr)
        {
            return (((hr) >> 16) & 0x1fff);
        }

        public static int HRESULT_CODE(int hr)
        {
            return ((hr) & 0xFFFF);
        }

        public static int HRESULT_SEVERITY(int hr)
        {
            return (((hr) >> 31) & 0x1);
        }

        public static int HRESULT_CUSTOMER(int hr)
        {
            return (((hr) >> 30) & 0x1);
        }
    }

    #endregion
}