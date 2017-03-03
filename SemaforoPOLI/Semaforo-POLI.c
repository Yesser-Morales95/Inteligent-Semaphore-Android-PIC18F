//------------  Semaforo Control Policiaco ------------- //
 // ELABORADO POR YESSER MORALES y KELLER JIRON         //
 // Maquina de estado                                 //
 // 07-12-2015   //

  struct  State
   {
   unsigned char St1;
   unsigned char St2;
   unsigned char St3;
   unsigned char St4;
   unsigned int delay;
            int next[4];      // NEXT [11] [10] [01] [00]

   };                          //     MSB            LSB

struct  State fsm_sema[] =
    {                      //LSB    MSB
       { 0x04,  0x01, 0x04,  0x04,  3000,  {1}},
       { 0x04,  0x02, 0x04,  0x04,  800,   {2}},
       { 0x04,  0x04, 0x04,  0x04,  500,   {3}},
       { 0x01,  0x04, 0x04,  0x04,  3000,  {4}},
       { 0x02,  0x04, 0x04,  0x04,  800,   {5}},
       { 0x04,  0x04, 0x04,  0x04,  500,   {6}},
       { 0x04,  0x04, 0x01,  0x04,  3000,  {7}},
       { 0x04,  0x04, 0x02,  0x04,  800,   {8}},
       { 0x04,  0x04, 0x04,  0x04,  500,   {9}},
       { 0x04,  0x04, 0x04,  0x01,  3000,  {10}},
       { 0x04,  0x04, 0x04,  0x02,  800,   {11}},
       { 0x04,  0x04, 0x04,  0x04,  500,   {0}},
    };

unsigned char cs;
char uart_rd;
char uart_rd1;
unsigned int i;
unsigned int get,CNT;

void main(void)
 {
ADCON1 = 0x0F;
INTCON = 0x90;
TRISC = 0x80;
TRISB = 0x00;    //Salida
TRISA = 0xFF;    //Entrada
TRISD = 0x00;    //Salida
PORTB = 0x00;    // Estado inicial del puerto PORTB
PORTA=  0x00;
PORTD=  0x00;


    UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");
  UART1_Write(10);
  UART1_Write(13);
  //uart_rd ='0';
   //uart_rd = UART1_Read();
while(1)
 {    uart_rd = UART1_Read();
 Error:

 while(uart_rd == 'A'||'B'||'C'||'D')
 {

   // If data is received,
          // read the received data,
      // uart_rd1 = uart_rd;

   while (uart_rd=='A') {
   
   
   uart_rd = UART1_Read();
       // Calle 1 con pase  2,3 y 4 en ALTO
       PORTB = (0x04 << 4)  |  0x04  << 1;
       PORTD = (0x01 << 4)  |  0x04  << 1;
        delay_ms (500);
     UART1_Write_Text("I have not ");
     if ( uart_rd !='A') {
     PORTB = (0x04 << 4)  |  0x04  << 1;
       PORTD = (0x02 << 4)  |  0x04  << 1;
         delay_ms (800);
    goto Error;
}

                     }

     while (uart_rd=='B') {
      uart_rd = UART1_Read();
       PORTB = (0x04 << 4)  |  0x04  << 1;
       PORTD = (0x04 << 4)  |  0x01  << 1;
       delay_ms (500);
       UART1_Write_Text("I have all ");
       if ( uart_rd !='B') {
     PORTB = (0x04 << 4)  |  0x04  << 1;
       PORTD = (0x04 << 4)  |  0x02  << 1;
         delay_ms (800);
    goto Error;
}
                          }
      while (uart_rd=='C') {
       uart_rd = UART1_Read();
       PORTB = (0x01 << 4)  |  0x04  << 1;
       PORTD = (0x04 << 4)  |  0x04  << 1;
       delay_ms (500);
       UART1_Write_Text("I have maximun ");
       if ( uart_rd !='C') {
     PORTB = (0x02 << 4)  |  0x04  << 1;
       PORTD = (0x04 << 4)  |  0x04  << 1;
         delay_ms (800);
    goto Error;
}


                           }
 while (uart_rd=='D') {
  uart_rd = UART1_Read();
     PORTB = (0x04 << 4)  |  0x01  << 1;
       PORTD = (0x04 << 4)  |  0x04  << 1;
       delay_ms (500);
       UART1_Write_Text("I have less ");
      if ( uart_rd !='D') {
     PORTB = (0x04 << 4)  |  0x02  << 1;
       PORTD = (0x04 << 4)  |  0x04  << 1;
         delay_ms (800);
    goto Error;
}
                     }
                       break;
                       continue;
           }

        cs = fsm_sema[cs].next[0];
       PORTB = (fsm_sema[cs].St3 << 4)  |  fsm_sema[cs].St4  << 1;
       PORTD = (fsm_sema[cs].St2 << 4)  |  fsm_sema[cs].St1  << 1;
       Vdelay_ms (fsm_sema[cs].delay);


}
    }