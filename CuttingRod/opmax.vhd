library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity opmax is
     port (max_val, price, valp : in std_logic_vector(7 downto 0);
     y : out std_logic_vector(7 downto 0));
end opmax;

architecture rtl of opmax is
component adder is
    port (a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component max is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
signal add : std_logic_vector(7 downto 0);
begin
    u1 : adder port map (price, valp, add);
    u2 : max port map (add, max_val, y);
end rtl;