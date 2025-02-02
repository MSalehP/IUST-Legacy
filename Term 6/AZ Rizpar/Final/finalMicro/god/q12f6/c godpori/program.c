#include <mega32.h>
#include <stdio.h>
#include <stdlib.h>
#include <delay.h>

int dip = 0;

void main(void) {
    DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
    PORTA=(1<<PORTA7) | (1<<PORTA6) | (1<<PORTA5) | (1<<PORTA4) | (1<<PORTA3) | (1<<PORTA2) | (1<<PORTA1) | (1<<PORTA0);

    UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
    UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
    UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
    UBRRH=0x00;
    UBRRL=0x33;

    puts("in the name of god\n\r");
    while (1) {
        int x = PINA;
        if(x!=dip){
            int second_digit = (x >> 4) & 0x0F;
            int first_digit = x & 0x0F;

            if (second_digit < 10) {
                putchar(second_digit + '0');
            } else {
                putchar(second_digit - 10 + 'A');
            }

            if (first_digit < 10) {
                putchar(first_digit + '0');
            } else {
                putchar(first_digit - 10 + 'A');
            }

            puts("\n\r");
            dip = x;
        }
    }
}
