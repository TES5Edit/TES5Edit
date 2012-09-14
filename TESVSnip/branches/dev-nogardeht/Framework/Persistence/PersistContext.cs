namespace TESVSnip.Framework.Persistence
{
    using System;
    using System.Collections;
    using System.Runtime.Serialization;

    /// <summary>
    /// </summary>
    public class PersistContext : IDisposable
    {
        private readonly PersistContextStates _context;

        private readonly int _savecount;

        private Hashtable _infoTypeCache;

        private ArrayList _postSerializeCallbacks;

        private object _root;

        public PersistContext(object root, PersistContextStates context, int SaveCount)
        {
            this._root = root;
            this._context = context;
            this._savecount = SaveCount;
            this._infoTypeCache = new Hashtable();
        }

        public PersistContext(object root, PersistContextStates context)
        {
            this._root = root;
            this._context = context;
            this._savecount = 0;
            this._infoTypeCache = new Hashtable();
        }

        ~PersistContext()
        {
            this.Dispose(false);
        }

        public event EventHandler Disposed;

        public PersistContextStates Context
        {
            get
            {
                return this._context;
            }
        }

        public object Root
        {
            get
            {
                return this._root;
            }
        }

        public int SaveCount
        {
            get
            {
                return this._savecount;
            }
        }

        public void AddPostSerializationCallback(IPostSerializationCallback callback)
        {
            if (callback == null)
            {
                return;
            }

            if (callback.NeedCallback == false)
            {
                return;
            }

            if (this._postSerializeCallbacks == null)
            {
                this._postSerializeCallbacks = new ArrayList();
            }

            this._postSerializeCallbacks.Add(callback);
        }

        public void Dispose()
        {
            this.Dispose(true);
        }

        public void RaisePostSerializationCallbacks()
        {
            if (this._postSerializeCallbacks != null)
            {
                foreach (IPostSerializationCallback callback in this._postSerializeCallbacks)
                {
                    callback.OnPostSerialization();
                }

                this._postSerializeCallbacks.Clear();
                this._postSerializeCallbacks = null;
            }
        }

        public bool RetrieveCacheInfo(object obj, SerializationInfo info)
        {
            Type t = obj.GetType();
            var objmap = this._infoTypeCache[t] as Hashtable;
            if (objmap != null)
            {
                var data = objmap[obj] as SerializationInfoCacheList;
                if (data != null)
                {
                    IEnumerator itr = ((IEnumerable)data).GetEnumerator();
                    while (itr.MoveNext())
                    {
                        var cache = itr.Current as SerializationInfoCache;
                        if (cache != null)
                        {
                            info.AddValue(cache.Name, cache.Value, cache.ObjectType);
                        }
                    }

                    return true;
                }
            }

            return false;
        }

        public bool StoreCacheInfo(object obj, SerializationInfo info)
        {
            Type t = obj.GetType();
            var objmap = this._infoTypeCache[t] as Hashtable;
            if (objmap == null)
            {
                objmap = new Hashtable();
                this._infoTypeCache[t] = objmap;
            }

            var data = objmap[obj] as SerializationInfoCacheList;
            if (data == null)
            {
                data = new SerializationInfoCacheList(info.MemberCount);
                objmap[obj] = data;
            }

            SerializationInfoEnumerator itr = info.GetEnumerator();
            while (itr.MoveNext())
            {
                data.Add(new SerializationInfoCache(itr.Name, itr.Value, itr.ObjectType));
            }

            return true;
        }

        private void Dispose(bool disposing)
        {
            this._root = null;
            if (this.Disposed != null)
            {
                this.Disposed(this, EventArgs.Empty);
            }

            if (this._infoTypeCache != null)
            {
                this._infoTypeCache.Clear();
                this._infoTypeCache = null;
            }

            if (this._postSerializeCallbacks != null)
            {
                this._postSerializeCallbacks.Clear();
                this._postSerializeCallbacks = null;
            }

            if (disposing)
            {
                GC.SuppressFinalize(this);
            }
        }
    }
}