--*****************************************************************************
--*  Copyright (C) 2016 by Trevor Smouter
--*
--*  All rights reserved.
--*
--*  Redistribution and use in source and binary forms, with or without 
--*  modification, are permitted provided that the following conditions 
--*  are met:
--*  
--*  1. Redistributions of source code must retain the above copyright 
--*     notice, this list of conditions and the following disclaimer.
--*  2. Redistributions in binary form must reproduce the above copyright
--*     notice, this list of conditions and the following disclaimer in the 
--*     documentation and/or other materials provided with the distribution.
--*  3. Neither the name of the author nor the names of its contributors may 
--*     be used to endorse or promote products derived from this software 
--*     without specific prior written permission.
--*
--*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
--*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
--*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
--*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
--*  THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
--*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
--*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
--*  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
--*  AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
--*  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
--*  THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF 
--*  SUCH DAMAGE.
--*
--*****************************************************************************
--*  History:
--*
--*  04.02.2016    First Version
--*****************************************************************************


-- ****************************************************************************
-- *  Library                                                                 *
-- ****************************************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- ****************************************************************************
-- *  Entity                                                                  *
-- ****************************************************************************

entity operation_alu is
   port (
			 clkin_50			: in	std_logic;
          pb        : in  std_logic_vector(3 downto 0);	
			 SW_IN1 		: in  std_logic_vector(3 downto 0);	
			 SW_IN2 		: in  std_logic_vector(3 downto 0);
			 DOUT			: out	std_logic_vector(7 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
        );
end entity operation_alu;

-- *****************************************************************************
-- *  Architecture                                                             *
-- *****************************************************************************

architecture syn1 of operation_alu is
	

	
  component segment7_mux port (
		clk : in std_logic := '0';
		DIN2 : in std_logic_vector (6 downto 0);
		DIN1 : in std_logic_vector (6 downto 0);
		DOUT : out std_logic_vector (6 downto 0);
		DIG2 : out std_logic;
		DIG1 : out std_logic
	);
	end component;
	
  component SevenSegment port (        --acts as a function 
		hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
		sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	signal seg7_A		: std_logic_vector(6 downto 0);
	
	signal seg7_B		: std_logic_vector(6 downto 0);
	signal seg7_data		: std_logic_vector(6 downto 0);
begin
	INST1 : SevenSegment port map(SW_IN1, seg7_A);
	INST2 : SevenSegment port map(SW_IN2, seg7_B);
	INST3 : segment7_mux port map (clkin_50, seg7_A, seg7_B, seg7_data, DIG2, DIG1);
	with pb select
		DOUT <= "0000" & (SW_IN1 AND SW_IN2) when "1110",
			"0000" & (SW_IN1 OR SW_IN2) when "1101",
			"0000" & (SW_IN1 XOR SW_IN2) when "1011",
			"00000000" when others;
	

	
	

end architecture syn1;
