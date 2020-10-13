*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE rec_wwt 
* Date       : Mon Sep 07 20:28:17 CEST 2020
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
    LOAD_ENT    ent, entrec_wwt
    LEA     stack,A0
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_REC_WWT

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
    SAVE_VEC    rentrec_wwt, entrec_wwt
    SIMHALT             ; halt simulator
; c3d:  procedure_ - - 0 

P_REC_WWT:
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #50, A6  
; c3d: assig_ 35 - 1 
    ASIGN_VALUE_SIMBOL -2, #35
; c3d: assig_ 49 - 4 
    ASIGN_VALUE_SIMBOL -8, #49
; c3d: assig_ 4 - 1 
    ASIGN_SIMBOL_SIMBOL -8, -2
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
; c3d: assig_ 1 - 5 
    ASIGN_SIMBOL_SIMBOL -2, -10
; c3d: assig_ 49 - 6 
    ASIGN_VALUE_SIMBOL -12, #49
;   c3d: igual_ 5 6 7 
    COMP_IGUAL_SIMBOL -10, -12, -14   
;   condicional if 
;   c3d: if_ 7 - t_while_0_1 
    MOVE.W  -14(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_1   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_2 
    BRA t_while_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_1 
t_while_0_1:
;   c3d: ramifica_ - - 1 
    MOVE.L  #t_end_ramifica_1,-(A6)      
    MOVE.L  #t_ramifica_1_2,-(A6)      
    MOVE.L  #t_ramifica_1_1,-(A6)      
ask_1:  
    ASK_RAMIF   #1, #2
    IF.B    D1 <GT> #2 THEN.S
        MOVE.L  #13,D0
        MOVE.L  #novalido,A1
        TRAP    #15
        BRA     ask_1
    ENDI
    MOVE.L     A6,A1
    SUB.L      #1,D1
    MULU.W     #4,D1
    ADD.L      D1,A1
    MOVE.L     (A1),A1
    JMP        (A1)
;   escribir etiqueta 
;   c3d: skip_ - - t_ramifica_1_1 
t_ramifica_1_1:
;   c3d: llegir_ 0 - 8 
    READ_VECTOR 	entrec_wwt, -16, entrec_wwtcursor
    LEA.L   entrec_wwtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 35 - 9 
    ASIGN_VALUE_SIMBOL -18, #35
;   c3d: diferent_ 8 9 10 
    COMP_DIF_SIMBOL -16, -18, -20   
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
;   c3d: llegir_ 0 - 11 
    READ_VECTOR 	entrec_wwt, -22, entrec_wwtcursor
    LEA.L   entrec_wwtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
;   empilar simbolo 
;   c3d: empila_ 11 - - 
    EMPILA -22
;   c3d: dreta_ - - 0 
    DRETA entrec_wwtcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_1 
t_if_0_1:
; c3d: assig_ 48 - 14 
    ASIGN_VALUE_SIMBOL -28, #48
; c3d: assig_ 14 - 1 
    ASIGN_SIMBOL_SIMBOL -28, -2
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_2 
t_if_0_2:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_end_ramifica_1 
    BRA t_end_ramifica_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_ramifica_1_2 
t_ramifica_1_2:
; c3d: assig_ 48 - 16 
    ASIGN_VALUE_SIMBOL -32, #48
; c3d: assig_ 16 - 1 
    ASIGN_SIMBOL_SIMBOL -32, -2
;   escribir etiqueta 
;   c3d: skip_ - - t_end_ramifica_1 
t_end_ramifica_1:
    ADD.L   #12,A6
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_3 
t_while_0_3:
;   no buida pila 
;   c3d: nobuida_ 0 - 17 
    NOBUIDA stack, -34
;   cima de la pila 
;   c3d: cim_ - - 18 
    CIM -36
;   c3d: llegir_ 0 - 19 
    READ_VECTOR 	entrec_wwt, -38, entrec_wwtcursor
    LEA.L   entrec_wwtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
;   c3d: igual_ 18 19 20 
    COMP_IGUAL_SIMBOL -36, -38, -40   
;   condicional if 
;   c3d: ifnot_ 17 - t_while_0_5 
    MOVE.W  -34(A7),D0 
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
    DRETA entrec_wwtcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_3 
    BRA t_while_0_3   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_5 
t_while_0_5:
;   buida pila 
;   c3d: buida_ 0 - 21 
    BUIDA stack, -42
;   c3d: llegir_ 0 - 22 
    READ_VECTOR 	entrec_wwt, -44, entrec_wwtcursor
    LEA.L   entrec_wwtcursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 35 - 23 
    ASIGN_VALUE_SIMBOL -46, #35
;   c3d: igual_ 22 23 24 
    COMP_IGUAL_SIMBOL -44, -46, -48   
;   condicional if 
;   c3d: ifnot_ 21 - t_if_0_4 
    MOVE.W  -42(A7),D0 
    CMP.W   #0, D0   
    BEQ t_if_0_4   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_3 
t_if_0_3:
; c3d: assig_ 49 - accepta 
    ASIGN_VALUE_ACCEPTA #49, accepta
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
    ADD.L   #54, A7  ;nos situamos en PC para volver
    RTS


    ORG $4000                                   
* Put variables and constants here                   
memoria         ds.l    0                       
accepta         dc.b    '00',0                  
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entrec_wwt     ds.l        1024
entrec_wwtcursor     dc.l        0   
rentrec_wwt     dc.l        'resultados/ent_rec_wwt.txt',0
space           ds.w    1024                    
stack           ds.w    0                       
ent             dc.l    'files/ent',0
linea1          dc.b    'Ramificacion del programa: ',0
linea2          dc.b    'Seleccionar la rama a ejecutar entre 1 y ',0
dospuntos       dc.b    ': ',0
separador       dc.b    '-----------------------------------------------',0
novalido        dc.b    'El numero de rama no es valido. Por favor, introduce otro.',0
    END    START        ; last line of source    
