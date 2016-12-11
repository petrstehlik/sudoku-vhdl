/*******************************************************************************
   main.c: ....
   Copyright (C) 2015 Brno University of Technology,
                      Faculty of Information Technology

   LICENSE TERMS

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:
   1. Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
   2. Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the
      distribution.
   3. All advertising materials mentioning features or use of this software
      or firmware must display the following acknowledgement:

        This product includes software developed by the University of
        Technology, Faculty of Information Technology, Brno and its
        contributors.

   4. Neither the name of the Company nor the names of its contributors
      may be used to endorse or promote products derived from this
      software without specific prior written permission.

   This software or firmware is provided ``as is'', and any express or implied
   warranties, including, but not limited to, the implied warranties of
   merchantability and fitness for a particular purpose are disclaimed.
   In no event shall the company or contributors be liable for any
   direct, indirect, incidental, special, exemplary, or consequential
   damages (including, but not limited to, procurement of substitute
   goods or services; loss of use, data, or profits; or business
   interruption) however caused and on any theory of liability, whether
   in contract, strict liability, or tort (including negligence or
   otherwise) arising in any way out of the use of this software, even
   if advised of the possibility of such damage.

   $Id$


*******************************************************************************/
#include <fitkitlib.h>
#include <stdlib.h>
#include <thermometer/thermometer.h>
//#include <time.h>

#define S 9
#define BRAM_BASE 0


int grid[4][81] = { 
   {3, 2, 9, 5, 6, 1, 8, 7, 4, 6, 1, 7, 8, 2, 4, 5, 3, 9, 4, 5, 8, 3, 9, 7, 1, 2, 6, 1, 7, 4, 2, 3, 6, 9, 5, 8, 8, 6, 5, 7, 1, 9, 2, 4, 3, 2, 9, 3, 4, 5, 8, 7, 6, 1, 5, 8, 2, 9, 4, 3, 6, 1, 7, 9, 3, 1, 6, 7, 5, 4, 8, 2, 7, 4, 6, 1, 8, 2, 3, 9, 5},
   {4, 5, 9, 2, 8, 6, 7, 3, 1, 6, 7, 1, 3, 4, 9, 2, 8, 5, 3, 8, 2, 1, 5, 7, 6, 9, 4, 9, 4, 3, 5, 6, 2, 1, 7, 8, 7, 1, 6, 8, 9, 4, 3, 5, 2, 8, 2, 5, 7, 3, 1, 4, 6, 9, 1, 6, 8, 9, 2, 3, 5, 4, 7, 5, 3, 7, 4, 1, 8, 9, 2, 6, 2, 9, 4, 6, 7, 5, 8, 1, 3},
   {5, 4, 6, 1, 8, 7, 9, 3, 2, 9, 8, 2, 4, 5, 3, 6, 7, 1, 3, 1, 7, 2, 9, 6, 4, 8, 5, 7, 2, 8, 9, 1, 4, 3, 5, 6, 1, 6, 5, 8, 3, 2, 7, 4, 9, 4, 3, 9, 6, 7, 5, 1, 2, 8, 8, 9, 3, 5, 4, 1, 2, 6, 7, 2, 7, 1, 3, 6, 8, 5, 9, 4, 6, 5, 4, 7, 2, 9, 8, 1, 3},
   {8, 2, 3, 9, 5, 1, 6, 4, 7, 6, 1, 4, 7, 3, 2, 5, 8, 9, 9, 5, 7, 4, 8, 6, 3, 2, 1, 4, 9, 6, 2, 1, 8, 7, 3, 5, 1, 3, 5, 6, 4, 7, 2, 9, 8, 7, 8, 2, 3, 9, 5, 4, 1, 6, 5, 6, 1, 8, 2, 4, 9, 7, 3, 2, 7, 9, 1, 6, 3, 8, 5, 4, 3, 4, 8, 5, 7, 9, 1, 6, 2}
};

int board[81];
unsigned char* out;
size_t size = sizeof(board)/sizeof(board[0]);
int i;

void convert_to_char() {
   out = (unsigned char*)board;
}


