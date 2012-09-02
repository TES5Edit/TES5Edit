namespace TESVSnip.Domain.Scripts
{
    using System;
    using System.Collections.Generic;
    using System.Text;

    internal class TokenStream
    {
        private static readonly string[] ReservedWords = new[]
            {
                "if", "elseif", "else", "endif", "scriptname", "scn", "short", "int", "float", "ref", "begin", "end", "set", "to", "return", "showmessage" 
            };

        private static readonly List<string> edids = new List<string>();

        private static readonly List<string> functions = new List<string>();

        private static readonly List<string> globalVars = new List<string>();

        private readonly StringBuilder builder = new StringBuilder(32);

        private readonly List<string> errors;

        private readonly List<Token> getNextStatementTokens = new List<Token>();

        private readonly Queue<char> input;

        private readonly List<string> localVars = new List<string>();

        private readonly Queue<Token> storedTokens;

        private Token[] lastTokens;

        private int line;

        public TokenStream(string file, List<string> errors)
        {
            this.errors = errors;
            this.line = 1;
            this.input = new Queue<char>(file.ToCharArray());
            this.input.Enqueue('\n');
            this.storedTokens = new Queue<Token>();
            while (this.input.Count > 0)
            {
                this.PopTokenInternal();
            }

            this.line = 0;
        }

        public int Line
        {
            get
            {
                return this.line;
            }
        }

        public static void AddEdid(string s)
        {
            edids.Add(s);
        }

        public static void AddFunction(string s)
        {
            functions.Add(s);
        }

        public static void AddGlobal(string s)
        {
            globalVars.Add(s);
        }

        public static void Reset()
        {
            globalVars.Clear();
            edids.Clear();
        }

        public void AddLocal(string s)
        {
            this.localVars.Add(s);
        }

        public Token[] PeekNextStatement()
        {
            if (this.lastTokens == null)
            {
                this.lastTokens = this.PopNextStatement();
            }

            return this.lastTokens;
        }

        public Token[] PopNextStatement()
        {
            if (this.lastTokens != null)
            {
                Token[] tmp = this.lastTokens;
                this.lastTokens = null;
                return tmp;
            }

            this.line++;
            Token t = this.DequeueToken();
            while (t.IsSymbol("\n"))
            {
                this.line++;
                t = this.DequeueToken();
            }

            if (this.storedTokens.Count == 0)
            {
                return new Token[0];
            }

            this.getNextStatementTokens.Clear();
            while (t.type != TokenType.Null && !t.IsSymbol("\n"))
            {
                this.getNextStatementTokens.Add(t);
                t = this.DequeueToken();
            }

            return this.getNextStatementTokens.ToArray();
        }

        private static Token FromWord(string token)
        {
            int i;
            string ltoken = token.ToLowerInvariant();
            if (char.IsDigit(token[0]) || (token.Length > 1 && (token[0] == '.' || token[0] == '-') && char.IsDigit(token[1])))
            {
                if (token.Contains(".") || ltoken.Contains("e"))
                {
                    return new Token(TokenType.Float, token);
                }

                return new Token(TokenType.Integer, token);
            }

            if ((i = Array.IndexOf(ReservedWords, ltoken)) != -1)
            {
                return new Token(TokenType.Keyword, (Keywords)i);
            }

            return new Token(TokenType.Unknown, ltoken, token);
        }

        private void AddError(string msg)
        {
            this.errors.Add(this.line.ToString() + ": " + msg);
        }

        private Token DequeueToken()
        {
            if (this.storedTokens.Count == 0)
            {
                return Token.Null;
            }

            Token t = this.storedTokens.Dequeue();
            if (t.type == TokenType.Unknown)
            {
                if (this.localVars.Contains(t.token))
                {
                    return new Token(TokenType.Local, t.token, t.utoken);
                }

                if (globalVars.Contains(t.token))
                {
                    return new Token(TokenType.Global, t.token, t.utoken);
                }

                if (functions.Contains(t.token))
                {
                    return new Token(TokenType.Function, t.token, t.utoken);
                }

                if (edids.Contains(t.token))
                {
                    return new Token(TokenType.edid, t.token, t.utoken);
                }
            }

            return t;
        }

        private void PopTokenInternal()
        {
            Token t;
            t = this.PopTokenInternal2();
            this.storedTokens.Enqueue(t);
        }

        private Token PopTokenInternal2()
        {
            char c;
            while (true)
            {
                while (true)
                {
                    c = this.SafePop();
                    if (c == '\0')
                    {
                        return Token.Null;
                    }
                    else if (c == '\n')
                    {
                        this.line++;
                        return Token.NewLine;
                    }
                    else if (c == ';')
                    {
                        this.SkipLine();
                        return Token.NewLine;
                    }
                    else
                    {
                        if (!char.IsWhiteSpace(c))
                        {
                            break;
                        }
                    }
                }

                if (char.IsLetterOrDigit(c) || c == '_' || ((c == '.' || c == '~') && char.IsDigit(this.SafePeek())))
                {
                    this.builder.Length = 0;
                    if (c == '~')
                    {
                        this.builder.Append('-');
                    }
                    else
                    {
                        this.builder.Append(c);
                    }

                    bool numeric = char.IsDigit(c);
                    while (true)
                    {
                        c = this.SafePeek();
                        if (char.IsLetterOrDigit(c) || c == '_' || (numeric && c == '.'))
                        {
                            this.builder.Append(this.input.Dequeue());
                        }
                        else
                        {
                            break;
                        }
                    }

                    return FromWord(this.builder.ToString());
                }
                else
                {
                    switch (c)
                    {
                        case '"':
                            this.builder.Length = 0;
                            while ((c = this.SafePop()) != '"')
                            {
                                if (c == '\r' || c == '\n' || c == '\0')
                                {
                                    this.AddError("Unexpected end of line");
                                    break;
                                }

                                if (c == '\\')
                                {
                                    switch (c = this.SafePop())
                                    {
                                        case '\0':
                                        case '\r':
                                        case '\n':
                                            this.AddError("Unexpected end of line");
                                            return FromWord(this.builder.ToString());
                                        case '\\':
                                            this.builder.Append('\\');
                                            break;
                                        case 'n':
                                            this.builder.Append('\n');
                                            break;
                                        case '"':
                                            this.builder.Append('"');
                                            break;
                                        default:
                                            this.AddError("Unrecognised escape sequence");
                                            this.builder.Append(c);
                                            break;
                                    }
                                }
                                else
                                {
                                    this.builder.Append(c);
                                }
                            }

                            return FromWord(this.builder.ToString());
                        case '+':
                            return new Token(TokenType.Symbol, "+");
                        case '-':
                            return new Token(TokenType.Symbol, "-");
                        case '*':
                            if (this.SafePeek() == '*')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, "**");
                            }

                            return new Token(TokenType.Symbol, "*");
                        case '/':
                            if (this.SafePeek() == '=')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, "/=");
                            }

                            if (this.SafePeek() == ')')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, "/)");
                            }

                            return new Token(TokenType.Symbol, "/");
                        case '!':
                            if (this.SafePeek() == '=')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, "!=");
                            }

                            this.AddError("Illegal symbol '!'");
                            return new Token(TokenType.Symbol, "!");
                        case '=':
                            if (this.SafePeek() == '=')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, "==");
                            }

                            this.AddError("Illegal symbol '='");
                            return new Token(TokenType.Symbol, "=");
                        case '>':
                            if (this.SafePeek() == '=')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, ">=");
                            }

                            return new Token(TokenType.Symbol, ">");
                        case '<':
                            if (this.SafePeek() == '=')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, "<=");
                            }

                            return new Token(TokenType.Symbol, "<");
                        case '(':
                            return new Token(TokenType.Symbol, "(");
                        case ')':
                            return new Token(TokenType.Symbol, ")");

                            // case ',':
                            // return new Token(TokenType.Symbol, ",");
                        case '&':
                            if (this.SafePeek() == '&')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, "&&");
                            }

                            this.AddError("Illegal symbol '&'");
                            return new Token(TokenType.Symbol, "&");
                        case '|':
                            if (this.SafePeek() == '|')
                            {
                                this.input.Dequeue();
                                return new Token(TokenType.Symbol, "||");
                            }

                            this.AddError("Illegal symbol '|'");
                            return new Token(TokenType.Symbol, "|");
                        case '.':
                            return new Token(TokenType.Symbol, ".");
                        default:
                            this.AddError("Unexpected character");
                            this.SkipLine();
                            break;
                    }
                }
            }
        }

        private char SafePeek()
        {
            if (this.input.Count == 0)
            {
                return '\0';
            }

            char c = this.input.Peek();
            while (c == '\r')
            {
                this.input.Dequeue();
                if (this.input.Count == 0)
                {
                    return '\0';
                }

                c = this.input.Peek();
            }

            if (c == '\t' || c == ',')
            {
                c = ' ';
            }

            if (c < 32 && c != '\n')
            {
                this.AddError("There is an invalid character in the file");
            }

            return c;
        }

        private char SafePop()
        {
            if (this.input.Count == 0)
            {
                return '\0';
            }

            char c = this.input.Dequeue();
            while (c == '\r')
            {
                if (this.input.Count == 0)
                {
                    return '\0';
                }

                c = this.input.Dequeue();
            }

            if (c == '\t' || c == ',')
            {
                c = ' ';
            }

            if (c < 32 && c != '\n')
            {
                this.AddError("There is an invalid character in the file");
            }

            return c;
        }

        private void SkipLine()
        {
            while (this.input.Count > 0 && this.input.Dequeue() != '\n')
            {
                ;
            }

            this.line++;
        }
    }
}