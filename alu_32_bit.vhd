
Library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity alu is
  port (
    ctrl  : in std_logic_vector(3 downto 0);      
    A     : in std_logic_vector(31 downto 0);
    B     : in std_logic_vector(31 downto 0);
    cout  : out std_logic;  ---> carry out
    oflow : out std_logic;  ---> overflow
    ze    : out std_logic;  ---> is zero
    R     : out std_logic_vector(31 downto 0)
);
end alu;

architecture structure of alu is
  
component alu_1_bit is
    port(A, B   : in std_logic; 
         sel    : in std_logic_vector(2 downto 0);
         -- 'X00' for 1_bit_adder, '0X1' for and, '1X1' for or, 'X10' for slt/sltu
         cin    : in std_logic;
         inv    : in std_logic;
         less   : in std_logic;
         result : out std_logic;
         cout   : out std_logic;
         temp   : out std_logic
       );
end component;

component alu_ctrl is
  port(
    ctrl       : in std_logic_vector(3 downto 0);
    ctrl_out   : out std_logic_vector(3 downto 0)
  );
end component;

component nor_gate_32to1 is
  port (
    x   : in  std_logic_vector(31 downto 0);
    z   : out std_logic
  );
end component;

component shift_left is
  port (
    x   : in  std_logic_vector(31 downto 0);
    y   : in  std_logic_vector(4 downto 0);
    z   : out std_logic_vector(31 downto 0)
  );
end component;

signal resultA, resultB, w, v : std_logic_vector(31 downto 0);
signal less, temp : std_logic;
signal sel_sl, sel_shift : std_logic;
signal wire0, wire1, wire2, wire3, wire4, wire5 : std_logic;
signal ctrl_o: std_logic_vector(3 downto 0);

begin
    A1: alu_ctrl port map(ctrl(3 downto 0), ctrl_o(3 downto 0));
    
    -- sel of mux for slt/sltu 
    G1: not_gate port map(ctrl(3), wire0);
    G2: and_gate port map(ctrl(1), ctrl(0), wire1);
    G3: and_gate port map(ctrl(2), wire0, wire2);
    G4: and_gate port map(wire1, wire2, sel_sl);
      
    -- sel of mux for sll
    H1: not_gate port map(ctrl(0), wire5);
    H2: and_gate port map(ctrl(1), wire5, wire3);
    H3: and_gate port map(ctrl(2), ctrl(3), wire4);
    H4: and_gate port map(wire3, wire4, sel_shift);
    
    Ivn0: not_gate port map(w(31), temp);
    Mux0: mux port map(sel_sl, temp, v(31), less);  

bigLoop: FOR i in 0 to 31 GENERATE begin
    Condition_0: If i = 0 GENERATE begin
        ALU1: alu_1_bit port map(A(i), B(i), ctrl_o(3 downto 1), ctrl_o(0), ctrl_o(0), less, resultA(i), w(i), v(i));
    end GENERATE;
     
    Condition_1_to_30: If i < 31 AND i > 0 GENERATE begin
        ALU2: alu_1_bit port map(A(i), B(i), ctrl_o(3 downto 1), w(i-1), ctrl_o(0), '0', resultA(i), w(i), v(i));
    end GENERATE;
    
    Condition_31: If i = 31 GENERATE begin
        ALU3: alu_1_bit port map(A(i), B(i), ctrl_o(3 downto 1), w(i-1), ctrl_o(0), '0', resultA(i), w(i), v(i));
    end GENERATE;
end GENERATE;

    -- shifter left
    Shift: shift_left port map(A, B(4 downto 0), resultB);

    K1: xor_gate port map(w(30), w(31), oflow);
    K2: nor_gate_32to1 port map(resultA, ze);
    cout <= w(31);
    MUX1: mux_32 port map(sel_shift, resultA, resultB, R);
    

end architecture;
