namespace TESVSnip.Framework
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    internal static class EnumerableExtensions
    {
        private static readonly Random rand = new Random();

        public static int IndexOf<T>(this IEnumerable<T> collection, T item)
        {
            int i = 0;
            var itr = collection.GetEnumerator();
            for (bool ok = itr.MoveNext(); ok; ok = itr.MoveNext(), ++i)
            {
                if (itr.Current.Equals(item))
                {
                    return i;
                }
            }

            return -1;
        }

        public static int IndexOf<T>(this IEnumerable<T> collection, T item, int startIndex)
        {
            int i = 0;
            var itr = collection.Skip(startIndex).GetEnumerator();
            for (bool ok = itr.MoveNext(); ok; ok = itr.MoveNext(), ++i)
            {
                if (itr.Current.Equals(item))
                {
                    return i;
                }
            }

            return -1;
        }

        public static IEnumerable<int> Indices<T>(this IEnumerable<T> collection, IEnumerable<T> items)
        {
            foreach (var itr in items)
            {
                yield return collection.IndexOf(itr);
            }
        }

        public static IEnumerable<T> Random<T>(this IEnumerable<T> itr, int size)
        {
            yield return itr.Skip(rand.Next(size)).FirstOrDefault();
        }
    }
}