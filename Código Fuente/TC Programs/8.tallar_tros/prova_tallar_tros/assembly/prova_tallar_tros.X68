*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE prova_tallar_tros 
* Date       : Thu Sep 03 18:45:06 CEST 2020
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
    LOAD_ENT    ent, entprova_tallar_tros
    INIT_VECTOR resultatprova_tallar_tros
    INIT_VECTOR continuitallar_tros
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_PROVA_TALLAR_TROS

FINALLY:;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_VEC    rentprova_tallar_tros, entprova_tallar_tros
    SAVE_VEC    rresultatprova_tallar_tros, resultatprova_tallar_tros
    SAVE_VEC    rcontinuitallar_tros, continuitallar_tros
    SIMHALT             ; halt simulator
; c3d:  procedure_ - - 0 

P_PROVA_TALLAR_TROS:
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #2, A6  
;   llamada a un subprograma 
;   c3d:    call_ - - 1 
    MOVE.L  A7, A5      ;Preparamos la pila para añadir nuevo prmbl
    MOVE.L  A6, A7      
    MOVE.L  A5, -(A7)  ;BP anterior
    SUB.L #4, A7  ;Espacio para PC
    ADD.L #4, A7  ;Regresamos para poner el pc en el salto
    JSR P_TALLAR_TROS
    ;volvemos de subrutina
    ADD.L #0, A7 ;Botamos return
    MOVE.L (A7)+, A5 ;Cogemos BP
    MOVE.L A7, A6  ;Dejamos A6 en la cima
    MOVE.L A5, A7 ;Nos colocamos en el BP del metodo actual
; c3d: assig_ 49 - accepta 
    ASIGN_VALUE_ACCEPTA #49, accepta
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7        
    ADD.L   #6, A7  ;nos situamos en PC para volver
    RTS
; c3d:  procedure_ - - 1 

P_TALLAR_TROS:
;   c3d:    preamble_ - - 1 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #22, A6  
; c3d: escriure_ 49 - 2 
    ASIGN_VALUE_VECTOR #49,continuitallar_tros,continuitallar_troscursor
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
;   c3d: llegir_ 2 - 2 
    READ_VECTOR 	continuitallar_tros, -4, continuitallar_troscursor
    LEA.L   continuitallar_troscursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 49 - 3 
    ASIGN_VALUE_SIMBOL -6, #49
;   c3d: igual_ 2 3 4 
    COMP_IGUAL_SIMBOL -4, -6, -8   
;   condicional if 
;   c3d: if_ 4 - t_while_0_1 
    MOVE.W  -8(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_1   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_2 
    BRA t_while_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_1 
t_while_0_1:
;   c3d: llegir_ 0 - 5 
    READ_VECTOR 	entprova_tallar_tros, -10, entprova_tallar_troscursor
    LEA.L   entprova_tallar_troscursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 35 - 6 
    ASIGN_VALUE_SIMBOL -12, #35
;   c3d: igual_ 5 6 7 
    COMP_IGUAL_SIMBOL -10, -12, -14   
;   condicional if 
;   c3d: if_ 7 - t_if_0_0 
    MOVE.W  -14(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_1 
    BRA t_if_0_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_0 
t_if_0_0:
; c3d: escriure_ 48 - 2 
    ASIGN_VALUE_VECTOR #48,continuitallar_tros,continuitallar_troscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_1 
t_if_0_1:
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
; c3d: escriure_ 48 - 2 
    ASIGN_VALUE_VECTOR #48,continuitallar_tros,continuitallar_troscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_end_ramifica_1 
    BRA t_end_ramifica_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_ramifica_1_2 
t_ramifica_1_2:
;   c3d: llegir_ 0 - 10 
    READ_VECTOR 	entprova_tallar_tros, -20, entprova_tallar_troscursor
    LEA.L   entprova_tallar_troscursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: escriure_ 10 - 1 
    ASIGN_SIMBOL_VECTOR -20, resultatprova_tallar_tros,resultatprova_tallar_troscursor
; c3d: escriure_ 35 - 0 
    ASIGN_VALUE_VECTOR #35,entprova_tallar_tros,entprova_tallar_troscursor
;   c3d: dreta_ - - 0 
    DRETA entprova_tallar_troscursor
;   c3d: dreta_ - - 1 
    DRETA resultatprova_tallar_troscursor
;   escribir etiqueta 
;   c3d: skip_ - - t_end_ramifica_1 
t_end_ramifica_1:
    ADD.L   #12,A6
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_2 
t_if_0_2:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
;   c3d:    endProcedure_ - - 1 
    MOVE.L  A6,A7        
    ADD.L   #26, A7  ;nos situamos en PC para volver
    RTS


    ORG $4000                                   
* Put variables and constants here                   
memoria         ds.l    0                       
accepta         dc.b    '00',0                  
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entprova_tallar_tros     ds.l        1024
entprova_tallar_troscursor     dc.l        0   
rentprova_tallar_tros     dc.l        'resultados/ent_prova_tallar_tros.txt',0
resultatprova_tallar_tros     ds.l        1024
resultatprova_tallar_troscursor     dc.l        0   
rresultatprova_tallar_tros     dc.l        'resultados/resultat_prova_tallar_tros.txt',0
continuitallar_tros     ds.l        1024
continuitallar_troscursor     dc.l        0   
rcontinuitallar_tros     dc.l        'resultados/continui_tallar_tros.txt',0
ent             dc.l    'files/ent',0
linea1          dc.b    'Ramificacion del programa: ',0
linea2          dc.b    'Seleccionar la rama a ejecutar entre 1 y ',0
dospuntos       dc.b    ': ',0
separador       dc.b    '-----------------------------------------------',0
novalido        dc.b    'El numero de rama no es valido. Por favor, introduce otro.',0
    END    START        ; last line of source    
