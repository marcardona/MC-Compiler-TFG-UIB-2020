*-----------------------------------------------------------
* Title      : MACROS
* Written by : Maria del Mar Cardona Aranda
* Description: macros
*-----------------------------------------------------------

************************************************************
*                             MACROS                       *
************************************************************

*-----------------------------------------------------------
LOAD_ENT 	MACRO
* Macro to reads 1 word from the vector address             
* Parameters:     \1: ent file adress                      
*                 \2: ent vector adress                    
* Modifies  : D0, D1, D2, D3, A1                            
* Always executed after TRAP 51, 52 or 55                   
*-----------------------------------------------------------
    ; open existing file                                    
    LEA.L   \1,A1                                          
    MOVE.L  #51,D0                                          
    TRAP    #15                                             
    ; read file                                             
    CLR.L   D2                                              
    CLR.L   D3                                              
    LEA.L   \2,A1                                          
    WHILE.W #1024 <GT> D3 DO.S                              
        MOVE.W  D3,D2                                       
        ; set cursor                                        
        MOVE.L  #55,D0                                      
        TRAP    #15                                         
        MOVE.W  #0,(A1)                                     
        MOVE.L  #1,D2                                       
        MOVE.L  #53,D0                                      
        TRAP    #15                                         
        ADD.W   #1,D3                                       
        ADD.L   #2,A1                                       
    ENDW                                                    
    ; close file                                            
    MOVE.L  #50,D0                                          
    TRAP    #15                                             
    ENDM                                                    

*-----------------------------------------------------------
SAVE_ENT     MACRO
* Macro to reads 1 word from the vector address             
* Parameters:     \1: ent file adress                      
*                 \2: ent vector adress* Modifies  : D0, D1, D2, A1                                
* Always executed after TRAP 51, 52 or 55                   
*-----------------------------------------------------------
   CLR.L  D3                                                
    ; open existing file                                    
    LEA.L   \1,A1                                          
    MOVE.L  #51,D0                                          
    TRAP    #15                                             
    LEA.L   \2,A1                                          
    WHILE.W #1023 <GT> D3 DO.S                              
        MOVE.L  D3,D2                                       
        ; set cursor                                        
        MOVE.L  #55,D0                                      
        TRAP    #15                                         
        ; write file                                        
        MOVE.L  #1,D2                                       
        MOVE.L  #54,D0                                      
        TRAP    #15                                         
        ; aumentar el cursor y el vector                    
        ADD.L   #1,D3                                       
        ADD.L   #2,A1                                       
    ENDW                                                    
    ; close file                                            
    MOVE.L  #50,D0                                          
    TRAP    #15                                             
    ENDM                                                    

*-----------------------------------------------------------
INIT_VECTOR     MACRO
* Macro to load 1024 # in a vector.                         
* Parameters:     \1: vector adress                        
* Modifies  : D0, D1, D2, A1                                
*-----------------------------------------------------------
   CLR.L   D0                                               
   WHILE.W D0 <LE> #1024 DO.S                               
       LEA.L   \1,A1                                       
       ADD.L   D0,A1                                        
       MOVE.W  #$2300,(A1)                                  
       ADD.W   #2,D0                                        
   ENDW                                                     
   ENDM                                                    

*-----------------------------------------------------------
DRETA 	MACRO                                    
* Macro to increase in 1 word the cursor of the file.       
* Parameters: \1: vector cursor name                       
* Modifies  : D0, A1                                        
*-----------------------------------------------------------
   CLR.L   D0                                               
   LEA.L   \1,A1                                           
   MOVE.L  (A1),D0                                          
   ADD.L   #2,D0                                            
   MOVE.L  D0,(A1)                                          
   ENDM                                                     

*-----------------------------------------------------------
ESQUERRA 	MACRO                                    
* Macro to increase in 1 unit the cursor of the file.       
* Parameters: \1: vector cursor name                       
* Modifies  : D0, A1                                        
*-----------------------------------------------------------
   CLR.L   D0                                               
   LEA.L   \1,A1                                           
   MOVE.L  (A1),D0                                          
   SUB.L   #2,D0                                            
   MOVE.L  D0,(A1)                                          
   ENDM                                                     

