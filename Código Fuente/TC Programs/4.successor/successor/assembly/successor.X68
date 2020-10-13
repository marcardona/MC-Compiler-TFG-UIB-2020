*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE successor 
* Date       : Mon May 04 19:17:27 CEST 2020
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
    LOAD_ENT    ENT, entsuccessor
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_SUCCESSOR

;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_ENT    ENT, entsuccessor
    SIMHALT             ; halt simulator
******************** PROCEDURE ******************** 
; c3d:  procedure_ - - 0 

P_SUCCESSOR:
******************** PREAMBLE ******************** 
;   preambulo 
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #18, A6  
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entsuccessor, -2, entsuccessorcursor
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
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 48 - 3 
    ASIGN_VALUE_SIMBOL -8, #48
******************** ESCRIBIR SIMBOLO EN VECTOR ; pendiente de hacer  ******************** 
; c3d: escriure_ 3 - 0 
    ASIGN_SIMBOL_VECTOR -8, entsuccessor,entsuccessorcursor
    DRETA entsuccessorcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 4 
    ASIGN_VALUE_SIMBOL -10, #49
******************** ESCRIBIR SIMBOLO EN VECTOR ; pendiente de hacer  ******************** 
; c3d: escriure_ 4 - 0 
    ASIGN_SIMBOL_VECTOR -10, entsuccessor,entsuccessorcursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 49 - 5 
    ASIGN_VALUE_SIMBOL -12, #49
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 5 - accepta 
    ASIGN_SIMBOL_ACCEPTA -12, accepta 
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_3 
t_while_0_3:
 ****************** READ VECTOR ***************** 
    READ_VECTOR 	entsuccessor, -14, entsuccessorcursor
******************** ASIGNAR SIMBOLO ******************** 
; c3d: assig_ 35 - 7 
    ASIGN_VALUE_SIMBOL -16, #35
;   comparar si son diferentes 
;   c3d: diferent_ 6 7 8 
    COMP_DIF_SIMBOL -14, -16, -18   
;   condicional if 
;   c3d: if_ 8 - t_while_0_4 
    MOVE.W  -18(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_4   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_5 
    BRA t_while_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_4 
t_while_0_4:
    ESQUERRA entsuccessorcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_3 
    BRA t_while_0_3   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_5 
t_while_0_5:
    DRETA entsuccessorcursor
******************** END PROCEDURE ******************** 
;   para salir del subprograma 
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7       ; EN PRUEBAS 
    ADD.L   #22, A7  ;nos situamos en PC para volver
    RTS
                                                
* Put variables and constants here                   
accepta         dc.b    '00',0                   
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entsuccessor     ds.l        1024
entsuccessorcursor     dc.l        0   
ENT             dc.l     'files/ent',0
    END    START        ; last line of source    
