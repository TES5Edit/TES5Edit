using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;
using System.Diagnostics;
using System.IO;
using Microsoft.Win32;
using System.Linq;

namespace MSBuildTasks
{
    /// <summary>
    /// Set environment variable
    /// </summary>
    /// <example>
    /// 
    ///     <UsingTask TaskName="MSBuildTasks.SetEnvVar" AssemblyFile="$(RootDir)Tools\Bin\MSBuildTasks.dll"/>
    ///     <Target Name="PrepareBuildEnvironment">
    ///         <SetEnvVar Variable="DevEnvDir" Value="$(DevEnvDir)"/>
    ///     <Target Name="PrepareBuildEnvironment">
    ///     
    /// </example>
    public class SetEnvVar : Task
    {
        private string _variable;
        private string _value;

        [Required]
        public string Variable
        {
            get { return _variable; }
            set { _variable = value; }
        }

        [Required]
        public string Value
        {
            get { return _value; }
            set { _value = value; }
        }

        public override bool Execute()
        {
            Environment.SetEnvironmentVariable(_variable, _value);
            return true;
        }
    }

    /// <summary>
    /// Set environment variable
    /// </summary>
    /// <example>
    /// 
    ///     <UsingTask TaskName="MSBuildTasks.SetEnvVar" AssemblyFile="$(RootDir)Tools\Bin\MSBuildTasks.dll"/>
    ///     <Target Name="PrepareBuildEnvironment">
    ///         <SetEnvVar Variable="DevEnvDir" Value="$(DevEnvDir)"/>
    ///     <Target Name="PrepareBuildEnvironment">
    ///     
    /// </example>
    public class SimpleExec : Task
    {
        [Required]
        public string Command
        {
            get;
            set;
        }

        [Required]
        public string Args
        {
            get;
            set;
        }

        public string StdIn
        {
            get;
            set;
        }

        public string WorkingDirectory
        {
            get;
            set;
        }

        public bool FailOnErrorCode
        {
            get;
            set;
        }

        public SimpleExec()
        {
            this.WorkingDirectory = System.Environment.CurrentDirectory;
            this.FailOnErrorCode = true;
        }


        [Output]
        public ITaskItem StdOut
        {
            get; private set;
        }

        [Output]
        public ITaskItem StdError
        {
            get; private set;
        }

        [Output]
        public ITaskItem ExitCode
        {
            get; private set;
        }

        void LogError(string text, params object[] args)
        {
            if (FailOnErrorCode) 
                Log.LogError(text, args);
            else
                Log.LogWarning(text, args);
        }

        private static int SearchPath(string lpPath, string lpFileName, string lpExtension, out string lpBuffer, out string lpFilePart)
        {
            // lpPath [in, optional] 
            // The path to be searched for the file. 
            // If this parameter is NULL, the function searches for a matching file using a registry-dependent system search path.

            //lpFileName [in] 
            //The name of the file for which to search.

            //lpExtension [in, optional] 
            //The extension to be added to the file name when searching for the file. The first character of the file name extension must be a period (.). The extension is added only if the specified file name does not end with an extension. 

            //If a file name extension is not required or if the file name contains an extension, this parameter can be NULL.

            //nBufferLength [in] 
            //The size of the buffer that receives the valid path and file name, in TCHARs.

            //lpBuffer [out] 
            //A pointer to the buffer to receive the path and file name of the file found. The string is a null-terminated string.

            //lpFilePart [out, optional] 
            //A pointer to the variable to receive the address (within lpBuffer) of the last component of the valid path and file name, which is the address of the character immediately following the final backslash (\) in the path.

            //Return Value
            //If the function succeeds, the value returned is the length, in TCHARs, of the string that is copied to the buffer, not including the terminating null character. If the return value is greater than nBufferLength, the value returned is the size of the buffer that is required to hold the path.

            //If the function fails, the return value is zero. 

            List<string> pathsToSearch = new List<string>();
            lpBuffer = "";
            lpFilePart = "";

            if (lpPath == null)
            {
                string currentWorkingFolder = Environment.CurrentDirectory;
                string path = System.Environment.GetEnvironmentVariable("path");

                RegistryKey key = Registry.LocalMachine.OpenSubKey("SYSTEM\\CurrentControlSet\\Control\\Session Manager");
                object safeProcessSearchModeObject = key.GetValue("SafeProcessSearchMode");
                if (safeProcessSearchModeObject != null)
                {
                    int safeProcessSearchMode = (int)safeProcessSearchModeObject;
                    if (safeProcessSearchMode == 1)
                    {
                        // When the value of this registry key is set to "1", 
                        // SearchPath first searches the folders that are specified in the system path, 
                        // and then searches the current working folder. 
                        pathsToSearch.AddRange(Environment.GetEnvironmentVariable("PATH").Split(new char[] { Path.PathSeparator }, StringSplitOptions.None));
                        pathsToSearch.Add(currentWorkingFolder);
                    }
                    else
                    {
                        // When the value of this registry entry is set to "0", 
                        // the computer first searches the current working folder, 
                        // and then searches the folders that are specified in the system path. 
                        // The system default value for this registry key is "0".
                        pathsToSearch.Add(currentWorkingFolder);
                        pathsToSearch.AddRange(Environment.GetEnvironmentVariable("PATH").Split(new char[] { Path.PathSeparator }, StringSplitOptions.None));
                    }
                }
                else
                {
                    // Default 0 case
                    pathsToSearch.Add(currentWorkingFolder);
                    pathsToSearch.AddRange(Environment.GetEnvironmentVariable("PATH").Split(new char[] { Path.PathSeparator }, StringSplitOptions.None));
                }
            }
            else
            {
                // Path was provided, use it
                pathsToSearch.Add(lpPath);
            }

            FileInfo foundFile = SearchPath(pathsToSearch, lpExtension, lpFileName);
            if (foundFile != null)
            {
                lpBuffer = Path.Combine(foundFile.DirectoryName, foundFile.Name);
                lpFilePart = foundFile.Name;

            }

            return lpBuffer.Length;
        }

