#line 1 "C:/Users/Ronald/Desktop/TP3SB/application/TP3SB.c"
#line 1 "c:/users/ronald/desktop/tp3sb/application/lcd.h"
#line 43 "c:/users/ronald/desktop/tp3sb/application/lcd.h"
void lcd_initt(void);
void lcd_cmdd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(char* str);
#line 1 "c:/users/ronald/desktop/tp3sb/application/atraso.h"
#line 26 "c:/users/ronald/desktop/tp3sb/application/atraso.h"
void atraso_ms(unsigned int valor);
#line 4 "C:/Users/Ronald/Desktop/TP3SB/application/TP3SB.c"
unsigned short contador = 0;
int segundos = 0;
int pause = 0;
int estado = 0;
char txt[15];
int i;

void interrupt()
{
 if(INTCON.T0IF == 1)
 {
 INTCON.T0IF = 0;
 contador++;
 TMR0 = 12;
 }
}

void main()
{
 TRISB = 0x01;
 TRISD = 0x00;
 TRISE = 0x00;
 PORTB = 0x00;

 OPTION_REG.T0CS = 0;
 OPTION_REG.PSA = 0;

 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 INTCON.T0IE = 1;

 OPTION_REG.PS0 = 1;
 OPTION_REG.PS1 = 1;
 OPTION_REG.PS2 = 1;


 TMR0 = 12;

 txt[0] = 'T';
 txt[1] = 'E';
 txt[2] = 'M';
 txt[3] = 'P';
 txt[4] = 'O';
 txt[5] = ' ';
 txt[6] = 'T';
 txt[7] = 'O';
 txt[8] = 'T';
 txt[9] = 'A';
 txt[10] = 'L';

 lcd_initt();
 lcd_cmdd(_LCD_CURSOR_OFF);
 lcd_str("PRESSIONE S1                            PARA INICIAR  ");

 while(1)
 {
 if(contador == 16)
 {
 contador = 0;
 TMR0 = 12;

 if(estado == 1)
 segundos++;
 }

 else if(!PORTB.RB0 && estado == 0)
 {
 estado = 1;

 lcd_cmdd( 0x01 );
 lcd_str("PRESSIONE S1                            PARA PARAR  ");
 }

 else if(!PORTB.RB0 && estado == 1)
 {
 estado = 2;

 lcd_cmdd( 0x01 );
 lcd_str(txt);
 delay_ms(2000);
 lcd_cmdd( 0x01 );
 IntToStr(segundos, txt);
 lcd_str(txt);
 lcd_str(" s");
 }

 }
}
