library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
port(clk, wr : in std_logic;
i, j, n : in std_logic_vector(3 downto 0);
max_val : in std_logic_vector(7 downto 0);
y, valp : out std_logic_vector(7 downto 0));
end ram;
architecture rtl of ram is
type ram_type is array (0 to 15) of
std_logic_vector(7 downto 0);
signal program: ram_type := ( others => (others => '0') );
signal iminusj, ijminus1 : std_logic_vector(3 downto 0);

component sub is
    port (a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component minus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;

begin
u1 : sub port map (i, j, iminusj);
u3 : minus1 port map (iminusj, ijminus1);
process(clk)
begin
if (rising_edge(clk)) then
if (wr = '1') then
program(conv_integer(unsigned(i))) <= max_val;
end if;
end if;
end process;
y <= program(conv_integer(unsigned(n)));
valp <= program(conv_integer(unsigned(ijminus1)));
end rtl;