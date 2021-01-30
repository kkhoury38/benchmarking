library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL; 
  
entity clock_divider is
  port( 
    clk,reset: in std_logic;
    clock_out: out std_logic
  );
end clock_divider; 

architecture behavioral of clock_divider is
  signal count: integer:=1;
  signal tmp : std_logic := '0'; 
begin
  process(clk,reset)
  begin
    if(reset='1') then
      count<=1;
      tmp<='0';
    elsif rising_edge(clk) then
      count <=count+1;
      -- 100MHz -> 2KHz: count = 25000
	  -- 100MHz -> ~3.4 KHz: count = 14700
	  --  12MHz -> 2KHz: count =  3000
      if (count = 1000) then
        tmp <= NOT tmp;
        count <= 1;
      end if;
    end if;
    
    clock_out <= tmp;
  end process;
  
end behavioral;

----
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity signal_generator is
  port(
    clk: in std_logic;
    DATA, LOAD, CLK_OUTPUT: out std_logic 
  );
end signal_generator;
 
architecture behavioral of signal_generator is 
signal temp_LOAD: std_logic;
begin
  process (clk)
    variable count: integer:= 1;
  begin
    if falling_edge(clk) then
      if count=1 then
        DATA <= '0';
        temp_LOAD <= '0';
      elsif count=3 or count=5 or count=6 then
        DATA <= '0';
      elsif count=2 or count=4 or count=7 or count=8 then
        DATA <= '1';
      elsif count=9 then
        count:=0;
        temp_LOAD <= '1';
      end if;
      count:=count+1;
    end if;
  end process;
  
  process(clk,temp_LOAD)
  begin
   CLK_OUTPUT <= clk and NOT temp_LOAD;
  end process;
  
  LOAD <= temp_LOAD;
  
end behavioral;

----
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.ALL; 

entity top_level is
  port(
    board_clock: in std_logic;
	DATA_top, LOAD_top, CLK_OUTPUT_top, led8: out std_logic 
  );
end top_level;
 
architecture behavioral of top_level is

  component clock_divider
  port( 
    clk,reset: in std_logic;
    clock_out: out std_logic
  );
  end component;
  
  component signal_generator is
  port(
    clk: in std_logic;
    DATA, LOAD, CLK_OUTPUT: out std_logic 
  );
  end component;
  
  signal clk_divided, DATA_Temp: std_logic;
begin
  clk_div1: clock_divider
    port map(clk => board_clock, reset => '0', clock_out => clk_divided);
	
  sig_gen: signal_generator
    port map(clk => clk_divided, DATA => DATA_Temp, LOAD => LOAD_top, CLK_OUTPUT => CLK_OUTPUT_top);
