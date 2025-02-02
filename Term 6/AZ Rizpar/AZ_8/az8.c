//Mohamad Saleh Pazhand 400521171

#include <mega32.h>
#include <alcd.h>
#include <stdint.h>
#include <string.h>
#include <delay.h>
#include <math.h>

#define KEYPAD_R1 PORTD.0
#define KEYPAD_R2 PORTD.1
#define KEYPAD_R3 PORTD.2
#define KEYPAD_R4 PORTD.3
#define KEYPAD_C1 PIND.4
#define KEYPAD_C2 PIND.5
#define KEYPAD_C3 PIND.6
#define KEYPAD_C4 PIND.7

#define KEYPAD_NUM0 0
#define KEYPAD_NUM1 1
#define KEYPAD_NUM2 2
#define KEYPAD_NUM3 3
#define KEYPAD_NUM4 4
#define KEYPAD_NUM5 5
#define KEYPAD_NUM6 6
#define KEYPAD_NUM7 7
#define KEYPAD_NUM8 8
#define KEYPAD_NUM9 9
#define KEYPAD_DIV  10
#define KEYPAD_MUL  11
#define KEYPAD_PLS  12
#define KEYPAD_MNS  13
#define KEYPAD_EQU  14
#define KEYPAD_ON   15

void static Calculator(unsigned char key_res);
unsigned char keypad_scan();
unsigned char key_res;

int flag1 = 0,flag2 = 0,flag3 = 0,flag4 = 0;
int result[10];
int num[10] = {0,1,2,3,4,5,6,7,8,9};
int i,digits=0,res=0;
int operand=-1,equal=-1;
char op = '';
char output[11] = "0123456789";
void main(void)
{   
    lcd_init(16);
    lcd_clear();
    lcd_gotoxy(5,0);
    lcd_puts("WELCOME");
    delay_ms(1500);
    lcd_clear();
    
    while (1)
    {
        key_res = keypad_scan();
        Calculator(key_res);
    }
}

 void static Calculator(unsigned char key_res){

 
        if(key_res != 255)
        {
            while(keypad_scan() != 255);
            
            if(operand == -1)
                operand = 0;   
                
            if(operand != -1 && equal == -1 && flag1 == 1)
                equal = 0; 
                
            delay_ms(20);
            if (key_res == KEYPAD_DIV){
                lcd_putchar('%');
                flag1 = 1;
                op = '%';
            }
            else if (key_res == KEYPAD_MUL){
                lcd_putchar('*');
                flag1 = 1;
                op = '*';
            }
            else if (key_res == KEYPAD_MNS){
                lcd_putchar('-');
                flag1 = 1;
                op = '-';
            }
            else if (key_res == KEYPAD_PLS){
                lcd_putchar('+');
                flag1 = 1;
                op = '+';
            }
            else if (key_res == KEYPAD_EQU){
                if (flag3 == 1)
                    operand *= -1;  
                if (flag4 == 1)
                    equal *= -1;
                lcd_putchar('=');
                if (op == '%')
                    res = operand/equal;
                else if(op == '*')
                    res = operand*equal;
                else if(op == '-')
                    res = operand-equal;
                else if(op == '+')
                    res = operand+equal;
                digits=0;
                if(res <0){
                    flag2 = 1;
                    res = -res;
                }
                for(i = 0;i < 11;i++){
                    result[i] = res%10;
                    res = res / 10;
                    if(res ==0)
                        break;
                    digits++;
                }
                if (flag2 == 1)
                    lcd_putchar('-');
                for(i = digits;i>=0;i--){
                    lcd_putchar(output[result[i]]);
                }
            }
            else if (key_res == KEYPAD_ON)
            {
                lcd_clear();
                lcd_gotoxy(0,0);
                operand = -1;
                equal = -1;
                flag1 = 0;
                op = '';
                res = 0;
                digits=0;
                flag2 = 0;
                flag3 = 0;
                flag4 = 0;
            }
            else{
                lcd_putchar(key_res + 48);
                if (flag1 == 0){
                    operand = (operand*10)+num[key_res];
                }
                else {
                    equal = (equal*10)+num[key_res];
                }
            }
        }

}

unsigned char keypad_scan()
{
    unsigned char result=255;
    ////////////////////////  ROW1 ////////////////////////
    KEYPAD_R1 = 1; KEYPAD_R2 = 0;  KEYPAD_R3 = 0;  KEYPAD_R4 = 0; //set Row1 for Keypad
    delay_ms(5);
    if (KEYPAD_C1)
        result = KEYPAD_NUM7;
    else if (KEYPAD_C2)
        result = KEYPAD_NUM8;
    else if (KEYPAD_C3)
        result = KEYPAD_NUM9;
    else if (KEYPAD_C4)
        result = KEYPAD_DIV;
    
    ////////////////////////  ROW2 ////////////////////////
    KEYPAD_R1 = 0; KEYPAD_R2 = 1;  KEYPAD_R3 = 0;  KEYPAD_R4 = 0; //set Row2 for Keypad
    delay_ms(5);
    if (KEYPAD_C1)
        result = KEYPAD_NUM4;
    else if (KEYPAD_C2)
        result = KEYPAD_NUM5;
    else if (KEYPAD_C3)
        result = KEYPAD_NUM6;
    else if (KEYPAD_C4)
        result = KEYPAD_MUL;
    
    ////////////////////////  ROW3 ////////////////////////
    KEYPAD_R1 = 0; KEYPAD_R2 = 0;  KEYPAD_R3 = 1;  KEYPAD_R4 = 0; //set Row3 for Keypad
    delay_ms(5);
    if (KEYPAD_C1)
        result = KEYPAD_NUM1;
    else if (KEYPAD_C2)
        result = KEYPAD_NUM2;
    else if (KEYPAD_C3)
        result = KEYPAD_NUM3;
    else if (KEYPAD_C4)
        result = KEYPAD_MNS;
    
    ////////////////////////  ROW4 ////////////////////////
    KEYPAD_R1 = 0; KEYPAD_R2 = 0;  KEYPAD_R3 = 0;  KEYPAD_R4 = 1; //set Row4 for Keypad
    delay_ms(5);
    if (KEYPAD_C1)
        result = KEYPAD_ON;
    else if (KEYPAD_C2)
        result = KEYPAD_NUM0;
    else if (KEYPAD_C3)
        result = KEYPAD_EQU;
    else if (KEYPAD_C4)
        result = KEYPAD_PLS;
    
    return result;
}