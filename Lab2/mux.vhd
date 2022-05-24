library ieee;
use ieee.std_logic_1164.all;


entity mux is port (
	inputA, inputb	: in std_logic_vector(7 downto 0);
	mux_select		: in std_logic;
	hex_out			: out std_logic_vector(7 downto 0)
);
end mux;

architecture mux_logic of mux is

begin

hex_out <= inputA when (mux_select = '0') else inputB;

end mux_logic;

 