*-----------------------------------------------------------
READ_VECTOR 	MACRO
* Macro to reads 1 word from the vector address             
* Parameters: \1: vector name                              
*             \2: simbol desp                              
*             \3: vector cursor                            
* Modifies  : D0, D1, D2, A1                                
* Always executed after TRAP 51, 52 or 55                   
*-----------------------------------------------------------
   LEA.L    \3,A1                                          
   MOVE.L   (A1),D0                                         
   IF.B    D0 <LT> #0 THEN.S                                
        MOVE.L #'#',D0                                      
   ELSE                                                     
        LEA.L    \1,A1                                     
        ADD.L    D0,A1                                      
        MOVE.W   (A1),D0                                    
        ROR.W    #8,D0                                      
   ENDI                                                     
   MOVE.W   D0,\2(A7)                                      
   ENDM                                                     

*-----------------------------------------------------------
READ_SIMBOL 	MACRO
* Macro to read.                                            
* Parameters: \1: Param1   ;Desplazamiento del origen      
*             \2: Param2   ;Desplazamiento del destino     
* Modifies  : D0, A1                                        
*-----------------------------------------------------------
   CLR.L   D0                                               
   MOVE.L  \2, A1                                          
   MOVE.W  (A1),D0                                          
   MOVE.W  D0, \1(A7)                                      
   ENDM                                                     

*-----------------------------------------------------------
ASIGN_VALUE_SIMBOL MACRO                                    
* Macro to assign value to simbol.                          
* Parameters: \1: Param1   ;DESP                           
*             \2: Param2   ;VALOR                          
* Modifies  : D0                                            
*-----------------------------------------------------------
   CLR.L D0                                                 
   MOVE.W \2, D0                                           
   MOVE.W D0, \1(A7)                                       
   ENDM                                                     

*-----------------------------------------------------------
ASIGN_VALUE_ACCEPTA MACRO                                   
* Macro to assign value to simbol.                          
* Parameters: \1: value                                    
*             \2: accepta address                          
* Modifies  : D0                                            
*-----------------------------------------------------------
   CLR.L   D0                                               
   LEA     \2,A1                                           
   MOVE.W  \1,D0                                           
   MOVE.W  D0,(A1)                                          
   ENDM                                                     

*-----------------------------------------------------------
ASIGN_SIMBOL_SIMBOL MACRO                                   
* Macro to assign simbol to simbol.                         
* Parameters: \1: desp simbol param 1                      
*             \2: desp simbol dest                         
* Modifies  : D0                                            
*-----------------------------------------------------------
   CLR.L   D0                                               
   MOVE.W  \1(A7),D0                                       
   MOVE.W  D0,\2(A7)                                       
   ENDM                                                     

*-----------------------------------------------------------
ASIGN_SIMBOL_ACCEPTA MACRO                                  
* Macro to assign simbol to accepta.                        
* Parameters: \1: desp simbol param 1                      
*             \2: accepta address                          
* Modifies  : D0,A1                                         
*-----------------------------------------------------------
   CLR.L   D0                                               
   LEA     \2,A1                                           
   MOVE.W  \1(A7),D0                                       
   MOVE.W  D0,(A1)                                          
   ENDM                                                     

*-----------------------------------------------------------
ASIGN_ACCEPTA_SIMBOL MACRO                                  
* Macro to assign accepta to simbol.                        
* Parameters: \1: desp simbol param 1                      
*             \2: accepta address                          
* Modifies  : D0,A1                                         
*-----------------------------------------------------------
   CLR.L   D0                                               
   LEA     \2,A1                                           
   MOVE.W  (A1),\1(A7)                                     
   ENDM                                                     

*-----------------------------------------------------------
ASIGN_VALUE_VECTOR MACRO                                    
* Macro to assign value to vector.                          
* Parameters: \1: value                                    
*             \2: vector address                           
*             \3: cursor address                           
* Modifies  : D0,A1                                         
*-----------------------------------------------------------
   LEA     \3,A1                                           
   MOVE.L  (A1),D0                                          
   LEA     \2,A1                                           
   ADD.L   D0,A1                                            
   MOVE.W  \1,D0                                           
   ROR.W   #8,D0                                            
   MOVE.W  D0,(A1)                                          
   ENDM                                                     