        private static FileInfo SearchPath(List<string> paths, string extension, string fileNamePart)
        {
            string fileName = fileNamePart + extension;
            foreach (string path in paths)
            {
                DirectoryInfo dir = new DirectoryInfo(path);
                var fileInfo = dir.GetFiles().Where(file => string.Compare(file.Name, fileName, true) == 0 );
                if (fileInfo.Any())
                    return fileInfo.First();
            }
            return null;
        }

        public override bool Execute()
        {
            bool ok = false;
            try
            {
                if (!string.IsNullOrEmpty(this.Command))
                {
                    using (System.Diagnostics.Process p = new System.Diagnostics.Process())
                    {
                        string exename, arglist;
                        if (!System.IO.File.Exists(this.Command))
                        {
                            string path, fname;
                            string ext = Path.GetExtension(this.Command);
                            string[] extn = (!string.IsNullOrEmpty(ext)) ? new string[] { ext } : Environment.GetEnvironmentVariable("PATHEXT").Split(';');
                            foreach ( var extension in extn )
                            {
                                if (SearchPath(null, Path.GetFileNameWithoutExtension(this.Command), extension, out path, out fname) > 0)
                                    if (System.IO.File.Exists(path))
                                    {
                                        this.Command = path;
                                        break;
                                    }
                            }
                        }
                        if (string.Compare(Path.GetExtension(this.Command), ".exe", true) != 0)
                        {
                            exename = Environment.GetEnvironmentVariable("COMSPEC");
                            arglist = string.Format("/c \"{0} {1}\"", this.Command, this.Args.Replace("\"", "\"\""));
                        }
                        else
                        {
                            exename = this.Command;
                            arglist = this.Args;
                        }
                        Log.LogMessage("Exec: \"{0}\" {1}", exename, arglist);
                        System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo(exename, arglist);
                        startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                        startInfo.CreateNoWindow = true;
                        startInfo.UseShellExecute = false;
                        startInfo.RedirectStandardOutput = true;
                        startInfo.RedirectStandardError = true;
                        startInfo.WorkingDirectory = this.WorkingDirectory;

                        bool useStdIn = false;
                        if (!string.IsNullOrEmpty(StdIn) && File.Exists(StdIn))
                        {
                            startInfo.RedirectStandardInput = true;
                            useStdIn = true;
                        }

                        StringBuilder stdOutput = new StringBuilder("");
                        StringBuilder stdError = new StringBuilder("");
                        p.StartInfo = startInfo;
                        p.OutputDataReceived += delegate(object sendingProcess, DataReceivedEventArgs outLine)
                        {
                            if (!String.IsNullOrEmpty(outLine.Data))
                                stdOutput.Append(outLine.Data);
                        };
                        p.ErrorDataReceived += delegate(object sendingProcess, DataReceivedEventArgs outLine)
                        {
                            if (!String.IsNullOrEmpty(outLine.Data))
                                stdError.Append(outLine.Data);
                        };

                        if (p.Start())
                        {
                            p.BeginOutputReadLine();
                            p.BeginErrorReadLine();
                            if (!string.IsNullOrEmpty(StdIn))
                            {
                                var r = new StreamReader(File.OpenRead(StdIn));
                                p.StandardInput.Write(r.ReadToEnd());
                                p.StandardInput.Flush();
                                p.StandardInput.Close();
                            }
                            p.WaitForExit();
                            this.StdOut = new TaskItem(stdOutput.ToString());
                            this.StdError = new TaskItem(stdError.ToString());
                            this.ExitCode = new TaskItem((p.ExitCode).ToString());
                            if (p.ExitCode == 0 || !this.FailOnErrorCode)
                                ok = true;
                        }
                        else
                        {
                            LogError("Unable to start command");
                            this.ExitCode = new TaskItem((-1).ToString());
                            ok = false;
                        }                       
                    }
                }
                else
                {
                    LogError("Command not specified.");
                }
            }
            catch (Exception ex)
            {
                LogError("Error trying to execute process." + ex.Message);
                this.ExitCode = new TaskItem((-1).ToString());
            }
            return !this.FailOnErrorCode || (ok && !Log.HasLoggedErrors);
        }
    }

}