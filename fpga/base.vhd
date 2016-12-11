library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity base_mask is
	port (
		CLK: in std_logic;
		DOUT: out std_logic_vector(0 to 80)
	);
end entity;


architecture Behavioral of base_mask is
	--type t_ram is array(0 to 80) of std_logic;
	--signal mask_array : t_ram := (others=>'0');
	signal mask: std_logic_vector(0 to 80) := (others => '0'); --:= "101100111110110011111011001111101100111110110011111011001111101100111110110011111";
	signal rand_number: std_logic_vector(5 downto 0);
	signal rand_en: std_logic := '1';

	type t_state is (GETRAND, CHECKRAND, CHECKIND, SETONE, INCREMENT, DONE);
   	signal pstate: t_state; 
   	signal nstate : t_state := GETRAND;
	
begin

rand: entity work.random port map(clk => CLK, random_num => rand_number);

--Present State register
pstate_logic: process(CLK)
begin
 	if (CLK'event) and (CLK='1') then
		pstate <= nstate;
	end if;
end process; -- pstate_reg

--Next State logic + output logic
nstate_logic: process(CLK, pstate, nstate)
variable tmp_index : integer range 0 to 80;
variable cnt : integer range 0 to 64;
begin
   case pstate is
   		when GETRAND =>
   			tmp_index := 36;--conv_integer(rand_number);
   			nstate <= CHECKRAND;
   			rand_en <= '0';
   			cnt := 0;
   		when CHECKRAND =>
   			if tmp_index < 10 then
   				nstate <= GETRAND;
   			else
   				nstate <= SETONE;
   			end if;
   		when SETONE =>
   			mask(tmp_index) <= '1';
   			nstate <= INCREMENT;
   		when INCREMENT =>
   			tmp_index := tmp_index + tmp_index;
   			cnt := cnt + 1;
   			nstate <= CHECKIND;
   		when CHECKIND =>
   			if cnt = 50 then
   				nstate <= DONE;
   			end if;

   			if tmp_index > 80 then
   				tmp_index := tmp_index - 80;
   			end if;
   		when DONE =>
   			nstate <= DONE;
      when others => null;
   end case;
end process; -- nstate_logic

DOUT <= mask;


end architecture;

