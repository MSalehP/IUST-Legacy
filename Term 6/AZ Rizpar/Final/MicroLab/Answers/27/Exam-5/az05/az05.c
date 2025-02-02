/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.4a Advanced
Automatic Program Generator
© Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : az05
Version : 
Date    : 5/31/2020
Author  : Alireza
Company : aaa
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*****************************************************/

#include <mega32.h>
#include <delay.h>
// Declare your global variables here


unsigned char image_code[16]=
{
	0xEF,	//	0001		# # # . # # # # 
	0xEF,	//	0002		# # # . # # # # 
	0xAB,	//	0003		# . # . # . # # 
	0xC7,	//	0004		# # . . . # # # 
	0xEF,	//	0005		# # # . # # # # 
	0xFF,	//	0006		# # # # # # # # 
	0xFF,	//	0007		# # # # # # # # 
	0xFF,	//	0008		# # # # # # # # 
	0xFF,	//	0009		# # # # # # # # 
	0xFF,	//	000A		# # # # # # # # 
	0xFF,	//	000B		# # # # # # # # 
	0xFF,	//	000C		# # # # # # # # 
	0xFF,	//	000D		# # # # # # # # 
	0xFF,	//	000E		# # # # # # # # 
	0xFF,	//	000F		# # # # # # # # 
	0xFF 	//	0010		# # # # # # # #  
};

void main(void)
{
// Declare your local variables here
unsigned char col,scan, temp, R;
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTB=0x00;
DDRB=0xFF;

// Port C initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTC=0x00;
DDRC=0xFF;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0xFF;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=FFh
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;


while (1)
    { 
        scan=0b10000000;
        for(col=0; col<8; col++)
        {  
            PORTB =  scan;
            PORTD =  0b00000000;
            PORTC = image_code[col];
            delay_ms(1);
            PORTB =  0b00000000;
            PORTD =  scan; 
            PORTC = image_code[col +8];
            delay_ms(1);
            scan = scan >> 1;
            //scan = scan | 1;
        }
        delay_ms(15);
        temp = image_code[15];
        for(R=15;R>0;R--)
        {
            image_code[R] = image_code[R-1];    
        }
        image_code[0] = temp;
    };
}
