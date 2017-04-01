#include "lcd.h"
#include "atraso.h"

unsigned short contador = 0; // Contador auxiliar do timer
int segundos = 0; // Contador em segundos
int pause = 0; // Auxiliar para a interrupção
int estado = 0; // Auxiliar para o pause do cronometro
char txt[15]; // String de saida do LCD
int i;

void interrupt()
{
    if(INTCON.T0IF == 1) // Verifica a flag de overflow
    {
        INTCON.T0IF = 0; // Reseta a flag de overflow
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

    OPTION_REG.T0CS = 0; // Incremento via oscilador
    OPTION_REG.PSA = 0; // Ligando o prescaler do TIMER0

    INTCON.GIE = 1; // Ligando a chave geral da interrupcao
    INTCON.PEIE = 1; // Ligando a chave dos perifericos
    INTCON.T0IE = 1; // Ligando a interrupcao do TIMER0

    OPTION_REG.PS0 = 1; // Bit 0 do prescaler igual a 1
    OPTION_REG.PS1 = 1; // Bit 1 do prescaler igual a 1
    OPTION_REG.PS2 = 1; // Bit 2 do prescaler igual a 1
    // Prescaler em 256

    TMR0 = 12; // Carga inicial = 12
    
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

    lcd_initt(); // Inicializa o LCD
    lcd_cmdd(_LCD_CURSOR_OFF); // Desliga o cursor do LCD
    lcd_str("PRESSIONE S1                            PARA INICIAR  ");
    
    while(1)
    {
        if(contador == 16) // contador = 16 = 1s
        {
            contador = 0;
            TMR0 = 12;
            
            if(estado == 1) // Cronometro iniciou
                segundos++;
        }

        else if(!PORTB.RB0 && estado == 0)
        {
            estado = 1;

            lcd_cmdd(L_CLR);
            lcd_str("PRESSIONE S1                            PARA PARAR  ");
        }
        
        else if(!PORTB.RB0 && estado == 1)
        {
            estado = 2;
            
            lcd_cmdd(L_CLR);
            lcd_str(txt);
            delay_ms(2000);
            lcd_cmdd(L_CLR);
            IntToStr(segundos, txt);
            lcd_str(txt);
            lcd_str(" s");
        }

    }
}