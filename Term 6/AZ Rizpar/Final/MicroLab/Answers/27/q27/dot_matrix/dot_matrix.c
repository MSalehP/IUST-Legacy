#include <mega32.h>
#include <delay.h>

const unsigned char imagee_code[35]=
{
    0xFF,    //    0001        # # # # # # # # 
    0x81,    //    0002        # . . . . . . # 
    0xEE,    //    0003        # # # . # # # . 
    0xEE,    //    0004        # # # . # # # . 
    0xEE,    //    0005        # # # . # # # . 
    0x81,    //    0006        # . . . . . . # 
    0xFF,    //    0007        # # # # # # # #
     
    0x80,    //    0008        # . . . . . . . 
    0xBF,    //    0009        # . # # # # # # 
    0xBF,    //    000A        # . # # # # # # 
    0xBF,    //    000B        # . # # # # # # 
    0xBF,    //    000C        # . # # # # # # 
    0xFF,    //    000D        # # # # # # # # 
    0xFF,    //    000E        # # # # # # # # 
    0xBE,    //    000F        # . # # # # # . 
    0x80,    //    0010        # . . . . . . . 
    0xBE,    //    0011        # . # # # # # . 
    0xFF,	//	0012		# # # # # # # # 
	0xFF,	//	0013		# # # # # # # # 
	0xFF,	//	0014		# # # # # # # # 
	0xFF,	//	0015		# # # # # # # # 
	0xFF,	//	0016		# # # # # # # # 
	0xFF,	//	0017		# # # # # # # # 
	0xFF,	//	0018		# # # # # # # # 
	0xFF,	//	0019		# # # # # # # # 
	0xFF,	//	001A		# # # # # # # # 
	0xFF,	//	001B		# # # # # # # # 
	0xFF,	//	001C		# # # # # # # # 
	0xFF,	//	001D		# # # # # # # # 
	0xFF,	//	001E		# # # # # # # # 
	0xFF,	//	001F		# # # # # # # # 
	0xFF,	//	0020		# # # # # # # # 
	0xFF,	//	0021		# # # # # # # # 
	0xFF,	//	0022		# # # # # # # # 
	0xFF 	//	0023		# # # # # # # # 
};

const unsigned char image_code[35]=
{
	0x01,	//	0001		. . . . . . . # 
	0x6D,	//	0002		. # # . # # . # 
	0x6D,	//	0003		. # # . # # . # 
	0x6D,	//	0004		. # # . # # . # 
	0x7D,	//	0005		. # # # # # . # 
	0xFF,	//	0006		# # # # # # # # 
	0x00,	//	0007		. . . . . . . . 
	0xF7,	//	0008		# # # # . # # # 
	0xF7,	//	0009		# # # # . # # # 
	0x0F,	//	000A		. . . . # # # # 
	0xFF,	//	000B		# # # # # # # # 
	0x67,	//	000C		. # # . . # # # 
	0x57,	//	000D		. # . # . # # # 
	0x37,	//	000E		. . # # . # # # 
	0xFF,	//	000F		# # # # # # # # 
	0xBF,	//	0010		# . # # # # # # 
	0x57,	//	0011		. # . # . # # # 
	0x57,	//	0012		. # . # . # # # 
	0x0F,	//	0013		. . . . # # # # 
	0xFF,	//	0014		# # # # # # # # 
	0x07,	//	0015		. . . . . # # # 
	0xF7,	//	0016		# # # # . # # # 
	0xF7,	//	0017		# # # # . # # # 
	0x0F,	//	0018		. . . . # # # # 
	0xFF,	//	0019		# # # # # # # # 
	0xFF,	//	001A		# # # # # # # # 
	0xFF,	//	001B		# # # # # # # # 
	0xFF,	//	001C		# # # # # # # # 
	0xFF,	//	001D		# # # # # # # # 
	0xFF,	//	001E		# # # # # # # # 
	0xFF,	//	001F		# # # # # # # # 
	0xFF,	//	0020		# # # # # # # # 
	0xFF,	//	0021		# # # # # # # # 
	0xFF,	//	0022		# # # # # # # # 
	0xFF 	//	0023		# # # # # # # # 
};
void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port C initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

while (1)
      {
      unsigned int i, offset = 18;
      for (; offset < 18 + 35; offset++) {
            int repeat = 0;
            for (; repeat < 5; repeat++) {
                unsigned long scan = 1;
                PORTA = 0; //C9-C16
                for (i = 0; i < 8; i++) { 
                    PORTD = scan & 0xff;
                    PORTC = image_code[(offset + i) % 35];
                    scan <<= 1;                           
                    delay_ms(2);
                }
                PORTD = 0; //C1-C8
                for (i = 8; i < 16; i++) {
                    PORTA = scan >> 8;
                    PORTC = image_code[(offset + i) % 35];
                    scan <<= 1;
                    delay_ms(2);
                }
            }      
      }

      }
}
