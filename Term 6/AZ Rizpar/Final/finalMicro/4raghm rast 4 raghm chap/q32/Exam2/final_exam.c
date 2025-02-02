/*
Danial Bazmandeh
97521135
*/

#include <mega32.h>

int i1 , j1 , k1 , q1 , i2 , j2 , k2 , q2;
int n = 0 , m = 0;
int s = 0;
int flag = 0;
int flag2 = 1;
char seg[10]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};

interrupt [TIM0_OVF] void timer0_ovf_isr(void) //1ms
{
    // Reinitialize Timer 0 value
    TCNT0=0x83;  
    
    // Place your code here
    flag = 1;
}

interrupt [TIM1_OVF] void timer1_ovf_isr(void) //0.5s
{
    // Reinitialize Timer1 value
    TCNT1H=0xBDC >> 8;
    TCNT1L=0xBDC & 0xff; 
    
    // Place your code here
    if ( flag2 == 0 ) {
        s++;
        n++;
        if (s%2 == 1) m--;
        if (n == 10000) n = 0;
        if (m == -1) m = 9999;
    }
}

void main(void) {

    DDRB = 0xff;
    PORTB = 0xff;
    DDRC = 0xff;
    PORTC = 0x3f;

    // Timer Period: 1 ms
    TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (1<<CS00);
    TCNT0=0x83;
    OCR0=0x00;

    // Timer Period: 0/5 s
    TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
    TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);
    TCNT1H=0x0B;
    TCNT1L=0xDC;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x00;
    OCR1AL=0x00;
    OCR1BH=0x00;
    OCR1BL=0x00;
    TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
    #asm("sei")

    while (1) {
        i1 = (n/1000); // hezargan n - samte rast
        j1 = (n/100)%10;
        k1 = (n/10)%10;
        q1 = (n%10);
        i2 = (m/1000); // hezargan m - samte chap
        j2 = (m/100)%10;
        k2 = (m/10)%10;
        q2 = (m%10);
                    
        PORTB = 0b11111111;
        PORTB = 0b11111110;
        PORTC = seg[i2]; 
                   
        flag=0;
        while (flag != 1);
                   
        PORTB = 0b11111111;
        PORTB = 0b11111101; 
        PORTC = seg[j2];
                   
        flag=0;
        while (flag != 1);
                   
        PORTB = 0b11111111;
        PORTB = 0b11111011; 
        PORTC = seg[k2];
                   
        flag=0;
        while (flag != 1);
                   
        PORTB = 0b11111111;
        PORTB = 0b11110111; 
        PORTC = seg[q2];
                   
        flag=0;
        while (flag != 1);
                   
        PORTB = 0b11111111;
        PORTB = 0b11101111; 
        PORTC = seg[i1];
                   
        flag=0;
        while (flag != 1);
                   
        PORTB = 0b11111111;
        PORTB = 0b11011111; 
        PORTC = seg[j1];
                   
        flag=0;
        while (flag != 1);
                   
        PORTB = 0b11111111;
        PORTB = 0b10111111; 
        PORTC = seg[k1]; 
                   
        flag=0;
        while (flag != 1);
                   
        PORTB = 0b11111111;
        PORTB = 0b01111111; 
        PORTC = seg[q1];
                   
        flag=0;
        while (flag != 1);
                   
        if ( flag2 == 1 ) {
            m = 9999;
            flag2 = 0;
        }
    }
}
