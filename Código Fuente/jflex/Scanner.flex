/**
 * Trabajo de Final de Grado
 * Estudios: Grado en Ingenieria Informatica
 * Curso: 2019-2020
 *
 * Maria del Mar Cardona Aranda
 */
 
package compilador;

import java.io.*;

import java_cup.runtime.*;
import java_cup.runtime.ComplexSymbolFactory.ComplexSymbol;
import compilador.ParserSym;

%%

/****
%implements java_cup.runtime.Scanner
%function next_token
%type java_cup.runtime.Symbol

****/

%public              
%class Scanner       
%line
%column
%cup

%eofval{
  return symbol(ParserSym.EOF);
%eofval}

%initthrow FileNotFoundException

%init{
  this.ps = new PrintStream(new FileOutputStream("Tokens.txt"));
%init}


// Declaraciones
binario		= [0-1]
numero	    = binario|[2-9]
letra 		= [:jletter:]
id      	= [:jletter:] [:jletterdigit:]*
comment  	= "/""/" [^\n\r]* 
relacion	= "="|"/="
espacio   	= " "|\t
salto     	= \r|\n|\r\n



%{
    /**
    * Impresión de tokens
    */
    PrintStream console = System.out;
    PrintStream ps;
    
    /***
       Mecanismos de gestión de símbolos basados en ComplexSymbol.
     ***/
     
    /**
       Construcción de un símbolo sin atributo asociado.
     **/
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /**
       Construcción de un símbolo con aributo asociado.
     **/
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }

    private void error(String message) {
    	System.out.println("Error at line "+(yyline+1)+", column "+(yycolumn+1)+" : "+message);
    }
	
    public int getYyline() {
        return yyline+1;
    }

    public int getYycolumn() {
        return yycolumn+1;
    }
%}


%%

// Reglas/acciones

i    		{ System.setOut(ps); System.out.println("<Token: i, _>"); System.setOut(console); return symbol(ParserSym.i); 								}
o    		{ System.setOut(ps); System.out.println("<Token: o, _>"); System.setOut(console); return symbol(ParserSym.o); 								}
programa    { System.setOut(ps); System.out.println("<Token: programa, _>"); System.setOut(console); return symbol(ParserSym.programa); 				}
accepta     { System.setOut(ps); System.out.println("<Token: accepta, _>"); System.setOut(console); return symbol(ParserSym.accepta); 					}
fi    		{ System.setOut(ps); System.out.println("<Token: fi, _>"); System.setOut(console); return symbol(ParserSym.fi);								}
dreta       { System.setOut(ps); System.out.println("<Token: dreta, _>"); System.setOut(console); return symbol(ParserSym.dreta); 						}
esquerra    { System.setOut(ps); System.out.println("<Token: esquerra, _>"); System.setOut(console); return symbol(ParserSym.esquerra);	 				}
escriure 	{ System.setOut(ps); System.out.println("<Token: escriure, _>"); System.setOut(console); return symbol(ParserSym.escriure); 				}
si      	{ System.setOut(ps); System.out.println("<Token: si, _>"); System.setOut(console); return symbol(ParserSym.si); 							}
llavors     { System.setOut(ps); System.out.println("<Token: llavors, _>"); System.setOut(console); return symbol(ParserSym.llavors); 					}
fsi   		{ System.setOut(ps); System.out.println("<Token: fsi, _>"); System.setOut(console); return symbol(ParserSym.fsi); 							}
si_no		{ System.setOut(ps); System.out.println("<Token: si_no, _>"); System.setOut(console); return symbol(ParserSym.si_no); 						}
mentre      { System.setOut(ps); System.out.println("<Token: mentre, _>"); System.setOut(console); return symbol(ParserSym.mentre); 					}
fer      	{ System.setOut(ps); System.out.println("<Token: fer, _>"); System.setOut(console); return symbol(ParserSym.fer); 							}
fmentre    	{ System.setOut(ps); System.out.println("<Token: fmentre, _>"); System.setOut(console); return symbol(ParserSym.fmentre); 					}
llegir      { System.setOut(ps); System.out.println("<Token: llegir, _>"); System.setOut(console); return symbol(ParserSym.llegir); 					}
ramificar   { System.setOut(ps); System.out.println("<Token: ramificar, _>"); System.setOut(console); return symbol(ParserSym.ramificar);				}
amb   		{ System.setOut(ps); System.out.println("<Token: amb, _>"); System.setOut(console); return symbol(ParserSym.amb);							} 
framificar  { System.setOut(ps); System.out.println("<Token: framificar, _>"); System.setOut(console); return symbol(ParserSym.framificar);				} 
vector   	{ System.setOut(ps); System.out.println("<Token: vector, _>"); System.setOut(console); return symbol(ParserSym.vector);						} 
simbol  	{ System.setOut(ps); System.out.println("<Token: simbol, _>"); System.setOut(console); return symbol(ParserSym.simbol);						}
tipus_pila  { System.setOut(ps); System.out.println("<Token: tipus_pila, _>"); System.setOut(console); return symbol(ParserSym.tipus_pila);				} 
cim			{ System.setOut(ps); System.out.println("<Token: cim, _>"); System.setOut(console); return symbol(ParserSym.cim);							}
empilar  	{ System.setOut(ps); System.out.println("<Token: empilar, _>"); System.setOut(console); return symbol(ParserSym.empilar);					}
desempilar  { System.setOut(ps); System.out.println("<Token: desempilar, _>"); System.setOut(console); return symbol(ParserSym.desempilar);				}
empilar_par { System.setOut(ps); System.out.println("<Token: empilar_par, _>"); System.setOut(console); return symbol(ParserSym.empilar_par);			}
buida  		{ System.setOut(ps); System.out.println("<Token: buida, _>"); System.setOut(console); return symbol(ParserSym.buida);						    }
no  		{ System.setOut(ps); System.out.println("<Token: no, _>"); System.setOut(console); return symbol(ParserSym.no);							}
en          { System.setOut(ps); System.out.println("<Token: en, _>"); System.setOut(console); return symbol(ParserSym.en);                            }

