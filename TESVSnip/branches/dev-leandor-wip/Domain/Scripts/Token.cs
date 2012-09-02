namespace TESVSnip.Domain.Scripts
{
    using System;

    internal struct Token
    {
        public static readonly Token NewLine = new Token(TokenType.Symbol, "\n");

        public static readonly Token Null = new Token(TokenType.Null, null);

        private static readonly Keywords[] flowlist = new[] { Keywords.If, Keywords.ElseIf, Keywords.Else, Keywords.EndIf, Keywords.Return };

        private static readonly Keywords[] typelist = new[] { Keywords.Int, Keywords.Float, Keywords.Ref };

        public readonly Keywords keyword;

        public readonly string token;

        public readonly TokenType type;

        public readonly string utoken;

        public Token(TokenType type, string token)
        {
            this.type = type;
            this.utoken = token;
            this.token = token;
            this.keyword = Keywords.NotAKeyword;
        }

        public Token(TokenType type, string ltoken, string token)
        {
            this.type = type;
            this.utoken = token;
            this.token = ltoken;
            this.keyword = Keywords.NotAKeyword;
        }

        public Token(TokenType type, Keywords keyword)
        {
            if (keyword == Keywords.Short)
            {
                keyword = Keywords.Int;
            }
            else if (keyword == Keywords.Scn)
            {
                keyword = Keywords.ScriptName;
            }

            this.type = type;
            this.keyword = keyword;
            this.token = keyword.ToString();
            this.utoken = this.token;
        }

        public bool IsFlowControl()
        {
            return this.type == TokenType.Keyword && Array.IndexOf(flowlist, this.keyword) != -1;
        }

        public bool IsKeyword(Keywords k)
        {
            return this.type == TokenType.Keyword && this.keyword == k;
        }

        public bool IsSymbol(string s)
        {
            return this.type == TokenType.Symbol && s == this.token;
        }

        public bool IsType()
        {
            return this.type == TokenType.Keyword && Array.IndexOf(typelist, this.keyword) != -1;
        }

        public override string ToString()
        {
            if (this.type == TokenType.Keyword)
            {
                return this.keyword.ToString();
            }

            return this.token;
        }

        /*public bool IsLiteral() {
            if(type==TokenType.String||type==TokenType.Float||type==TokenType.Integer) return true;
            return false;
        }*/
    }
}
