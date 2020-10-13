*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE iguals 
* Date       : Fri Aug 28 19:48:04 CEST 2020
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
     TAG0:                                             
     ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        ADD.L   #0,D0
        MOVE.L  #0,D0
        MOVE.L  #0,D0
TAG1:
;   cargar el vector de entrada 
    LOAD_ENT    ENT, entiguals
    INIT_VECTOR copiaiguals
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_IGUALS

FINALLY:;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_ENT    ENT, entiguals
    SIMHALT             ; halt simulator
; c3d:  procedure_ - - 0 

P_IGUALS:
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #30, A6  
;   llamada a un subprograma 
;   c3d:    call_ - - 1 
    MOVE.L  A7, A5      ;Preparamos la pila para añadir nuevo prmbl
    MOVE.L  A6, A7      
    MOVE.L  A5, -(A7)  ;BP anterior
    SUB.L #4, A7  ;Espacio para PC
    ADD.L #4, A7  ;Regresamos para poner el pc en el salto
    JSR P_COPIAR
    ;volvemos de subrutina
    ADD.L #0, A7 ;Botamos return
    MOVE.L (A7)+, A5 ;Cogemos BP
    MOVE.L A7, A6  ;Dejamos A6 en la cima
    MOVE.L A5, A7 ;Nos colocamos en el BP del metodo actual
; c3d: assig_ 49 - 0 
    ASIGN_VALUE_SIMBOL -2, #49
; c3d: assig_ 0 - accepta 
    ASIGN_SIMBOL_ACCEPTA -2, accepta 
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
;   c3d: llegir_ 0 - 1 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	entiguals, -4, entigualscursor
; c3d: assig_ 35 - 2 
    ASIGN_VALUE_SIMBOL -6, #35
;   c3d: diferent_ 1 2 3 
    COMP_DIF_SIMBOL -4, -6, -8   
