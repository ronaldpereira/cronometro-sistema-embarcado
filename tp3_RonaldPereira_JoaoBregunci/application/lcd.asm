
_lcd_wr:

;lcd.c,29 :: 		void lcd_wr(unsigned char val)
;lcd.c,31 :: 		LPORT=val;
	MOVF       FARG_lcd_wr_val+0, 0
	MOVWF      PORTD+0
;lcd.c,32 :: 		}
L_end_lcd_wr:
	RETURN
; end of _lcd_wr

_lcd_cmdd:

;lcd.c,34 :: 		void lcd_cmdd(unsigned char val)
;lcd.c,36 :: 		LENA=1;
	BSF        PORTE+0, 1
;lcd.c,37 :: 		lcd_wr(val);
	MOVF       FARG_lcd_cmdd_val+0, 0
	MOVWF      FARG_lcd_wr_val+0
	CALL       _lcd_wr+0
;lcd.c,38 :: 		LDAT=0;
	BCF        PORTE+0, 0
;lcd.c,39 :: 		atraso_ms(3);
	MOVLW      3
	MOVWF      FARG_atraso_ms_valor+0
	MOVLW      0
	MOVWF      FARG_atraso_ms_valor+1
	CALL       _atraso_ms+0
;lcd.c,40 :: 		LENA=0;
	BCF        PORTE+0, 1
;lcd.c,41 :: 		atraso_ms(3);
	MOVLW      3
	MOVWF      FARG_atraso_ms_valor+0
	MOVLW      0
	MOVWF      FARG_atraso_ms_valor+1
	CALL       _atraso_ms+0
;lcd.c,42 :: 		LENA=1;
	BSF        PORTE+0, 1
;lcd.c,43 :: 		}
L_end_lcd_cmdd:
	RETURN
; end of _lcd_cmdd

_lcd_dat:

;lcd.c,45 :: 		void lcd_dat(unsigned char val)
;lcd.c,47 :: 		LENA=1;
	BSF        PORTE+0, 1
;lcd.c,48 :: 		lcd_wr(val);
	MOVF       FARG_lcd_dat_val+0, 0
	MOVWF      FARG_lcd_wr_val+0
	CALL       _lcd_wr+0
;lcd.c,49 :: 		LDAT=1;
	BSF        PORTE+0, 0
;lcd.c,50 :: 		atraso_ms(3);
	MOVLW      3
	MOVWF      FARG_atraso_ms_valor+0
	MOVLW      0
	MOVWF      FARG_atraso_ms_valor+1
	CALL       _atraso_ms+0
;lcd.c,51 :: 		LENA=0;
	BCF        PORTE+0, 1
;lcd.c,52 :: 		atraso_ms(3);
	MOVLW      3
	MOVWF      FARG_atraso_ms_valor+0
	MOVLW      0
	MOVWF      FARG_atraso_ms_valor+1
	CALL       _atraso_ms+0
;lcd.c,53 :: 		LENA=1;
	BSF        PORTE+0, 1
;lcd.c,54 :: 		}
L_end_lcd_dat:
	RETURN
; end of _lcd_dat

_lcd_initt:

;lcd.c,56 :: 		void lcd_initt(void)
;lcd.c,58 :: 		LENA=0;
	BCF        PORTE+0, 1
;lcd.c,59 :: 		LDAT=0;
	BCF        PORTE+0, 0
;lcd.c,60 :: 		atraso_ms(20);
	MOVLW      20
	MOVWF      FARG_atraso_ms_valor+0
	MOVLW      0
	MOVWF      FARG_atraso_ms_valor+1
	CALL       _atraso_ms+0
;lcd.c,61 :: 		LENA=1;
	BSF        PORTE+0, 1
;lcd.c,63 :: 		lcd_cmdd(L_CFG);
	MOVLW      56
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;lcd.c,64 :: 		atraso_ms(5);
	MOVLW      5
	MOVWF      FARG_atraso_ms_valor+0
	MOVLW      0
	MOVWF      FARG_atraso_ms_valor+1
	CALL       _atraso_ms+0
;lcd.c,65 :: 		lcd_cmdd(L_CFG);
	MOVLW      56
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;lcd.c,66 :: 		atraso_ms(1);
	MOVLW      1
	MOVWF      FARG_atraso_ms_valor+0
	MOVLW      0
	MOVWF      FARG_atraso_ms_valor+1
	CALL       _atraso_ms+0
;lcd.c,67 :: 		lcd_cmdd(L_CFG); //configura
	MOVLW      56
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;lcd.c,68 :: 		lcd_cmdd(L_OFF);
	MOVLW      8
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;lcd.c,69 :: 		lcd_cmdd(L_ON); //liga
	MOVLW      15
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;lcd.c,70 :: 		lcd_cmdd(L_CLR); //limpa
	MOVLW      1
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;lcd.c,71 :: 		lcd_cmdd(L_CFG); //configura
	MOVLW      56
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;lcd.c,72 :: 		lcd_cmdd(L_L1);
	MOVLW      128
	MOVWF      FARG_lcd_cmdd_val+0
	CALL       _lcd_cmdd+0
;lcd.c,73 :: 		}
L_end_lcd_initt:
	RETURN
; end of _lcd_initt

_lcd_str:

;lcd.c,75 :: 		void lcd_str(char* str)
;lcd.c,77 :: 		unsigned char i=0;
	CLRF       lcd_str_i_L0+0
;lcd.c,79 :: 		while(str[i] != 0)
L_lcd_str0:
	MOVF       lcd_str_i_L0+0, 0
	ADDWF      FARG_lcd_str_str+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_str1
;lcd.c,81 :: 		lcd_dat(str[i]);
	MOVF       lcd_str_i_L0+0, 0
	ADDWF      FARG_lcd_str_str+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_dat_val+0
	CALL       _lcd_dat+0
;lcd.c,82 :: 		i++;
	INCF       lcd_str_i_L0+0, 1
;lcd.c,83 :: 		}
	GOTO       L_lcd_str0
L_lcd_str1:
;lcd.c,84 :: 		}
L_end_lcd_str:
	RETURN
; end of _lcd_str
