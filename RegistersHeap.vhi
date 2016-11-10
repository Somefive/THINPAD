
-- VHDL Instantiation Created from source file RegistersHeap.vhd -- 20:20:00 11/10/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RegistersHeap
	PORT(
		ReadRegister1 : IN std_logic_vector(2 downto 0);
		ReadRegister2 : IN std_logic_vector(2 downto 0);
		WriteRegister : IN std_logic_vector(2 downto 0);
		WriteData : IN std_logic_vector(15 downto 0);
		WriteEN : IN std_logic;          
		ReadData1 : OUT std_logic_vector(15 downto 0);
		ReadData2 : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_RegistersHeap: RegistersHeap PORT MAP(
		ReadRegister1 => ,
		ReadRegister2 => ,
		WriteRegister => ,
		WriteData => ,
		ReadData1 => ,
		ReadData2 => ,
		WriteEN => 
	);


