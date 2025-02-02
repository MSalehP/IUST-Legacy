/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project :
Version :
Date    : 11/25/2024
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
#include <delay.h>
#include <stdbool.h>

// Declare your global variables here
#define BUTTON_PIN PIND2
#define LED_PIN PORTB0

bool button_pressed = true;

// External Interrupt 0 service routine
interrupt[EXT_INT0] void ext_int0_isr(void)
{
    delay_ms(5);
    if (!(PIND & (1 << BUTTON_PIN)))
    {
        button_pressed = !button_pressed;
    }
}

void main(void)
{

    DDRB = (0 << DDB7) | (0 << DDB6) | (0 << DDB5) | (0 << DDB4) | (0 << DDB3) | (0 << DDB2) | (0 << DDB1) | (1 << DDB0);
    PORTB = (0 << PORTB7) | (0 << PORTB6) | (0 << PORTB5) | (0 << PORTB4) | (0 << PORTB3) | (0 << PORTB2) | (0 << PORTB1) | (0 << PORTB0);

    DDRD = (0 << DDD7) | (0 << DDD6) | (0 << DDD5) | (0 << DDD4) | (0 << DDD3) | (0 << DDD2) | (0 << DDD1) | (0 << DDD0);
    PORTD = (0 << PORTD7) | (0 << PORTD6) | (0 << PORTD5) | (0 << PORTD4) | (0 << PORTD3) | (1 << PORTD2) | (0 << PORTD1) | (0 << PORTD0);

    // External Interrupt(s) initialization
    // INT0: On
    // INT0 Mode: Falling Edge
    // INT1: Off
    // INT2: Off
    GICR |= (0 << INT1) | (1 << INT0) | (0 << INT2);
    MCUCR = (0 << ISC11) | (0 << ISC10) | (1 << ISC01) | (0 << ISC00);
    MCUCSR = (0 << ISC2);
    GIFR = (0 << INTF1) | (1 << INTF0) | (0 << INTF2);

// Global enable interrupts
#asm("sei")
    PORTB &= ~(1 << LED_PIN);
    while (1)
    {
        // Place your code here
        if (button_pressed)
        {
            PORTB |= (1 << LED_PIN);
        }
        else
        {
            PORTB &= ~(1 << LED_PIN);
        }
    }
}