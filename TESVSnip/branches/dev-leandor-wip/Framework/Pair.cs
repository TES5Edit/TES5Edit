namespace TESVSnip.Framework
{
    internal struct Pair<A, B>
    {
        public A a;

        public B b;

        public Pair(A a, B b)
        {
            this.a = a;
            this.b = b;
        }

        public A Key
        {
            get
            {
                return this.a;
            }

            set
            {
                this.a = value;
            }
        }

        public B Value
        {
            get
            {
                return this.b;
            }

            set
            {
                this.b = value;
            }
        }

        public override string ToString()
        {
            return this.a.ToString();
        }
    }
}
