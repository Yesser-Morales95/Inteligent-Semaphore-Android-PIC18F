
_main:

;Semaforo-POLI.c,39 :: 		void main(void)
;Semaforo-POLI.c,44 :: 		ADCON1 = 0x0F;
	MOVLW      15
	MOVWF      ADCON1+0
;Semaforo-POLI.c,45 :: 		INTCON = 0x90;
	MOVLW      144
	MOVWF      INTCON+0
;Semaforo-POLI.c,46 :: 		TRISC = 0x80;
	MOVLW      128
	MOVWF      TRISC+0
;Semaforo-POLI.c,47 :: 		TRISB = 0x00;    //Salida
	CLRF       TRISB+0
;Semaforo-POLI.c,48 :: 		TRISA = 0xFF;    //Entrada
	MOVLW      255
	MOVWF      TRISA+0
;Semaforo-POLI.c,49 :: 		TRISD = 0x00;    //Salida
	CLRF       TRISD+0
;Semaforo-POLI.c,50 :: 		PORTB = 0x00;    // Estado inicial del puerto PORTB
	CLRF       PORTB+0
;Semaforo-POLI.c,51 :: 		PORTA=  0x00;
	CLRF       PORTA+0
;Semaforo-POLI.c,52 :: 		PORTD=  0x00;
	CLRF       PORTD+0
;Semaforo-POLI.c,53 :: 		cs = 0;
	CLRF       _cs+0
;Semaforo-POLI.c,55 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Semaforo-POLI.c,56 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	NOP
	NOP
;Semaforo-POLI.c,58 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr1_Semaforo_45POLI+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Semaforo-POLI.c,59 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Semaforo-POLI.c,60 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Semaforo-POLI.c,61 :: 		uart_rd ='0';
	MOVLW      48
	MOVWF      _uart_rd+0
;Semaforo-POLI.c,62 :: 		while(1)
L_main1:
;Semaforo-POLI.c,66 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;Semaforo-POLI.c,67 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Semaforo-POLI.c,69 :: 		}                    // Endless loop
L_main3:
;Semaforo-POLI.c,72 :: 		switch(uart_rd) {
	GOTO       L_main4
;Semaforo-POLI.c,74 :: 		case '0':     // Sistema trabajando automaticamente no se detecta ningun caracter
L_main6:
;Semaforo-POLI.c,76 :: 		UART1_Write_Text("I have it");
	MOVLW      ?lstr2_Semaforo_45POLI+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Semaforo-POLI.c,77 :: 		cs = fsm_sema[cs].next[0];
	MOVLW      14
	MOVWF      R0+0
	MOVF       _cs+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      _fsm_sema+0
	ADDWF      R0+0, 1
	MOVLW      6
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _cs+0
;Semaforo-POLI.c,78 :: 		PORTB = (fsm_sema[cs].St3 << 4)  |  fsm_sema[cs].St4  << 1;
	MOVLW      14
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	ADDLW      _fsm_sema+0
	MOVWF      R4+0
	MOVLW      2
	ADDWF      R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R3+0
	RLF        R3+0, 1
	BCF        R3+0, 0
	RLF        R3+0, 1
	BCF        R3+0, 0
	RLF        R3+0, 1
	BCF        R3+0, 0
	RLF        R3+0, 1
	BCF        R3+0, 0
	MOVLW      3
	ADDWF      R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      R3+0, 0
	MOVWF      PORTB+0
;Semaforo-POLI.c,79 :: 		PORTD = (fsm_sema[cs].St2 << 4)  |  fsm_sema[cs].St1  << 1;
	INCF       R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R3+0
	RLF        R3+0, 1
	BCF        R3+0, 0
	RLF        R3+0, 1
	BCF        R3+0, 0
	RLF        R3+0, 1
	BCF        R3+0, 0
	RLF        R3+0, 1
	BCF        R3+0, 0
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      R3+0, 0
	MOVWF      PORTD+0
;Semaforo-POLI.c,80 :: 		Vdelay_ms (fsm_sema[cs].delay);
	MOVLW      4
	ADDWF      R4+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_VDelay_ms_Time_ms+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_VDelay_ms_Time_ms+1
	CALL       _VDelay_ms+0
;Semaforo-POLI.c,81 :: 		break;
	GOTO       L_main5
;Semaforo-POLI.c,84 :: 		case 'A' :     // Calle 1 con pase  2,3 y 4 en ALTO
L_main7:
;Semaforo-POLI.c,97 :: 		PORTB = (0x04 << 4)  |  0x04  << 1;
	MOVLW      72
	MOVWF      PORTB+0
;Semaforo-POLI.c,98 :: 		PORTD = (0x01 << 4)  |  0x04  << 1;
	MOVLW      24
	MOVWF      PORTD+0
;Semaforo-POLI.c,99 :: 		delay_ms (400);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
;Semaforo-POLI.c,100 :: 		UART1_Write_Text("I have not ");
	MOVLW      ?lstr3_Semaforo_45POLI+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Semaforo-POLI.c,101 :: 		break;
	GOTO       L_main5
;Semaforo-POLI.c,103 :: 		case 'B' :
L_main9:
;Semaforo-POLI.c,104 :: 		PORTB = (0x04 << 4)  |  0x04  << 1;
	MOVLW      72
	MOVWF      PORTB+0
;Semaforo-POLI.c,105 :: 		PORTD = (0x04 << 4)  |  0x01  << 1;
	MOVLW      66
	MOVWF      PORTD+0
;Semaforo-POLI.c,106 :: 		delay_ms (400);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
;Semaforo-POLI.c,107 :: 		UART1_Write_Text("I have all ");
	MOVLW      ?lstr4_Semaforo_45POLI+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Semaforo-POLI.c,108 :: 		break;
	GOTO       L_main5
;Semaforo-POLI.c,110 :: 		case 'C' :
L_main11:
;Semaforo-POLI.c,111 :: 		PORTB = (0x01 << 4)  |  0x04  << 1;
	MOVLW      24
	MOVWF      PORTB+0
;Semaforo-POLI.c,112 :: 		PORTD = (0x04 << 4)  |  0x04  << 1;
	MOVLW      72
	MOVWF      PORTD+0
;Semaforo-POLI.c,113 :: 		delay_ms (400);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
;Semaforo-POLI.c,114 :: 		UART1_Write_Text("I have maximun ");
	MOVLW      ?lstr5_Semaforo_45POLI+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Semaforo-POLI.c,116 :: 		break;
	GOTO       L_main5
;Semaforo-POLI.c,118 :: 		case 'D' :
L_main13:
;Semaforo-POLI.c,119 :: 		PORTB = (0x04 << 4)  |  0x01  << 1;
	MOVLW      66
	MOVWF      PORTB+0
;Semaforo-POLI.c,120 :: 		PORTD = (0x04 << 4)  |  0x04  << 1;
	MOVLW      72
	MOVWF      PORTD+0
;Semaforo-POLI.c,121 :: 		delay_ms (400);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
;Semaforo-POLI.c,122 :: 		UART1_Write_Text("I have less ");
	MOVLW      ?lstr6_Semaforo_45POLI+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Semaforo-POLI.c,123 :: 		break;
	GOTO       L_main5
;Semaforo-POLI.c,124 :: 		}
L_main4:
	MOVF       _uart_rd+0, 0
	XORLW      48
	BTFSC      STATUS+0, 2
	GOTO       L_main6
	MOVF       _uart_rd+0, 0
	XORLW      65
	BTFSC      STATUS+0, 2
	GOTO       L_main7
	MOVF       _uart_rd+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _uart_rd+0, 0
	XORLW      67
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _uart_rd+0, 0
	XORLW      68
	BTFSC      STATUS+0, 2
	GOTO       L_main13
L_main5:
;Semaforo-POLI.c,125 :: 		uart_rd ='0';
	MOVLW      48
	MOVWF      _uart_rd+0
;Semaforo-POLI.c,126 :: 		}
	GOTO       L_main1
;Semaforo-POLI.c,127 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
