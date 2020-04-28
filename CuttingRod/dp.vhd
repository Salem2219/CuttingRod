library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dp is
    port (clk, rst, wr, i_ld, ld, sel : in std_logic;
    n : in std_logic_vector(3 downto 0);
    price : in std_logic_vector(7 downto 0);
    x1, x2 : out std_logic;
    price_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end dp;

architecture rtl of dp is
component compgr is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component complt is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component plus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component mux4 is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component mux8 is
    port (s : in std_logic;
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component reg4 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(3 downto 0);
reg_out: out std_logic_vector(3 downto 0));
end component;
component reg8 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(7 downto 0);
reg_out: out std_logic_vector(7 downto 0));
end component;
component ram is
port(clk, wr : in std_logic;
i, j, n : in std_logic_vector(3 downto 0);
max_val : in std_logic_vector(7 downto 0);
y, valp : out std_logic_vector(7 downto 0));
end component;
component opmax is
     port (max_val, price, valp : in std_logic_vector(7 downto 0);
     y : out std_logic_vector(7 downto 0));
end component;
signal i, i_in, iplus1, j, j_in, jplus1 :  std_logic_vector(3 downto 0);
signal  max_val, max_in, m, valp : std_logic_vector(7 downto 0);
begin
    i_op : plus1 port map (i, iplus1);
    i_mux : mux4 port map (sel, "0001", iplus1, i_in);
    i_reg : reg4 port map (clk, rst, i_ld, i_in, i);
    j_op : plus1 port map (j, jplus1);
    j_mux : mux4 port map (sel, "0000", jplus1, j_in);
    j_reg : reg4 port map (clk, rst, ld, j_in, j);
    max_op : opmax port map (max_val, price, valp, m);
    max_mux : mux8 port map (sel, "00000000", m, max_in);
    max_reg : reg8 port map (clk, rst, ld, max_in, max_val);
    in_comp : compgr port map (i, n, x1);
    ji_comp : complt port map (j, i, x2);
    val_ram : ram port map (clk, wr, i, j, n, max_val, y, valp);
    price_addr <= j;
end rtl;

