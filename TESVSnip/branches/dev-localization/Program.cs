namespace TESVSnip
{
    using System;
    using System.Windows.Forms;

    using TESVSnip.Domain.Services;
    using TESVSnip.Framework.Services;
    using TESVSnip.Properties;
    using TESVSnip.UI.Forms;

    using Settings = TESVSnip.Properties.Settings;

    internal static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        /// <param name="args">
        /// The args.
        /// </param>
        [STAThread]
        private static void Main(string[] args)
        {
            Options.Initialize(args);
            Encoding.Initalize(Settings.Default.UseUTF8);
            ZLib.Initialize();

            try
            {
                AppDomain.CurrentDomain.UnhandledException += OnUnhandledException;

                Settings.Default.Reload();
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);

                var main = new MainView();
                foreach (string arg in Options.Value.Plugins)
                {
                    main.LoadPlugin(arg);
                }

                try
                {
                    Application.Run(main);
                    Settings.Default.Save();
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

        private static void OnUnhandledException(object sender, UnhandledExceptionEventArgs eventArgs)
        {
            if (eventArgs.IsTerminating)
            {
                MessageBox.Show("Fatal Unhandled Exception:\n" + eventArgs.ExceptionObject.ToString(), Resources.ErrorText, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
                MessageBox.Show("Unhandled Exception:\n" + eventArgs.ExceptionObject.ToString(), Resources.ErrorText, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
