

Library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity alu_ctrl is
  port(
    ctrl       : in std_logic_vector(3 downto 0);
    ctrl_out   : out std_logic_vector(3 downto 0)
  );
end alu_ctrl;

architecture structural of alu_ctrl is
  
    signal wire: std_logic_vector(14 downto 0);
begin
    O3G1: not_gate port map(ctrl(2), wire(0));
    O3G2: not_gate port map(ctrl(0), wire(1));
    O3G3: and_gate port map(ctrl(1), wire(1), wire(2));
    O3G4: and_gate port map(ctrl(3), wire(0), wire(3));
    O3G5: and_gate port map(wire(2), wire(3), ctrl_out(3));
      
    O2G1: and_gate port map(ctrl(2), ctrl(1), wire(4));
    O2G2: and_gate port map(ctrl(0), wire(4), wire(8));  
    ctrl_out(2) <= wire(8);
      
    O1G1: not_gate port map(ctrl(2), wire(5));
    O1G2: not_gate port map(ctrl(0), wire(6));
    O1G3: and_gate port map(ctrl(1), wire(6), wire(7));
    O1G4: and_gate port map(wire(7), wire(5), ctrl_out(1)); 
       
    O0G1: not_gate port map(ctrl(3), wire(9));
    O0G2: not_gate port map(ctrl(2), wire(10));
    O0G3: not_gate port map(ctrl(1), wire(11));
    O0G4: and_gate port map(wire(9), wire(10), wire(12));
    O0G5: and_gate port map(wire(11), ctrl(0), wire(13));
    O0G6: and_gate port map(wire(12), wire(13), wire(14));
    O0G7: or_gate port map(wire(14), wire(8), ctrl_out(0));      
  
  
end structural;
