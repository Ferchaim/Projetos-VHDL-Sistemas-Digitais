entity alu1bit is
    port(
        a, b, less, cin: in bit;
        result, cout, set, overflow: out bit;
        ainvert, binvert: in bit;
        operation: in bit_vector(1 downto 0)
    );
end entity;

architecture arch_alu of alu1bit is

    component fulladder is
        port (
                a, b, cin: in bit;
                s, cout: out bit
             );
    end component;

    signal a_in, b_in, e, ou, somar, slt : bit;
    signal resul_soma, cout_soma, overflau : bit;
    signal resul_or, resul_and : bit;
    signal parc_slt : bit;
begin

    --UC
    e <= '1' when (operation = "00") else '0';
    --e <= '1' when (operation = "00" and ainvert = '0' and binvert = '0') else '0';
    --nou <= '1' when (operation = "00" and ainvert = '1' and binvert = '1') else '0';   
    --ou <= '1' when (operation = "01" and ainvert = '0' and binvert = '0') else '0'; 
    ou <= '1' when (operation = "01") else '0';
    --somar <= '1' when (operation = "10" and ainvert = '0' and binvert = '0') else '0';
    --subtrair <= '1' when (operation = "10" and ainvert = '0' and binvert = '1') else '0';
    somar <= '1' when (operation = "10") else '0';
    slt <= '1' when (operation = "11") else '0';
    

    -- FD

    -- Inverter a e b
    a_in <= not a when (ainvert = '1') else a;
    b_in <= not b when (binvert = '1') else b;

    -- Determinar carry_in:
    --car_in <= '1' when (binvert = '1' and somar = '1') else '0';

    -- Soma e Subtração
    Somador: fulladder
             port map (a_in, b_in, cin, resul_soma, cout_soma);
    --Subtrator: fulladder
             --port map(a_in, b_in, '1', resul_subtra, cout_sub);

    -- OR
    resul_or <= a_in or b_in;

    -- AND e NOR
    resul_and <= a_in and b_in;

    -- SLT
    parc_slt <= less when (slt = '1');

    -- Overflau
    --overflau <= '1' when (cout_soma = '1') else '0';
    overflau <= cin xor cout_soma;

    -- Saídas
    set <= resul_soma;
    overflow <= overflau;
    cout <= cout_soma;
    result <= resul_and when (e = '1') else
              resul_or when (ou = '1') else
              resul_soma when (somar = '1') else
              parc_slt when (slt = '1');

end arch_alu ; -- arch_alu