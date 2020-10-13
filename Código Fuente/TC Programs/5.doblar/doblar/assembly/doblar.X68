*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE doblar 
* Date       : Fri Aug 28 19:59:49 CEST 2020
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
    LOAD_ENT    ENT, entdoblar
    INIT_VECTOR vecdoblar
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_DOBLAR

FINALLY:;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_ENT    ENT, entdoblar
    SIMHALT             ; halt simulator
; c3d:  procedure_ - - 0 

P_DOBLAR:
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #30, A6  
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
;   c3d: llegir_ 0 - 0 
    READ_VECTOR 	entdoblar, -2, entdoblarcursor
; c3d: assig_ 35 - 1 
    ASIGN_VALUE_SIMBOL -4, #35
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
;   c3d: llegir_ 0 - 3 
    READ_VECTOR 	entdoblar, -8, entdoblarcursor
; c3d: escriure_ 3 - 1 
    ASIGN_SIMBOL_VECTOR -8, vecdoblar,vecdoblarcursor
;   c3d: dreta_ - - 0 
    DRETA entdoblarcursor
;   c3d: dreta_ - - 1 
    DRETA vecdoblarcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
;   c3d: esquerra_ - - 1 
    ESQUERRA vecdoblarcursor
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_3 
t_while_0_3:
;   c3d: llegir_ 1 - 4 
    READ_VECTOR 	vecdoblar, -10, vecdoblarcursor
; c3d: assig_ 35 - 5 
    ASIGN_VALUE_SIMBOL -12, #35
;   c3d: diferent_ 4 5 6 
    COMP_DIF_SIMBOL -10, -12, -14   
;   condicional if 
;   c3d: if_ 6 - t_while_0_4 
    MOVE.W  -14(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_4   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_5 
    BRA t_while_0_5   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_4 
t_while_0_4:
;   c3d: esquerra_ - - 1 
    ESQUERRA vecdoblarcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_3 
    BRA t_while_0_3   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_5 
t_while_0_5:
;   c3d: dreta_ - - 1 
    DRETA vecdoblarcursor
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_6 
t_while_0_6:
;   c3d: llegir_ 1 - 7 
    READ_VECTOR 	vecdoblar, -16, vecdoblarcursor
; c3d: assig_ 35 - 8 
    ASIGN_VALUE_SIMBOL -18, #35
;   c3d: diferent_ 7 8 9 
    COMP_DIF_SIMBOL -16, -18, -20   
;   condicional if 
;   c3d: if_ 9 - t_while_0_7 
    MOVE.W  -20(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_7   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_8 
    BRA t_while_0_8   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_7 
t_while_0_7:
;   c3d: llegir_ 1 - 10 
    READ_VECTOR 	vecdoblar, -22, vecdoblarcursor
; c3d: escriure_ 10 - 0 
    ASIGN_SIMBOL_VECTOR -22, entdoblar,entdoblarcursor
;   c3d: dreta_ - - 0 
    DRETA entdoblarcursor
;   c3d: dreta_ - - 1 
    DRETA vecdoblarcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_6 
    BRA t_while_0_6   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_8 
t_while_0_8:
;   c3d: esquerra_ - - 0 
    ESQUERRA entdoblarcursor
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_9 
t_while_0_9:
;   c3d: llegir_ 0 - 11 
    READ_VECTOR 	entdoblar, -24, entdoblarcursor
; c3d: assig_ 35 - 12 
    ASIGN_VALUE_SIMBOL -26, #35
;   c3d: diferent_ 11 12 13 
    COMP_DIF_SIMBOL -24, -26, -28   
;   condicional if 
;   c3d: if_ 13 - t_while_0_10 
    MOVE.W  -28(A7),D0 
    CMP.W   #1, D0   
    BEQ t_while_0_10   
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_11 
    BRA t_while_0_11   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_10 
t_while_0_10:
;   c3d: esquerra_ - - 0 
    ESQUERRA entdoblarcursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_9 
    BRA t_while_0_9   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_11 
t_while_0_11:
;   c3d: dreta_ - - 0 
    DRETA entdoblarcursor
; c3d: assig_ 49 - 14 
    ASIGN_VALUE_SIMBOL -30, #49
; c3d: assig_ 14 - accepta 
    ASIGN_SIMBOL_ACCEPTA -30, accepta 
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7        
    ADD.L   #34, A7  ;nos situamos en PC para volver
    RTS


    ORG $4000                                   
* Put variables and constants here                   
memoria         ds.l    0                       
accepta         dc.b    '00',0                  
                ds.w     0                      
acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  
entdoblar     ds.l        1024
entdoblarcursor     dc.l        0   
vecdoblar     ds.l        1024
vecdoblarcursor     dc.l        0   
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
