
-- VHDL Instantiation Created from source file Comparator.vhd -- 20:30:40 11/10/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Comparator
	PORT(
		First : IN std_logic_vector(15 downto 0);
		Second : IN std_logic_vector(15 downto 0);          
		Result : OUT std_logic
		);
	END COMPONENT;

	Inst_Comparator: Comparator PORT MAP(
		First => ,
		Second => ,
		Result => 
	);


