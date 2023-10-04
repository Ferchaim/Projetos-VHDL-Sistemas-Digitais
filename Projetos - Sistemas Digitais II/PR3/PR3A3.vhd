library ieee;
use ieee.math_real.ceil;
use ieee.math_real.log2;
use ieee.numeric_bit.all;

entity regfile is
    generic(
        regn: natural:= 32;
        wordSize: natural:= 64
    );
    port(
        clock: in bit;
        reset: in bit;
        regWrite: in bit;
        rr1, rr2, wr: in bit_vector(natural(ceil(log2(real(regn))))-1 downto 0);
        d: in bit_vector(wordSize-1 downto 0);
        q1, q2: out bit_vector(wordSize-1 downto 0)
    );
end regfile;

architecture arch_regfile of regfile is

  type registerFile is array(0 to regn-1) of bit_vector(wordSize-1 downto 0);
  signal registers : registerFile;
    
  begin

    reg_File: process(clock,reset)
        begin
            if reset = '1' then
              registers(to_integer(unsigned(wr))) <= (others => '0'); 
            elsif (clock'event and clock = '1') then
                if regWrite = '1' then
                  registers(to_integer(unsigned(wr))) <= d;  -- Write
                end if;
            end if; 
        end process;
        q1 <= registers(to_integer(unsigned(rr1)));
        q2 <= registers(to_integer(unsigned(rr2)));


end arch_regfile; -- arch

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

    component regfile is
        generic(
            regn: natural:= 32;
            wordSize: natural:= 64
        );
        port(
            clock: in bit;
            reset: in bit;
            regWrite: in bit;
            rr1, rr2, wr: in bit_vector(natural(ceil(log2(real(regn))))-1 downto 0);
            d: in bit_vector(wordSize-1 downto 0);
            q1, q2: out bit_vector(wordSize-1 downto 0)
        );
    end component;

    signal opcode: bit_vector(1 downto 0);
    signal oper2, oper1, dest: bit_vector(4 downto 0);
    signal dc,dc2: bit_vector(4 downto 0); --Vetor que guardam dados irrelevantes
    signal fds,fds2: bit_vector(15 downto 0); --Vetor que guardam dados irrelevantes
    signal v1,v2: bit_vector(15 downto 0); --Talvez tenha que mudar para out 
    signal result: bit_vector(15 downto 0);

    begin
        opcode <= instruction(16 downto 15);
        oper2 <= instruction(14 downto 10);
        oper1 <= instruction(9 downto 5);
        dest <= instruction(4 downto 0);
        
        reg1: regfile
        generic map(regn => 32, wordSize => 16)
            --   clock  reset rWrite rr1   rr2   wr    d   q1   q2
        port map(clock, reset, '0', oper1, oper2, dest, fds, v1, v2);

        result <= bit_vector(signed(v1) + signed(v2)) when (opcode = "00") else
                  bit_vector(signed(v1) + signed(resize(signed(oper2), 16))) when (opcode = "01") else
                  bit_vector(signed(v1) - signed(v2)) when (opcode = "10") else
                  bit_vector(signed(v1) - signed(resize(signed(oper2), 16))) when (opcode = "11");

        q1 <= bit_vector(signed(v1));

        reg2: regfile
        generic map(regn => 32, wordSize => 16)
            --   clock  reset rWrite rr1   rr2     wr    d      q1  q2
        port map(clock, reset, '1', dc, dc2, dest, result, fds, fds2);

end arch_calc ; -- arch