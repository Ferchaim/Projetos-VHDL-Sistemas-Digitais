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
  --component reg is
    --port(clock: in bit;
      --reset: in bit;
      --load:  in bit;
      --d:     in bit_vector(wordSize-1 downto 0);
     -- q:     out bit_vector(wordSize-1 downto 0));
  --end component;

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