library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity romtex is
	port (
		ADDR: IN integer range 0 to 28*9-1 ;
		DATA: OUT std_logic_vector(0 to 37)
	);
end entity;

architecture beh of romtex is
	type mem is  array(0 to 28*9-1) of std_logic_vector(0 to 37);
	signal rom_numbers : mem := (	---------------------------------------------------------------
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000001111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000011111111110000000000000000",
									"00000000001111111111110000000000000000",
									"00000011111111111111110000000000000000",
									"00001111111111111111110000000000000000",
									"00111111110000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000111111110000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									-----
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000011111111111000000000000000000",
									"00000011111111111111111100000000000000",
									"00001111111111111111111111000000000000",
									"00111111111111111111111111110000000000",
									"00111111110000000001111111110000000000",
									"00000000000000000001111111110000000000",
									"00000000000000000001111111110000000000",
									"00000000000000000111111111000000000000",
									"00000000000000011111111100000000000000",
									"00000000000001111111110000000000000000",
									"00000000000111111111000000000000000000",
									"00000000011111111100000000000000000000",
									"00000001111111110000000000000000000000",
									"00000111111111000000000000000000000000",
									"00000111111111000000000000000000000000",
									"00011111111100000000000000000000000000",
									"00011111111111111111111111111000000000",
									"00011111111111111111111111111000000000",
									"00011111111111111111111111111000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									--
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000011111111111000000000000000000",
									"00001111111111111111111100000000000000",
									"00111111111111111111111111000000000000",
									"11111111100000001111111111110000000000",
									"11111110000000000001111111110000000000",
									"00000000000000000001111111110000000000",
									"00000000000000000001111111110000000000",
									"00000000000000011111111111000000000000",
									"00000000111111111111111100000000000000",
									"00000000111111111111110000000000000000",
									"00000000111111111111111111000000000000",
									"00000000000000000011111111110000000000",
									"00000000000000000000111111110000000000",
									"00000000000000000000111111110000000000",
									"00000000000000000011111111110000000000",
									"00011110000000000011111111110000000000",
									"01111111111111111111111111100000000000",
									"01111111111111111111111110000000000000",
									"01111111111111111111111000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									--
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000011111111000000000000",
									"00000000000000001111111111000000000000",
									"00000000000000111111111111000000000000",
									"00000000000011111111111111000000000000",
									"00000000001111111111111111000000000000",
									"00000000011111111111111111000000000000",
									"00000000111111110011111111000000000000",
									"00000011111111000011111111000000000000",
									"00001111111100000011111111000000000000",
									"00111111110000000011111111000000000000",
									"00111111110000000011111111000000000000",
									"01111111100000000011111111000000000000",
									"01111111111111111111111111111100000000",
									"01111111111111111111111111111100000000",
									"01111111111111111111111111111100000000",
									"00000000000000000011111111000000000000",
									"00000000000000000011111111000000000000",
									"00000000000000000011111111000000000000",
									"00000000000000000011111111000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									--
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000011111111111111111111100000000000",
									"00000011111111111111111111100000000000",
									"00000011111111111111111111100000000000",
									"00000011111111111111111111100000000000",
									"00000011111110000000000000000000000000",
									"00000011111110000000000000000000000000",
									"00000011111110000000000000000000000000",
									"00000011111110000000000000000000000000",
									"00000011111111111111111000000000000000",
									"00000011111111111111111110000000000000",
									"00000011111111111111111111100000000000",
									"00000000000000000011111111110000000000",
									"00000000000000000000111111110000000000",
									"00000000000000000000111111110000000000",
									"00000000000000000001111111110000000000",
									"00011000000000000111111111110000000000",
									"00011111111111111111111111100000000000",
									"00111111111111111111111110000000000000",
									"00111111111111111111111000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									--
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000111100000000000",
									"00000000000000011111111111100000000000",
									"00000000000111111111111111100000000000",
									"00000000111111111111111111100000000000",
									"00000011111111111100000000000000000000",
									"00000111111111110000000000000000000000",
									"00001111111110000000000000000000000000",
									"00011111111100111111000000000000000000",
									"00011111111111111111111111000000000000",
									"00111111111111111111111111110000000000",
									"00111111111000000001111111111000000000",
									"00111111111000000000011111111000000000",
									"00111111111000000000011111111000000000",
									"00111111111000000000011111111100000000",
									"00011111111100000000011111111100000000",
									"00011111111110000001111111111000000000",
									"00001111111111111111111111110000000000",
									"00000011111111111111111111000000000000",
									"00000000011111111111111000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									--
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00111111111111111111111111111100000000",
									"00111111111111111111111111111100000000",
									"00111111111111111111111111111100000000",
									"00111111111111111111111111111100000000",
									"00000000000000000011111111110000000000",
									"00000000000000000111111111100000000000",
									"00000000000000001111111111000000000000",
									"00000000000000111111111110000000000000",
									"00000000000001111111111000000000000000",
									"00000000000001111111111000000000000000",
									"00000000000011111111110000000000000000",
									"00000000000111111111100000000000000000",
									"00000000001111111111000000000000000000",
									"00000000011111111110000000000000000000",
									"00000000011111111110000000000000000000",
									"00000000111111111100000000000000000000",
									"00000000111111111100000000000000000000",
									"00000000111111111000000000000000000000",
									"00000000111111111000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									--
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000111111111000000000000000000",
									"00000001111111111111111110000000000000",
									"00000111111111111111111111100000000000",
									"00001111111111111111111111110000000000",
									"00011111111100000000111111111000000000",
									"00011111111000000000111111111000000000",
									"00011111111100000000111111110000000000",
									"00001111111110000001111111100000000000",
									"00000111111111111111111111000000000000",
									"00000001111111111111111100000000000000",
									"00000011111111111111111111100000000000",
									"00001111111110000011111111111000000000",
									"00011111111100000000111111111000000000",
									"00111111111000000000011111111100000000",
									"00111111111000000000011111111100000000",
									"00011111111100000000111111111000000000",
									"00001111111111111111111111110000000000",
									"00000111111111111111111111100000000000",
									"00000000111111111111111100000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									--
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000111111110000000000000000000",
									"00000011111111111111111100000000000000",
									"00001111111111111111111111000000000000",
									"00011111111111111111111111100000000000",
									"00111111111000000001111111110000000000",
									"00111111110000000000111111111000000000",
									"00111111110000000000011111111000000000",
									"00111111110000000000011111111000000000",
									"00111111111100000000011111111000000000",
									"00011111111111111111111111111000000000",
									"00001111111111111111111111111000000000",
									"00000001111111111111111111111000000000",
									"00000000000000000001111111110000000000",
									"00000000000000000011111111100000000000",
									"00000000000000001111111111000000000000",
									"00000000000111111111111110000000000000",
									"00001111111111111111111000000000000000",
									"00001111111111111111100000000000000000",
									"00001111111111111100000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000",
									"00000000000000000000000000000000000000"
									);

begin
	DATA <= rom_numbers(ADDR);

end architecture ; -- beh