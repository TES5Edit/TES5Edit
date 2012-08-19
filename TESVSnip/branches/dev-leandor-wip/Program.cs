using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Windows.Forms;
using Microsoft.Win32;
using TESVSnip.Properties;

namespace TESVSnip
{
    using TESVSnip.Domain.Services;
    using TESVSnip.Framework.Services;
    using TESVSnip.UI.Forms;

    internal static class Program
    {
        public static string settingsDir { get; set; }
        public static string exeDir { get; set; }
        public static string gameDir { get; set; }
        public static string gameDataDir { get; set; }


        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        private static void Main(string[] args)
        {
            Encoding.Initalize(Settings.Default.UseUTF8);
            ZLib.Initialize();

            var plugins = new List<string>();
            settingsDir = Environment.CurrentDirectory;
            exeDir = Environment.CurrentDirectory;
            try
            {
                Assembly asm = Assembly.GetExecutingAssembly();
                exeDir = Path.GetDirectoryName(asm.Location);
                settingsDir = Path.Combine(exeDir, "conf");

                using (
                    RegistryKey key = Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Wow6432Node\Bethesda Softworks\Skyrim")
                    )
                {
                    gameDir = key.GetValue("Installed Path", gameDir, RegistryValueOptions.None) as string;
                    gameDataDir = Path.Combine(gameDir, "Data");
                }

                object[] asmAttributes = asm.GetCustomAttributes(true);
            }
            catch
            {
            }
            try
            {
                for (int i = 0; i < args.Length; ++i)
                {
                    string arg = args[i];
                    if (string.IsNullOrEmpty(arg))
                        continue;
                    if (arg[0] == '-' || arg[0] == '/')
                    {
                        if (arg.Length == 1)
                            continue;
                        switch (char.ToLower(arg[1]))
                        {
                            case 'c':
                                settingsDir = (arg.Length > 2 && arg[2] == ':') ? arg.Substring(3) : args[++i];
                                break;
                        }
                    }
                    else
                    {
                        plugins.Add(arg);
                    }
                }

                if (string.IsNullOrEmpty(gameDir))
                    gameDir = Environment.CurrentDirectory;
                if (string.IsNullOrEmpty(gameDataDir))
                    gameDataDir = Environment.CurrentDirectory;
                if (Directory.Exists(gameDataDir))
                    Environment.CurrentDirectory = gameDataDir;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error initializing main view: \n" + ex.Message, Resources.ErrorText);
            }

            try
            {
                AppDomain.CurrentDomain.UnhandledException += (sender, eventArgs) =>
                                                                  {
                                                                      if (eventArgs.IsTerminating)
                                                                      {
                                                                          MessageBox.Show(
                                                                              "Fatal Unhandled Exception:\n" +
                                                                              eventArgs.ExceptionObject.ToString(),
                                                                              Resources.ErrorText, MessageBoxButtons.OK,
                                                                              MessageBoxIcon.Error);
                                                                      }
                                                                      else
                                                                      {
                                                                          MessageBox.Show(
                                                                              "Unhandled Exception:\n" +
                                                                              eventArgs.ExceptionObject.ToString(),
                                                                              Resources.ErrorText, MessageBoxButtons.OK,
                                                                              MessageBoxIcon.Error);
                                                                      }
                                                                  };

                Properties.Settings.Default.Reload();
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);

                var main = new MainView();
                foreach (string arg in plugins)
                {
                    main.LoadPlugin(arg);
                }

                try
                {
                    Application.Run(main);
                    Properties.Settings.Default.Save();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error running main window: \n" + ex, Resources.ErrorText);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error initializing main view: \n" + ex, Resources.ErrorText);
            }
        }
    }
}