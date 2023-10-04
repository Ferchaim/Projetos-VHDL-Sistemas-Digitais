library ieee;
use ieee.math_real.ceil;
use ieee.math_real.log2;
use ieee.numeric_bit.all;
use ieee.numeric_std.resize;

entity calc is
    port(
        clock: in bit;
        reset: in bit;
        instruction: in bit_vector(16 downto 0);
        q1: out bit_vector(15 downto 0)
    );
end calc;

architecture arch_calc of calc is

    type registerFile is array(0 to 31) of bit_vector(15 downto 0);
    signal registers : registerFile;
    signal opcode: bit_vector(1 downto 0);
    signal oper2, oper1, dest: bit_vector(4 downto 0);
    signal v1,v2: bit_vector(15 downto 0); 
    signal result: bit_vector(15 downto 0);

    begin

        opcode <= instruction(16 downto 15);
        oper2 <= instruction(14 downto 10);
        oper1 <= instruction(9 downto 5);
        dest <= instruction(4 downto 0);

        v1 <= registers(to_integer(signed(oper1)));
        v2 <= registers(to_integer(unsigned(oper2)));
        q1 <= registers(to_integer(signed(oper1)));

        result <= bit_vector(signed(v1) + signed(v2)) when (opcode = "00") else
        bit_vector(signed(v1) + signed(resize(signed(oper2), 16))) when (opcode = "01") else
        bit_vector(signed(v1) - signed(v2)) when (opcode = "10") else
        bit_vector(signed(v1) - signed(resize(signed(oper2), 16))) when (opcode = "11");

      reg_File: process(clock,reset)
          begin
              if reset = '1' then
                registers(to_integer(unsigned(dest))) <= (others => '0'); 
                registers(to_integer(unsigned(oper1))) <= (others => '0'); 
                registers(to_integer(unsigned(oper2))) <= (others => '0'); 
              elsif (clock'event and clock = '1') then
                registers(to_integer(unsigned(dest))) <= result;  -- Write
              end if; 
          end process;
          
          --q2 <= registers(to_integer(unsigned(rr2)));

end arch_calc ; -- _calc