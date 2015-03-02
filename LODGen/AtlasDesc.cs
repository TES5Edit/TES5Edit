using System;
using System.Collections.Generic;

namespace LODGenerator
{
    public struct AtlasDesc
    {
        public string SourceTexture;
        public string AtlasTexture;
        public string AtlasTextureN;
        public float posU;
        public float posV;
        public float scaleU;
        public float scaleV;
    }

    static class AtlasList
    {
        static Dictionary<string, AtlasDesc> _list;

        static AtlasList()
        {
            _list = new Dictionary<string, AtlasDesc>();
        }

        public static void Set(string key, AtlasDesc value)
        {
            _list.Add(key, value);
        }

        public static AtlasDesc Get(string key)
        {
            return _list[key];
        }

        public static bool Contains(string key)
        {
            return _list.ContainsKey(key);
        }
    }
}