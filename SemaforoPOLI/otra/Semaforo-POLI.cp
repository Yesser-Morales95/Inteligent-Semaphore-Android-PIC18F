#line 1 "D:/DOCUMENTOS/ELECTRÓNICA/Unidad de Proyectos/SemaforoPOLI/otra/Semaforo-POLI.c"





 struct State
 {
 unsigned char St1;
 unsigned char St2;
 unsigned char St3;
 unsigned char St4;
 unsigned int delay;
 int next[4];

 };

struct State fsm_sema[] =
 {
 { 0x04, 0x01, 0x04, 0x04, 1000, {1}},
 { 0x04, 0x02, 0x04, 0x04, 1000, {2}},
 { 0x04, 0x04, 0x04, 0x04, 1000, {3}},
 { 0x01, 0x04, 0x04, 0x04, 1000, {4}},
 { 0x02, 0x04, 0x04, 0x04, 1000, {5}},
 { 0x04, 0x04, 0x04, 0x04, 1000, {6}},
 { 0x04, 0x04, 0x01, 0x04, 1000, {7}},
 { 0x04, 0x04, 0x02, 0x04, 1000, {8}},
 { 0x04, 0x04, 0x04, 0x04, 1000, {9}},
 { 0x04, 0x04, 0x04, 0x01, 1000, {10}},
 { 0x04, 0x04, 0x04, 0x02, 1000, {11}},
 { 0x04, 0x04, 0x04, 0x04, 1000, {0}},
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
TRISB = 0x00;
TRISA = 0xFF;
TRISD = 0x00;
PORTB = 0x00;
PORTA= 0x00;
PORTD= 0x00;
 cs = 0;

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);
 uart_rd ='0';
while(1)
 {


 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();

 }


switch(uart_rd) {

 case '0':

 UART1_Write_Text("I have it");
 cs = fsm_sema[cs].next[0];
 PORTB = (fsm_sema[cs].St3 << 4) | fsm_sema[cs].St4 << 1;
 PORTD = (fsm_sema[cs].St2 << 4) | fsm_sema[cs].St1 << 1;
 Vdelay_ms (fsm_sema[cs].delay);
 break;


 case 'A' :
#line 97 "D:/DOCUMENTOS/ELECTRÓNICA/Unidad de Proyectos/SemaforoPOLI/otra/Semaforo-POLI.c"
 PORTB = (0x04 << 4) | 0x04 << 1;
 PORTD = (0x01 << 4) | 0x04 << 1;
 delay_ms (400);
 UART1_Write_Text("I have not ");
 break;

 case 'B' :
 PORTB = (0x04 << 4) | 0x04 << 1;
 PORTD = (0x04 << 4) | 0x01 << 1;
 delay_ms (400);
 UART1_Write_Text("I have all ");
 break;

 case 'C' :
 PORTB = (0x01 << 4) | 0x04 << 1;
 PORTD = (0x04 << 4) | 0x04 << 1;
 delay_ms (400);
 UART1_Write_Text("I have maximun ");

 break;

 case 'D' :
 PORTB = (0x04 << 4) | 0x01 << 1;
 PORTD = (0x04 << 4) | 0x04 << 1;
 delay_ms (400);
 UART1_Write_Text("I have less ");
 break;
}
uart_rd ='0';
 }
 }
