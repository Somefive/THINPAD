----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:36:37 11/10/2016 
-- Design Name: 
-- Module Name:    Timer - Behavioral 
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

-- 分时器
entity Timer is
    Port ( CLK0 : in  STD_LOGIC;
           CLK1 : in  STD_LOGIC;
           CLK_FROM_KEY : in  STD_LOGIC;
           CLK_OUT : out STD_LOGIC);
end Timer;

architecture Behavioral of Timer is

type MODE_TYPE is(MODE_SINGLE_STEP,MODE_CLK);
constant mode: MODE_TYPE := MODE_SINGLE_STEP; --当前的分时器模式 单步调试模式 50M分时模式
signal CLK_CURRENT: STD_LOGIC:='0'; --分时后的信号
shared variable count: INTEGER RANGE 0 TO 64:= 0;
shared variable count2: INTEGER RANGE 0 TO 64:= 0;
begin
	
	process(CLK_FROM_KEY,CLK_CURRENT)
	begin
	case mode is
		when MODE_SINGLE_STEP =>
			CLK_OUT <= CLK_FROM_KEY;
		when MODE_CLK =>
			CLK_OUT <= CLK_CURRENT;
	end case;
	end process;
	
	process(CLK1)
	begin
	if(CLK1'event and CLK1='1')then
		if(count=9)then
			CLK_CURRENT <= not CLK_CURRENT;
			count := 0;
		else
			count := count + 1;
		end if;
	end if;
	end process;
	
	process(CLK0)
	begin
	if(CLK0'event and CLK0='0')then
		if(count2=9)then
			count2 := 0;
		else
			count2 := count2 + 1;
		end if;
	end if;
	end process;

end Behavioral;

