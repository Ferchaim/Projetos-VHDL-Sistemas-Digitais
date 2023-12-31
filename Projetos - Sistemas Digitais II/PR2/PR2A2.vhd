library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity rom_arquivo is
    port(
        addr: in bit_vector(4 downto 0);
        data: out bit_vector(7 downto 0)
    );
end rom_arquivo;

architecture arch_rom_arquivo of rom_arquivo is

    type mem_t is array(0 to 31) of bit_vector(7 downto 0);
    impure function inicializa(nome_do_arquivo: in string) return mem_t is
        file arquivo : text open read_mode is nome_do_arquivo;
        variable linha: line;
        variable temp_bv : bit_vector(7 downto 0);
        variable temp_mem: mem_t;
        begin
            for i in mem_t'range loop
                readline(arquivo, linha);
                read(linha, temp_bv);
                temp_mem(i) := temp_bv;
            end loop;
            return temp_mem;
        end;

        constant mem: mem_t := inicializa("conteudo_rom_ativ_02_carga.dat");

        begin

            data <= mem(to_integer(unsigned(addr)));

--end arch_rom_arquivo;
end architecture;


