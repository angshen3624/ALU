

Library ieee;
Use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

Entity full_adder is
port(in1, in2, c_in: in std_logic;
     sum, c_out: out std_logic);
end entity full_adder;

architecture structural of full_adder is
  
component half_adder is
port(x, y: in std_logic;
     sum, carry: out std_logic);
end component half_adder;

signal s1, s2, s3: std_logic;
begin
  H1: half_adder port map(x=>in1, y=>in2, sum=>s1, carry=>s3);
  H2: half_adder port map(x=>s1, y=>c_in, sum=>sum, carry=>s2);  
  O1: or_gate port map(s2, s3, c_out);
end structural;
