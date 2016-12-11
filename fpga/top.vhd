library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.vga_controller_cfg.all;


architecture behav of tlv_pc_ifc is 
  signal vga_mode: std_logic_vector(60 downto 0);
  signal red: std_logic_vector(2 downto 0);
  signal green: std_logic_vector(2 downto 0);
  signal blue: std_logic_vector(2 downto 0);
  signal rgb : std_logic_vector(8 downto 0);
  signal rgbf : std_logic_vector(8 downto 0);

  signal vgaRow: std_logic_vector(11 downto 0);
  signal vgaCol: std_logic_vector(11 downto 0);

  signal sx : integer range 0 to 19 := 0;
  signal sy : integer range 0 to 19 := 0;

  signal gridCol : integer range 0 to 20 := 0;
  signal gridRow : integer range 0 to 20 := 0;

  signal tex_addr: integer range 0 to 28*9-1;
  signal tex_data: std_logic_vector(0 to 37);

  signal romval: std_logic_vector(0 to 1);

  signal num_posx: integer range 0 to 27 := 0;

  signal pressed_key: integer range 0 to 10 := 0;

  --signal rand_number: std_logic_vector(31 downto 0);
  --signal rand_number_generated: std_logic_vector(31 downto 0);
  --signal max_gen: std_logic_vector(5 downto 0) := (others => '0');
  

  --POLE integeru pro 
  type int_array is array(0 to 80) of integer range 0 to 9;
  signal grid_numbers: int_array;

  signal en_grid: std_logic := '0';

  signal show: std_logic_vector(0 to 80);
  signal full_mask: std_logic_vector(0 to 80);
  signal show_me: std_logic;

  signal addr_mask: integer range 0 to 80;
  signal out_mask: std_logic;
  signal in_mask: std_logic;
  signal en_mask: std_logic;
  signal rdwr_mask: std_logic;
  signal show2: std_logic;

  signal bram_addr     : std_logic_vector(9 downto 0);
  signal bram_data_out : std_logic_vector(15 downto 0);
  signal bram_data_in  : std_logic_vector(15 downto 0);
  signal bram_we       : std_logic := '0';

  signal kbrd_data_out : std_logic_vector(15 downto 0);
  signal kbrd_data_vld : std_logic;


component RAMB16_S18
  port (
    DO   : out std_logic_vector(15 downto 0);
    DOP  : out std_logic_vector(1 downto 0);
    ADDR : in std_logic_vector(9 downto 0);
    CLK  : in std_ulogic;
    DI   : in std_logic_vector(15 downto 0);
    DIP  : in std_logic_vector(1 downto 0);
    EN   : in std_ulogic;
    SSR  : in std_ulogic;
    WE   : in std_ulogic
  );
end component;

component SPI_adc
  generic (
     ADDR_WIDTH : integer;
     DATA_WIDTH : integer;
     ADDR_OUT_WIDTH : integer;
     BASE_ADDR  : integer
  );
  port (
     CLK      : in  std_logic;

     CS       : in  std_logic;
     DO       : in  std_logic;
     DO_VLD   : in  std_logic;
     DI       : out std_logic;
     DI_REQ   : in  std_logic;

     ADDR     : out std_logic_vector (ADDR_OUT_WIDTH-1 downto 0);
     DATA_OUT : out std_logic_vector (DATA_WIDTH-1 downto 0);
     DATA_IN  : in  std_logic_vector (DATA_WIDTH-1 downto 0);

     WRITE_EN : out std_logic;
     READ_EN  : out std_logic
  );
end component;


begin

  -- SPI dekoder pro displej
   spidecd: SPI_adc
      generic map (
         ADDR_WIDTH => 16,      -- sirka adresy 16 bitu
         DATA_WIDTH => 16,      -- sirka dat 16 bitu
         ADDR_OUT_WIDTH => 10,  -- sirka adresy k adresaci BRAM 10 bitu
         BASE_ADDR  => 16#0000# -- adresovy prostor od 0x0000 - 0x03FF
      )
      port map (
         CLK      => CLK,
         CS       => SPI_CS,

         DO       => SPI_DO,
         DO_VLD   => SPI_DO_VLD,
         DI       => SPI_DI,
         DI_REQ   => SPI_DI_REQ,

         ADDR     => bram_addr,
         DATA_OUT => bram_data_in,
         DATA_IN  => bram_data_out,
         WRITE_EN => bram_we,
         READ_EN  => open
      );

   -- Block RAM
   blkram: RAMB16_S18
      port map (
         CLK  => CLK,
         DO   => bram_data_out,
         DI   => bram_data_in,
         ADDR => bram_addr,
         EN   => '1',
         SSR  => '0',
         WE   => bram_we,
         DOP  => open,
         DIP  => "00"
      );

