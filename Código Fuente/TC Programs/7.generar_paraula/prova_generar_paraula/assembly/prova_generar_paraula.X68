*------------------------------------------------------------
* Title      : CODIGO ENSAMBLADOR DE prova_generar_paraula 
* Date       : Thu Sep 03 15:03:27 CEST 2020
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
    LOAD_ENT    ent, entprova_generar_paraula
    INIT_VECTOR continuigenerar_paraula
;   instruccion start del programa 
;   c3d:        call_ - - 0 
    JSR         P_PROVA_GENERAR_PARAULA

FINALLY:;   imprimir valor de accepta 
    LEA         acceptastr,A1 
    MOVE.W      #14,D0        
    TRAP        #15           
    CLR.L       D1            
    LEA         accepta,A1    
    MOVE.W      (A1),D1       
    MOVE.W      #6,D0         
    TRAP        #15           
    SAVE_VEC    rentprova_generar_paraula, entprova_generar_paraula
    SAVE_VEC    rcontinuigenerar_paraula, continuigenerar_paraula
    SIMHALT             ; halt simulator
; c3d:  procedure_ - - 0 

P_PROVA_GENERAR_PARAULA:
;   c3d:    preamble_ - - 0 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #0, A6  
;   llamada a un subprograma 
;   c3d:    call_ - - 1 
    MOVE.L  A7, A5      ;Preparamos la pila para añadir nuevo prmbl
    MOVE.L  A6, A7      
    MOVE.L  A5, -(A7)  ;BP anterior
    SUB.L #4, A7  ;Espacio para PC
    ADD.L #4, A7  ;Regresamos para poner el pc en el salto
    JSR P_GENERAR_PARAULA
    ;volvemos de subrutina
    ADD.L #0, A7 ;Botamos return
    MOVE.L (A7)+, A5 ;Cogemos BP
    MOVE.L A7, A6  ;Dejamos A6 en la cima
    MOVE.L A5, A7 ;Nos colocamos en el BP del metodo actual
;   c3d:    endProcedure_ - - 0 
    MOVE.L  A6,A7        
    ADD.L   #4, A7  ;nos situamos en PC para volver
    RTS
; c3d:  procedure_ - - 1 

P_GENERAR_PARAULA:
;   c3d:    preamble_ - - 1 

    SUB.L   #0, A7
    SUB.L   #4, A7  ;BP
    MOVE.L  #0, (A7) ;Todo 0
    MOVE.L  A7, A6 ;SP==A7
    SUB.L   #14, A6  
; c3d: escriure_ 49 - 1 
    ASIGN_VALUE_VECTOR #49,continuigenerar_paraula,continuigenerar_paraulacursor
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_0 
t_while_0_0:
;   c3d: llegir_ 1 - 1 
    READ_VECTOR 	continuigenerar_paraula, -4, continuigenerar_paraulacursor
    LEA.L   continuigenerar_paraulacursor,A1
    MOVE.L  (A1),D0
    IF.L    D0 <LE> #-2 THEN.S 
        ASIGN_VALUE_ACCEPTA #'e', accepta
        JMP FINALLY
    ENDI
; c3d: assig_ 49 - 2 
    ASIGN_VALUE_SIMBOL -6, #49
;   c3d: igual_ 1 2 3 
    COMP_IGUAL_SIMBOL -4, -6, -8   
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
;   c3d: ramifica_ - - 1 
    MOVE.L  #t_end_ramifica_1,-(A6)      
    MOVE.L  #t_ramifica_1_3,-(A6)      
    MOVE.L  #t_ramifica_1_2,-(A6)      
    MOVE.L  #t_ramifica_1_1,-(A6)      
ask_1:  
    ASK_RAMIF   #1, #3
    IF.B    D1 <GT> #3 THEN.S
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
; c3d: escriure_ 48 - 1 
    ASIGN_VALUE_VECTOR #48,continuigenerar_paraula,continuigenerar_paraulacursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_end_ramifica_1 
    BRA t_end_ramifica_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_ramifica_1_2 
t_ramifica_1_2:
; c3d: escriure_ 48 - 0 
    ASIGN_VALUE_VECTOR #48,entprova_generar_paraula,entprova_generar_paraulacursor
;   c3d: dreta_ - - 0 
    DRETA entprova_generar_paraulacursor
;   saltar a la etiqueta 
;   c3d: goto_ - - t_end_ramifica_1 
    BRA t_end_ramifica_1   
;   escribir etiqueta 
;   c3d: skip_ - - t_ramifica_1_3 
t_ramifica_1_3:
; c3d: escriure_ 49 - 0 
    ASIGN_VALUE_VECTOR #49,entprova_generar_paraula,entprova_generar_paraulacursor
;   c3d: dreta_ - - 0 
    DRETA entprova_generar_paraulacursor
;   escribir etiqueta 
;   c3d: skip_ - - t_end_ramifica_1 
t_end_ramifica_1:
    ADD.L   #16,A6
;   saltar a la etiqueta 
;   c3d: goto_ - - t_while_0_0 
    BRA t_while_0_0   
;   escribir etiqueta 
;   c3d: skip_ - - t_while_0_2 
t_while_0_2:
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
entprova_generar_paraula     ds.l        1024
entprova_generar_paraulacursor     dc.l        0   
rentprova_generar_paraula     dc.l        'resultados/ent_prova_generar_paraula.txt',0
continuigenerar_paraula     ds.l        1024
continuigenerar_paraulacursor     dc.l        0   
rcontinuigenerar_paraula     dc.l        'resultados/continui_generar_paraula.txt',0
ent             dc.l    'files/ent',0
linea1          dc.b    'Ramificacion del programa: ',0
linea2          dc.b    'Seleccionar la rama a ejecutar entre 1 y ',0
dospuntos       dc.b    ': ',0
separador       dc.b    '-----------------------------------------------',0
novalido        dc.b    'El numero de rama no es valido. Por favor, introduce otro.',0
    END    START        ; last line of source    
