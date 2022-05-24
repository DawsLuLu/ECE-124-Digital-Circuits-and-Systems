library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (       --Entity only states input and output values
   clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;

	component segment7_mux port (
		clk		: in std_logic := '0';
		DIN2		: in std_logic_vector(6 downto 0);
		DIN1		: in std_logic_vector(6 downto 0);
		DOUT		: out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
	);
	end component;
	
	component Logic_Processor port (
		hexA		: in std_logic_vector(3 downto 0);
		hexB		: in std_logic_vector(3 downto 0);
		Button	: in std_logic_vector(2 downto 0);
		output	: out std_logic_vector(7 downto 0)
	);
	end component;
	
	component mux port (
	inputA		: in std_logic_vector(7 downto 0);
	inputB		: in std_logic_vector(7 downto 0);
	mux_select  : in std_logic;
	hex_out 		: out std_logic_vector(7 downto 0)
	
	);
	end component;
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal hex_A		: std_logic_vector(3 downto 0);
	
	signal hex_B      : std_logic_vector(3 downto 0);
	Signal seg7_B     : std_logic_vector(6 downto 0);
	
	signal sum			: std_logic_vector(7 downto 0);
	
	Signal hex_A_B_concatenate : std_logic_vector(7 downto 0);
	
	signal muxed_display: std_logic_vector(7 downto 0);
	Signal logic_display: std_logic_vector(7 downto 0);
	
	Signal leftdisplay	: std_logic_vector(3 downto 0);
	Signal rightdisplay	: std_logic_vector(3 downto 0);
	
	Signal switch_3 	:std_logic;
	Signal switch_012	:std_logic_vector(2 downto 0);
	
-- Here the circuit begins

begin

	hex_A <= sw(3 downto 0);	
	hex_B <= sw(7 downto 4);
	switch_3 <= pb(3);
	switch_012 <= pb(2 downto 0);
	
	


-----sum------------------------------------------------------------------------------------------------------
	sum <= std_logic_vector(unsigned("0000" & hex_A) + unsigned("0000" & hex_B)); -- for ADD mode
	
	hex_A_B_concatenate <= hex_B & hex_A;
	
	INST4: mux port map(sum, hex_A_B_concatenate, switch_3, muxed_display);  -- check if its add operation
	
	INST5: Logic_Processor port map(hex_A, hex_B, not switch_012, logic_display); -- for AND, OR and XOR modes
	
	leftdisplay <= muxed_display(3 downto 0); -- left seven segment display
	rightdisplay <= muxed_display(7 downto 4); -- right seven segment display
	
	INST1: SevenSegment port map(leftdisplay, seg7_A); -- convert from four bits to seven segment
	INST2: SevenSegment port map(rightdisplay, seg7_B); 
	
	INST3: segment7_mux port map(clkin_50, seg7_B, seg7_A, seg7_data, seg7_char1, seg7_char2); -- show digits on seven segment display
	
	INST6: mux port map(sum, logic_display, switch_3, leds); -- if pb3 is pushed, return sum and vice versa
	
	
end SimpleCircuit;

