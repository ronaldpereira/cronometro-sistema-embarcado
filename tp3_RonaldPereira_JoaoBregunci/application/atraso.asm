
_atraso_ms:

;atraso.c,28 :: 		void atraso_ms(unsigned int valor)
;atraso.c,33 :: 		for (i =0; i< valor; i++)
	CLRF       R1+0
	CLRF       R1+1
L_atraso_ms0:
	MOVF       FARG_atraso_ms_valor+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__atraso_ms7
	MOVF       FARG_atraso_ms_valor+0, 0
	SUBWF      R1+0, 0
L__atraso_ms7:
	BTFSC      STATUS+0, 0
	GOTO       L_atraso_ms1
;atraso.c,36 :: 		for (j =0 ; j < 200; j++)
	CLRF       R3+0
L_atraso_ms3:
	MOVLW      200
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_atraso_ms4
	INCF       R3+0, 1
;atraso.c,38 :: 		}
	GOTO       L_atraso_ms3
L_atraso_ms4:
;atraso.c,33 :: 		for (i =0; i< valor; i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;atraso.c,39 :: 		}
	GOTO       L_atraso_ms0
L_atraso_ms1:
;atraso.c,40 :: 		}
L_end_atraso_ms:
	RETURN
; end of _atraso_ms
