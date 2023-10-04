entity UC is
    port(

    );
end entity;

architecture arch_UC of UC is

    begin

end architecture;














entity mmc is
    port(
    reset, clock: in bit; --Entradas de controle global
    inicia: in bit; -- Entrada de controle
    A,B: in bit_vector(7 downto 0); -- Entrada de dados
    fim: out bit; --Saida de controle
    nSomas: out bit_vector(8 downto 0); --Saida de dados
    MMC: out bit_vector(15 downto 0) --Saida de dados
    );
end mmc;