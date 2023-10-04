entity fulladder is
    port (
      a, b, cin: in bit;
      s, cout: out bit
    );
   end entity;

architecture structural of fulladder is

    signal axorb: bit;

  begin
    axorb <= a xor b;
    s <= axorb xor cin;
    cout <= (axorb and cin) or (a and b);
end architecture;

-------------------------------------------------------------------------------

entity alu1bit is
    port(
        a, b, less, cin: in bit;
        result, cout, set, overflow: out bit;
        ainvert, binvert: in bit;
        operation: in bit_vector(1 downto 0)
    );
end entity;

architecture arch_alu1bit of alu1bit is

    component fulladder is
        port (
                a, b, cin: in bit;
                s, cout: out bit
             );
    end component;

    signal a_in, b_in, e, ou, somar, pass_b : bit;
    signal resul_soma, cout_soma, overflau : bit;
    signal resul_or, resul_and : bit;
    signal parc_pass_b : bit;
begin

    --UC
    e <= '1' when (operation = "00") else '0';
    ou <= '1' when (operation = "01") else '0';
    somar <= '1' when (operation = "10") else '0';
    pass_b <= '1' when (operation = "11") else '0';
    

    -- FD
    -- Inverter a e b
    a_in <= not a when (ainvert = '1') else a;
    b_in <= not b when (binvert = '1') else b;

    -- Soma e Subtração
    Somador: fulladder
             port map (a_in, b_in, cin, resul_soma, cout_soma);
    -- OR
    resul_or <= a_in or b_in;

    -- AND e NOR
    resul_and <= a_in and b_in;

    -- SLT
    parc_pass_b <= b when (pass_b = '1');

    -- Overflau
    overflau <= cin xor cout_soma;

    -- Saídas
    set <= resul_soma;
    overflow <= overflau;
    cout <= cout_soma;
    result <= resul_and when (e = '1') else
              resul_or when (ou = '1') else
              resul_soma when (somar = '1') else
              parc_pass_b when (pass_b = '1');

end arch_alu1bit ; -- arch_alu

-----------------------------------------------------------------------------------

library ieee;
use ieee.numeric_bit.all;

entity alu is
    generic (
        size: natural := 64 -- bit size
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
        Z <= '1' when (signed(result_parc) = 0) else '0';
        
end arch_alu64 ; -- arch_alu64