*-----------------------------------------------------------
ASIGN_SIMBOL_VECTOR MACRO                                   
* Macro to assign simbol to vector.                         
* Parameters: \1: simbol desp                              
*             \2: vector address                           
*             \3: vector cursor                            
* Modifies  : D0,A1                                         
*-----------------------------------------------------------
   LEA     \3,A1                                           
   MOVE.L  (A1),D0                                          
   LEA     \2,A1                                           
   ADD.L   D0,A1                                            
   MOVE.W  \1(A7),D0                                       
   ROR.W   #8,D0                                            
   MOVE.W  D0,(A1)                                          
   ENDM                                                     

*-----------------------------------------------------------
COMP_IGUAL_SIMBOL 	MACRO
* Macro to compare.                          
* Parameters: \1: Param1
*             \2: Param2
*             \3: Param3 

* Modifies  : D0
*             D1
*-----------------------------------------------------------
        CLR.L D0
        CLR.L D1
* COMPARAR D0 Y D1
        MOVE.W \1(A7), D0
        ; mirar que d0 es correcto
        IF.B   D0 <EQ> #$FF THEN.S
           AND.W   #$FF00,D0
           ROR.L   #8,D0
        ENDI
        MOVE.W \2(A7), D1
        ; mirar que d1 es correcto
        IF.B   D1 <EQ> #$FF THEN.S
           AND.W   #$FF00,D1
           ROR.L   #8,D1
        ENDI
* SI SON IGUALES GUARDAR UN 1 (BOOLEAN TRUE)
        CMP.W D0, D1
        BNE igual_int_falso\@
        MOVE.W  #1,D0
        BRA igual_asig_int_true\@

* SI SON DIFERENTES GUARDAR UN 0 (BOOLEAN FALSE)
igual_int_falso\@
        MOVE.W  #0,D0
igual_asig_int_true\@        
        MOVE.W D0, \3(A7)
        ENDM

*-----------------------------------------------------------
COMP_DIF_SIMBOL 	MACRO
* Macro to compare.                          
* Parameters: \1: Param1
*             \2: Param2
*             \3: Param3 

* Modifies  : D0
*             D1
*-----------------------------------------------------------
        CLR.L D0
        CLR.L D1
* COMPARAR D0 Y D1
        MOVE.W \1(A7), D0
        ; mirar que d0 es correcto
        IF.B   D0 <EQ> #$FF THEN.S
           AND.W   #$FF00,D0
           ROR.L   #8,D0
        ENDI
        MOVE.W \2(A7), D1
        ; mirar que d0 es correcto
        IF.B   D1 <EQ> #$FF THEN.S
           AND.W   #$FF00,D1
           ROR.L   #8,D1
        ENDI
* SI SON iguales GUARDAR UN 0 (BOOLEAN FALSE)
        CMP.W D0, D1
        BNE dif_int_falso\@
        MOVE.W  #0,D0
        BRA dif_asig_int_true\@

* SI SON DIFERENTES GUARDAR UN 1 (BOOLEAN TRUE)
dif_int_falso\@
        MOVE.W  #1,D0
        
dif_asig_int_true\@        
        MOVE.W D0, \3(A7)
		ENDM

; -----------------------------------------------------------------------------
EMPILA      MACRO
; Insertar un simbolo en la pila.
* Parameters: \1: desplazamiento del simbolo

* Modifies  : D0,A0
; -----------------------------------------------------------------------------
            MOVE.W   \1(A7),D0
            MOVE.W   D0,-(A0)
            ENDM

; -----------------------------------------------------------------------------
CIM      MACRO
; Coger el símbolo de la cima de la pila.
* Parameters: \1: desplazamiento del simbolo

* Modifies  : D0
; -----------------------------------------------------------------------------
            MOVE.W   (A0),\1(A7)
            ENDM

; -----------------------------------------------------------------------------
DESEMPILA      MACRO
; Eliminar un simbolo de la pila.

* Modifies  : A0
; -----------------------------------------------------------------------------
            ADD.L    #2,A0
            ENDM

