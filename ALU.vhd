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
    Port ( OperandA : in  STD_LOGIC_VECTOR (15 downto 0);
           OperandB : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUOp : in  STD_LOGIC_VECTOR (3 downto 0);
           Result : out  STD_LOGIC_VECTOR (15 downto 0);
			  ALUWriteEN: in STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

begin

	process(OperandA,OperandB,ALUOp,ALUWriteEN)
	begin
	if(ALUWriteEN='0')then
		case ALUOp is
			when "0001" => Result <= OperandA + OperandB;
			when "0010" => Result <= OperandA - OperandB;
			when "0011" => Result <= OperandA and OperandB;
			when "0100" => Result <= OperandA or OperandB;
			when "0101" => Result <= to_stdlogicvector(to_bitvector(OperandB) sll conv_integer(OperandA));
			when "0110" => Result <= to_stdlogicvector(to_bitvector(OperandB) sra conv_integer(OperandA));
			when "0111" => Result <= "0000000000000000"-OperandB;
			when others => Result <= "0000000000000000";
		end case;
	end if;
	end process;

end Behavioral;

