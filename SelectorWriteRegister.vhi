
-- VHDL Instantiation Created from source file SelectorWriteRegister.vhd -- 21:46:31 11/10/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT SelectorWriteRegister
	PORT(
		rx : IN std_logic_vector(2 downto 0);
		ry : IN std_logic_vector(2 downto 0);
		rz : IN std_logic_vector(2 downto 0);
		selector : IN std_logic_vector(1 downto 0);          
		output : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	Inst_SelectorWriteRegister: SelectorWriteRegister PORT MAP(
		rx => ,
		ry => ,
		rz => ,
		selector => ,
		output => 
	);


