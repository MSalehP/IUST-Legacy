/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/30/2022
Author  : 
Company : 
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32.h>

// Declare your global variables here
char a;
char counter1='a', counter2='a', counter3='a', counter4='a', counter5='a', counter6='b' ;
int idx, idx2 ;
//int delay = 0;
// Standard Input/Output functions
#include <stdio.h>
 
unsigned char number (unsigned char digit) {
    if (digit == 0) {
        return 0x3F;
    }
    if (digit == 1) {
        return 0x06;
    }
    if (digit == 2) {
        return 0x5B;
    }
    if (digit == 3) {
        return 0x4F;
    }
    if (digit == 4) {
        return 0x66;
    }
    if (digit == 5) {
        return 0x6D;
    }
    if (digit == 6) {
        return 0x7D;
    }
    if (digit == 7) {
        return 0x07;
    }
    if (digit == 8) {
        return 0x7F;
    }
    if (digit == 9) {
        return 0x6F;
    }
}

void set_number(char c){
    if (c == '0'){
        PORTC = number(0);
    }
    else if (c == '1'){
        PORTC = number(1);
    }
    else if (c == '2'){
        PORTC = number(2);
    }
    else if (c == '3'){
        PORTC = number(3);
    }
    else if (c == '4'){
        PORTC = number(4);
    }
    else if (c == '5'){
        PORTC = number(5);
    }
    else if (c == '6'){
        PORTC = number(6);
    }
    else if (c == '7'){
        PORTC = number(7);
    } 
    else if (c == '8'){
        PORTC = number(8);
    }
    else if (c == '9'){
        PORTC = number(9);
    }
    else {
        PORTC = 0x00;
    }
}

// Timer 0 output compare interrupt service routine
interrupt [TIM0_COMP] void timer0_comp_isr(void)
{
// Place your code here
    idx++;
    idx = idx % 6;
    if (idx == 0) {
        PORTB = 0b10111111;  
        set_number(counter1);
    }
                
    if (idx == 1) {
        PORTB = 0b11011111; 
        set_number(counter2);
    }
                
    if (idx == 2) {
        PORTB = 0b11101111;
        set_number(counter3);
    } 
                
    if (idx == 3) {
        PORTB = 0b11110111;
        set_number(counter4);
    } 
                
    if (idx == 4) {
        PORTB = 0b11111011;
        set_number(counter5);
    } 
                
     if (idx == 5) {
        PORTB = 0b11111101;
        set_number(counter6);
      }   
}

void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
    // Input/Output Ports initialization
    // Port A initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
    PORTA = 0x00;
    DDRA = 0x00;

    // Port B initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
    PORTB = 0x0ff;
    DDRB = 0xff;

    // Port C initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
    PORTC = 0xFF;
    DDRC = 0xFF;

    // Port D initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
    PORTD = 0x00;
    DDRD = 0x00;
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 125.000 kHz
// Mode: Normal top=0xFF
// OC0 output: Disconnected
// Timer Period: 2.048 ms
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (1<<CS00);
TCNT0=0x00;
OCR0=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (1<<OCIE0) | (0<<TOIE0);

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
UBRRH=0x00;
UBRRL=0x33;

// Global enable interrupts
#asm("sei")

while (1)
      {
      // Place your code here
    a = getchar();      
    if (idx2 == 0) {
        counter1 = a;  
    }
                
    if (idx2 == 1) { 
        counter2 = a;
    }
                
    if (idx2 == 2) {
        counter3 = a;
    } 
                
    if (idx2 == 3) {
        counter4 = a;
    } 
                
    if (idx2 == 4) {
        counter5 = a;
    } 
                
     if (idx2 == 5) {
        counter6 = a;
      } 
      idx2++;
      idx2 %= 6;
}
}
