namespace TESVSnip.Domain.Services
{
    using System.Drawing;
    using System.IO;
    using System.Windows.Forms;
    using System.Xml;

    internal static class Settings
    {
        private static readonly string xmlPath = Path.Combine(Options.Value.SettingsDirectory, "settings.xml");

        private static XmlElement rootNode;

        private static XmlDocument xmlDoc;

        static Settings()
        {
            Init();
        }

        public static bool GetBool(string name)
        {
            var xe = rootNode.SelectSingleNode("descendant::boolValue[@name='" + name + "']") as XmlElement;
            if (xe == null)
            {
                return false;
            }
            else
            {
                return xe.InnerText == "true";
            }
        }

        public static string GetString(string name)
        {
            var xe = rootNode.SelectSingleNode("descendant::strValue[@name='" + name + "']") as XmlElement;
            if (xe == null)
            {
                return null;
            }
            else
            {
                return xe.InnerText;
            }
        }

        public static string[] GetStringArray(string name)
        {
            var xe = rootNode.SelectSingleNode("descendant::strArray[@name='" + name + "']") as XmlElement;
            if (xe == null)
            {
                return null;
            }

            var result = new string[xe.ChildNodes.Count];
            for (int i = 0; i < result.Length; i++)
            {
                result[i] = xe.ChildNodes[i].InnerText;
            }

            return result;
        }

        public static void GetWindowPosition(string window, Form f)
        {
            var xe = rootNode.SelectSingleNode("descendant::window[@name='" + window + "']") as XmlElement;
            if (xe == null)
            {
                return;
            }

            if (xe.Attributes.GetNamedItem("maximized").Value == "true")
            {
                f.WindowState = FormWindowState.Maximized;
            }
            else
            {
                f.Location = new Point(int.Parse(xe.Attributes.GetNamedItem("left").Value), int.Parse(xe.Attributes.GetNamedItem("top").Value));
                f.ClientSize = new Size(int.Parse(xe.Attributes.GetNamedItem("width").Value), int.Parse(xe.Attributes.GetNamedItem("height").Value));
                f.StartPosition = FormStartPosition.Manual;
            }
        }

        public static void Init()
        {
            xmlDoc = new XmlDocument();
            if (File.Exists(xmlPath))
            {
                try
                {
                    xmlDoc.Load(xmlPath);
                    rootNode = (XmlElement)xmlDoc.LastChild;
                }
                catch
                {
                    MessageBox.Show("Unable to load settings.xml", "Error");
                    xmlDoc = new XmlDocument();
                    xmlDoc.AppendChild(rootNode = xmlDoc.CreateElement("settings"));
                }
            }
            else
            {
                xmlDoc.AppendChild(rootNode = xmlDoc.CreateElement("settings"));
            }
        }

        public static void RemoveString(string name)
        {
            var xe = rootNode.SelectSingleNode("descendant::strValue[@name='" + name + "']") as XmlElement;
            if (xe != null)
            {
                xe.ParentNode.RemoveChild(xe);
            }
        }

        public static void SetBool(string name, bool value)
        {
            var xe = rootNode.SelectSingleNode("descendant::boolValue[@name='" + name + "']") as XmlElement;
            if (xe == null)
            {
                rootNode.AppendChild(xe = xmlDoc.CreateElement("boolValue"));
                xe.Attributes.Append(xmlDoc.CreateAttribute("name"));
                xe.Attributes[0].Value = name;
            }

            xe.InnerText = value ? "true" : "false";

            xmlDoc.Save(xmlPath);
        }

        public static void SetString(string name, string value)
        {
            var xe = rootNode.SelectSingleNode("descendant::strValue[@name='" + name + "']") as XmlElement;
            if (xe == null)
            {
                rootNode.AppendChild(xe = xmlDoc.CreateElement("strValue"));
                xe.Attributes.Append(xmlDoc.CreateAttribute("name"));
                xe.Attributes[0].Value = name;
            }

            xe.InnerText = value;

            xmlDoc.Save(xmlPath);
        }

        public static void SetStringArray(string name, string[] items)
        {
            var xe = rootNode.SelectSingleNode("descendant::strArray[@name='" + name + "']") as XmlElement;
            if (xe == null)
            {
                rootNode.AppendChild(xe = xmlDoc.CreateElement("strArray"));
                xe.Attributes.Append(xmlDoc.CreateAttribute("name"));
                xe.Attributes[0].Value = name;
            }

            while (xe.ChildNodes.Count > 0)
            {
                xe.RemoveChild(xe.FirstChild);
            }

            foreach (string str in items)
            {
                XmlElement xe2 = xmlDoc.CreateElement("element");
                xe2.InnerText = str;
                xe.AppendChild(xe2);
            }

            xmlDoc.Save(xmlPath);
        }

        public static void SetWindowPosition(string window, Form f)
        {
            if (f.WindowState == FormWindowState.Minimized)
            {
                return;
            }

            Point location = f.Location;
            Size size = f.ClientSize;
            bool maximized = f.WindowState == FormWindowState.Maximized;
            var xe = rootNode.SelectSingleNode("descendant::window[@name='" + window + "']") as XmlElement;
            if (xe == null)
            {
                rootNode.AppendChild(xe = xmlDoc.CreateElement("window"));
                xe.Attributes.Append(xmlDoc.CreateAttribute("name"));
                xe.Attributes[0].Value = window;
            }

            XmlAttribute xa = xmlDoc.CreateAttribute("left");
            xa.Value = location.X.ToString();
            xe.Attributes.SetNamedItem(xa);
            xa = xmlDoc.CreateAttribute("top");
            xa.Value = location.Y.ToString();
            xe.Attributes.SetNamedItem(xa);
            xa = xmlDoc.CreateAttribute("width");
            xa.Value = size.Width.ToString();
            xe.Attributes.SetNamedItem(xa);
            xa = xmlDoc.CreateAttribute("height");
            xa.Value = size.Height.ToString();
            xe.Attributes.SetNamedItem(xa);
            xa = xmlDoc.CreateAttribute("maximized");
            xa.Value = maximized ? "true" : "false";
            xe.Attributes.SetNamedItem(xa);

            xmlDoc.Save(xmlPath);
        }
    }
}
