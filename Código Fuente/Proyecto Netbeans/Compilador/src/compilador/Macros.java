/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package compilador;

import data.AccesoFichero;
import java.io.File;

/**
 *
 * @author María del Mar Cardona Aranda
 */
public class Macros {

    /**
     * Constructor vacío.
     */
    public Macros() {

    }

    private static final String loadVector = "*-----------------------------------------------------------\n"
            + "LOAD_ENT 	MACRO\n"
            + "* Macro to reads 1 word from the vector address             \n"
            + "* Parameters:     \\1: ent file adress                      \n"
            + "*                 \\2: ent vector adress                    \n"
            + "* Modifies  : D0, D1, D2, D3, A1                            \n"
            + "* Always executed after TRAP 51, 52 or 55                   \n"
            + "*-----------------------------------------------------------\n"
            + "    ; open existing file                                    \n"
            + "    LEA.L   \\1,A1                                          \n"
            + "    MOVE.L  #51,D0                                          \n"
            + "    TRAP    #15                                             \n"
            + "    ; read file                                             \n"
            + "    CLR.L   D2                                              \n"
            + "    CLR.L   D3                                              \n"
            + "    LEA.L   \\2,A1                                          \n"
            + "    WHILE.W #1024 <GT> D3 DO.S                              \n"
            + "        MOVE.W  D3,D2                                       \n"
            + "        ; set cursor                                        \n"
            + "        MOVE.L  #55,D0                                      \n"
            + "        TRAP    #15                                         \n"
            + "        MOVE.W  #0,(A1)                                     \n"
            + "        MOVE.L  #1,D2                                       \n"
            + "        MOVE.L  #53,D0                                      \n"
            + "        TRAP    #15                                         \n"
            + "        ADD.W   #1,D3                                       \n"
            + "        ADD.L   #2,A1                                       \n"
            + "    ENDW                                                    \n"
            + "    ; close file                                            \n"
            + "    MOVE.L  #50,D0                                          \n"
            + "    TRAP    #15                                             \n"
            + "    ENDM                                                    \n";
    private static final String saveVector = "*-----------------------------------------------------------\n"
            + "SAVE_VEC     MACRO\n"
            + "* Macro to reads 1 word from the vector address             \n"
            + "* Parameters:     \\1: ent file adress                      \n"
            + "*                 \\2: ent vector adress"
            + "* Modifies  : D0, D1, D2, A1                                \n"
            + "* Always executed after TRAP 51, 52 or 55                   \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L  D3                                                \n"
            + "    ; open file                                             \n"
            + "    LEA.L   \\1,A1                                          \n"
            + "    MOVE.L  #52,D0                                          \n"
            + "    TRAP    #15                                             \n"
            + "    LEA.L   \\2,A1                                          \n"
            + "    WHILE.W #1023 <GT> D3 DO.S                              \n"
            + "        MOVE.L  D3,D2                                       \n"
            + "        ; set cursor                                        \n"
            + "        MOVE.L  #55,D0                                      \n"
            + "        TRAP    #15                                         \n"
            + "        ; write file                                        \n"
            + "        MOVE.L  #1,D2                                       \n"
            + "        MOVE.L  #54,D0                                      \n"
            + "        TRAP    #15                                         \n"
            + "        ; aumentar el cursor y el vector                    \n"
            + "        ADD.L   #1,D3                                       \n"
            + "        ADD.L   #2,A1                                       \n"
            + "    ENDW                                                    \n"
            + "    ; close file                                            \n"
            + "    MOVE.L  #50,D0                                          \n"
            + "    TRAP    #15                                             \n"
            + "    ENDM                                                    \n";
    private static final String initVector = "*-----------------------------------------------------------\n"
            + "INIT_VECTOR     MACRO\n"
            + "* Macro to load 1024 # in a vector.                         \n"
            + "* Parameters:     \\1: vector adress                        \n"
            + "* Modifies  : D0, D1, D2, A1                                \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L   D0                                               \n"
            + "   WHILE.W D0 <LE> #2048 DO.S                               \n"
            + "       LEA.L   \\1,A1                                       \n"
            + "       ADD.L   D0,A1                                        \n"
            + "       MOVE.W  #$2300,(A1)                                  \n"
            + "       ADD.W   #2,D0                                        \n"
            + "   ENDW                                                     \n"
            + "   ENDM                                                    \n";
    private static final String macroReadVector = "*-----------------------------------------------------------\n"
            + "READ_VECTOR 	MACRO\n"
            + "* Macro to reads 1 word from the vector address             \n"
            + "* Parameters: \\1: vector name                              \n"
            + "*             \\2: simbol desp                              \n"
            + "*             \\3: vector cursor                            \n"
            + "* Modifies  : D0, D1, D2, A1                                \n"
            + "* Always executed after TRAP 51, 52 or 55                   \n"
            + "*-----------------------------------------------------------\n"
            + "   LEA.L    \\3,A1                                          \n"
            + "   MOVE.L   (A1),D0                                         \n"
            + "   IF.B    D0 <LT> #0 THEN.S                                \n"
            + "        MOVE.L #'#',D0                                      \n"
            + "   ELSE                                                     \n"
            + "        LEA.L    \\1,A1                                     \n"
            + "        ADD.L    D0,A1                                      \n"
            + "        MOVE.W   (A1),D0                                    \n"
            + "        ROR.W    #8,D0                                      \n"
            + "   ENDI                                                     \n"
            + "   MOVE.W   D0,\\2(A7)                                      \n"
            + "   ENDM                                                     \n";
    private static final String macroDreta = "*-----------------------------------------------------------\n"
            + "DRETA 	MACRO                                    \n"
            + "* Macro to increase in 1 word the cursor of the file.       \n"
            + "* Parameters: \\1: vector cursor name                       \n"
            + "* Modifies  : D0, A1                                        \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L   D0                                               \n"
            + "   LEA.L   \\1,A1                                           \n"
            + "   MOVE.L  (A1),D0                                          \n"
            + "   ADD.L   #2,D0                                            \n"
            + "   MOVE.L  D0,(A1)                                          \n"
            + "   ENDM                                                     \n";
    private static final String macroEsquerra = "*-----------------------------------------------------------\n"
            + "ESQUERRA 	MACRO                                    \n"
            + "* Macro to increase in 1 unit the cursor of the file.       \n"
            + "* Parameters: \\1: vector cursor name                       \n"
            + "* Modifies  : D0, A1                                        \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L   D0                                               \n"
            + "   LEA.L   \\1,A1                                           \n"
            + "   MOVE.L  (A1),D0                                          \n"
            + "   SUB.L   #2,D0                                            \n"
            + "   MOVE.L  D0,(A1)                                          \n"
            + "   ENDM                                                     \n";
    private static final String macroReadSimbol = "*-----------------------------------------------------------\n"
            + "READ_SIMBOL 	MACRO\n"
            + "* Macro to read.                                            \n"
            + "* Parameters: \\1: Param1   ;Desplazamiento del origen      \n"
            + "*             \\2: Param2   ;Desplazamiento del destino     \n"
            + "* Modifies  : D0, A1                                        \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L   D0                                               \n"
            + "   MOVE.L  \\2, A1                                          \n"
            + "   MOVE.W  (A1),D0                                          \n"
            + "   MOVE.W  D0, \\1(A7)                                      \n"
            + "   ENDM                                                     \n";
    private static final String macroAsigSimbol
            = "*-----------------------------------------------------------\n"
            + "ASIGN_VALUE_SIMBOL MACRO                                    \n"
            + "* Macro to assign value to simbol.                          \n"
            + "* Parameters: \\1: Param1   ;DESP                           \n"
            + "*             \\2: Param2   ;VALOR                          \n"
            + "* Modifies  : D0                                            \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L D0                                                 \n"
            + "   MOVE.W \\2, D0                                           \n"
            + "   MOVE.W D0, \\1(A7)                                       \n"
            + "   ENDM                                                     \n";
    private static final String macroAsigAccepta
            = "*-----------------------------------------------------------\n"
            + "ASIGN_VALUE_ACCEPTA MACRO                                   \n"
            + "* Macro to assign value to simbol.                          \n"
            + "* Parameters: \\1: value                                    \n"
            + "*             \\2: accepta address                          \n"
            + "* Modifies  : D0                                            \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L   D0                                               \n"
            + "   LEA     \\2,A1                                           \n"
            + "   MOVE.W  \\1,D0                                           \n"
            + "   MOVE.W  D0,(A1)                                          \n"
            + "   ENDM                                                     \n";
    private static final String macroAsigRefSimb
            = "*-----------------------------------------------------------\n"
            + "ASIGN_SIMBOL_SIMBOL MACRO                                   \n"
            + "* Macro to assign simbol to simbol.                         \n"
            + "* Parameters: \\1: desp simbol param 1                      \n"
            + "*             \\2: desp simbol dest                         \n"
            + "* Modifies  : D0                                            \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L   D0                                               \n"
            + "   MOVE.W  \\1(A7),D0                                       \n"
            + "   MOVE.W  D0,\\2(A7)                                       \n"
            + "   ENDM                                                     \n";
    private static final String macroAsigRefSimbAcc
            = "*-----------------------------------------------------------\n"
            + "ASIGN_SIMBOL_ACCEPTA MACRO                                  \n"
            + "* Macro to assign simbol to accepta.                        \n"
            + "* Parameters: \\1: desp simbol param 1                      \n"
            + "*             \\2: accepta address                          \n"
            + "* Modifies  : D0,A1                                         \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L   D0                                               \n"
            + "   LEA     \\2,A1                                           \n"
            + "   MOVE.W  \\1(A7),D0                                       \n"
            + "   MOVE.W  D0,(A1)                                          \n"
            + "   ENDM                                                     \n";
    private static final String macroAsigAccRefSimb
            = "*-----------------------------------------------------------\n"
            + "ASIGN_ACCEPTA_SIMBOL MACRO                                  \n"
            + "* Macro to assign accepta to simbol.                        \n"
            + "* Parameters: \\1: desp simbol param 1                      \n"
            + "*             \\2: accepta address                          \n"
            + "* Modifies  : D0,A1                                         \n"
            + "*-----------------------------------------------------------\n"
            + "   CLR.L   D0                                               \n"
            + "   LEA     \\2,A1                                           \n"
            + "   MOVE.W  (A1),\\1(A7)                                     \n"
            + "   ENDM                                                     \n";
    private static final String macroAsigValVect
            = "*-----------------------------------------------------------\n"
            + "ASIGN_VALUE_VECTOR MACRO                                    \n"
            + "* Macro to assign value to vector.                          \n"
            + "* Parameters: \\1: value                                    \n"
            + "*             \\2: vector address                           \n"
            + "*             \\3: cursor address                           \n"
            + "* Modifies  : D0,A1                                         \n"
            + "*-----------------------------------------------------------\n"
            + "   LEA     \\3,A1                                           \n"
            + "   MOVE.L  (A1),D0                                          \n"
            + "   LEA     \\2,A1                                           \n"
            + "   ADD.L   D0,A1                                            \n"
            + "   MOVE.W  \\1,D0                                           \n"
            + "   ROR.W   #8,D0                                            \n"
            + "   MOVE.W  D0,(A1)                                          \n"
            + "   ENDM                                                     \n";
    private static final String macroAsigSimbVect
            = "*-----------------------------------------------------------\n"
            + "ASIGN_SIMBOL_VECTOR MACRO                                   \n"
            + "* Macro to assign simbol to vector.                         \n"
            + "* Parameters: \\1: simbol desp                              \n"
            + "*             \\2: vector address                           \n"
            + "*             \\3: vector cursor                            \n"
            + "* Modifies  : D0,A1                                         \n"
            + "*-----------------------------------------------------------\n"
            + "   LEA     \\3,A1                                           \n"
            + "   MOVE.L  (A1),D0                                          \n"
            + "   LEA     \\2,A1                                           \n"
            + "   ADD.L   D0,A1                                            \n"
            + "   MOVE.W  \\1(A7),D0                                       \n"
            + "   ROR.W   #8,D0                                            \n"
            + "   MOVE.W  D0,(A1)                                          \n"
            + "   ENDM                                                     \n";
    private static final String macroOpIgualInt = "*-----------------------------------------------------------\n"
            + "COMP_IGUAL_SIMBOL 	MACRO\n"
            + "* Macro to compare.                          \n"
            + "* Parameters: \\1: Param1\n"
            + "*             \\2: Param2\n"
            + "*             \\3: Param3 \n"
            + "\n"
            + "* Modifies  : D0\n"
            + "*             D1\n"
            + "*-----------------------------------------------------------\n"
            + "        CLR.L D0\n"
            + "        CLR.L D1\n"
            + "* COMPARAR D0 Y D1\n"
            + "        MOVE.W \\1(A7), D0\n"
            + "        ; mirar que d0 es correcto\n"
            + "        IF.B   D0 <EQ> #$FF THEN.S\n"
            + "           AND.W   #$FF00,D0\n"
            + "           ROR.L   #8,D0\n"
            + "        ENDI\n"
            + "        MOVE.W \\2(A7), D1\n"
            + "        ; mirar que d1 es correcto\n"
            + "        IF.B   D1 <EQ> #$FF THEN.S\n"
            + "           AND.W   #$FF00,D1\n"
            + "           ROR.L   #8,D1\n"
            + "        ENDI\n"
            + "* SI SON IGUALES GUARDAR UN 1 (BOOLEAN TRUE)\n"
            + "        CMP.W D0, D1\n"
            + "        BNE igual_int_falso\\@\n"
            + "        MOVE.W  #1,D0\n"
            + "        BRA igual_asig_int_true\\@\n"
            + "\n"
            + "* SI SON DIFERENTES GUARDAR UN 0 (BOOLEAN FALSE)\n"
            + "igual_int_falso\\@\n"
            + "        MOVE.W  #0,D0\n"
            + "igual_asig_int_true\\@        \n"
            + "        MOVE.W D0, \\3(A7)\n"
            + "        ENDM\n";
    private static final String macroOpDiferenteInt = "*-----------------------------------------------------------\n"
            + "COMP_DIF_SIMBOL 	MACRO\n"
            + "* Macro to compare.                          \n"
            + "* Parameters: \\1: Param1\n"
            + "*             \\2: Param2\n"
            + "*             \\3: Param3 \n"
            + "\n"
            + "* Modifies  : D0\n"
            + "*             D1\n"
            + "*-----------------------------------------------------------\n"
            + "        CLR.L D0\n"
            + "        CLR.L D1\n"
            + "* COMPARAR D0 Y D1\n"
            + "        MOVE.W \\1(A7), D0\n"
            + "        ; mirar que d0 es correcto\n"
            + "        IF.B   D0 <EQ> #$FF THEN.S\n"
            + "           AND.W   #$FF00,D0\n"
            + "           ROR.L   #8,D0\n"
            + "        ENDI\n"
            + "        MOVE.W \\2(A7), D1\n"
            + "        ; mirar que d0 es correcto\n"
            + "        IF.B   D1 <EQ> #$FF THEN.S\n"
            + "           AND.W   #$FF00,D1\n"
            + "           ROR.L   #8,D1\n"
            + "        ENDI\n"
            + "* SI SON iguales GUARDAR UN 0 (BOOLEAN FALSE)\n"
            + "        CMP.W D0, D1\n"
            + "        BNE dif_int_falso\\@\n"
            + "        MOVE.W  #0,D0\n"
            + "        BRA dif_asig_int_true\\@\n"
            + "\n"
            + "* SI SON DIFERENTES GUARDAR UN 1 (BOOLEAN TRUE)\n"
            + "dif_int_falso\\@\n"
            + "        MOVE.W  #1,D0\n"
            + "        \n"
            + "dif_asig_int_true\\@        \n"
            + "        MOVE.W D0, \\3(A7)\n"
            + "		ENDM\n";
    private static final String loadstack = "; -----------------------------------------------------------------------------\n"
            + "LOAD_STACK      MACRO\n"
            + "; Prepara la pila en A0.\n"
            + "* Parameters: \\1: direccion de la pila\n"
            + "\n"
            + "* Modifies  : A0\n"
            + "; -----------------------------------------------------------------------------\n"
            + "            LEA.L  \\1, A0\n"
            + "            ADD.L   #2, A0\n"
            + "            ENDM\n";
    private static final String empila = "; -----------------------------------------------------------------------------\n"
            + "EMPILA      MACRO\n"
            + "; Insertar un simbolo en la pila.\n"
            + "* Parameters: \\1: desplazamiento del simbolo\n"
            + "\n"
            + "* Modifies  : D0,A0\n"
            + "; -----------------------------------------------------------------------------\n"
            + "            MOVE.W   \\1(A7),D0\n"
            + "            MOVE.W   D0,-(A0)\n"
            + "            ENDM\n";
    private static final String empila_valor = "; -----------------------------------------------------------------------------\n"
            + "EMPILA_VALOR      MACRO\n"
            + "; Insertar un simbolo en la pila.\n"
            + "* Parameters: \\1: desplazamiento del simbolo\n"
            + "\n"
            + "* Modifies  : D0,A0\n"
            + "; -----------------------------------------------------------------------------\n"
            + "            MOVE.W   \\1,-(A0)\n"
            + "            ENDM\n";
    private static final String cim = "; -----------------------------------------------------------------------------\n"
            + "CIM      MACRO\n"
            + "; Coger el símbolo de la cima de la pila.\n"
            + "* Parameters: \\1: desplazamiento del simbolo\n"
            + "\n"
            + "* Modifies  : D0\n"
            + "; -----------------------------------------------------------------------------\n"
            + "            MOVE.W   (A0),\\1(A7)\n"
            + "            ENDM\n";
    private static final String desempila = "; -----------------------------------------------------------------------------\n"
            + "DESEMPILA      MACRO\n"
            + "; Eliminar un simbolo de la pila.\n"
            + "\n"
            + "* Modifies  : A0\n"
            + "; -----------------------------------------------------------------------------\n"
            + "            ADD.L    #2,A0\n"
            + "            ENDM\n";
    private static final String buida = "*-----------------------------------------------------------\n"
            + "BUIDA 	MACRO\n"
            + "* Macro para saber si la pila esta vacia.                  \n"
            + "* Parameters: \\1: Dirección de la pila (cuando esta a 0)\n"
            + "*             \\2: Simbolo donde se guarda el resultado\n"
            + "\n"
            + "* Modifies  : D0,A1\n"
            + "*-----------------------------------------------------------\n"
            + "        LEA.L        \\1,A1\n"
            + "* COMPARAR A0 Y A1\n"
            + "* SI SON IGUALES GUARDAR UN 1 (BOOLEAN TRUE)\n"
            + "        CMP.L A0,A1\n"
            + "        BNE igual_int_falso\\@\n"
            + "        MOVE.W  #1,D0\n"
            + "        BRA igual_asig_int_true\\@\n"
            + "\n"
            + "* SI SON DIFERENTES GUARDAR UN 0 (BOOLEAN FALSE)\n"
            + "igual_int_falso\\@\n"
            + "        MOVE.W  #0,D0\n"
            + "igual_asig_int_true\\@        \n"
            + "        MOVE.W D0, \\2(A7)\n"
            + "        ENDM\n";
    private static final String nobuida = "*-----------------------------------------------------------\n"
            + "NOBUIDA 	MACRO\n"
            + "* Macro para saber si la pila esta vacia.                  \n"
            + "* Parameters: \\1: Dirección de la pila (cuando esta a 0)\n"
            + "*             \\2: Simbolo donde se guarda el resultado\n"
            + "\n"
            + "* Modifies  : D0,A1\n"
            + "*-----------------------------------------------------------\n"
            + "        LEA.L        \\1,A1\n"
            + "* COMPARAR A0 Y A1\n"
            + "* SI SON DIFERENTES GUARDAR UN 1 (BOOLEAN TRUE)\n"
            + "        CMP.L A0,A1\n"
            + "        BEQ igual_int_falso\\@\n"
            + "        MOVE.W  #1,D0\n"
            + "        BRA igual_asig_int_true\\@\n"
            + "\n"
            + "* SI SON DIFERENTES GUARDAR UN 0 (BOOLEAN FALSE)\n"
            + "igual_int_falso\\@\n"
            + "        MOVE.W  #0,D0\n"
            + "igual_asig_int_true\\@        \n"
            + "        MOVE.W D0, \\2(A7)\n"
            + "        ENDM\n";
    private static final String andsimbol = "*-----------------------------------------------------------\n"
            + "AND_SIMBOL 	MACRO\n"
            + "* Operación AND entre dos símbolos.                  \n"
            + "* Parameters: \\1: Desplazamiento del parametro 1\n"
            + "*             \\2: Desplazamiento del parametro 2\n"
            + "*             \\3: Desplazamiento del parametro resultado\n"
            + "\n"
            + "* Modifies  : D0\n"
            + "*-----------------------------------------------------------\n"
            + "            MOVE.W   \\1(A7),D0\n"
            + "            AND.W    \\2(A7),D0\n"
            + "            MOVE.W   D0,\\3(A7)\n"
            + "            ENDM\n";
    private static final String orsimbol = "*-----------------------------------------------------------\n"
            + "OR_SIMBOL 	MACRO\n"
            + "* Operación OR entre dos símbolos.                  \n"
            + "* Parameters: \\1: Desplazamiento del parametro 1\n"
            + "*             \\2: Desplazamiento del parametro 2\n"
            + "*             \\3: Desplazamiento del parametro resultado\n"
            + "\n"
            + "* Modifies  : D0\n"
            + "*-----------------------------------------------------------\n"
            + "            MOVE.W   \\1(A7),D0\n"
            + "            OR.W    \\2(A7),D0\n"
            + "            MOVE.W   D0,\\3(A7)\n"
            + "            ENDM\n";
    private static final String askRamification = "*-----------------------------------------------------------\n"
            + "ASK_RAMIF    MACRO\n"
            + "* Establece si el programa esta en el main o en una rama     \n"
            + "* Parameters:     \\1: numero de ramificacion                \n"
            + "*                 \\2: numero de ramas                       \n"
            + "* Modifies  : D0, D1, A1, A2, A3                             \n"
            + "*----------------------------------------------------------- \n"
            + "    ; separador\n"
            + "    MOVE.L  #13,D0\n"
            + "    MOVE.L  #separador,A1\n"
            + "    TRAP    #15\n"
            + "    \n"
            + "    ; pregunta p1\n"
            + "    MOVE.L  #17,D0\n"
            + "    MOVE.L  #linea1,A1\n"
            + "    MOVE.L  \\1,D1               ; numero de ramificacion\n"
            + "    TRAP    #15\n"
            + "    \n"
            + "    MOVE.L  #6,D0\n"
            + "    MOVE.L  #13,D1 ; CR\n"
            + "    TRAP    #15\n"
            + "    \n"
            + "    MOVE.L  #6,D0\n"
            + "    MOVE.L  #10,D1 ; LF\n"
            + "    TRAP    #15\n"
            + "    \n"
            + "    ;pregunta p2\n"
            + "    MOVE.L  #17,D0\n"
            + "    MOVE.L  #linea2,A1\n"
            + "    MOVE.L  \\2,D1               ; numero de rama\n"
            + "    TRAP    #15\n"
            + "    \n"
            + "    ; pregunta p3\n"
            + "    MOVE.L  #18,D0\n"
            + "    MOVE.L  #dospuntos,A1\n"
            + "    TRAP    #15\n"
            + "    \n"
            + "    ; separador\n"
            + "    MOVE.L  #13,D0\n"
            + "    MOVE.L  #separador,A1\n"
            + "    TRAP    #15\n"
            + "    ENDM";