void swapHorizontal() {
   int tmpBoard[9];
   //which lines to swap
   unsigned int tmp1 = rand();
   int lineIndex = (tmp1 % 3) * 3;
   tmp1 = rand();
   int swapWith = (tmp1 % 2) + 1;

   //printf("lineIndex: %d\n", lineIndex);
   //printf("swapWith: %d\n", swapWith);

   for (i = 0; i < S; i++) {
      tmpBoard[i] = board[(lineIndex * S) + i];
      board[(lineIndex * S) + i] = board[(swapWith+lineIndex) * S + i];
      board[(swapWith+lineIndex) * S + i] = tmpBoard[i];
   }
}

void swapVertical() {
   int tmpBoard[9];

   //which lines to swap
   unsigned int tmp1 = rand();
   int colIndex = (tmp1 % 3) * 3;
   
   unsigned int tmp2 = rand();
   int swapWith = (tmp2 % 2) + 1;


   for (i = 0; i < S; i++) {
      tmpBoard[i] = board[(colIndex) + i*9];
      board[(colIndex) + i*9] = board[(swapWith+colIndex) + i*9];
      board[(swapWith+colIndex) + i*9] = tmpBoard[i];
   }
}

/*******************************************************************************
 * Vypis uzivatelske napovedy (funkce se vola pri vykonavani prikazu "help")
*******************************************************************************/
void print_user_help(void)
{

}

/*******************************************************************************
 * Dekodovani uzivatelskych prikazu a jejich vykonavani
*******************************************************************************/
unsigned char decode_user_cmd(char *cmd_ucase, char *cmd)
{
   return (CMD_UNKNOWN);
}

/*******************************************************************************
 * Inicializace periferii/komponent po naprogramovani FPGA
*******************************************************************************/
void fpga_initialized() {}

/*******************************************************************************
 * Hlavni funkce
*******************************************************************************/
int main(void)
{
   unsigned short ofs, val;
   unsigned int temp;

   
   initialize_hardware();

   for(i = 0; i < 10; i++) {
      temp += thermometer_gettemp();
   }
   
   srand(temp);

   //generate random number for array selection
   //it must unsigned int, because for some reason rand() 
   //sometimes generates negative number
   unsigned int tmp_rand = rand();
   int arr = tmp_rand % 4;

   int counter = 0;
   term_send_crlf();
   term_send_str_crlf("Originalni deska===============");
   
   for (i = 0; i < S*S; i++) {
      board[i] = grid[arr][i];
      term_send_num(board[i]);
      term_send_char(' ');

      if (counter == 8) {
         term_send_crlf();
         counter = 0;
      }
      else {
         counter++;
      }
   }
   term_send_crlf();


   unsigned int tmp_swap = rand();

   i = tmp_swap%25;
   int j = 0;

   for (; i > 0; i--) {
      swapVertical(); 

      j++;
      if (j == 25)
         break; 
   }

   
   int k = 0;
   tmp_swap = rand();
   i = tmp_swap%25;
   for (; i > 0; i--) {
      swapVertical(); 

      k++;
      if (k == 25)
         break; 
   }

   term_send_str_crlf("Nova deska=====================");
   counter = 0;
   for (ofs=0; ofs < S*S; ofs++)
    {
      term_send_num(board[ofs]);
      term_send_char(' ');

      if (counter == 8) {
         term_send_crlf();
         counter = 0;
      }
      else {
         counter++;
      }

      //zapis 16 bitove hodnoty val na adresu BRAM_BASE + offset ofs
      FPGA_SPI_RW_AN_DN(SPI_FPGA_ENABLE_WRITE, BRAM_BASE+ofs, (unsigned char *)&board[ofs], 2, 2);
    }


    term_send_crlf();
    term_send_str_crlf("Deska nactena z BRAM=========");

    counter = 0;

    for (ofs=0; ofs < S*S; ofs++)
    {
      //zapis 16 bitove hodnoty val na adresu BRAM_BASE + offset ofs
      FPGA_SPI_RW_AN_DN(SPI_FPGA_ENABLE_READ, BRAM_BASE+ofs, (unsigned char *)&val, 2, 2);
      term_send_num((int)val);
      term_send_char(' ');
      
      if (counter == 8) {
         term_send_crlf();
         counter = 0;
      }
      else {
         counter++;
      }
      
    }
    

   set_led_d6(1);  //rozsvitit LED D6
   set_led_d5(1);  //rozsvitit LED D5

   while (1) 
   {
         
      delay_ms(1);  //zpozdeni 1ms

      terminal_idle();  // obsluha terminalu


   }

}

