LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decodeExecute IS
	PORT (
		clk : IN STD_LOGIC;
		--input ports
		i_flushEnable : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		i_readData1, i_readData2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		i_wbAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		i_PC_plus_one : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		i_inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		i_immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		i_cuSignals : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		o_readData1, o_readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		o_aluOP : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		o_aluSrc : OUT STD_LOGIC;
		o_cuSignals : OUT STD_LOGIC_VECTOR(22 DOWNTO 0); --23 cu signals - 5 opcode - 1 alusrc = 17 cu signals left to be passed over 
		o_wbAddress : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		o_immediate : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		o_inputPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		o_PC_plus_one : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END decodeExecute;

ARCHITECTURE a_decodeExecBuffer OF decodeExecute IS
BEGIN
	PROCESS (clk, i_flushEnable)
	BEGIN
		IF (i_flushEnable(1) = '1' AND rising_edge(clk)) THEN
			o_cuSignals <= (OTHERS => '0');
			o_readData1 <= (OTHERS => '0');
			o_readData2 <= (OTHERS => '0');
			o_aluOP <= (OTHERS => '0');
			o_aluSrc <= '0';
			o_wbAddress <= (OTHERS => '0');
			o_immediate <= (OTHERS => '0');
			o_PC_plus_one <= (OTHERS => '0');
		ELSIF (rising_edge(clk)) THEN
			o_readData1 <= i_readData1;
			o_wbAddress <= i_wbAddress;
			o_PC_plus_one <= i_PC_plus_one;
			o_aluOP <= i_cuSignals(19 DOWNTO 15);
			o_aluSrc <= i_cuSignals(20);
			o_cuSignals <= i_cuSignals;
			o_immediate <= i_immediate;
			o_readData2 <= i_readData2;
			o_inputPort <= i_inputPort;
		END IF;
	END PROCESS;
END a_decodeExecBuffer;