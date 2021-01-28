----
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity counter_input is
  port(
    clk: in std_logic;
    DATA, LOAD, CLK_OUTPUT: out std_logic 
  );
end counter_input;
 
architecture behavioral of counter_input is 
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

-- Testbench for OR gate
library IEEE;
use IEEE.std_logic_1164.all;
 
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component counter_input is
 port(
    clk: in std_logic;
    DATA, LOAD, CLK_OUTPUT: out std_logic 
  );
end component;

signal clk_in, DATA_out, LOAD_out, CLK_OUTPUT_out: std_logic;

begin

  -- Connect DUT
  DUT: counter_input port map(clk_in, DATA_out, LOAD_out, CLK_OUTPUT_out);

  process
  begin
    clk_in <= '0';
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    clk_in <= NOT clk_in ;
    wait for 1 ns;
    
    wait;
  end process;
end tb;
