using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Design;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using System.Windows.Forms.Design;

namespace TESVSnip.Windows.Controls
{
    /// <summary>
    /// BallonToolTip
    /// </summary>
    /// <remarks>Original author: Eric Wilson</remarks>
    [
        ProvideProperty("ToolTip", typeof (Control)),
        ProvideProperty("TipTitle", typeof (Control)),
        ProvideProperty("IconType", typeof (Control)),
        ToolboxBitmap(typeof (ToolTip))
    ]
    public class BallonToolTip : Component, IExtenderProvider
    {
        #region class NativeToolTipWindow

        /// <summary>
        /// Native ToolTip window for use with the BallonToolTip component.
        /// </summary>
        internal class NativeToolTipWindow : NativeWindow
        {
            private readonly BallonToolTip m_toolTip;

            /// <summary>
            /// Initializes a new instance of the NativeToolTipWindow class.
            /// </summary>
            public NativeToolTipWindow(BallonToolTip toolTip)
            {
                m_toolTip = toolTip;
            }

            protected override void WndProc(ref Message m)
            {
                m_toolTip.WndProc(ref m);
            }
        }

        #endregion

        // Reference to the Native win32 window
        private readonly NativeToolTipWindow m_window;

        // The keys are Control references and the values are the ToolTipInfo.
        private readonly Hashtable m_controls;

        private readonly ArrayList m_addedList;

        private readonly ToolTipStyle m_style;

        #region Constructors

        /// <summary>
        /// Initializes a new instance of the BallonToolTip class.
        /// </summary>
        public BallonToolTip()
        {
            m_window = new NativeToolTipWindow(this);
            m_controls = new Hashtable();
            m_addedList = new ArrayList();
            m_style = ToolTipStyle.Balloon;
        }

        /// <summary>
        /// Initializes a new instance of the BallonToolTip class.
        /// </summary>
        public BallonToolTip(IContainer container) : this()
        {
            container.Add(this);
        }

        #endregion

        #region Dispose Override 

        /// <summary>
        /// Releases the unmanaged resources used by the Component. 
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (m_window != null && m_window.Handle != IntPtr.Zero)
            {
                m_window.DestroyHandle();
            }
            base.Dispose(disposing);
        }

        #endregion

        #region Public Properties/Methods

        #region ToolTip

        /// <summary>
        /// Retrieves the ToolTip text associated with the specified control.
        /// </summary>
        /// <param name="control">The Control for which to retrieves the ToolTip text</param>
        /// <returns>The ToolTip text for the specified control</returns>
        [DefaultValue("")]
        [Editor(typeof (GWinfoMultilineEditor), typeof (UITypeEditor))]
        public virtual string GetToolTip(Control control)
        {
            string text = "";
            if (m_controls.Contains(control))
            {
                text = ((ToolTipInfo) m_controls[control]).TipText;
            }
            return text;
        }

        /// <summary>
        /// Associates ToolTip text with the specified control.
        /// </summary>
        /// <param name="control">The Control whose ToolTip text you want to set</param>
        /// <param name="text">The ToolTip text</param>
        public virtual void SetToolTip(Control control, string text)
        {
            bool bNewControl, bValidText;

            if (control == null)
            {
                throw new ArgumentNullException("control");
            }

            bNewControl = !m_controls.ContainsKey(control);
            bValidText = (text != null && text.Length > 0);

            if (bNewControl)
            {
                if (bValidText)
                {
                    var info = new ToolTipInfo(text, "", ToolTipIconType.None);
                    m_controls.Add(control, info);
                    control.HandleCreated += HandleCreated;
                    control.HandleDestroyed += HandleDestroyed;
                    if (control.IsHandleCreated)
                    {
                        HandleCreated(control, EventArgs.Empty);
                    }
                }
            }
            else
            {
                var info = (ToolTipInfo) m_controls[control];
                info.TipText = text;
                if (info.TipText.Length == 0 && info.TipTitle.Length == 0 && info.IconType == ToolTipIconType.None)
                {
                    // Remove the control.
                    m_controls.Remove(control);
                    // unhook events
                    control.HandleCreated -= HandleCreated;
                    control.HandleDestroyed -= HandleDestroyed;

                    if (m_addedList.Contains(control))
                    {
                        DestroyRegion(control);
                        m_addedList.Remove(control);
                    }
                }
            }
        }

