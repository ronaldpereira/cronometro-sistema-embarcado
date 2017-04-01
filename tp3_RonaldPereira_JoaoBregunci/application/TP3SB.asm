
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TP3SB.c,11 :: 		void interrupt()
;TP3SB.c,13 :: 		if(INTCON.T0IF == 1) // Verifica a flag de overflow
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;TP3SB.c,15 :: 		INTCON.T0IF = 0; // Reseta a flag de overflow
	BCF        INTCON+0, 2
;TP3SB.c,16 :: 		contador++;
	INCF       _contador+0, 1
;TP3SB.c,17 :: 		TMR0 = 12;
	MOVLW      12
	MOVWF      TMR0+0
;TP3SB.c,18 :: 		}
L_interrupt0:
;TP3SB.c,19 :: 		}
L_end_interrupt:
L__interrupt17:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TP3SB.c,21 :: 		void main()
;TP3SB.c,23 :: 		TRISB = 0x01;
	MOVLW      1
	MOVWF      TRISB+0
;TP3SB.c,24 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;TP3SB.c,25 :: 		TRISE = 0x00;
	CLRF       TRISE+0
;TP3SB.c,26 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;TP3SB.c,28 :: 		OPTION_REG.T0CS = 0; // Incremento via oscilador
	BCF        OPTION_REG+0, 5
;TP3SB.c,29 :: 		OPTION_REG.PSA = 0; // Ligando o prescaler do TIMER0
	BCF        OPTION_REG+0, 3
;TP3SB.c,31 :: 		INTCON.GIE = 1; // Ligando a chave geral da interrupcao
	BSF        INTCON+0, 7
;TP3SB.c,32 :: 		INTCON.PEIE = 1; // Ligando a chave dos perifericos
	BSF        INTCON+0, 6
;TP3SB.c,33 :: 		INTCON.T0IE = 1; // Ligando a interrupcao do TIMER0
	BSF        INTCON+0, 5
;TP3SB.c,35 :: 		OPTION_REG.PS0 = 1; // Bit 0 do prescaler igual a 1
	BSF        OPTION_REG+0, 0
;TP3SB.c,36 :: 		OPTION_REG.PS1 = 1; // Bit 1 do prescaler igual a 1
	BSF        OPTION_REG+0, 1
;TP3SB.c,37 :: 		OPTION_REG.PS2 = 1; // Bit 2 do prescaler igual a 1
	BSF        OPTION_REG+0, 2
;TP3SB.c,40 :: 		TMR0 = 12; // Carga inicial = 12
	MOVLW      12
	MOVWF      TMR0+0
;TP3SB.c,42 :: 		txt[0] = 'T';
	MOVLW      84
	MOVWF      _txt+0
;TP3SB.c,43 :: 		txt[1] = 'E';
	MOVLW      69
	MOVWF      _txt+1
;TP3SB.c,44 :: 		txt[2] = 'M';
	MOVLW      77
	MOVWF      _txt+2
;TP3SB.c,45 :: 		txt[3] = 'P';
	MOVLW      80
	MOVWF      _txt+3
;TP3SB.c,46 :: 		txt[4] = 'O';
	MOVLW      79
	MOVWF      _txt+4
;TP3SB.c,47 :: 		txt[5] = ' ';
	MOVLW      32
	MOVWF      _txt+5
;TP3SB.c,48 :: 		txt[6] = 'T';
	MOVLW      84
	MOVWF      _txt+6
;TP3SB.c,49 :: 		txt[7] = 'O';
	MOVLW      79
	MOVWF      _txt+7
;TP3SB.c,50 :: 		txt[8] = 'T';
	MOVLW      84
	MOVWF      _txt+8
;TP3SB.c,51 :: 		txt[9] = 'A';
	MOVLW      65
	MOVWF      _txt+9
;TP3SB.c,52 :: 		txt[10] = 'L';
	MOVLW      76
	MOVWF      _txt+10
