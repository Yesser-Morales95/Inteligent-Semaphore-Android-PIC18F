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
       { 0x04,  0x01, 0x04,  0x04,  1000,  {1}},
       { 0x04,  0x02, 0x04,  0x04,  1000,  {2}},
       { 0x04,  0x04, 0x04,  0x04,  1000,  {3}},
       { 0x01,  0x04, 0x04,  0x04,  1000,  {4}},
       { 0x02,  0x04, 0x04,  0x04,  1000,  {5}},
       { 0x04,  0x04, 0x04,  0x04,  1000,  {6}},
       { 0x04,  0x04, 0x01,  0x04,  1000,  {7}},
       { 0x04,  0x04, 0x02,  0x04,  1000,  {8}},
       { 0x04,  0x04, 0x04,  0x04,  1000,  {9}},
       { 0x04,  0x04, 0x04,  0x01,  1000,  {10}},
       { 0x04,  0x04, 0x04,  0x02,  1000,  {11}},
       { 0x04,  0x04, 0x04,  0x04,  1000,  {0}},
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
 cs = 0;

    UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");
  UART1_Write(10);
  UART1_Write(13);
   uart_rd ='0';
while(1)
   {
   

   if (UART1_Data_Ready()) {     // If data is received,
      uart_rd = UART1_Read();     // read the received data,
      // uart_rd1 = uart_rd;
                           }                    // Endless loop


switch(uart_rd) {

   case '0':     // Sistema trabajando automaticamente no se detecta ningun caracter
                 //Proveniente de la comunicacion RS232
    UART1_Write_Text("I have it");
        cs = fsm_sema[cs].next[0];
       PORTB = (fsm_sema[cs].St3 << 4)  |  fsm_sema[cs].St4  << 1;
       PORTD = (fsm_sema[cs].St2 << 4)  |  fsm_sema[cs].St1  << 1;
       Vdelay_ms (fsm_sema[cs].delay);
     break;
     
     
   case 'A' :     // Calle 1 con pase  2,3 y 4 en ALTO
   
        // cs = fsm_sema[cs].next[0];
       
/*PORTB = (0x04 << 4)  |  0x04  << 1;
       PORTD = (0x04 << 4)  |  0x04  << 1;
       delay_ms (700);
       PORTB = (0x04 << 4)  |  0x04  << 1;
       PORTD = (0x02 << 4)  |  0x04  << 1;
        delay_ms (200);*/
     //uart_rd1 = UART1_Read();
       //  while ('A'==uart_rd1) {
        //  uart_rd1 = UART1_Read();
       PORTB = (0x04 << 4)  |  0x04  << 1;
       PORTD = (0x01 << 4)  |  0x04  << 1;
        delay_ms (400);
      UART1_Write_Text("I have not ");
      break;
     
   case 'B' :
       PORTB = (0x04 << 4)  |  0x04  << 1;
       PORTD = (0x04 << 4)  |  0x01  << 1;
       delay_ms (400);
       UART1_Write_Text("I have all ");
     break;

     case 'C' :
     PORTB = (0x01 << 4)  |  0x04  << 1;
       PORTD = (0x04 << 4)  |  0x04  << 1;
       delay_ms (400);
       UART1_Write_Text("I have maximun ");
       
     break;
     
     case 'D' :
     PORTB = (0x04 << 4)  |  0x01  << 1;
       PORTD = (0x04 << 4)  |  0x04  << 1;
       delay_ms (400);
       UART1_Write_Text("I have less ");
     break;
}
uart_rd ='0';
  }
 }