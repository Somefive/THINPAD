
-- VHDL Instantiation Created from source file ALU.vhd -- 20:23:46 11/10/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ALU
	PORT(
		Operand1 : IN std_logic_vector(15 downto 0);
		Operand2 : IN std_logic_vector(15 downto 0);
		ALUOp : IN std_logic_vector(3 downto 0);          
		Result : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_ALU: ALU PORT MAP(
		Operand1 => ,
		Operand2 => ,
		ALUOp => ,
		Result => 
	);


