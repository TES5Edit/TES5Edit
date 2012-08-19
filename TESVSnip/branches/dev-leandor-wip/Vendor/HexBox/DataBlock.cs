namespace Be.Windows.Forms
{
    internal abstract class DataBlock
    {
        public abstract long Length { get; }

        public abstract void RemoveBytes(long position, long count);
    }
}