;   condicional if 
;   c3d: if_ 3 - t_while_0_1 
    MOVE.W  -8(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_1   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_2 
    BRA t_while_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_1 
t_while_0_1:
;   c3d: llegir_ 0 - 4 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	entiguals, -10, entigualscursor
;   c3d: llegir_ 1 - 5 
    LEA.L    copiaigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	copiaiguals, -12, copiaigualscursor
;   c3d: diferent_ 4 5 6 
    COMP_DIF_SIMBOL -10, -12, -14   
;   condicional if 
;   c3d: if_ 6 - t_if_0_0 
    MOVE.W  -14(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_1 
    BRA t_if_0_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_0 
t_if_0_0:
; c3d: assig_ 48 - 7 
    ASIGN_VALUE_SIMBOL -16, #48
; c3d: assig_ 7 - accepta 
    ASIGN_SIMBOL_ACCEPTA -16, accepta 
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_1 
t_if_0_1:
;   c3d: dreta_ - - 0 
    DRETA entigualscursor
;   c3d: dreta_ - - 1 
    DRETA copiaigualscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_2 
t_if_0_2:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
;   c3d: llegir_ 0 - 8 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	entiguals, -18, entigualscursor
;   c3d: llegir_ 1 - 9 
    LEA.L    copiaigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	copiaiguals, -20, copiaigualscursor
;   c3d: diferent_ 8 9 10 
    COMP_DIF_SIMBOL -18, -20, -22   
;   condicional if 
;   c3d: if_ 10 - t_if_0_3 
    MOVE.W  -22(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_3   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_4 
    BRA t_if_0_4   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_3 
t_if_0_3:
; c3d: assig_ 48 - 11 
    ASIGN_VALUE_SIMBOL -24, #48
; c3d: assig_ 11 - accepta 
    ASIGN_SIMBOL_ACCEPTA -24, accepta 
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_5 
    BRA t_if_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_4 
t_if_0_4:
;   c3d: esquerra_ - - 0 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    ESQUERRA entigualscursor
;   c3d: esquerra_ - - 1 
    LEA.L    copiaigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    ESQUERRA copiaigualscursor
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_3 
t_while_0_3:
;   c3d: llegir_ 0 - 12 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	entiguals, -26, entigualscursor
; c3d: assig_ 35 - 13 
    ASIGN_VALUE_SIMBOL -28, #35
;   c3d: diferent_ 12 13 14 
    COMP_DIF_SIMBOL -26, -28, -30   
;   condicional if 
;   c3d: if_ 14 - t_while_0_4 
    MOVE.W  -30(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_4   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_5 
    BRA t_while_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_4 
t_while_0_4:
;   c3d: esquerra_ - - 0 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    ESQUERRA entigualscursor
;   c3d: esquerra_ - - 1 
    LEA.L    copiaigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    ESQUERRA copiaigualscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_3 
    BRA t_while_0_3   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_5 
t_while_0_5:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_5 
    BRA t_if_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_5 
t_if_0_5:
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7        
    ADD.L   #34, A7  ;nos situamos en PC para volver
    RTS
; c3d:  procedure_ - - 1 

P_COPIAR:
;   c3d:    preamble_ - - 1 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #14, A6  
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_6 
t_while_0_6:
;   c3d: llegir_ 0 - 15 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	entiguals, -2, entigualscursor
; c3d: assig_ 35 - 16 
    ASIGN_VALUE_SIMBOL -4, #35
;   c3d: diferent_ 15 16 17 
    COMP_DIF_SIMBOL -2, -4, -6   
;   condicional if 
;   c3d: if_ 17 - t_while_0_7 
    MOVE.W  -6(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_7   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_8 
    BRA t_while_0_8   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_7 
t_while_0_7:
;   c3d: llegir_ 0 - 18 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	entiguals, -8, entigualscursor
; c3d: escriure_ 18 - 1 
    ASIGN_SIMBOL_VECTOR -8, copiaiguals,copiaigualscursor
;   c3d: dreta_ - - 0 
    DRETA entigualscursor
;   c3d: dreta_ - - 1 
    DRETA copiaigualscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_6 
    BRA t_while_0_6   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_8 
t_while_0_8:
;   c3d: esquerra_ - - 0 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    ESQUERRA entigualscursor
;   c3d: esquerra_ - - 1 
    LEA.L    copiaigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    ESQUERRA copiaigualscursor
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_9 
t_while_0_9:
;   c3d: llegir_ 0 - 19 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    READ_VECTOR 	entiguals, -10, entigualscursor
; c3d: assig_ 35 - 20 
    ASIGN_VALUE_SIMBOL -12, #35
;   c3d: diferent_ 19 20 21 
    COMP_DIF_SIMBOL -10, -12, -14   
;   condicional if 
;   c3d: if_ 21 - t_while_0_10 
    MOVE.W  -14(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_10   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_11 
    BRA t_while_0_11   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_10 
t_while_0_10:
;   c3d: esquerra_ - - 0 
    LEA.L    entigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    ESQUERRA entigualscursor
;   c3d: esquerra_ - - 1 
    LEA.L    copiaigualscursor,A1
    MOVE.W   (A1),D0
    IF.W    D0 <LT> #0 THEN.S
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
    ESQUERRA copiaigualscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_9 
    BRA t_while_0_9   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_11 
t_while_0_11:
;   c3d: dreta_ - - 0 
    DRETA entigualscursor
;   c3d: dreta_ - - 1 
    DRETA copiaigualscursor
;   c3d:    endProcedure_ - - 1 
    MOVE.L  A6,A7        
    ADD.L   #18, A7  ;nos situamos en PC para volver
    RTS


    ORG $4000                                   
* Put variables and constants here                   
memoria         ds.l    0                       
accepta         dc.b    '00',0                  
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entiguals     ds.l        1024
entigualscursor     dc.l        0   
copiaiguals     ds.l        1024
copiaigualscursor     dc.l        0   
ENT             dc.l    'files/ent',0
filename        dc.b    'files/thread'           
threads         dc.b    '0000'                   
ext             dc.b    '.txt',0                 
actual          dc.l    'files/temp',0              
filenamebytes   dc.l    20                               
threadstr       dc.w    'Fichero creado: ',0            
threadbytes     dc.l    16
runningstr      dc.w    'Ejecutando rama ',0
runningbytes    dc.l    16
introbytes      dc.l    1
logfile         dc.w    'files/log.txt',0
ramificando     dc.w    0
registros       ds.l    3
fichero         ds.l    20
buffer         ds.l    20
    END    START        ; last line of source    
