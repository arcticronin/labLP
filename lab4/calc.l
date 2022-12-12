/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2000 Gerwin Klein <lsf@jflex.de>                          *
 * All rights reserved.                                                    *
 *                                                                         *
 * Thanks to Larry Bell and Bob Jamison for suggestions and comments.      *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%%

%state ELEMENT
%byaccj

%{
  private Parser yyparser;

  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
  String title;
  String name;
%}

NUM = [0-9]+ ("." [0-9]+)?
NL  = \n | \r | \r\n
BLOCKSTART = "{"
BLOCKEND = "}"

%%

<YYINITIAL> {
  {BLOCKSTART} { yybegin(ELEMENT);}
  }

<ELEMENT> 
    { .* {BLOCKEND} {
      System.out.println("interno dell'elemento: " + yytext().substring (0,yylength() - 1));
      yybegin(YYINITIAL); }
    }

/*studente*/
/*
[a-zA-Z]+":{" {
  title = yytext().substring(yytext().length() -1 ); 
}

"\"nome\" : "[a-zA-Z]+ {name = yytext().substring(9)};

"\"matricola\" : 0\n}" {return Parser.INSMATRICOLA};

"{" return Parser.OPEN


 end */

/* operators */
"+" | 
"-" | 
"*" | 
"/" | 
"^" | 
"(" | 
")"    { return (int) yycharat(0); }

/* newline */
{NL}   { return Parser.NL; }

/* float */
{NUM}  { yyparser.yylval = new ParserVal(Double.parseDouble(yytext()));
         return Parser.NUM; }

/* whitespace */
[ \t]+ { }

\b     { System.err.println("Sorry, backspace doesn't work"); }

/* error fallback */
[^]    { System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }
