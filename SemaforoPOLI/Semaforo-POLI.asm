
_main:

;Semaforo-POLI.c,39 :: 		void main(void)
;Semaforo-POLI.c,41 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Semaforo-POLI.c,42 :: 		INTCON = 0x90;
	MOVLW       144
	MOVWF       INTCON+0 
;Semaforo-POLI.c,43 :: 		TRISC = 0x80;
	MOVLW       128
	MOVWF       TRISC+0 
;Semaforo-POLI.c,44 :: 		TRISB = 0x00;    //Salida
	CLRF        TRISB+0 
;Semaforo-POLI.c,45 :: 		TRISA = 0xFF;    //Entrada
	MOVLW       255
	MOVWF       TRISA+0 
;Semaforo-POLI.c,46 :: 		TRISD = 0x00;    //Salida
	CLRF        TRISD+0 
;Semaforo-POLI.c,47 :: 		PORTB = 0x00;    // Estado inicial del puerto PORTB
	CLRF        PORTB+0 
;Semaforo-POLI.c,48 :: 		PORTA=  0x00;
	CLRF        PORTA+0 
;Semaforo-POLI.c,49 :: 		PORTD=  0x00;
	CLRF        PORTD+0 
;Semaforo-POLI.c,52 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Semaforo-POLI.c,53 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	NOP
	NOP
;Semaforo-POLI.c,55 :: 		UART1_Write_Text("Start");
	MOVLW       ?lstr1_Semaforo_45POLI+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Semaforo_45POLI+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Semaforo-POLI.c,56 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Semaforo-POLI.c,57 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Semaforo-POLI.c,60 :: 		while(1)
L_main1:
;Semaforo-POLI.c,61 :: 		{    uart_rd = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;Semaforo-POLI.c,62 :: 		Error:
___main_Error:
;Semaforo-POLI.c,71 :: 		while (uart_rd=='A') {
L_main5:
	MOVF        _uart_rd+0, 0 
	XORLW       65
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;Semaforo-POLI.c,74 :: 		uart_rd = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;Semaforo-POLI.c,76 :: 		PORTB = (0x04 << 4)  |  0x04  << 1;
	MOVLW       72
	MOVWF       PORTB+0 
;Semaforo-POLI.c,77 :: 		PORTD = (0x01 << 4)  |  0x04  << 1;
	MOVLW       24
	MOVWF       PORTD+0 
;Semaforo-POLI.c,78 :: 		delay_ms (500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
	NOP
;Semaforo-POLI.c,79 :: 		UART1_Write_Text("I have not ");
	MOVLW       ?lstr2_Semaforo_45POLI+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_Semaforo_45POLI+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Semaforo-POLI.c,80 :: 		if ( uart_rd !='A') {
	MOVF        _uart_rd+0, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;Semaforo-POLI.c,81 :: 		PORTB = (0x04 << 4)  |  0x04  << 1;
	MOVLW       72
	MOVWF       PORTB+0 
;Semaforo-POLI.c,82 :: 		PORTD = (0x02 << 4)  |  0x04  << 1;
	MOVLW       40
	MOVWF       PORTD+0 
;Semaforo-POLI.c,83 :: 		delay_ms (800);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	DECFSZ      R11, 1, 1
	BRA         L_main9
;Semaforo-POLI.c,84 :: 		goto Error;
	GOTO        ___main_Error
;Semaforo-POLI.c,85 :: 		}
L_main8:
;Semaforo-POLI.c,87 :: 		}
	GOTO        L_main5
L_main6:
;Semaforo-POLI.c,89 :: 		while (uart_rd=='B') {
L_main10:
	MOVF        _uart_rd+0, 0 
	XORLW       66
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;Semaforo-POLI.c,90 :: 		uart_rd = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;Semaforo-POLI.c,91 :: 		PORTB = (0x04 << 4)  |  0x04  << 1;
	MOVLW       72
	MOVWF       PORTB+0 
;Semaforo-POLI.c,92 :: 		PORTD = (0x04 << 4)  |  0x01  << 1;
	MOVLW       66
	MOVWF       PORTD+0 
;Semaforo-POLI.c,93 :: 		delay_ms (500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
	NOP
	NOP
;Semaforo-POLI.c,94 :: 		UART1_Write_Text("I have all ");
	MOVLW       ?lstr3_Semaforo_45POLI+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_Semaforo_45POLI+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Semaforo-POLI.c,95 :: 		if ( uart_rd !='B') {
	MOVF        _uart_rd+0, 0 
	XORLW       66
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
;Semaforo-POLI.c,96 :: 		PORTB = (0x04 << 4)  |  0x04  << 1;
	MOVLW       72
	MOVWF       PORTB+0 
;Semaforo-POLI.c,97 :: 		PORTD = (0x04 << 4)  |  0x02  << 1;
	MOVLW       68
	MOVWF       PORTD+0 
;Semaforo-POLI.c,98 :: 		delay_ms (800);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
;Semaforo-POLI.c,99 :: 		goto Error;
	GOTO        ___main_Error
;Semaforo-POLI.c,100 :: 		}
L_main13:
;Semaforo-POLI.c,101 :: 		}
	GOTO        L_main10
L_main11:
;Semaforo-POLI.c,102 :: 		while (uart_rd=='C') {
L_main15:
	MOVF        _uart_rd+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;Semaforo-POLI.c,103 :: 		uart_rd = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;Semaforo-POLI.c,104 :: 		PORTB = (0x01 << 4)  |  0x04  << 1;
	MOVLW       24
	MOVWF       PORTB+0 
;Semaforo-POLI.c,105 :: 		PORTD = (0x04 << 4)  |  0x04  << 1;
	MOVLW       72
	MOVWF       PORTD+0 
;Semaforo-POLI.c,106 :: 		delay_ms (500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	DECFSZ      R11, 1, 1
	BRA         L_main17
	NOP
	NOP
;Semaforo-POLI.c,107 :: 		UART1_Write_Text("I have maximun ");
	MOVLW       ?lstr4_Semaforo_45POLI+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_Semaforo_45POLI+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Semaforo-POLI.c,108 :: 		if ( uart_rd !='C') {
	MOVF        _uart_rd+0, 0 
	XORLW       67
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
;Semaforo-POLI.c,109 :: 		PORTB = (0x02 << 4)  |  0x04  << 1;
	MOVLW       40
	MOVWF       PORTB+0 
;Semaforo-POLI.c,110 :: 		PORTD = (0x04 << 4)  |  0x04  << 1;
	MOVLW       72
	MOVWF       PORTD+0 
;Semaforo-POLI.c,111 :: 		delay_ms (800);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main19:
	DECFSZ      R13, 1, 1
	BRA         L_main19
	DECFSZ      R12, 1, 1
	BRA         L_main19
	DECFSZ      R11, 1, 1
	BRA         L_main19
;Semaforo-POLI.c,112 :: 		goto Error;
	GOTO        ___main_Error
;Semaforo-POLI.c,113 :: 		}
L_main18:
;Semaforo-POLI.c,116 :: 		}
	GOTO        L_main15
L_main16:
;Semaforo-POLI.c,117 :: 		while (uart_rd=='D') {
L_main20:
	MOVF        _uart_rd+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;Semaforo-POLI.c,118 :: 		uart_rd = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;Semaforo-POLI.c,119 :: 		PORTB = (0x04 << 4)  |  0x01  << 1;
	MOVLW       66
	MOVWF       PORTB+0 
;Semaforo-POLI.c,120 :: 		PORTD = (0x04 << 4)  |  0x04  << 1;
	MOVLW       72
	MOVWF       PORTD+0 
;Semaforo-POLI.c,121 :: 		delay_ms (500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	DECFSZ      R12, 1, 1
	BRA         L_main22
	DECFSZ      R11, 1, 1
	BRA         L_main22
	NOP
	NOP
;Semaforo-POLI.c,122 :: 		UART1_Write_Text("I have less ");
	MOVLW       ?lstr5_Semaforo_45POLI+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_Semaforo_45POLI+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Semaforo-POLI.c,123 :: 		if ( uart_rd !='D') {
	MOVF        _uart_rd+0, 0 
	XORLW       68
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
;Semaforo-POLI.c,124 :: 		PORTB = (0x04 << 4)  |  0x02  << 1;
	MOVLW       68
	MOVWF       PORTB+0 
;Semaforo-POLI.c,125 :: 		PORTD = (0x04 << 4)  |  0x04  << 1;
	MOVLW       72
	MOVWF       PORTD+0 
;Semaforo-POLI.c,126 :: 		delay_ms (800);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main24:
	DECFSZ      R13, 1, 1
	BRA         L_main24
	DECFSZ      R12, 1, 1
	BRA         L_main24
	DECFSZ      R11, 1, 1
	BRA         L_main24
;Semaforo-POLI.c,127 :: 		goto Error;
	GOTO        ___main_Error
;Semaforo-POLI.c,128 :: 		}
L_main23:
;Semaforo-POLI.c,129 :: 		}
	GOTO        L_main20
L_main21:
;Semaforo-POLI.c,132 :: 		}
L_main4:
;Semaforo-POLI.c,134 :: 		cs = fsm_sema[cs].next[0];
	MOVLW       14
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _cs+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _fsm_sema+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_fsm_sema+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _cs+0 
;Semaforo-POLI.c,135 :: 		PORTB = (fsm_sema[cs].St3 << 4)  |  fsm_sema[cs].St4  << 1;
	MOVLW       0
	MOVWF       R1 
	MOVLW       14
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _fsm_sema+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_fsm_sema+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       2
	ADDWF       R4, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R3 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	MOVLW       3
	ADDWF       R4, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	IORWF       R3, 0 
	MOVWF       PORTB+0 
;Semaforo-POLI.c,136 :: 		PORTD = (fsm_sema[cs].St2 << 4)  |  fsm_sema[cs].St1  << 1;
	MOVLW       1
	ADDWF       R4, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R3 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	IORWF       R3, 0 
	MOVWF       PORTD+0 
;Semaforo-POLI.c,137 :: 		Vdelay_ms (fsm_sema[cs].delay);
	MOVLW       4
	ADDWF       R4, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;Semaforo-POLI.c,140 :: 		}
	GOTO        L_main1
;Semaforo-POLI.c,141 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
