*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE perdos 
* Date       : Mon May 04 19:02:46 CEST 2020
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
    LOAD_ENT    ENT, entperdos
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_PERDOS

;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_ENT    ENT, entperdos
    SIMHALT             ; halt simulator
******************** PROCEDURE ******************** 
; c3d:  procedure_ - - 0 

P_PERDOS:
******************** PREAMBLE ******************** 
;   preambulo 
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #26, A6  
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entperdos, -2, entperdoscursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 35 - 1 
    ASIGN_VALUE_SIMBOL -4, #35
;   comparar si son diferentes 
;   c3d: diferent_ 0 1 2 
    COMP_DIF_SIMBOL -2, -4, -6   
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
    DRETA entperdoscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
    ESQUERRA entperdoscursor
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_3 
t_while_0_3:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entperdos, -8, entperdoscursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 35 - 4 
    ASIGN_VALUE_SIMBOL -10, #35
;   comparar si son diferentes 
;   c3d: diferent_ 3 4 5 
    COMP_DIF_SIMBOL -8, -10, -12   
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
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entperdos, -14, entperdoscursor
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
    DRETA entperdoscursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 48 - 9 
    ASIGN_VALUE_SIMBOL -20, #48
******************** ESCRIBIR SIMBOLO EN VECTOR ; pendiente de hacer  ******************** 
; c3d: escriure_ 9 - 0 
    ASIGN_SIMBOL_VECTOR -20, entperdos,entperdoscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_1 
t_if_0_1:
    DRETA entperdoscursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 10 
    ASIGN_VALUE_SIMBOL -22, #49
******************** ESCRIBIR SIMBOLO EN VECTOR ; pendiente de hacer  ******************** 
; c3d: escriure_ 10 - 0 
    ASIGN_SIMBOL_VECTOR -22, entperdos,entperdoscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_if_0_2 
    BRA t_if_0_2   
;   escribir etiqueta 
;   c3d: skip_ - - t_if_0_2 
t_if_0_2:
    ESQUERRA entperdoscursor
    ESQUERRA entperdoscursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_3 
    BRA t_while_0_3   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_5 
t_while_0_5:
    DRETA entperdoscursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 48 - 11 
    ASIGN_VALUE_SIMBOL -24, #48
******************** ESCRIBIR SIMBOLO EN VECTOR ; pendiente de hacer  ******************** 
; c3d: escriure_ 11 - 0 
    ASIGN_SIMBOL_VECTOR -24, entperdos,entperdoscursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 12 
    ASIGN_VALUE_SIMBOL -26, #49
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 12 - accepta 
    ASIGN_SIMBOL_ACCEPTA -26, accepta 
******************** END PROCEDURE ******************** 
;   para salir del subprograma 
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7       ; EN PRUEBAS 
    ADD.L   #30, A7  ;nos situamos en PC para volver
    RTS
                                                
* Put variables and constants here                   
accepta         dc.b    '00',0                   
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entperdos     ds.l        1024
entperdoscursor     dc.l        0   
ENT             dc.l     'files/ent',0
    END    START        ; last line of source    