    /**
     * Generar las macros.
     *
     * @param directorio: directorio de la carpeta macros.
     */
    public void generateMacros(String directorio) {
        String macros = "";
        macros += "*-----------------------------------------------------------\n"
                + "* Title      : MACROS\n"
                + "* Written by : Maria del Mar Cardona Aranda\n"
                + "* Description: macros\n"
                + "*-----------------------------------------------------------\n\n";
        macros += "************************************************************\n"
                + "*                             MACROS                       *\n"
                + "************************************************************\n\n";
        macros += Macros.loadVector + "\n";
        macros += Macros.saveVector + "\n";
        macros += Macros.initVector + "\n";
        macros += Macros.macroDreta + "\n";
        macros += Macros.macroEsquerra + "\n";
        macros += Macros.macroReadVector + "\n";
        macros += Macros.macroReadSimbol + "\n";
        macros += Macros.macroAsigSimbol + "\n";
        macros += Macros.macroAsigAccepta + "\n";
        macros += Macros.macroAsigRefSimb + "\n";
        macros += Macros.macroAsigRefSimbAcc + "\n";
        macros += Macros.macroAsigAccRefSimb + "\n";
        macros += Macros.macroAsigValVect + "\n";
        macros += Macros.macroAsigSimbVect + "\n";
        macros += Macros.macroOpIgualInt + "\n";
        macros += Macros.macroOpDiferenteInt + "\n";
        macros += Macros.empila + "\n";
        macros += Macros.empila_valor + "\n";
        macros += Macros.cim + "\n";
        macros += Macros.desempila + "\n";
        macros += Macros.loadstack + "\n";
        macros += Macros.buida + "\n";
        macros += Macros.nobuida + "\n";
        macros += Macros.andsimbol + "\n";
        macros += Macros.orsimbol + "\n";
        macros += Macros.askRamification + "\n";

        // SE SUPONE QUE EL DIRECTORIO ASSEMBLY YA EXISTE
        // crear directorio de macros
        File macrosDirectory = new File(directorio + "/macros");
        if (!macrosDirectory.exists()) {
            macrosDirectory.mkdir();
        } else {
            for (File f : macrosDirectory.listFiles()) {
                f.delete();
            }
        }

        //Guardar
        File macrosFile = new File(directorio + "/macros/macros.X68");
        if (macrosFile.exists()) {
            macrosFile.delete();
        }
        AccesoFichero af = new AccesoFichero();
        af.writeFile(macrosFile, macros);
    }

}
