namespace TESVSnip.Domain.Services
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Reflection;

    using Microsoft.Win32;

    /// <summary>
    /// Global program options.
    /// </summary>
    public sealed class Options
    {
        private static Options instance;

        private readonly List<string> plugins = new List<string>();

        private Options(string[] args)
        {
            this.SettingsDirectory = Environment.CurrentDirectory;
            this.ApplicationDirectory = Environment.CurrentDirectory;

            this.SetupGameDirectory();
            this.SetupApplicationDirectory();
            this.ParseCommandLine(args);
            this.PrepareDirectories();
        }

        /// <summary>
        /// Gets access to the single instance of this class.
        /// </summary>
        public static Options Value
        {
            get
            {
                if (instance == null)
                {
                    throw new NullReferenceException("Program options are not initialized yet.");
                }

                return instance;
            }
        }

        /// <summary>
        /// Gets the list of plugins to pre-load specified using the command-line options.
        /// </summary>
        public IEnumerable<string> Plugins
        {
            get
            {
                return this.plugins;
            }
        }

        public string SettingsDirectory { get; private set; }

        public string ApplicationDirectory { get; private set; }

        public string GameDirectory { get; private set; }

        public string GameDataDirectory { get; private set; }

        /// <summary>
        /// Initializes the global options parsing the given <paramref name="args"/> array.
        /// </summary>
        /// <param name="args">
        /// The received command-line options.
        /// </param>
        public static void Initialize(string[] args)
        {
            instance = new Options(args);
        }

        private void SetupApplicationDirectory()
        {
            var assembly = Assembly.GetExecutingAssembly();
            this.ApplicationDirectory = Path.GetDirectoryName(assembly.Location);
            var applicationDirectory = this.ApplicationDirectory;
            if (applicationDirectory != null)
            {
                this.SettingsDirectory = Path.Combine(applicationDirectory, "conf");
            }
        }

        private void ParseCommandLine(string[] args)
        {
            for (int i = 0; i < args.Length; ++i)
            {
                string arg = args[i];
                if (string.IsNullOrEmpty(arg))
                {
                    continue;
                }

                if (arg[0] == '-' || arg[0] == '/')
                {
                    if (arg.Length == 1)
                    {
                        continue;
                    }

                    switch (char.ToLower(arg[1]))
                    {
                        case 'c':
                            this.SettingsDirectory = (arg.Length > 2 && arg[2] == ':') ? arg.Substring(3) : args[++i];
                            break;
                    }
                }
                else
                {
                    this.plugins.Add(arg);
                }
            }
        }

        private void SetupGameDirectory()
        {
            try
            {
                using (var key = Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Wow6432Node\Bethesda Softworks\Skyrim"))
                {
                    if (key == null)
                    {
                        return;
                    }

                    this.GameDirectory = key.GetValue("Installed Path", this.GameDirectory, RegistryValueOptions.None) as string;
                    var gameDirectory = this.GameDirectory;
                    if (gameDirectory != null)
                    {
                        this.GameDataDirectory = Path.Combine(gameDirectory, "Data");
                    }
                }
            }
            catch
            {
            }
        }

        private void PrepareDirectories()
        {
            if (string.IsNullOrEmpty(this.GameDirectory))
            {
                this.GameDirectory = Environment.CurrentDirectory;
            }

            if (string.IsNullOrEmpty(this.GameDataDirectory))
            {
                this.GameDataDirectory = Environment.CurrentDirectory;
            }

            if (Directory.Exists(this.GameDataDirectory))
            {
                Environment.CurrentDirectory = this.GameDataDirectory;
            }
        }
    }
}