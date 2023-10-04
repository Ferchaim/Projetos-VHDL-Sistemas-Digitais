entity hamming is
    port (
        entrada: in bit_vector(9 downto 0);
        dados: out bit_vector(5 downto 0);
        erro: out bit
    );
end hamming;

architecture a_ha of hamming is

    signal d: bit_vector(5 downto 0);
    signal p: bit_vector(3 downto 0);
    signal p1,p2,p4,p8: bit;

begin

    d <= entrada(9 downto 4);
    p <= entrada(3 downto 0);
    p1 <= d(0) xor d(1) xor d(3) xor d(4);
    p2 <= d(0) xor d(2) xor d(3) xor d(5);
    p4 <= d(1) xor d(2) xor d(3);
    p8 <= d(4) xor d(5);

    dados <= d when (((p(0) = p1) and (p(1) = p2) and (p(2) = p4) and (p(3) = p8))    or --Talvez tenha que adicionar 
                    ((p(0) /= p1) and (p(1) = p2) and (p(2) = p4) and (p(3) = p8))    or -- os valores de quando as
                    ((p(0) = p1) and (p(1) /= p2) and (p(2) = p4) and (p(3) = p8))    or -- posições erradas estão em
                    ((p(0) = p1) and (p(1) = p2) and (p(2) /= p4) and (p(3) = p8))    or -- 11,12,13,14 ou 15. 
                    ((p(0) = p1) and (p(1) = p2) and (p(2) = p4) and (p(3) /= p8))    or
                    ((p(0) /= p1) and (p(1) /= p2) and (p(2) = p4) and (p(3) /= p8))  or
                    ((p(0) = p1) and (p(1) = p2) and (p(2) /= p4) and (p(3) /= p8))   or 
                    ((p(0) /= p1) and (p(1) = p2) and (p(2) /= p4) and (p(3) /= p8))  or
                    ((p(0) = p1) and (p(1) /= p2) and (p(2) /= p4) and (p(3) /= p8))  or
                    ((p(0) /= p1) and (p(1) /= p2) and (p(2) /= p4) and (p(3) /= p8))) else
             d(5 downto 1) & not d(0) when ((p(0) /= p1) and (p(1) /= p2) and (p(2) = p4) and (p(3) = p8)) else --Posi 3 errada
             d(5 downto 2) & not d(1) & d(0) when ((p(0) /= p1) and (p(1) = p2) and (p(2) /= p4) and (p(3) = p8)) else --Posi 5 errada
             d(5 downto 3) & not d(2) & d(1 downto 0) when ((p(0) = p1) and (p(1) /= p2) and (p(2) /= p4) and (p(3) = p8)) else --Posi 6 
             d(5 downto 4) & not d(3) & d(2 downto 0) when ((p(0) /= p1) and (p(1) /= p2) and (p(2) /= p4) and (p(3) = p8)) else --Posi 7
             d(5) & not d(4) & d(3 downto 0) when ((p(0) /= p1) and (p(1) = p2) and (p(2) = p4) and (p(3) /= p8)) else --Posi 9
             not d(5) & d(4 downto 0) when ((p(0) = p1) and (p(1) /= p2) and (p(2) = p4) and (p(3) /= p8));
             --Talvez precise add um catch all nesse final, pique else "000000"
    erro <= '1' when (((p(0) /= p1) and (p(1) /= p2) and (p(2) = p4) and (p(3) /= p8))  or
                      ((p(0) = p1) and (p(1) = p2) and (p(2) /= p4) and (p(3) /= p8))   or 
                      ((p(0) /= p1) and (p(1) = p2) and (p(2) /= p4) and (p(3) /= p8))  or
                      ((p(0) = p1) and (p(1) /= p2) and (p(2) /= p4) and (p(3) /= p8))  or
                      ((p(0) /= p1) and (p(1) /= p2) and (p(2) /= p4) and (p(3) /= p8))) else
            '0';
end a_ha; -- arch_hamming
