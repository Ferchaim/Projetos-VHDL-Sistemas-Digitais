library ieee;
use ieee.numeric_bit.all;

entity FD is
    port(
        clock: in bit;
        h1, h2, s1, s2, x1: in bit;
        dif_Zero, diferente,a_Menor: out bit; --Sinais de Status
        a_en, b_en: in bit_vector(7 downto 0);
        n_Somas: out  bit_vector(8 downto 0);
        inicia: in bit;
        mmc_out: out bit_vector(15 downto 0)
        
    );
end entity;

architecture arch_FD of FD is
    component register8 is
        port(
            clock, reset: in  bit;
            load:         in  bit;
            parallel_in:  in  bit_vector(7 downto 0);
            parallel_out: out bit_vector(7 downto 0)
        );
    end component;

    component register9 is
        port(
            clock, reset: in  bit;
            load:         in  bit;
            parallel_in:  in  bit_vector(8 downto 0);
            parallel_out: out bit_vector(8 downto 0)
        );
    end component;

    component register16 is
        port(
            clock, reset: in  bit;
            load:         in  bit;
            parallel_in:  in  bit_vector(15 downto 0);
            parallel_out: out bit_vector(15 downto 0)
        );
    end component;

    component upcount is
        port ( Clock, Resetn, E : in bit;
        Q : out bit_vector(8 downto 0));
    end component ;

    --signal ma, mb: bit_vector(15 downto 0);
    --signal a_in, b_in: bit_vector(7 downto 0);
    signal mA, mB: bit_vector(15 downto 0);
    signal a_in, b_in: bit_vector(15 downto 0);
    signal counter: bit_vector(8 downto 0);
        
    begin 

    regA: register16
    port map(clock, '0', h1, a_in, mA);

    regB: register16
    port map(clock, '0', h2, b_in, mB);

    regnSomas: register9
    port map(clock, '0', h2, counter, n_Somas);

    regMMC: register16
    port map (clock, '0', x1, mA, mmc_out);

    --Atualizar mB e nSomas quando 
    --ma <= bit_vector((unsigned(ma) + unsigned(a_en))) when s1 = '1' else ma;
    --mb <= bit_vector((unsigned(mb) + unsigned(b_en))) when s2 = '1' else mb;

    a_in <= a_en when (s1 = '0') else -- a_in se liga a a_en qnd estamos em qlq estado fora o estado "a_maior_b"
                bit_vector((unsigned(mA) + unsigned(a_in)));

    b_in <= b_en when (s2 = '0') else
                bit_vector((unsigned(mB) - unsigned(b_in)));

    counter <= bit_vector((unsigned(counter)) + "000000001") when ((s1 = '1') or (s2 = '1'));

    --Sinais de status para a UC
    dif_Zero <= '1' when (a_en /= "00000000") and (b_en /= "00000000") else '0';
    diferente <= '1' when (ma /= mb) else '0';
    a_Menor <= '1' when (ma < mb) else '0';

end architecture;




ma <= A se (estado = ter_a_b) ou 
      bit_vector((unsigned(mA) + unsigned(A))) se (estado = a_menor_b) else
      ma;

mb <= B se (estado = ter_a_b) ou bit_vector((unsigned(mb) + unsigned(B))) se (estado = b_menor_a) else
ma;
      