        #endregion

        #region TipTitle Ù–‘

        [DefaultValue("")]
        public virtual string GetTipTitle(Control control)
        {
            string text = "";
            if (m_controls.Contains(control))
            {
                text = ((ToolTipInfo) m_controls[control]).TipTitle;
            }
            return text;
        }

        public virtual void SetTipTitle(Control control, string title)
        {
            bool bNewControl, bValidText;

            if (control == null)
            {
                throw new ArgumentNullException("control");
            }

            bNewControl = !m_controls.ContainsKey(control);
            bValidText = (title != null && title.Length > 0);

            if (bNewControl)
            {
                if (bValidText)
                {
                    var info = new ToolTipInfo("", title, ToolTipIconType.None);
                    m_controls.Add(control, info);
                    control.HandleCreated += HandleCreated;
                    control.HandleDestroyed += HandleDestroyed;
                    if (control.IsHandleCreated)
                    {
                        HandleCreated(control, EventArgs.Empty);
                    }
                }
            }
            else
            {
                var info = (ToolTipInfo) m_controls[control];
                info.TipTitle = title;
                if (info.TipText.Length == 0 && info.TipTitle.Length == 0 && info.IconType == ToolTipIconType.None)
                {
                    // Remove the control.
                    m_controls.Remove(control);
                    // unhook events
                    control.HandleCreated -= HandleCreated;
                    control.HandleDestroyed -= HandleDestroyed;

                    if (m_addedList.Contains(control))
                    {
                        DestroyRegion(control);
                        m_addedList.Remove(control);
                    }
                }
            }
        }

        #endregion

        #region IconType Ù–‘

        [DefaultValue(ToolTipIconType.None)]
        public virtual ToolTipIconType GetIconType(Control control)
        {
            ToolTipIconType type = ToolTipIconType.None;
            if (m_controls.Contains(control))
            {
                type = ((ToolTipInfo) m_controls[control]).IconType;
            }
            return type;
        }

        public virtual void SetIconType(Control control, ToolTipIconType type)
        {
            bool bNewControl;

            if (control == null)
            {
                throw new ArgumentNullException("control");
            }

            bNewControl = !m_controls.ContainsKey(control);

            if (bNewControl)
            {
                if (type != ToolTipIconType.None)
                {
                    var info = new ToolTipInfo("", "", type);
                    m_controls.Add(control, info);
                    control.HandleCreated += HandleCreated;
                    control.HandleDestroyed += HandleDestroyed;
                    if (control.IsHandleCreated)
                    {
                        HandleCreated(control, EventArgs.Empty);
                    }
                }
            }
            else
            {
                var info = (ToolTipInfo) m_controls[control];
                info.IconType = type;
                if (info.TipText.Length == 0 && info.TipTitle.Length == 0 && info.IconType == ToolTipIconType.None)
                {
                    // Remove the control.
                    m_controls.Remove(control);
                    // unhook events
                    control.HandleCreated -= HandleCreated;
                    control.HandleDestroyed -= HandleDestroyed;

                    if (m_addedList.Contains(control))
                    {
                        DestroyRegion(control);
                        m_addedList.Remove(control);
                    }
                }
            }
        }

        #endregion

        #endregion

        #region WndProc Method

