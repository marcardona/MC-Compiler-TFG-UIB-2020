*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE rec_w2wt 
* Date       : Mon Sep 07 20:21:32 CEST 2020
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
    LOAD_ENT    ent, entrec_w2wt
    LEA     stack,A0
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_REC_W2WT

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
    SAVE_VEC    rentrec_w2wt, entrec_w2wt
    SIMHALT             ; halt simulator
; c3d:  procedure_ - - 0 

P_REC_W2WT:
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #44, A6  
; c3d: assig_ 49 - accepta 
    ASIGN_VALUE_ACCEPTA #49, accepta
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
;   c3d: llegir_ 0 - 2 
    READ_VECTOR 	entrec_w2wt, -4, entrec_w2wtcursor
    LEA.L   entrec_w2wtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 50 - 3 
    ASIGN_VALUE_SIMBOL -6, #50
;   c3d: diferent_ 2 3 4 
    COMP_DIF_SIMBOL -4, -6, -8   
;   c3d: llegir_ 0 - 5 
    READ_VECTOR 	entrec_w2wt, -10, entrec_w2wtcursor
    LEA.L   entrec_w2wtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 35 - 6 
    ASIGN_VALUE_SIMBOL -12, #35
;   c3d: diferent_ 5 6 7 
    COMP_DIF_SIMBOL -10, -12, -14   
;   condicional if 
;   c3d: ifnot_ 4 - t_while_0_2 
    MOVE.W  -8(A7),D0 
    CMP.W   #0, D0   
    BEQ t_while_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_1 
t_while_0_1:
;   c3d: llegir_ 0 - 8 
    READ_VECTOR 	entrec_w2wt, -16, entrec_w2wtcursor
    LEA.L   entrec_w2wtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
;   empilar simbolo 
;   c3d: empila_ 8 - - 
    EMPILA -16
;   c3d: dreta_ - - 0 
    DRETA entrec_w2wtcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
;   c3d: llegir_ 0 - 10 
    READ_VECTOR 	entrec_w2wt, -20, entrec_w2wtcursor
    LEA.L   entrec_w2wtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 50 - 11 
    ASIGN_VALUE_SIMBOL -22, #50
;   c3d: igual_ 10 11 12 
    COMP_IGUAL_SIMBOL -20, -22, -24   
;   condicional if 
;   c3d: if_ 12 - t_if_0_0 
    MOVE.W  -24(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_1 
    BRA t_if_0_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_0 
t_if_0_0:
;   c3d: dreta_ - - 0 
    DRETA entrec_w2wtcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_1 
t_if_0_1:
; c3d: assig_ 48 - accepta 
    ASIGN_VALUE_ACCEPTA #48, accepta
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_2 
t_if_0_2:
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_3 
t_while_0_3:
;   no buida pila 
;   c3d: nobuida_ 0 - 14 
    NOBUIDA stack, -28
;   cima de la pila 
;   c3d: cim_ - - 15 
    CIM -30
;   c3d: llegir_ 0 - 16 
    READ_VECTOR 	entrec_w2wt, -32, entrec_w2wtcursor
    LEA.L   entrec_w2wtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
;   c3d: igual_ 15 16 17 
    COMP_IGUAL_SIMBOL -30, -32, -34   
;   condicional if 
;   c3d: ifnot_ 14 - t_while_0_5 
    MOVE.W  -28(A7),D0 
    CMP.W   #0, D0   
    BEQ t_while_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_4 
t_while_0_4:
;   desempilar simbolo 
;   c3d: desempila_ - - - 
    LEA stack,A1
    IF.L A0 <EQ> A1 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    DESEMPILA 
;   c3d: dreta_ - - 0 
    DRETA entrec_w2wtcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_3 
    BRA t_while_0_3   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_5 
t_while_0_5:
;   no buida pila 
;   c3d: nobuida_ 0 - 18 
    NOBUIDA stack, -36
;   c3d: llegir_ 0 - 19 
    READ_VECTOR 	entrec_w2wt, -38, entrec_w2wtcursor
    LEA.L   entrec_w2wtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 35 - 20 
    ASIGN_VALUE_SIMBOL -40, #35
;   c3d: diferent_ 19 20 21 
    COMP_DIF_SIMBOL -38, -40, -42   
;   condicional if 
;   c3d: if_ 18 - t_if_0_3 
    MOVE.W  -36(A7),D0 
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
    ADD.L   #48, A7  ;nos situamos en PC para volver
    RTS


    ORG $4000                                   
* Put variables and constants here                   
memoria         ds.l    0                       
accepta         dc.b    '00',0                  
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entrec_w2wt     ds.l        1024
entrec_w2wtcursor     dc.l        0   
rentrec_w2wt     dc.l        'resultados/ent_rec_w2wt.txt',0
space           ds.w    1024                    
stack           ds.w    0                       
ent             dc.l    'files/ent',0
linea1          dc.b    'Ramificacion del programa: ',0
linea2          dc.b    'Seleccionar la rama a ejecutar entre 1 y ',0
dospuntos       dc.b    ': ',0
separador       dc.b    '-----------------------------------------------',0
novalido        dc.b    'El numero de rama no es valido. Por favor, introduce otro.',0
    END    START        ; last line of source    
