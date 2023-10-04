library ieee;
use ieee.numeric_bit.all;

entity ram is
    generic(
        addressSize : natural := 5;
        wordSize : natural := 8
    );
    port(
        ck, wr : in bit;
        addr : in bit_vector(addressSize - 1 downto 0);
        data_i : in bit_vector(wordSize - 1 downto 0);
        data_o : out bit_vector(wordSize - 1 downto 0)
    );

end ram;

architecture behave of ram is

    constant mem_depth : integer := 2**addressSize;
    type mem_t is array(0 to mem_depth - 1) of bit_vector(wordSize - 1 downto 0);
    signal mem: mem_t;

    begin
        process(ck, wr)
        begin		
            if (ck'event and ck = '1' and wr = '1') then	
                mem(to_integer(unsigned(addr))) <= data_i;
            --elsif (ck = '1') then
                --data_o <= mem(to_integer(unsigned(addr)));
            end if;
        end process;
        
        data_o <= mem(to_integer(unsigned(addr)));

end behave;

