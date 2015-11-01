
Library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;


entity shift_left is
  port (
    x   : in  std_logic_vector(31 downto 0);
    y   : in  std_logic_vector(4 downto 0);
    z   : out std_logic_vector(31 downto 0)
  );
end shift_left;
  
architecture structure of shift_left is
  
signal w1, w2, w3, w4, w5: std_logic_vector(31 downto 0);

begin
bigLoop1: FOR i in 0 to 31 GENERATE begin
  Loop1: If i = 0 GENERATE begin
      Level_1a: mux port map(y(0), x(i), '0', w1(i));
  end GENERATE;
  Loop2: If i >= 1 AND i <= 31 GENERATE begin
      Level_1b: mux port map(y(0), x(i), x(i-1), w1(i));
  end GENERATE;
end GENERATE;

bigLoop2: FOR i in 0 to 31 GENERATE begin
  Loop1: If i >= 0 AND i <= 1 GENERATE begin
      Level_2a: mux port map(y(1), w1(i), '0', w2(i));
  end GENERATE;
  Loop2: If i >= 2 AND i <= 31 GENERATE begin
      Level_2b: mux port map(y(1), w1(i), w1(i-2), w2(i));
  end GENERATE;
end GENERATE;
  
bigLoop3: FOR i in 0 to 31 GENERATE begin
  Loop1: If i >= 0 AND i <= 3 GENERATE begin
      Level_3a: mux port map(y(2), w2(i), '0', w3(i));
  end GENERATE;
  Loop2: If i >= 4 AND i <= 31 GENERATE begin
      Level_3b: mux port map(y(2), w2(i), w2(i-4), w3(i));
  end GENERATE;
end GENERATE;
  
bigLoop4: FOR i in 0 to 31 GENERATE begin
  Loop1: If i >= 0 AND i <= 7 GENERATE begin
      Level_4a: mux port map(y(3), w3(i), '0', w4(i));
  end GENERATE;
  Loop2: If i >= 8 AND i <= 31 GENERATE begin
      Level_4b: mux port map(y(3), w3(i), w3(i-8), w4(i));
  end GENERATE;
end GENERATE;
  
bigLoop5: FOR i in 0 to 31 GENERATE begin
  Loop1: If i >= 0 AND i <= 15 GENERATE begin
      Level_5a: mux port map(y(4), w4(i), '0', z(i));
  end GENERATE;
  Loop2: If i >= 16 AND i <= 31 GENERATE begin
      Level_5b: mux port map(y(4), w4(i), w4(i-8), z(i));
  end GENERATE;
end GENERATE;

end architecture;