; -----------------------------------------------------------------------------
LOAD_STACK      MACRO
; Prepara la pila en A0.
* Parameters: \1: direccion de la pila

* Modifies  : A0
; -----------------------------------------------------------------------------
            LEA.L  \1, A0
            ADD.L   #2, A0
            ENDM

*-----------------------------------------------------------
BUIDA 	MACRO
* Macro para saber si la pila esta vacia.                  
* Parameters: \1: Dirección de la pila (cuando esta a 0)
*             \2: Simbolo donde se guarda el resultado

* Modifies  : D0,A1
*-----------------------------------------------------------
        LEA.L        \1,A1
* COMPARAR A0 Y A1
* SI SON IGUALES GUARDAR UN 1 (BOOLEAN TRUE)
        CMP.L A0,A1
        BNE igual_int_falso\@
        MOVE.W  #1,D0
        BRA igual_asig_int_true\@

* SI SON DIFERENTES GUARDAR UN 0 (BOOLEAN FALSE)
igual_int_falso\@
        MOVE.W  #0,D0
igual_asig_int_true\@        
        MOVE.W D0, \2(A7)
        ENDM

*-----------------------------------------------------------
NOBUIDA 	MACRO
* Macro para saber si la pila esta vacia.                  
* Parameters: \1: Dirección de la pila (cuando esta a 0)
*             \2: Simbolo donde se guarda el resultado

* Modifies  : D0,A1
*-----------------------------------------------------------
        LEA.L        \1,A1
* COMPARAR A0 Y A1
* SI SON DIFERENTES GUARDAR UN 1 (BOOLEAN TRUE)
        CMP.L A0,A1
        BEQ igual_int_falso\@
        MOVE.W  #1,D0
        BRA igual_asig_int_true\@

* SI SON DIFERENTES GUARDAR UN 0 (BOOLEAN FALSE)
igual_int_falso\@
        MOVE.W  #0,D0
igual_asig_int_true\@        
        MOVE.W D0, \2(A7)
        ENDM

*-----------------------------------------------------------
AND_SIMBOL 	MACRO
* Operación AND entre dos símbolos.                  
* Parameters: \1: Desplazamiento del parametro 1
*             \2: Desplazamiento del parametro 2
*             \3: Desplazamiento del parametro resultado

* Modifies  : D0
*-----------------------------------------------------------
            MOVE.W   \1(A7),D0
            AND.W    \2(A7),D0
            MOVE.W   D0,\3(A7)
            ENDM

*-----------------------------------------------------------
OR_SIMBOL 	MACRO
* Operación OR entre dos símbolos.                  
* Parameters: \1: Desplazamiento del parametro 1
*             \2: Desplazamiento del parametro 2
*             \3: Desplazamiento del parametro resultado

* Modifies  : D0
*-----------------------------------------------------------
            MOVE.W   \1(A7),D0
            OR.W    \2(A7),D0
            MOVE.W   D0,\3(A7)
            ENDM

*-----------------------------------------------------------
SAVE_MEM    MACRO
* Saves the program data in a file             
* Parameters:     \1: filename adress  
*                 \2: register adress
* Modifies  : D0, D1, D2, A1                              
*-----------------------------------------------------------
    ; poner los registros en la memoria
    LEA.L   \2,A1
    MOVE.L  A0,(A1)+
    MOVE.L  A6,(A1)+
    MOVE.L  A7,(A1)
    ; cerrar todos los ficheros (aconsejado)
    MOVE.L  #50,D0                                          
    TRAP    #15
    ; task 57: borra el fichero
    MOVE.L  #57,D0
    LEA.L   \1,A1
    TRAP    #15
    ; task 52: abre el fichero y como no existe lo crea
    LEA.L   \1,A1
    MOVE.L  #52,D0
    TRAP    #15
    ; task 54: escribe el fichero
    MOVE.L  #$4000,A1
    MOVE.L  #$01000000,D2
    SUB.L   #$4000,D2
    MOVE.L  #54,D0
    TRAP    #15
    ; task 56: cierra el fichero
    MOVE.L  #56,D0
    TRAP    #15
    ENDM