;TP3SB.c,54 :: 		lcd_initt(); // Inicializa o LCD
	CALL       _lcd_initt+0
;TP3SB.c,55 :: 		lcd_cmdd(_LCD_CURSOR_OFF); // Desliga o cursor do LCD
	MOVLW      12
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;TP3SB.c,56 :: 		lcd_str("PRESSIONE S1                            PARA INICIAR  ");
	MOVLW      ?lstr1_TP3SB+0
	MOVWF      FARG_lcd_str_str+0
	CALL       _lcd_str+0
;TP3SB.c,58 :: 		while(1)
L_main1:
;TP3SB.c,60 :: 		if(contador == 16) // contador = 16 = 1s
	MOVF       _contador+0, 0
	XORLW      16
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;TP3SB.c,62 :: 		contador = 0;
	CLRF       _contador+0
;TP3SB.c,63 :: 		TMR0 = 12;
	MOVLW      12
	MOVWF      TMR0+0
;TP3SB.c,65 :: 		if(estado == 1) // Cronometro iniciou
	MOVLW      0
	XORWF      _estado+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main19
	MOVLW      1
	XORWF      _estado+0, 0
L__main19:
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;TP3SB.c,66 :: 		segundos++;
	INCF       _segundos+0, 1
	BTFSC      STATUS+0, 2
	INCF       _segundos+1, 1
L_main4:
;TP3SB.c,67 :: 		}
	GOTO       L_main5
L_main3:
;TP3SB.c,69 :: 		else if(!PORTB.RB0 && estado == 0)
	BTFSC      PORTB+0, 0
	GOTO       L_main8
	MOVLW      0
	XORWF      _estado+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main20
	MOVLW      0
	XORWF      _estado+0, 0
L__main20:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
L__main15:
;TP3SB.c,71 :: 		estado = 1;
	MOVLW      1
	MOVWF      _estado+0
	MOVLW      0
	MOVWF      _estado+1
;TP3SB.c,73 :: 		lcd_cmdd(L_CLR);
	MOVLW      1
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;TP3SB.c,74 :: 		lcd_str("PRESSIONE S1                            PARA PARAR  ");
	MOVLW      ?lstr2_TP3SB+0
	MOVWF      FARG_lcd_str_str+0
	CALL       _lcd_str+0
;TP3SB.c,75 :: 		}
	GOTO       L_main9
L_main8:
;TP3SB.c,77 :: 		else if(!PORTB.RB0 && estado == 1)
	BTFSC      PORTB+0, 0
	GOTO       L_main12
	MOVLW      0
	XORWF      _estado+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main21
	MOVLW      1
	XORWF      _estado+0, 0
L__main21:
	BTFSS      STATUS+0, 2
	GOTO       L_main12
L__main14:
;TP3SB.c,79 :: 		estado = 2;
	MOVLW      2
	MOVWF      _estado+0
	MOVLW      0
	MOVWF      _estado+1
;TP3SB.c,81 :: 		lcd_cmdd(L_CLR);
	MOVLW      1
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;TP3SB.c,82 :: 		lcd_str(txt);
	MOVLW      _txt+0
	MOVWF      FARG_lcd_str_str+0
	CALL       _lcd_str+0
;TP3SB.c,83 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;TP3SB.c,84 :: 		lcd_cmdd(L_CLR);
	MOVLW      1
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;TP3SB.c,85 :: 		IntToStr(segundos, txt);
	MOVF       _segundos+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _segundos+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;TP3SB.c,86 :: 		lcd_str(txt);
	MOVLW      _txt+0
	MOVWF      FARG_lcd_str_str+0
	CALL       _lcd_str+0
;TP3SB.c,87 :: 		lcd_str(" s");
	MOVLW      ?lstr3_TP3SB+0
	MOVWF      FARG_lcd_str_str+0
	CALL       _lcd_str+0
;TP3SB.c,88 :: 		}
L_main12:
L_main9:
L_main5:
;TP3SB.c,90 :: 		}
	GOTO       L_main1
;TP3SB.c,91 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
