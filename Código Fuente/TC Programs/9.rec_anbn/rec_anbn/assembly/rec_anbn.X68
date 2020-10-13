*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE rec_anbn 
* Date       : Sat Sep 05 18:48:20 CEST 2020
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
    LOAD_ENT    ent, entrec_anbn
    LEA     stack,A0
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_REC_ANBN

FINALLY:;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_VEC    rentrec_anbn, entrec_anbn
    SIMHALT             ; halt simulator
; c3d:  procedure_ - - 0 

P_REC_ANBN:
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #32, A6  
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
;   c3d: llegir_ 0 - 1 
    READ_VECTOR 	entrec_anbn, -2, entrec_anbncursor
    LEA.L   entrec_anbncursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 97 - 2 
    ASIGN_VALUE_SIMBOL -4, #97
;   c3d: igual_ 1 2 3 
    COMP_IGUAL_SIMBOL -2, -4, -6   
;   condicional if 
;   c3d: if_ 3 - t_while_0_1 
    MOVE.W  -6(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_1   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_2 
    BRA t_while_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_1 
t_while_0_1:
; c3d: assig_ 65 - 5 
    ASIGN_VALUE_SIMBOL -10, #65
;   empilar simbolo 
;   c3d: empila_ 5 - - 
    EMPILA -10
;   c3d: dreta_ - - 0 
    DRETA entrec_anbncursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_3 
t_while_0_3:
;   c3d: llegir_ 0 - 6 
    READ_VECTOR 	entrec_anbn, -12, entrec_anbncursor
    LEA.L   entrec_anbncursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 98 - 7 
    ASIGN_VALUE_SIMBOL -14, #98
;   c3d: igual_ 6 7 8 
    COMP_IGUAL_SIMBOL -12, -14, -16   
;   cima de la pila 
;   c3d: nobuida_ 0 - 9 
    NOBUIDA stack, -18
;   instrucción and 
;   c3d: and_ 8 9 10 
    AND_SIMBOL -16, -18, -20   
;   condicional if 
;   c3d: if_ 10 - t_while_0_4 
    MOVE.W  -20(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_4   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_5 
    BRA t_while_0_5   
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
    DRETA entrec_anbncursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_3 
    BRA t_while_0_3   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_5 
t_while_0_5:
;   cima de la pila 
;   c3d: buida_ 0 - 11 
    BUIDA stack, -22
;   c3d: llegir_ 0 - 12 
    READ_VECTOR 	entrec_anbn, -24, entrec_anbncursor
    LEA.L   entrec_anbncursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 35 - 13 
    ASIGN_VALUE_SIMBOL -26, #35
;   c3d: igual_ 12 13 14 
    COMP_IGUAL_SIMBOL -24, -26, -28   
;   instrucción and 
;   c3d: and_ 11 14 15 
    AND_SIMBOL -22, -28, -30   
;   condicional if 
;   c3d: if_ 15 - t_if_0_0 
    MOVE.W  -30(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_1 
    BRA t_if_0_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_0 
t_if_0_0:
; c3d: assig_ 49 - accepta 
    ASIGN_VALUE_ACCEPTA #49, accepta
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_1 
t_if_0_1:
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_2 
t_if_0_2:
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7        
    ADD.L   #36, A7  ;nos situamos en PC para volver
    RTS


    ORG $4000                                   
* Put variables and constants here                   
memoria         ds.l    0                       
accepta         dc.b    '00',0                  
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entrec_anbn     ds.l        1024
entrec_anbncursor     dc.l        0   
rentrec_anbn     dc.l        'resultados/ent_rec_anbn.txt',0
space           ds.w    1024                    
stack           ds.w    0                       
ent             dc.l    'files/ent',0
linea1          dc.b    'Ramificacion del programa: ',0
linea2          dc.b    'Seleccionar la rama a ejecutar entre 1 y ',0
dospuntos       dc.b    ': ',0
separador       dc.b    '-----------------------------------------------',0
novalido        dc.b    'El numero de rama no es valido. Por favor, introduce otro.',0
    END    START        ; last line of source    

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
