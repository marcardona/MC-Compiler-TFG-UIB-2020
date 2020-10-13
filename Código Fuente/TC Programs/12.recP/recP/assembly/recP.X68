*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE recP 
* Date       : Tue Sep 08 13:38:34 CEST 2020
* Description: Codigo ensamblador
*------------------------------------------------------------

*************************************************************
*                             MACROS                         *
*************************************************************
    INCLUDE "macros/macros.X68"                                   
                                                              
                                                              
                                                              
*************************************************************
*                         MAIN PROGRAM                      *
*************************************************************

    ORG    $2000
START:                  ; first instruction of program

; cerrar todos los ficheros (aconsejado)                     
; close file                                            
    MOVE.L  #50,D0                                          
    TRAP    #15                                              
;   cargar el vector de entrada 
    LOAD_ENT    ent, entrecP
    LEA     stack,A0
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_RECP

FINALLY:
;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_VEC    rentrecP, entrecP
    SIMHALT             ; halt simulator
; c3d:  procedure_ - - 0 

P_RECP:
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #160, A6  
; c3d: assig_ 49 - accepta 
    ASIGN_VALUE_ACCEPTA #49, accepta
; c3d: assig_ 80 - 3 
    ASIGN_VALUE_SIMBOL -6, #80
;   empilar simbolo 
;   c3d: empila_ 3 - - 
    EMPILA -6
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
;   no buida pila 
;   c3d: nobuida_ 0 - 4 
    NOBUIDA stack, -8
; c3d: assig_ accepta - 5 
; c3d: assig_ 49 - 6 
    ASIGN_VALUE_SIMBOL -12, #49
;   c3d: igual_ 5 6 7 
    COMP_IGUAL_SIMBOL -10, -12, -14   
;   condicional if 
;   c3d: ifnot_ 4 - t_while_0_2 
    MOVE.W  -8(A7),D0 
    CMP.W   #0, D0   
    BEQ t_while_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_1 
t_while_0_1:
;   cima de la pila 
;   c3d: cim_ - - 8 
    CIM -16
; c3d: assig_ 80 - 9 
    ASIGN_VALUE_SIMBOL -18, #80
;   c3d: igual_ 8 9 10 
    COMP_IGUAL_SIMBOL -16, -18, -20   