        internal virtual void WndProc(ref Message m)
        {
            if (m.Msg == NativeMethods.WM_NOTIFY)
            {
                var hdr = (NativeMethods.NMHDR) Marshal.PtrToStructure(m.LParam, typeof (NativeMethods.NMHDR));

                if (hdr.code == NativeMethods.TTN_NEEDTEXT)
                {
                    Control control = Control.FromHandle(new IntPtr(hdr.idFrom));
                    if (control != null)
                    {
                        string text = GetToolTip(control);
                        string title = GetTipTitle(control);
                        var icon = (int) GetIconType(control);
                        NativeMethods.SendMessage(new HandleRef(this, Handle), NativeMethods.TTM_SETTITLE, icon, title);

                        var info =
                            (NativeMethods.NMTTDISPINFO)
                            Marshal.PtrToStructure(m.LParam, typeof (NativeMethods.NMTTDISPINFO));
                        info.lpszText = text;
                        Marshal.StructureToPtr(info, m.LParam, true);
                    }
                    return;
                }
            }
            m_window.DefWndProc(ref m);
        }

        #endregion

        #region IExtenderProvider Members

        public bool CanExtend(object extendee)
        {
            if (extendee is Control)
            {
                return true;
            }
            return false;
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Registers the control with the tooltip window when its handle is created.
        /// </summary>
        private void HandleCreated(object sender, EventArgs e)
        {
            CreateRegion((Control) sender);
        }

        private void HandleDestroyed(object sender, EventArgs e)
        {
            DestroyRegion((Control) sender);
        }

        /// <summary>
        /// Registers the specified control with the tooltip window.
        /// </summary>
        /// <param name="ctl"></param>
        private void CreateRegion(Control ctl)
        {
            if (!m_controls.ContainsKey(ctl))
            {
                return;
            }
            var info = (ToolTipInfo) m_controls[ctl];

            bool flag = info.TipText.Length > 0 || info.TipTitle.Length > 0 || info.IconType != ToolTipIconType.None;
            if (flag && !m_addedList.Contains(ctl) && !base.DesignMode)
            {
                var num1 =
                    (int)
                    NativeMethods.SendMessage(new HandleRef(this, Handle), NativeMethods.TTM_ADDTOOL, 0,
                                              GetTOOLINFO(ctl));
                if (num1 == 0)
                {
                    throw new InvalidOperationException("error:" + NativeMethods.GetLastError());
                }
                m_addedList.Add(ctl);
            }
        }

        private void DestroyRegion(Control control)
        {
            bool flag = control.IsHandleCreated && IsHandleCreated;
            if (m_addedList.Contains(control) && flag && !base.DesignMode)
            {
                NativeMethods.SendMessage(new HandleRef(this, Handle), NativeMethods.TTM_DELTOOL, 0,
                                          GetTOOLINFO(control));
                m_addedList.Remove(control);
            }
        }

        /// <summary>
        /// Creates and initializes a NativeMethods.TOOLINFO structure associate width the specified control
        /// </summary>
        private NativeMethods.TOOLINFO GetTOOLINFO(Control ctl)
        {
            var toolinfo = new NativeMethods.TOOLINFO();
            toolinfo.cbSize = Marshal.SizeOf(typeof (NativeMethods.TOOLINFO));
            toolinfo.hwnd = Handle;
            toolinfo.uFlags = NativeMethods.TTF_TRANSPARENT | NativeMethods.TTF_SUBCLASS | NativeMethods.TTF_IDISHWND;
            toolinfo.uId = ctl.Handle;
            toolinfo.lpszText = NativeMethods.LPSTR_TEXTCALLBACKW;
            return toolinfo;
        }

        /// <summary>
        /// Creates the ToolTip window handle.
        /// </summary>
        private void CreateHandle()
        {
            if (!IsHandleCreated)
            {
                var initcommoncontrolsex1 = new NativeMethods.INITCOMMONCONTROLSEX();
                initcommoncontrolsex1.dwICC = 8; // ICC_TAB_CLASSES : Load tab and ToolTip control classes. 
                NativeMethods.InitCommonControlsEx(initcommoncontrolsex1);
                m_window.CreateHandle(CreateParams);
                NativeMethods.SetWindowPos(new HandleRef(this, Handle), NativeMethods.HWND_TOPMOST, 0, 0, 0, 0,
                                           NativeMethods.SWP_NOACTIVATE | NativeMethods.SWP_NOMOVE |
                                           NativeMethods.SWP_NOSIZE);
                NativeMethods.SendMessage(new HandleRef(this, Handle), NativeMethods.TTM_SETMAXTIPWIDTH, 0,
                                          SystemInformation.MaxWindowTrackSize.Width);
                NativeMethods.SendMessage(new HandleRef(this, Handle), NativeMethods.TTM_ACTIVATE, 1, 0);
            }
        }

        private CreateParams CreateParams
        {
            get
            {
                var params1 = new CreateParams();
                params1.Parent = IntPtr.Zero;
                params1.ClassName = NativeMethods.TOOLTIPS_CLASS;
                params1.Style |= NativeMethods.TTS_ALWAYSTIP;
                if (m_style == ToolTipStyle.Balloon)
                {
                    params1.Style |= NativeMethods.TTS_BALLOON;
                }

                params1.ExStyle = 0;
                params1.Caption = null;
                return params1;
            }
        }

        private bool IsHandleCreated
        {
            get { return (m_window.Handle != IntPtr.Zero); }
        }

        private IntPtr Handle
        {
            get
            {
                if (!IsHandleCreated)
                {
                    CreateHandle();
                }
                return m_window.Handle;
            }
        }

        #endregion
    }

