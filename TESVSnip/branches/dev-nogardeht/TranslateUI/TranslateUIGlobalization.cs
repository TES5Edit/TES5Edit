using System;
using System.Windows.Forms;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;
using System.Resources;
using System.Threading;

namespace TESVSnip.TranslateUI
{
  public static class TranslateUIGlobalization
  {
    public static string ResourcesPath = string.Empty;
    public static string CultureCode = "";

    private static ResourceManager rm = null;
    public static ResourceManager RM { get { return rm; } }

    /// <summary>
    /// Globalize Application
    /// </summary>
    public static void GlobalizeApp()
    {
      SetCulture();
      SetResource();
    }

    /// <summary>
    /// Set Culture
    /// </summary>
    private static void SetCulture()
    {
      CultureInfo objCI = new CultureInfo(CultureCode);
      Thread.CurrentThread.CurrentCulture = objCI;
      Thread.CurrentThread.CurrentUICulture = objCI;
    }

    /// <summary>
    /// Set Resource from file
    /// </summary>
    private static void SetResource()
    {
      ResourcesPath = System.IO.Path.Combine(Application.StartupPath, "Lang");
      rm = null;
      rm = ResourceManager.CreateFileBasedResourceManager("resource", ResourcesPath, null);
    }

  }
}
