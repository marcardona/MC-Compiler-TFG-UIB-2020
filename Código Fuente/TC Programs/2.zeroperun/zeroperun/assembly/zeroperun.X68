*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE zeroperun 
* Date       : Mon May 04 19:04:25 CEST 2020
* Description: Codigo ensamblador
*------------------------------------------------------------

*************************************************************
*                             MACROS                         *
*************************************************************
    INCLUDE "macros/macros.X68"                                   
                                                              
                                                              
                                                              
*************************************************************
*                         MAIN PROGRAM                      *
*************************************************************

    ORG    $1000
START:                  ; first instruction of program

; cerrar todos los ficheros (aconsejado)                     
; close file                                            
    MOVE.L  #50,D0                                          
    TRAP    #15                                              
;   cargar el vector de entrada 
    LOAD_ENT    ENT, entzeroperun
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_ZEROPERUN

;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_ENT    ENT, entzeroperun
    SIMHALT             ; halt simulator
******************** PROCEDURE ******************** 
; c3d:  procedure_ - - 0 

P_ZEROPERUN:
******************** PREAMBLE ******************** 
;   preambulo 
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #46, A6  
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entzeroperun, -2, entzeroperuncursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 1 
    ASIGN_VALUE_SIMBOL -4, #49
;   comparar si son iguales 
;   c3d: igual_ 0 1 2 
    COMP_IGUAL_SIMBOL -2, -4, -6   
;   condicional if 
;   c3d: if_ 2 - t_while_0_1 
    MOVE.W  -6(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_1   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_2 
    BRA t_while_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_1 
t_while_0_1:
    DRETA entzeroperuncursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_3 
t_while_0_3:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entzeroperun, -8, entzeroperuncursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 35 - 4 
    ASIGN_VALUE_SIMBOL -10, #35
;   comparar si son iguales 
;   c3d: igual_ 3 4 5 
    COMP_IGUAL_SIMBOL -8, -10, -12   
;   condicional if 
;   c3d: if_ 5 - t_while_0_4 
    MOVE.W  -12(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_4   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_5 
    BRA t_while_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_4 
t_while_0_4:
    DRETA entzeroperuncursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_3 
    BRA t_while_0_3   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_5 
t_while_0_5:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entzeroperun, -14, entzeroperuncursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 48 - 7 
    ASIGN_VALUE_SIMBOL -16, #48
;   comparar si son iguales 
;   c3d: igual_ 6 7 8 
    COMP_IGUAL_SIMBOL -14, -16, -18   
;   condicional if 
;   c3d: if_ 8 - t_if_0_0 
    MOVE.W  -18(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_0   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_1 
    BRA t_if_0_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_0 
t_if_0_0:
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 9 
    ASIGN_VALUE_SIMBOL -20, #49
******************** ESCRIBIR SIMBOLO EN VECTOR ; pendiente de hacer  ******************** 
; c3d: escriure_ 9 - 0 
    ASIGN_SIMBOL_VECTOR -20, entzeroperun,entzeroperuncursor
    DRETA entzeroperuncursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_1 
t_if_0_1:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_2 
t_if_0_2:
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_6 
t_while_0_6:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entzeroperun, -22, entzeroperuncursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 11 
    ASIGN_VALUE_SIMBOL -24, #49
;   comparar si son iguales 
;   c3d: igual_ 10 11 12 
    COMP_IGUAL_SIMBOL -22, -24, -26   
;   condicional if 
;   c3d: if_ 12 - t_while_0_7 
    MOVE.W  -26(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_7   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_8 
    BRA t_while_0_8   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_7 
t_while_0_7:
    DRETA entzeroperuncursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_6 
    BRA t_while_0_6   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_8 
t_while_0_8:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entzeroperun, -28, entzeroperuncursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 35 - 14 
    ASIGN_VALUE_SIMBOL -30, #35
;   comparar si son iguales 
;   c3d: igual_ 13 14 15 
    COMP_IGUAL_SIMBOL -28, -30, -32   
;   condicional if 
;   c3d: if_ 15 - t_if_0_3 
    MOVE.W  -32(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_3   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_4 
    BRA t_if_0_4   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_3 
t_if_0_3:
    ESQUERRA entzeroperuncursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_5 
    BRA t_if_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_4 
t_if_0_4:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_5 
    BRA t_if_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_5 
t_if_0_5:
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_9 
t_while_0_9:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entzeroperun, -34, entzeroperuncursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 17 
    ASIGN_VALUE_SIMBOL -36, #49
;   comparar si son iguales 
;   c3d: igual_ 16 17 18 
    COMP_IGUAL_SIMBOL -34, -36, -38   
;   condicional if 
;   c3d: if_ 18 - t_while_0_10 
    MOVE.W  -38(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_10   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_11 
    BRA t_while_0_11   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_10 
t_while_0_10:
    ESQUERRA entzeroperuncursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_9 
    BRA t_while_0_9   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_11 
t_while_0_11:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entzeroperun, -40, entzeroperuncursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 35 - 20 
    ASIGN_VALUE_SIMBOL -42, #35
;   comparar si son iguales 
;   c3d: igual_ 19 20 21 
    COMP_IGUAL_SIMBOL -40, -42, -44   
;   condicional if 
;   c3d: if_ 21 - t_if_0_6 
    MOVE.W  -44(A7),D0 
    CMP.W   #1, D0   
    BEQ t_if_0_6   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_7 
    BRA t_if_0_7   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_6 
t_if_0_6:
    DRETA entzeroperuncursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 22 
    ASIGN_VALUE_SIMBOL -46, #49
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 22 - accepta 
    ASIGN_SIMBOL_ACCEPTA -46, accepta 
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_8 
    BRA t_if_0_8   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_7 
t_if_0_7:
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_8 
    BRA t_if_0_8   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_8 
t_if_0_8:
******************** END PROCEDURE ******************** 
;   para salir del subprograma 
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7       ; EN PRUEBAS 
    ADD.L   #50, A7  ;nos situamos en PC para volver
    RTS
                                                
* Put variables and constants here                   
accepta         dc.b    '00',0                   
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entzeroperun     ds.l        1024
entzeroperuncursor     dc.l        0   
ENT             dc.l     'files/ent',0
    END    START        ; last line of source    
