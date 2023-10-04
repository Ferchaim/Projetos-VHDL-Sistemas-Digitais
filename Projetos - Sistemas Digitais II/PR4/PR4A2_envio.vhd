library ieee;
use ieee.numeric_bit.all;

entity alu is
    generic (
        size: natural := 10 -- bit size
    );
    port (
        A, B : in bit_vector(size-1 downto 0); -- inputs
        F : out bit_vector(size-1 downto 0); -- outputs
        S : in bit_vector(3 downto 0); -- op selection
        Z : out bit; -- zero flag
        Ov : out bit; -- overflow flag
        Co : out bit -- carry out
    );
end entity alu; 

architecture arch_alu64 of alu is
    component fulladder is
        port (
                a, b, cin: in bit;
                s, cout: out bit
             );
    end component;

    component alu1bit is
        port(
            a, b, less, cin: in bit;
            result, cout, set, overflow: out bit;
            ainvert, binvert: in bit;
            operation: in bit_vector(1 downto 0)
        );
    end component; 

    signal result_parc, cout_parc, set_parc, overflau, Z_parc : bit_vector(size-1 downto 0);
    --signal Z_par : bit;
    --signal Zx : bit;

    begin
        -- Instanciando todas as alus
        alus: for i in size-1 downto 0 generate -- Talvez seja 2*size - 1 no lugar de size - 1
            alus0: if i=0 generate
                alu0: alu1bit port map(A(i),B(i),set_parc(size-1),S(2),result_parc(i),cout_parc(i),set_parc(i),overflau(i),S(3),S(2),S(1 downto 0));
            end generate;
            alus1_31: if i>0 generate
                alu1_31: alu1bit port map(A(i),B(i),'0',cout_parc(i-1),result_parc(i),cout_parc(i),set_parc(i),overflau(i),S(3),S(2),S(1 downto 0));
            end generate;
        end generate alus;

        F <= result_parc;
        Ov <= overflau(size-1);
        Co <= cout_parc(size-1);
        --Z_x <= result_parc(0) or result_parc(1);
        --Z_parc(0) <= result_parc(0);
        Z <= '1' when (signed(result_parc) = 0) else '0';
end arch_alu64 ; -- arch_alu64