"("      	{ System.setOut(ps); System.out.println("<Token: '(', _>"); System.setOut(console); return symbol(ParserSym.openparent); 					}
")"      	{ System.setOut(ps); System.out.println("<Token: ')', _>"); System.setOut(console); return symbol(ParserSym.closeparent); 					}
"{"         { System.setOut(ps); System.out.println("<Token: '{', _>"); System.setOut(console); return symbol(ParserSym.abrirllave);                    }
"}"         { System.setOut(ps); System.out.println("<Token: '}', _>"); System.setOut(console); return symbol(ParserSym.cerrarllave);                   }
","      	{ System.setOut(ps); System.out.println("<Token: ',', _>"); System.setOut(console); return symbol(ParserSym.coma); 							}
":"      	{ System.setOut(ps); System.out.println("<Token: ':', _>"); System.setOut(console); return symbol(ParserSym.dospunts); 						}
"#"      	{ System.setOut(ps); System.out.println("<Token: '#', _>"); System.setOut(console); return symbol(ParserSym.blanc); 						}		
				
{relacion} 	{ System.setOut(ps); System.out.println("<Token: relacion, "+this.yytext()+">"); System.setOut(console); return symbol(ParserSym.relacional, this.yytext());}
{letra}     { System.setOut(ps); System.out.println("<Token: letra, "+this.yytext()+">"); System.setOut(console); return symbol(ParserSym.letra, this.yytext());			}
{id}     	{ System.setOut(ps); System.out.println("<Token: id, "+this.yytext()+">"); System.setOut(console); return symbol(ParserSym.id, this.yytext());									}
{binario} 	{ System.setOut(ps); System.out.println("<Token: binario, "+this.yytext()+">"); System.setOut(console); return symbol(ParserSym.binario, this.yytext());}
{numero}    { System.setOut(ps); System.out.println("<Token: numero, "+this.yytext()+">"); System.setOut(console); return symbol(ParserSym.numero, this.yytext());		}

{comment}   { /* Comentario */ 					}
{espacio}   { /* No hacer nada */					}
{salto}     { /* No hacer nada */ 					}

[^]         { throw new Error("Caracter ilegal <"+yytext()+">"); }
