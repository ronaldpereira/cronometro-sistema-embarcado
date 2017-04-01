#line 1 "C:/Users/Ronald/Desktop/TP3SB/application/lcd.c"
#line 1 "c:/users/ronald/desktop/tp3sb/application/lcd.h"
#line 43 "c:/users/ronald/desktop/tp3sb/application/lcd.h"
void lcd_initt(void);
void lcd_cmdd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(char* str);
#line 1 "c:/users/ronald/desktop/tp3sb/application/atraso.h"
#line 26 "c:/users/ronald/desktop/tp3sb/application/atraso.h"
void atraso_ms(unsigned int valor);
#line 29 "C:/Users/Ronald/Desktop/TP3SB/application/lcd.c"
void lcd_wr(unsigned char val)
{
  PORTD =val;
}

void lcd_cmdd(unsigned char val)
{
  PORTE.RE1 =1;
 lcd_wr(val);
  PORTE.RE0 =0;
 atraso_ms(3);
  PORTE.RE1 =0;
 atraso_ms(3);
  PORTE.RE1 =1;
}

void lcd_dat(unsigned char val)
{
  PORTE.RE1 =1;
 lcd_wr(val);
  PORTE.RE0 =1;
 atraso_ms(3);
  PORTE.RE1 =0;
 atraso_ms(3);
  PORTE.RE1 =1;
}

void lcd_initt(void)
{
  PORTE.RE1 =0;
  PORTE.RE0 =0;
 atraso_ms(20);
  PORTE.RE1 =1;

 lcd_cmdd( 0x38 );
 atraso_ms(5);
 lcd_cmdd( 0x38 );
 atraso_ms(1);
 lcd_cmdd( 0x38 );
 lcd_cmdd( 0x08 );
 lcd_cmdd( 0x0F );
 lcd_cmdd( 0x01 );
 lcd_cmdd( 0x38 );
 lcd_cmdd( 0x80 );
}

void lcd_str(char* str)
{
 unsigned char i=0;

 while(str[i] != 0)
 {
 lcd_dat(str[i]);
 i++;
 }
}
