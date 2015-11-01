
library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity nor_gate_32to1 is
  port (
    x   : in  std_logic_vector(31 downto 0);
    z   : out std_logic
  );
end nor_gate_32to1;

architecture structure of nor_gate_32to1 is

signal w: std_logic_vector(30 downto 0);
begin
  
--w0 to w15
Loop1: FOR i in 0 to 15 GENERATE begin
    G0: or_gate port map(x(i), x(31-i), w(i));
end GENERATE;

--w16 to w23
Loop2: FOR j in 0 to 7 GENERATE begin
    G1: or_gate port map(w(j), w(15-j), w(16+j));
end GENERATE;

--w24 to w27
    G2: or_gate port map(w(16), w(17), w(24));
    G3: or_gate port map(w(18), w(19), w(25));
    G4: or_gate port map(w(20), w(21), w(26));
    G5: or_gate port map(w(22), w(23), w(27));
      
--w28 to w30
    G6: or_gate port map(w(24), w(25), w(28));
    G7: or_gate port map(w(26), w(27), w(29));
    G8: or_gate port map(w(28), w(29), w(30));
    
    G9: not_gate port map(w(30),z);
end structure;
    