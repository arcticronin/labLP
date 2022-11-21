
%%

%byaccj

%{
  /* store a reference to the parser object */
  private Parser yyparser;

  /* constructor taking an additional parser object */
  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}

%%

"["                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.OPEN_BRACKS; }
"]"                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.CLOSE_BRACKS; }

"("                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.OPEN_PAREN; }
")"                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.CLOSE_PAREN; }

[a-z]+            { yyparser.yylval = new ParserVal(yytext());
                        return Parser.SKIP; }

[^] {} /*butta il resto*/

[a-z]+ 
[A-Z]{2}[a-z]+
[:]+[a-z]+
[]
 /*
 jflex -J
 yacc
 javac
 java asdasd
 */