*-----------------------------------------------------------
LOAD_MEM    MACRO
* Saves the program data in a file             
* Parameters:     \1: filename adress  
*                 \2: memory adress
*                 \3: regs address
* Modifies  : D0, D1, D2, A1, A2                                
*-----------------------------------------------------------
    ; open file
    LEA.L   \1,A1                                          
    MOVE.L  #51,D0                                          
    TRAP    #15     
    ; read file                                        
    LEA.L   \2,A1     
    MOVE.L  #$01000000,D2
    SUB.L   #$4000,D2
    MOVE.L  #53,D0                                      
    TRAP    #15                                           
    ; close file                                            
    MOVE.L  #50,D0                                          
    TRAP    #15
    ; cargar registros
    LEA.L   \3,A1
    MOVE.L  (A1),A0
    ADD.L   #4,A1
    MOVE.L  (A1),A6
    ADD.L   #4,A1
    MOVE.L  (A1),A7
    ENDM

*-----------------------------------------------------------
NEXT_TRD    MACRO
* Calculates the next thread name             
* Parameters:     \1: thread name adress                      
* Modifies  : D0, D1, D2, D3, D4, D5, A1                               
*----------------------------------------------------------- 
    LEA.L   \1,A1
    MOVE.L  (A1),D0     
    MOVE.L  #0,D4
    MOVE.L  (A1),D3     
    FOR.B D1 = #3 DOWNTO #0 DO.S
        MOVE.B  D3,D2   
        IF.B    D2 <LT> #'9' THEN.S
            ADD.B   #1,D2
            MOVE.B  #0,D1
        ELSE
            MOVE.B  #'0',D2
            ASR.L   #8,D3
        ENDI
        FOR.B   D5 = #1 TO D4 DO.S
            ROR.L   #8,D0
        ENDF
        MOVE.B  D2,D0
        FOR.B   D5 = #1 TO D4 DO.S
            ROL.L   #8,D0
        ENDF
        ADD.B   #1,D4
    ENDF
    MOVE.L  D0,(A1)
    ENDM

*-----------------------------------------------------------
OPEN_FILE    MACRO
* Opens the editor to open a file             
* Parameters:     \1: buffer to save filename address       
* Modifies  : D0, D1, A1, A2, A3                     
*----------------------------------------------------------- 
    MOVE.L   #58,D0  
    MOVE.L   #0,D1   
    MOVE.L   #0,A1   
    MOVE.L   #0,A2   
    LEA.L    \1,A3  
    TRAP     #15     
    ENDM

*-----------------------------------------------------------
SET_RAMIF    MACRO
* Establece si el programa esta en el main o en una rama             
* Parameters:     \1: direccion de ramifica       
*                 \2: valor de ramifica* Modifies  : D0, D1, A1, A2, A3                     
*----------------------------------------------------------- 
    LEA.L    \1,A1  
    MOVE.L   \2,(A1)   
    ENDM

*-----------------------------------------------------------
ASK_RAMIF    MACRO
* Establece si el programa esta en el main o en una rama     
* Parameters:     \1: linea 1 del mensaje                   
*                 \2: linea 2 del mensaje                   
*                 \3: string dos puntos                     
*                 \4: numero de ramificacion                
*                 \5: numero de ramas                       
*                 \6: string separador                      
* Modifies  : D0, D1, A1, A2, A3                             
*----------------------------------------------------------- 
    ; separador
    MOVE.L  #13,D0
    MOVE.L  \6,A1
    TRAP    #15
    
    ; pregunta p1
    MOVE.L  #17,D0
    MOVE.L  \1,A1
    MOVE.L  \4,D1               ; numero de ramificacion
    TRAP    #15
    
    MOVE.L  #6,D0
    MOVE.L  #13,D1 ; CR
    TRAP    #15
    
    MOVE.L  #6,D0
    MOVE.L  #10,D1 ; LF
    TRAP    #15
    
    ;pregunta p2
    MOVE.L  #17,D0
    MOVE.L  \2,A1
    MOVE.L  \5,D1               ; numero de rama
    TRAP    #15
    
    ; pregunta p3
    MOVE.L  #18,D0
    MOVE.L  \3,A1
    TRAP    #15
    
    ; separador
    MOVE.L  #13,D0
    MOVE.L  \6,A1
    TRAP    #15
    ENDM
