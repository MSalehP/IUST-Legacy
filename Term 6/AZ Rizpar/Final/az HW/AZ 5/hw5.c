/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.4a Advanced
Automatic Program Generator
© Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/31/2020
Author  : Zahra Hosseini 96531226
Company : 
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


const unsigned char image_code[79]=
{
    0xFF,    //    0001        # # # # # # # # 
    0xFF,    //    0002        # # # # # # # # 
    0xFF,    //    0003        # # # # # # # # 
    0xFF,    //    0004        # # # # # # # # 
    0xFF,    //    0005        # # # # # # # # 
    0xFF,    //    0006        # # # # # # # # 
    0xFF,    //    0007        # # # # # # # # 
    0xFF,    //    0008        # # # # # # # # 
    0xFF,    //    0009        # # # # # # # # 
    0xFF,    //    000A        # # # # # # # # 
    0xFF,    //    000B        # # # # # # # # 
    0xFF,    //    000C        # # # # # # # # 
    0xFF,    //    000D        # # # # # # # # 
    0xFF,    //    000E        # # # # # # # # 
    0xFF,    //    000F        # # # # # # # # 
    0xFF,    //    0010        # # # # # # # # 
    0x07,    //    0011        . . . . . # # # 
    0x03,    //    0012        . . . . . . # # 
    0xD9,    //    0013        # # . # # . . # 
    0xDC,    //    0014        # # . # # # . . 
    0xD9,    //    0015        # # . # # . . # 
    0x03,    //    0016        . . . . . . # # 
    0x07,    //    0017        . . . . . # # # 
    0xFF,    //    0018        # # # # # # # # 
    0x00,    //    0019        . . . . . . . . 
    0x00,    //    001A        . . . . . . . . 
    0x6E,    //    001B        . # # . # # # . 
    0x6E,    //    001C        . # # . # # # . 
    0x6E,    //    001D        . # # . # # # . 
    0x6E,    //    001E        . # # . # # # . 
    0x11,    //    001F        . . . # . . . # 
    0xFF,    //    0020        # # # # # # # # 
    0xC3,    //    0021        # # . . . . # # 
    0x81,    //    0022        # . . . . . . # 
    0x3C,    //    0023        . . # # # # . . 
    0x7E,    //    0024        . # # # # # # . 
    0x7E,    //    0025        . # # # # # # . 
    0x7E,    //    0026        . # # # # # # . 
    0xBD,    //    0027        # . # # # # . # 
    0xFF,    //    0028        # # # # # # # # 
    0x00,    //    0029        . . . . . . . . 
    0x00,    //    002A        . . . . . . . . 
    0x7E,    //    002B        . # # # # # # . 
    0x7E,    //    002C        . # # # # # # . 
    0x7E,    //    002D        . # # # # # # . 
    0xBD,    //    002E        # . # # # # . # 
    0xC3,    //    002F        # # . . . . # # 
    0xFF,    //    0030        # # # # # # # # 
    0x00,    //    0031        . . . . . . . . 
    0x00,    //    0032        . . . . . . . . 
    0x76,    //    0033        . # # # . # # . 
    0x76,    //    0034        . # # # . # # . 
    0x76,    //    0035        . # # # . # # . 
    0x76,    //    0036        . # # # . # # . 
    0x7E,    //    0037        . # # # # # # . 
    0xFF,    //    0038        # # # # # # # # 
    0x00,    //    0039        . . . . . . . . 
    0x00,    //    003A        . . . . . . . . 
    0xF6,    //    003B        # # # # . # # . 
    0xF6,    //    003C        # # # # . # # . 
    0xF6,    //    003D        # # # # . # # . 
    0xF6,    //    003E        # # # # . # # . 
    0xFE,    //    003F        # # # # # # # . 
    0xFF,    //    0040        # # # # # # # # 
    0xFF,    //    0041        # # # # # # # # 
    0xFF,    //    0042        # # # # # # # # 
    0xFF,    //    0043        # # # # # # # # 
    0xFF,    //    0044        # # # # # # # # 
    0xFF,    //    0045        # # # # # # # # 
    0xFF,    //    0046        # # # # # # # # 
    0xFF,    //    0047        # # # # # # # # 
    0xFF,    //    0048        # # # # # # # # 
    0xFF,    //    0049        # # # # # # # # 
    0xFF,    //    004A        # # # # # # # # 
    0xFF,    //    004B        # # # # # # # # 
    0xFF,    //    004C        # # # # # # # # 
    0xFF,    //    004D        # # # # # # # # 
    0xFF,    //    004E        # # # # # # # # 
    0xFF     //    004F        # # # # # # # # 
};
void main(void)
{
// Declare your local variables here
  unsigned char Col,Scan,Refresh,Index,S;

PORTA=0x00;
DDRA=0x00;

PORTB=0x00;
DDRB=0xFF;

PORTC=0x00;
DDRC=0xFF;

PORTD=0x00;
DDRD=0xFF;

TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;


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
      // Place your code here
          
           for(S=8;S<72;S++)
        {
          for(Refresh=0;Refresh<5;Refresh++)
          {
          Scan=0b00000001;
          for(Col=0;Col<8;Col++)
          {   
          
          
          Index=Col+S;  
          PORTB=Scan;
          PORTC=image_code[Index] ;
              delay_ms(4);
          PORTB=0x00;
          PORTD=Scan;
          PORTC=image_code[Index-8] ;
          delay_ms(2);
            
           PORTD=0x00;
         Scan=Scan<<1;
         }
         
          
               
          }
          }
         
          
          
          
          
      };
}