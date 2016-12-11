library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ram_mask is
	port (
		CLK: in std_logic;
		EN, RDWR: in std_logic;
		ADDR: in integer range 0 to 80;
		DIN: in std_logic;
		DOUT: out std_logic;
		DFULL: out std_logic_vector(0 to 80)
	);
end entity;


architecture Behavioral of ram_mask is
	type t_ram is array(0 to 80) of std_logic;
	signal mask_array : t_ram := (others=>'0');
	signal full_mask: std_logic_vector(0 to 80);
	
begin

write : process (CLK)
begin
	if rising_edge(CLK) then
		if (EN = '1') then
			if (RDWR = '0') then
				mask_array(ADDR) <= DIN;
				--DOUT <= DIN;
			end if;
			DOUT <= mask_array(ADDR);
		end if;
	end if;
end process ; -- write

fillmask : for i in 0 to 80 generate
	full_mask(i) <= mask_array(i);
end generate; -- fillmask

DFULL <= full_mask;


end architecture;

