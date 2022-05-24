LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY Polarity_Controller IS
	PORT
	(
		SW_IN1, AND_OUT, NAND_OUT, OR_OUT, XOR_OUT : IN BIT;
		AND_OUT1, NAND_OUT1, OR_OUT1, XOR_OUT1 : OUT BIT
	);
END Polarity_Controller;

ARCHITECTURE simple_gates OF Polarity_Controller IS

BEGIN

AND_OUT1 <= AND_OUT XOR SW_IN1;
NAND_OUT1 <= NAND_OUT XOR SW_IN1;
OR_OUT1 <= OR_OUT XOR SW_IN1;
XOR_OUT1 <= XOR_OUT XOR SW_IN1;

END simple_gates;