----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:41:05 11/10/2016 
-- Design Name: 
-- Module Name:    SelectorWriteRegister - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SelectorWriteRegister is
    Port ( rx : in  STD_LOGIC_VECTOR (2 downto 0);
           ry : in  STD_LOGIC_VECTOR (2 downto 0);
           rz : in  STD_LOGIC_VECTOR (2 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC_VECTOR (2 downto 0));
end SelectorWriteRegister;

architecture Behavioral of SelectorWriteRegister is

begin
	
	with selector select output <=
		rx when "01",
		ry when "10",
		rz when "11",
		"000" when others;
		
end Behavioral;

