library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity price_rom is
port(addr: in std_logic_vector (3 downto 0);
data: out std_logic_vector (7 downto 0));
end price_rom;
architecture rtl of price_rom is
type rom_type is array (0 to 15) of
std_logic_vector (7 downto 0);
constant program : rom_type := (
"00000001", 
"00000101",
"00001000",
"00001001",
"00001010",
"00010001",
"00010001",
"00010100",
"10010000",
"10000000",
"11101000",
"10001111",
"10100000",
"10000000",
"01111000",
"00000000");
begin
data <= program(conv_integer(unsigned(addr)));
end rtl;