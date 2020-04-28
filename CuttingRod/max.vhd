library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity max is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end max;

architecture rtl of max is
begin
    y <= a when unsigned(a) > unsigned(b) else b;
end rtl;
