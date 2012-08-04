using System;

namespace TESVSnip.Windows.Controls
{
    public class OldNewEventArgs<T> : EventArgs
    {
        public OldNewEventArgs(T oldValue, T newValue)
        {
            OldValue = oldValue;
            NewValue = newValue;
        }

        public T OldValue { get; protected set; }

        public T NewValue { get; protected set; }
    }

    public delegate void OldNewEventHandler<T>(object sender, OldNewEventArgs<T> e);
}