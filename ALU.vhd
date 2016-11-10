----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:11:02 11/10/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( Operand1 : in  STD_LOGIC_VECTOR (15 downto 0);
           Operand2 : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUOp : in  STD_LOGIC_VECTOR (3 downto 0);
           Result : out  STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	process(Operand1,Operand2,ALUOp)
	begin
	case ALUOp is
		when "0001" => Result <= Operand1 + Operand2;
		when "0010" => Result <= Operand1 - Operand2;
		when "0011" => Result <= Operand1 and Operand2;
		when "0100" => Result <= Operand1 or Operand2;
		when "0101" => Result <= to_stdlogicvector(to_bitvector(Operand2) sll conv_integer(Operand1));
		when "0110" => Result <= to_stdlogicvector(to_bitvector(Operand2) sra conv_integer(Operand1));
		when "0111" => Result <= "0000000000000000"-Operand2;
		when others => Result <= "0000000000000000";
	end case;
	end process;

end Behavioral;