    /// <summary>
    /// IconType
    /// </summary>
    public enum ToolTipIconType
    {
        None = 0,
        Information,
        Warning,
        Error
    }

    /// <summary>
    /// ToolTipStyle
    /// </summary>
    public enum ToolTipStyle
    {
        Standard,
        Balloon
    }

    #region class ToolTipInfo

    /// <summary>
    /// ToolTipInfo
    /// </summary>
    internal class ToolTipInfo
    {
        /// <summary>
        /// Initializes a new instance of the ToolTipInfo class.
        /// </summary>
        public ToolTipInfo() : this("", "", ToolTipIconType.None)
        {
        }

        /// <summary>
        /// Initializes a new instance of the ToolTipInfo class.
        /// </summary>
        /// <param name="text">ToolTip text</param>
        /// <param name="title">ToolTip title</param>
        /// <param name="icon">ToolTip icon type</param>
        public ToolTipInfo(string text, string title, ToolTipIconType icon)
        {
            TipText = text;
            TipTitle = title;
            IconType = icon;
        }

        /// <summary>
        /// Gets/sets the tooltip text.
        /// </summary>
        public string TipText { get; set; }

        /// <summary>
        /// Gets/sets the tooltip title.
        /// </summary>
        public string TipTitle { get; set; }

        /// <summary>
        /// Gets/sets the icon type.
        /// </summary>
        public ToolTipIconType IconType { get; set; }
    }

    #endregion

    #region class GWinfoMultilineEditor

    internal class GWinfoMultilineEditor : UITypeEditor
    {
        public override UITypeEditorEditStyle GetEditStyle(ITypeDescriptorContext context)
        {
            return UITypeEditorEditStyle.DropDown;
        }

        public override object EditValue(ITypeDescriptorContext context, IServiceProvider provider, object value)
        {
            if (provider == null)
                return value;

            var edSvc = provider.GetService(typeof (IWindowsFormsEditorService)) as IWindowsFormsEditorService;

            if (edSvc == null)
                return value;

            var textBox = new MultilineTextBox();
            textBox.BorderStyle = BorderStyle.None;
            textBox.Size = new Size(150, 80);
            textBox.Text = value == null ? string.Empty : value.ToString();

            edSvc.DropDownControl(textBox);

            if (!textBox.Cancelled)
                value = textBox.Text;

            textBox.Dispose();

            return value;
        }

        private class MultilineTextBox : TextBox
        {
            private bool cancelled;

            internal MultilineTextBox()
            {
                Multiline = true;
                AcceptsTab = true;
            }

            internal bool Cancelled
            {
                get { return cancelled; }
            }

            protected override bool ProcessDialogKey(Keys keyData)
            {
                if (keyData == Keys.Escape)
                    cancelled = true;
                return base.ProcessDialogKey(keyData);
            }
        }
    }

    #endregion
}