--rand: entity work.random port map(clk => CLK, random_num => rand_number);

grid_numbers <= (5, 4, 8, 9, 7, 3, 2, 1, 6, 1, 6, 7, 2, 4, 8, 3, 5, 9, 2, 3, 9, 6, 1, 5, 7, 8, 4, 6, 8, 5, 1, 9, 7, 4, 2, 3, 7, 1, 4, 3, 6, 2, 5, 9, 8, 9, 2, 3, 5, 8, 4, 6, 7, 1, 4, 7, 6, 8, 2, 1, 9, 3, 5, 3, 9, 1, 7, 5, 6, 8, 4, 2, 8, 5, 2, 4, 3, 9, 1, 6, 7);
show <= "101011011110111101111011111111111000111101110111111111011110111110111011110001111";

--base_mask : entity work.base_mask port map(
--  clk => CLK,
--  DOUT => show
--  ) ;

vga: entity work.vga_controller(arch_vga_controller)
  port map(
    CLK => CLK,
    RST => RESET,
    ENABLE => '1',
    MODE => vga_mode,
    
    DATA_RED => red,
    DATA_GREEN => green,
    DATA_BLUE => blue,
    
    ADDR_COLUMN => vgaCol,
    ADDR_ROW => vgaRow,
    
    VGA_RED => RED_V,
    VGA_GREEN => GREEN_V,
    VGA_BLUE => BLUE_V,
    
    VGA_HSYNC => HSYNC_V,
    VGA_VSYNC => VSYNC_V
  );

kbrd_ctrl: entity work.keyboard_controller(arch_keyboard)
generic map (READ_INTERVAL => 1000000)
port map (
   CLK => CLK,
   RST => RESET,

   DATA_OUT => kbrd_data_out(15 downto 0),
   DATA_VLD => kbrd_data_vld,
   
   KB_KIN   => KIN,
   KB_KOUT  => KOUT
);

--ROM pro textury cisel
texture: entity work.romtex port map(
  ADDR => tex_addr, 
  DATA => tex_data
);

--RAM pro masku hracem vlozenych cisel
mask: entity work.ram_mask port map(
  CLK => CLK, 
  EN => en_mask, 
  RDWR => rdwr_mask, 
  ADDR => addr_mask, 
  DIN => in_mask,
  DOUT => out_mask,
  DFULL => full_mask
);

setmode(r640x480x60, vga_mode);

--odchytavani klaves A,B,C,D
--  A - doleva
--  B - doprava
--  C - dolu
--  D - nahoru

