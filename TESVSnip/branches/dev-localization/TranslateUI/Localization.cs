using System;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using System.Windows.Forms;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using RTF;

using TESVSnip;
using TESVSnip.Properties;
using BrightIdeasSoftware;
using System.Diagnostics;

namespace TESVSnip.UI.Forms
{
  internal partial class MainView : Form
  {

    /// <summary>
    /// Localize TESsnip
    /// </summary>
    private void LocalizeApp()
    {
      TranslateUI.TranslateUIGlobalization.CultureCode = Properties.Settings.Default.CultureCodeUI;
      TranslateUI.TranslateUIGlobalization.GlobalizeApp();

      AddLanguageUIOption();

      //** Mainview - TESSNIP_MainView      
      fileToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_fileToolStripMenuItem");
      newToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_newToolStripMenuItem");
      openNewPluginToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_openNewPluginToolStripMenuItem");
      saveToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_saveToolStripMenuItem");
      saveAsToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_saveAsToolStripMenuItem");
      closeToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_closeToolStripMenuItem");
      closeAllToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_closeAllToolStripMenuItem");
      reloadXmlToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_reloadXmlToolStripMenuItem");
      exitToolStripMenuItem.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("TESSNIP_MainView_exitToolStripMenuItem");
    }

    private void AddLanguageUIOption()
    {
      foreach (ToolStripMenuItem tsmi in this.optionsToolStripMenuItem.DropDown.Items)
      {
        if (Convert.ToString(tsmi.Tag) == "UILanguage")
        {
          for (int i = tsmi.DropDown.Items.Count - 1; i >= 0; i--)
          {
            ToolStripItem tsiUI = (ToolStripItem)tsmi.DropDown.Items[i];
            tsiUI.Click -= new EventHandler(UILanguageMenuItemClickHandler);
            tsmi.DropDown.Items.Remove(tsiUI);
          }

          this.optionsToolStripMenuItem.DropDown.Items.Remove(tsmi);
          break;
        }
      }

      ToolStripMenuItem menu = new System.Windows.Forms.ToolStripMenuItem();
      menu.Name = "UILanguageToolStripMenuItem";
      menu.Tag = "UILanguage";
      menu.Text = TranslateUI.TranslateUIGlobalization.RM.GetString("UI_Language_MenuName"); 
      this.optionsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { menu });

      ToolStripMenuItem[] items = new ToolStripMenuItem[2];
      for (int i = 0; i < items.Length; i++)
      {
        items[i] = new ToolStripMenuItem();
        items[i].Name = "dynamicItem" + i.ToString();
        switch (i)
        {
          case 0:
            items[i].Tag = "UIEnglish";
            items[i].Text = TranslateUI.TranslateUIGlobalization.RM.GetString("UI_Language_English"); //"English";
            break;
          case 1:
            items[i].Tag = "UIFrench";
            items[i].Text =  TranslateUI.TranslateUIGlobalization.RM.GetString("UI_Language_French"); //"French";
            break;
          default:
            break;
        }

        items[i].Click += new EventHandler(UILanguageMenuItemClickHandler);
      }

      menu.DropDownItems.AddRange(items);

    }

    private void UILanguageMenuItemClickHandler(object sender, EventArgs e)
    {
      ToolStripMenuItem clickedItem = (ToolStripMenuItem)sender;

      LocalizeApp();

      if (Convert.ToString(clickedItem.Tag) == "UIEnglish")
        Properties.Settings.Default.CultureCodeUI = "";

      if (Convert.ToString(clickedItem.Tag) == "UIFrench")
        Properties.Settings.Default.CultureCodeUI = "fr-FR";

      LocalizeApp();
    }


  }
}