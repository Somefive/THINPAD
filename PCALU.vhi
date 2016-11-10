
-- VHDL Instantiation Created from source file PCALU.vhd -- 20:21:41 11/10/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT PCALU
	PORT(
		Adder : IN std_logic_vector(15 downto 0);
		PC : IN std_logic_vector(15 downto 0);          
		Result : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_PCALU: PCALU PORT MAP(
		Adder => ,
		PC => ,
		Result => 
	);


