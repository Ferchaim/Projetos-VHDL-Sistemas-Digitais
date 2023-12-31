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

    constant MEM_DEPTH : integer := 2**ADDR_WIDTH;
    type mem_type is array (0 to MEM_DEPTH-1) of signed(DATA_WIDTH-1 downto 0);
    
    impure function init_mem(mif_file_name : in string) return mem_type is
        file mif_file : text open read_mode is mif_file_name;
        variable mif_line : line;
        variable temp_bv : bit_vector(DATA_WIDTH-1 downto 0);
        variable temp_mem : mem_type;
    begin
        for i in mem_type'range loop
            readline(mif_file, mif_line);
            read(mif_line, temp_bv);
            temp_mem(i) := signed(to_stdlogicvector(temp_bv));
        end loop;
        return temp_mem;

    end;
    
    constant mem : mem_type := init_mem("mem_init_vhd.mif");
    
        begin

            data <= mem(to_integer(unsigned(addr)));

end architecture;
