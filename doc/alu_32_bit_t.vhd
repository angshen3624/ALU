
library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;

entity alu_test is
end alu_test;

architecture alu_test_my of alu_test is
  
signal  ctrl_t  : std_logic_vector(3 downto 0);
signal  A_t     : std_logic_vector(31 downto 0);
signal  B_t     : std_logic_vector(31 downto 0);
signal  cout_t  : std_logic;  -- ?1? -> carry out
signal  oflow_t : std_logic;  -- ?1? -> overflow
signal  ze_t    : std_logic;  -- ?1? -> is zero
signal  R_t     : std_logic_vector(31 downto 0);

component alu
  port (
    ctrl  : in std_logic_vector(3 downto 0);
    -- ctrl(4) for stl_stlu, ctrl(3 downto 1) for sel, ctrl(0) for cin
    -- "0XX000" for add
    -- "0XX001" for sub
    -- "0X0X1X" for and
    -- "0X1X1X" for or
    -- "00X101" for sltu
    -- "01X101" for slt 
    -- "1XXXXX" for shift left  
    A     : in std_logic_vector(31 downto 0);
    B     : in std_logic_vector(31 downto 0);
    cout  : out std_logic;  ---> carry out
    oflow : out std_logic;  ---> overflow
    ze    : out std_logic;  ---> is zero
    R     : out std_logic_vector(31 downto 0)
);
end component;

begin
  test_port : 
    alu port map(ctrl => ctrl_t,
                 A => A_t,
                 B => B_t,
                 cout => cout_t,
                 oflow => oflow_t,
                 ze => ze_t,
                 R => R_t);
  test_bench : process
  begin
     
     -- #1 ADD no overflow
     ctrl_t <= "0000";
     A_t <= x"eeeeeeee";
     B_t <= x"11111111";
     wait for 10 ns;
     
     -- #2 ADD overflow
     A_t <= x"7fffffff";
     B_t <= x"00000001";
     wait for 10 ns;
     
     -- #3 SUB 
     ctrl_t <= "0001";
     A_t <= x"eeeeeeee";
     B_t <= x"11111111";
     wait for 10 ns;
     
     -- #4 SLTU set 
     ctrl_t <= "1111";
     A_t <= x"11111111";
     B_t <= x"7eeeeeee";
     wait for 10 ns;
     
     -- #5 SLTU notSet
     A_t <= x"7eeeeeee";
     B_t <= x"11111111";
     wait for 10 ns;
     
     -- #6 SLT Set
     ctrl_t <= "0111";
     A_t <= x"eeeeeeee";
     B_t <= x"11111111";
     wait for 10 ns;
     
     -- #7 SLT notSet 
     A_t <= x"11111111";
     B_t <= x"eeeeeeee";
     wait for 10 ns;
    
     -- #8 AND
     ctrl_t <= "0010";
     A_t <= x"eeeeeeee";
     B_t <= x"11111111";
     wait for 10 ns;
     
     -- #9 OR
     ctrl_t <= "1010";
     A_t <= x"eeeeeeee";
     B_t <= x"11111111";
     wait for 10 ns;
     
     -- #10 ZERO
     ctrl_t <= "0001";
     A_t <= x"11111111";
     B_t <= x"11111111";
     wait for 10 ns;
     
     -- #11 SHIFET LEFT
     ctrl_t <= "1110";
     A_t <= x"eeeeeeee";
     B_t <= x"00000008";
     wait for 10 ns;
     
     -- #12 SHIFET LEFT
     A_t <= x"eeeeeeee";
     B_t <= x"00000000";
     wait for 10 ns;
     
  end process;
  
end architecture;
  