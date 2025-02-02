;
; lab2.asm
;
; Created: 5/09/2020 16:25:36 PM
; Author :  Zahra Hosseini 96531226
;



.include "m32def.inc"




        LDI        R16,0xFF
        OUT        DDRC,R16        ;PORTC as output
        OUT        DDRD,R16        ;PORTD as output
        OUT        PORTA,R16        ;Enabling Pullup Resistor on PORTA 
        LDI        R16,0x00
        OUT        DDRA,R16        ;PORTA as input
 
        LDI        R30,00
        LDI        R31,00

  
DISPLY: MOV        R17,R30
        MOV        R24,R31
        LDI        R20,0
        LDI        R21,0
        LDI        R22,0
        LDI        R23,0
        LDI		   R29,30

          
            LDI R21,0  
           
            MOV        R17,R30
            MOV        R24,R31
    D1:     CPI        R17,10
            BRLO    D2
            LDI        R18,10
            SUB        R17,R18
            LDI        R19,01
            ADD        R21,R19            ;Dahgan
            RJMP    D1
    D2:     MOV        R22,R17            ;Yekan
           


            LDI        R23,0
    D4:     CPI        R24,10
            BRLO    D3
            LDI        R18,10
            SUB        R24,R18
            LDI        R19,01
            ADD        R23,R19            ;HEZAREGAN
            RJMP    D4
    D3:     MOV        R20,R24            ;SADEGAN
            
H:    
            LDI        R16,0b11110111     ;displaying Yekan
            OUT        PORTD,R16 
         
            MOV        R16,R22
            CALL    CONVERT
            OUT        PORTC,R16
            CALL    DELAY 
             
        
            LDI        R16,0b11111011    ;displaying Dahgan
            OUT        PORTD,R16
          
            MOV        R16,R21
            CALL    CONVERT
            OUT        PORTC,R16
            CALL    DELAY
           
        
            LDI        R16,0b11111101    ;displaying Sadgan
            OUT        PORTD,R16
            MOV        R16,R20
            CALL    CONVERT
            OUT        PORTC,R16
            CALL    DELAY 
            
            
            LDI        R16,0b11111110    ;displaying HEZAREGAN
            OUT        PORTD,R16 
            MOV        R16,R23
            CALL    CONVERT
            OUT        PORTC,R16
            CALL    DELAY
       
            DEC R29                      ;; HAR DELAY BARABAR 3.125ms *4*335 TAGHRIBAN BARABAR 1s
			BRNE H
           
            IN		R25,PINA            ;; TAAIN VORODI
            CPI      R25,0b00000000 
            BRNE  DS1
            RJMP     DS0
   


       
            

  

DS0:      CPI R31,99                 ;; AGAR DS BARABAR OFF BASHAD SOODI MISHOMARAD
          BRNE  INCREM              ;;AGAR SHMARANDE 9999 BASHAD 0000 MISHAVAD
          CPI R30,99
          BRNE  GO2
          LDI R31,00
          LDI R30,00
          JMP DISPLY
    INCREM:	CPI R30,99
            BRNE  GO2
            LDI R30,00
            INC R31
            JMP DISPLY
    GO2:		INC R30
                JMP DISPLY











              
         
DS1:      CPI R31,00            ;; AGAR DS BARABAR ON BASHAD NOZOLI MISHOMARAD
          BRNE  DECRE           ;;AGAR SHMARANDE 0000 BASHAD 9999 MISHAVAD
          CPI R30,00
          BRNE  GO1
          LDI R31,99
          LDI R30,99
          JMP DISPLY
    DECRE:	CPI R30,00
            BRNE  GO1
            LDI R30,99
            DEC R31
            JMP DISPLY
    GO1:		DEC R30
                JMP DISPLY


    





DELAY: 	    LDI R26,1                         ;; DELAY BARABAR 200*25*1*5*8MHz =3.125ms
LO1:		LDI R27,200
LO2:		LDI R28,25
LO3:
			NOP
			NOP
			DEC R28
			BRNE LO3
			
			DEC R27
			BRNE LO2
			
			DEC R26
			BRNE LO1
			RET
        
        
CONVERT:                ;converts a digit to 7seg code 
        CPI        R16,0
        BRNE    C1
        LDI        R16,0x3F
        RET
C1:        CPI        R16,1
        BRNE    C2
        LDI        R16,0x06
        RET
C2:        CPI        R16,2
        BRNE    C3
        LDI        R16,0x5B
        RET
C3:        CPI        R16,3
        BRNE    C4
        LDI        R16,0x4F
        RET
C4:        CPI        R16,4
        BRNE    C5
        LDI        R16,0x66
        RET
C5:        CPI        R16,5
        BRNE    C6
        LDI        R16,0x6D
        RET
C6:        CPI        R16,6
        BRNE    C7
        LDI        R16,0x7D
        RET
C7:        CPI        R16,7
        BRNE    C8
        LDI        R16,0x07
        RET
C8:        CPI        R16,8
        BRNE    C9
        LDI        R16,0x7F
        RET
C9:        CPI        R16,9
        BRNE    C10
        LDI        R16,0x6F
C10:    RET
                                
            
            

