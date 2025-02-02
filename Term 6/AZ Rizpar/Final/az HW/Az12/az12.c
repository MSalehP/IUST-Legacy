//zahra hosseini 96531226
#include <mega32.h>
#include <delay.h>
#include <glcd.h>
#include <font5x7.h>

int center_x=63;
int center_y=31;
int Direction=0;
int radius=4;
void ballMoving(void);
void main(void)
{
int i=1500;
GLCDINIT_t glcd_init_data;

glcd_init_data.font=font5x7;


glcd_init(&glcd_init_data);
glcd_clear();
delay_ms(50);
 //std id and full name
 glcd_outtextxy(0,0,"Zahra Hosseini");
 glcd_outtextxy(0,53,"96531226");
 delay_ms(i);
 glcd_clear();
  //HOME
glcd_setlinestyle(2,GLCD_LINE_SOLID);
      glcd_line(55,63,91,63); 
      glcd_line(91,63,91,32);
      glcd_line(55,63,55,32);
      glcd_line(55,32,45,32);  
      glcd_line(101,32,91,32); 
      glcd_line(73,0,101,32);
      glcd_line(73,0,59,14); 
      glcd_line(52,22,45,32);  
      glcd_line(52,22,52,7);  
      glcd_line(59,14,59,7);
      glcd_line(59,7,62,7);
      glcd_line(52,7,49,7); 
      glcd_line(62,7,62,3);
      glcd_line(49,7,49,3);                 
      glcd_line(49,3,62,3);
      delay_ms(i);
      glcd_clear();  
   
   
while (1)
      {
       glcd_setcolor(0);
       glcd_circle(center_x,center_y,4);  
      
       ballMoving();
         
       glcd_setcolor(1);
       glcd_circle(center_x,center_y,4); 
       delay_ms(50);
      }

}
void ballMoving()
{
if(Direction==0)
        {   
           center_y=center_y-radius;
           center_x=center_x+radius;
           if(center_x+radius>=127)
           {
            Direction=3;
           }
              if(center_y-radius<=0)
           {
            Direction=1;
           }
        }  
          else if(Direction==1)
        {   
           center_y=center_y+radius;
           center_x=center_x+radius;
           if(center_x+radius>=127)
           {
            Direction=2;
           }
              if(center_y+radius>=63)
           {
            Direction=0;
           }
        } 
            else if(Direction==2)
        {   
           center_y=center_y+radius;
           center_x=center_x-radius;
           if(center_x-radius<=0)
           {
            Direction=1;
           }
              if(center_y+radius>=63)
           {
            Direction=3;
           }
        }
        else
        {   
           center_y=center_y-radius;
           center_x=center_x-radius;
           if(center_x-radius<=0)
           {
            Direction=0;
           }
              if(center_y-radius<=0)
           {
            Direction=2;
           }
        }
}