;   condicional if 
;   c3d: if_ 10 - t_if_0_0 
    MOVE.W  -20(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_1 
    BRA t_if_0_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_0 
t_if_0_0:
;   desempilar simbolo 
;   c3d: desempila_ - - - 
    LEA stack,A1
    IF.L A0 <EQ> A1 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    DESEMPILA 
;   c3d: llegir_ 0 - 11 
    READ_VECTOR 	entrecP, -22, entrecPcursor
    LEA.L   entrecPcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 112 - 12 
    ASIGN_VALUE_SIMBOL -24, #112
;   c3d: igual_ 11 12 13 
    COMP_IGUAL_SIMBOL -22, -24, -26   
;   condicional if 
;   c3d: if_ 13 - t_if_1_0 
    MOVE.W  -26(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_1_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_1_1 
    BRA t_if_1_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_1_0 
t_if_1_0:
;   empilar simbolo 
;   c3d: empila_ 102 - - 
    EMPILA_VALOR #102
;   empilar simbolo 
;   c3d: empila_ 66 - - 
    EMPILA_VALOR #66
;   c3d: dreta_ - - 0 
    DRETA entrecPcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_1_2 
    BRA t_if_1_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_1_1 
t_if_1_1:
; c3d: assig_ 48 - accepta 
    ASIGN_VALUE_ACCEPTA #48, accepta
;   escribir etiqueta 
;   c3d: skip_ - - t_if_1_2 
t_if_1_2:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_1 
t_if_0_1:
;   cima de la pila 
;   c3d: cim_ - - 17 
    CIM -34
; c3d: assig_ 66 - 18 
    ASIGN_VALUE_SIMBOL -36, #66
;   c3d: igual_ 17 18 19 
    COMP_IGUAL_SIMBOL -34, -36, -38   
;   condicional if 
;   c3d: if_ 19 - t_if_1_3 
    MOVE.W  -38(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_1_3   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_1_4 
    BRA t_if_1_4   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_1_3 
t_if_1_3:
;   desempilar simbolo 
;   c3d: desempila_ - - - 
    LEA stack,A1
    IF.L A0 <EQ> A1 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    DESEMPILA 
;   c3d: llegir_ 0 - 20 
    READ_VECTOR 	entrecP, -40, entrecPcursor
    LEA.L   entrecPcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 'i' - 21 
    ASIGN_VALUE_SIMBOL -42, #'i'
; c3d: assig_ 115 - 22 
    ASIGN_VALUE_SIMBOL -44, #115
; c3d: assig_ 109 - 23 
    ASIGN_VALUE_SIMBOL -46, #109
;   c3d: igual_ 20 21 24 
    COMP_IGUAL_SIMBOL -40, -42, -48   
;   c3d: igual_ 20 21 25 
    COMP_IGUAL_SIMBOL -40, -42, -50   
;   instrucción or 
;   c3d: or_ 24 25 24 
    OR_SIMBOL -48, -50, -48   
;   c3d: igual_ 20 22 27 
    COMP_IGUAL_SIMBOL -40, -44, -54   
;   instrucción or 
;   c3d: or_ 24 27 24 
    OR_SIMBOL -48, -54, -48   
;   c3d: igual_ 20 23 29 
    COMP_IGUAL_SIMBOL -40, -46, -58   
;   instrucción or 
;   c3d: or_ 24 29 24 
    OR_SIMBOL -48, -58, -48   
;   condicional if 
;   c3d: if_ 24 - t_if_2_0 
    MOVE.W  -48(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_2_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_2_1 
    BRA t_if_2_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_2_0 
t_if_2_0:
;   empilar simbolo 
;   c3d: empila_ 66 - - 
    EMPILA_VALOR #66
;   empilar simbolo 
;   c3d: empila_ 73 - - 
    EMPILA_VALOR #73
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_2_2 
    BRA t_if_2_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_2_1 
t_if_2_1:
;   c3d: llegir_ 0 - 33 
    READ_VECTOR 	entrecP, -66, entrecPcursor
    LEA.L   entrecPcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 102 - 34 
    ASIGN_VALUE_SIMBOL -68, #102
; c3d: assig_ 103 - 35 
    ASIGN_VALUE_SIMBOL -70, #103
; c3d: assig_ 104 - 36 
    ASIGN_VALUE_SIMBOL -72, #104
;   c3d: diferent_ 33 34 37 
    COMP_DIF_SIMBOL -66, -68, -74   
;   c3d: diferent_ 33 34 38 
    COMP_DIF_SIMBOL -66, -68, -76   
;   instrucción and 
;   c3d: and_ 37 38 37 
    AND_SIMBOL -74, -76, -74   
;   c3d: diferent_ 33 35 40 
    COMP_DIF_SIMBOL -66, -70, -80   
;   instrucción and 
;   c3d: and_ 37 40 37 
    AND_SIMBOL -74, -80, -74   
;   c3d: diferent_ 33 36 42 
    COMP_DIF_SIMBOL -66, -72, -84   
;   instrucción and 
;   c3d: and_ 37 42 37 
    AND_SIMBOL -74, -84, -74   
;   condicional if 
;   c3d: if_ 37 - t_if_3_0 
    MOVE.W  -74(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_3_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_3_1 
    BRA t_if_3_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_0 
t_if_3_0:
; c3d: assig_ 48 - accepta 
    ASIGN_VALUE_ACCEPTA #48, accepta
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_3_2 
    BRA t_if_3_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_1 
t_if_3_1:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_2 
t_if_3_2:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_2_2 
t_if_2_2:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_1_5 
    BRA t_if_1_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_1_4 
t_if_1_4:
;   cima de la pila 
;   c3d: cim_ - - 45 
    CIM -90
; c3d: assig_ 73 - 46 
    ASIGN_VALUE_SIMBOL -92, #73
;   c3d: igual_ 45 46 47 
    COMP_IGUAL_SIMBOL -90, -92, -94   
;   condicional if 
;   c3d: if_ 47 - t_if_2_3 
    MOVE.W  -94(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_2_3   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_2_4 
    BRA t_if_2_4   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_2_3 
t_if_2_3:
;   desempilar simbolo 
;   c3d: desempila_ - - - 
    LEA stack,A1
    IF.L A0 <EQ> A1 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    DESEMPILA 
;   c3d: llegir_ 0 - 48 
    READ_VECTOR 	entrecP, -96, entrecPcursor
    LEA.L   entrecPcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 'i' - 49 
    ASIGN_VALUE_SIMBOL -98, #'i'
;   c3d: igual_ 48 49 50 
    COMP_IGUAL_SIMBOL -96, -98, -100   
;   condicional if 
;   c3d: if_ 50 - t_if_3_3 
    MOVE.W  -100(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_3_3   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_3_4 
    BRA t_if_3_4   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_3 
t_if_3_3:
;   c3d: dreta_ - - 0 
    DRETA entrecPcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_3_5 
    BRA t_if_3_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_4 
t_if_3_4:
;   c3d: llegir_ 0 - 51 
    READ_VECTOR 	entrecP, -102, entrecPcursor
    LEA.L   entrecPcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 115 - 52 
    ASIGN_VALUE_SIMBOL -104, #115
;   c3d: igual_ 51 52 53 
    COMP_IGUAL_SIMBOL -102, -104, -106   
;   condicional if 
;   c3d: if_ 53 - t_if_4_0 
    MOVE.W  -106(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_4_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_4_1 
    BRA t_if_4_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_4_0 
t_if_4_0:
;   empilar simbolo 
;   c3d: empila_ 103 - - 
    EMPILA_VALOR #103
;   empilar simbolo 
;   c3d: empila_ 66 - - 
    EMPILA_VALOR #66
;   c3d: dreta_ - - 0 
    DRETA entrecPcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_4_2 
    BRA t_if_4_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_4_1 
t_if_4_1:
;   c3d: llegir_ 0 - 56 
    READ_VECTOR 	entrecP, -112, entrecPcursor
    LEA.L   entrecPcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 109 - 57 
    ASIGN_VALUE_SIMBOL -114, #109
;   c3d: igual_ 56 57 58 
    COMP_IGUAL_SIMBOL -112, -114, -116   
;   condicional if 
;   c3d: if_ 58 - t_if_5_0 
    MOVE.W  -116(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_5_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_5_1 
    BRA t_if_5_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_5_0 
t_if_5_0:
;   empilar simbolo 
;   c3d: empila_ 104 - - 
    EMPILA_VALOR #104
;   empilar simbolo 
;   c3d: empila_ 66 - - 
    EMPILA_VALOR #66
;   c3d: dreta_ - - 0 
    DRETA entrecPcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_5_2 
    BRA t_if_5_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_5_1 
t_if_5_1:
; c3d: assig_ 48 - accepta 
    ASIGN_VALUE_ACCEPTA #48, accepta
;   escribir etiqueta 
;   c3d: skip_ - - t_if_5_2 
t_if_5_2:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_4_2 
t_if_4_2:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_5 
t_if_3_5:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_2_5 
    BRA t_if_2_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_2_4 
t_if_2_4:
;   cima de la pila 
;   c3d: cim_ - - 62 
    CIM -124
; c3d: assig_ 102 - 63 
    ASIGN_VALUE_SIMBOL -126, #102
; c3d: assig_ 103 - 64 
    ASIGN_VALUE_SIMBOL -128, #103
; c3d: assig_ 104 - 65 
    ASIGN_VALUE_SIMBOL -130, #104
;   c3d: igual_ 62 63 66 
    COMP_IGUAL_SIMBOL -124, -126, -132   
;   c3d: igual_ 62 63 67 
    COMP_IGUAL_SIMBOL -124, -126, -134   
;   instrucción or 
;   c3d: or_ 66 67 66 
    OR_SIMBOL -132, -134, -132   
;   c3d: igual_ 62 64 69 
    COMP_IGUAL_SIMBOL -124, -128, -138   
;   instrucción or 
;   c3d: or_ 66 69 66 
    OR_SIMBOL -132, -138, -132   
;   c3d: igual_ 62 65 71 
    COMP_IGUAL_SIMBOL -124, -130, -142   
;   instrucción or 
;   c3d: or_ 66 71 66 
    OR_SIMBOL -132, -142, -132   
;   condicional if 
;   c3d: if_ 66 - t_if_3_6 
    MOVE.W  -132(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_3_6   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_3_7 
    BRA t_if_3_7   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_6 
t_if_3_6:
;   cima de la pila 
;   c3d: cim_ - - 73 
    CIM -146
;   c3d: llegir_ 0 - 74 
    READ_VECTOR 	entrecP, -148, entrecPcursor
    LEA.L   entrecPcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
;   c3d: igual_ 73 74 75 
    COMP_IGUAL_SIMBOL -146, -148, -150   
;   condicional if 
;   c3d: if_ 75 - t_if_4_3 
    MOVE.W  -150(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_4_3   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_4_4 
    BRA t_if_4_4   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_4_3 
t_if_4_3:
;   desempilar simbolo 
;   c3d: desempila_ - - - 
    LEA stack,A1
    IF.L A0 <EQ> A1 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    DESEMPILA 
;   c3d: dreta_ - - 0 
    DRETA entrecPcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_4_5 
    BRA t_if_4_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_4_4 
t_if_4_4:
; c3d: assig_ 48 - accepta 
    ASIGN_VALUE_ACCEPTA #48, accepta
;   escribir etiqueta 
;   c3d: skip_ - - t_if_4_5 
t_if_4_5:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_3_8 
    BRA t_if_3_8   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_7 
t_if_3_7:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_3_8 
t_if_3_8:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_2_5 
t_if_2_5:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_1_5 
t_if_1_5:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_2 
t_if_0_2:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
;   c3d: llegir_ 0 - 77 
    READ_VECTOR 	entrecP, -154, entrecPcursor
    LEA.L   entrecPcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 35 - 78 
    ASIGN_VALUE_SIMBOL -156, #35
;   c3d: diferent_ 77 78 79 
    COMP_DIF_SIMBOL -154, -156, -158   
;   condicional if 
;   c3d: if_ 79 - t_if_0_3 
    MOVE.W  -158(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_3   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_4 
    BRA t_if_0_4   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_3 
t_if_0_3:
; c3d: assig_ 48 - accepta 
    ASIGN_VALUE_ACCEPTA #48, accepta
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_5 
    BRA t_if_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_4 
t_if_0_4:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_5 
t_if_0_5:
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7        
    ADD.L   #164, A7  ;nos situamos en PC para volver
    RTS


    ORG $4000                                   
* Put variables and constants here                   
memoria         ds.l    0                       
accepta         dc.b    '00',0                  
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entrecP     ds.l        1024
entrecPcursor     dc.l        0   
rentrecP     dc.l        'resultados/ent_recP.txt',0
space           ds.w    1024                    
stack           ds.w    0                       
ent             dc.l    'files/ent',0
linea1          dc.b    'Ramificacion del programa: ',0
linea2          dc.b    'Seleccionar la rama a ejecutar entre 1 y ',0
dospuntos       dc.b    ': ',0
separador       dc.b    '-----------------------------------------------',0
novalido        dc.b    'El numero de rama no es valido. Por favor, introduce otro.',0
    END    START        ; last line of source    