process (CLK)
begin
   if (CLK'event) and (CLK = '1') then
        if (kbrd_data_vld='1') then

          --A - pohyb doprava
          if kbrd_data_out(12) = '1' then
            if (sx < 8) then
              sx <= sx + 1;
            end if;
          end if;

          --B - pohyb doleva
          if kbrd_data_out(13) = '1' then
            if (sx > 0) then
              sx <= sx - 1;
            end if;
          end if;

          --C - pohyb dolu
          if kbrd_data_out(14) = '1' then
            if (sy < 8) then
              sy <= sy + 1;
            end if;
          end if;

          --D - pohyb nahoru
          if kbrd_data_out(15) = '1' then
            if (sy = 0) then
              sy <= 0;
            else
              sy <= sy - 1;
            end if;
          end if;

          --* pro napovedu
          if kbrd_data_out(3) = '1' then
            if show_me = '1' then
              show_me <= '0';
            else
              show_me <= '1';
            end if;
          end if;

          case( kbrd_data_out) is
            when "0000000000000001" => pressed_key <= 1;
            when "0000000000000010" => pressed_key <= 4;
            when "0000000000000100" => pressed_key <= 7;
            when "0000000000010000" => pressed_key <= 2;
            when "0000000000100000" => pressed_key <= 5;
            when "0000000001000000" => pressed_key <= 8;
            when "0000000100000000" => pressed_key <= 3;
            when "0000001000000000" => pressed_key <= 6;
            when "0000010000000000" => pressed_key <= 9;
            when others => null; 
        end case ;

        end if;
    end if;
end process;

--MASKOVANI hracem vlozenych cisel
maskgrid : process( CLK, RESET )
variable arraypos: integer;
begin
arraypos := gridCol + gridRow*9;
  if rising_edge(CLK) then
    en_mask <= '1';
    addr_mask <= arraypos;
    
    if (sx + sy*9) = arraypos then
      if pressed_key = grid_numbers(arraypos) then
        rdwr_mask <= '0';
        in_mask <= '1';
      elsif show_me = '1' then   
          rdwr_mask <= '0'; 
          in_mask <= '1';
      elsif show_me = '0' then
          rdwr_mask <= '0'; 
          in_mask <= '0';
      else
        rdwr_mask <= '1';
      end if; 
    else
      rdwr_mask <= '1';
    end if;
    show2 <= out_mask;

  end if; --CLK
end process ; -- masking


grid : process( vgaRow, vgaCol, CLK )
  variable gridColtmp: integer;
  variable gridRowtmp: integer;
  variable arraypos: integer;

begin
  gridRow <= conv_integer(vgaRow(11 downto 5));
  gridCol <= conv_integer(vgaCol(11 downto 5));
  gridColtmp := gridCol*32;
  gridRowtmp := gridRow*32;
  
  if (rising_edge(CLK)) then
    rgb <= "000"&"000"&"000";
    arraypos := gridCol + gridRow*9;
    
    --HRACI DESKA
    if (conv_integer(vgaCol(4 downto 0)) = 0) and (gridCol <= 9) and (gridRow < 9) then
      if gridCol = 3 or gridCol = 6 then
        rgb <= "000111000";
      else
        rgb <= "111000000";
      end if;
    elsif (conv_integer(vgaRow(4 downto 0)) = 0) and (gridCol < 9) and (gridRow <= 9) then
      if gridRow = 3 or gridRow = 6 then
        rgb <= "000111000";
      else
        rgb <= "111000000";
      end if;
    end if;

    	

    --KURZOR
    if (gridCol = sx) and (gridRow = sy) then
    	if (conv_integer(vgaRow(4 downto 0)) = 1) or (conv_integer(vgaRow(4 downto 0)) = 31) then
        rgb <= "000"&"111"&"000";
    	elsif (conv_integer(vgaCol(4 downto 0)) = 1) or (conv_integer(vgaCol(4 downto 0)) = 31) then
        rgb <= "000"&"111"&"000";
    	end if;     
    end if;
      
    --SELEKCE CISEL
    if show(arraypos) = '1' or show2 = '1' then
      if (gridCol < 9) and (gridRow < 9) then
        if  (conv_integer(vgaRow) > (gridRowtmp + 2)) and 
          (conv_integer(vgaRow) < (gridRowtmp + 30)) and 
          (conv_integer(vgaCol) > (gridColtmp + 8)) and 
          (conv_integer(vgaCol) < (gridColtmp + 28))  then
            
          num_posx <= conv_integer(vgaCol(4 downto 0)) - 9;
          --bram_addr <= conv_std_logic_vector(arraypos, 10);
          tex_addr <= ((grid_numbers(arraypos)-1)*28) + conv_integer(vgaRow(4 downto 0)) - 2;
          --tex_addr <= ((conv_integer(bram_data_out)-1)*28) + conv_integer(vgaRow(4 downto 0)) - 2;

          romval <= tex_data(2*num_posx to 2*num_posx+1);
          --bram_addr <= bram_addr + 1;
        end if;
      end if;   
    end if;

    --RENDEROVANI cisel
    if romval = "01" then
      rgb <= "000"&"000"&"101"; 
    elsif romval = "10" then
      rgb <= "101000000";
    elsif romval = "11" then
      rgb <= "111000111";
    else
      --zajisteni "alpha" kanalu
      --rgb <= "000000000";
    end if;

  end if; -- CLK
	
end process ; -- grid

--KONTROLA KONCE HRY
rgbf <= "000000111" when ((full_mask OR show) = "111111111111111111111111111111111111111111111111111111111111111111111111111111111") else rgb;

--OBARVENI pixelu
red <= rgbf(8 downto 6);
green <= rgbf(5 downto 3);
blue <= rgbf(2 downto 0);

end;

