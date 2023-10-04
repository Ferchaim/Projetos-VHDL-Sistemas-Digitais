-- Registrador de 8 bits
entity register8 is
    port(
        clock, reset: in  bit;
        load:         in  bit;
        parallel_in:  in  bit_vector(7 downto 0);
        parallel_out: out bit_vector(7 downto 0)
    );
end entity;

architecture arch_reg of register8 is
    signal internal: bit_vector(7 downto 0);
    begin
        process(clock, reset)
        begin
            if reset = '1' then -- reset assincrono
                internal <= (others => '0'); -- "000000"
            elsif (clock'event and clock = '1') then
                if load = '1' then
                    internal <= parallel_in;
                end if;
            end if; 
        end process;
        parallel_out <= internal;
end architecture;

--Registrador de 9 bits
entity register9 is
    port(
        clock, reset: in  bit;
        load:         in  bit;
        parallel_in:  in  bit_vector(8 downto 0);
        parallel_out: out bit_vector(8 downto 0)
    );
end entity;

architecture arch_reg of register9 is
    signal internal: bit_vector(8 downto 0);
    begin
        process(clock, reset)
        begin
            if reset = '1' then -- reset assincrono
                internal <= (others => '0'); -- "000000"
            elsif (clock'event and clock = '1') then
                if load = '1' then
                    internal <= parallel_in;
                end if;
            end if; 
        end process;
        parallel_out <= internal;
end architecture;

--Registrador de 16 bits
entity register16 is
    port(
        clock, reset: in  bit;
        load:         in  bit;
        parallel_in:  in  bit_vector(15 downto 0);
        parallel_out: out bit_vector(15 downto 0)
    );
end entity;

architecture arch_reg of register16 is
    signal internal: bit_vector(15 downto 0);
    begin
        process(clock, reset)
        begin
            if reset = '1' then -- reset assincrono
                internal <= (others => '0'); -- "000000"
            elsif (clock'event and clock = '1') then
                if load = '1' then
                    internal <= parallel_in;
                end if;
            end if; 
        end process;
        parallel_out <= internal;
end architecture;

--Contador de 9 bits
library ieee ;
use ieee.numeric_bit.all;

entity upcount is
port ( Clock, Resetn, E : in bit ;
Q : out bit_vector(8 downto 0)) ;
end upcount ;

architecture Behavior of upcount is
    signal Count : bit_vector(8 downto 0) ;

begin
    process ( Clock, Resetn )
        begin
            if Resetn = '0' then
                Count <= "000000000" ;
            elsif (Clock'EVENT and Clock = '1') then
                if E = '1' THEN
                    --Count <= Count + "000000001" ;
                else
                    Count <= Count ;
                end if ;
            end if ;
    end process ;

Q <= Count ;

end Behavior ;

-- Unidade de Controle
entity UC is
    port(
        clock, reset: in bit; -- Sinais de controle global
        inicia: in bit; -- Entrada de controle
        dif_Zero, diferente,a_Menor: in bit; --Sinais de Status (vem do FD)
        fim: out bit; -- Saida de controle
        h1, h2, s1, s2, x1: out bit --Sinais de Controle para o FD  
    );
end entity;

architecture arch_UC of UC is

    type state is (espera,a_b_zero,final,menor_A,menor_B,entrada, inicio);
    signal next_state, current_state: state;

    begin
        process(clock, reset)
        begin
            if reset = '1' then	-- reset assincrono
                current_state <= espera;		
            elsif (clock'event and clock = '1') then	
                current_state <= next_state;
            end if;
        end process;

    -- Logica de proximo estado

    next_state <= espera when (current_state = espera) and (inicia = '0') else 
    -- talvez tenha que add que next_state <= espera when (fim = '1')

                  inicio when (current_state = espera) and (inicia = '1') else

                  entrada when ((current_state = inicio) and (dif_Zero = '1')) else
                  entrada when ((current_state = menor_A) or (current_state = menor_B)) else
                  --entrada when ((current_state = menor_B) else

                  a_b_zero when (current_state = inicio) and (dif_Zero = '0') else
                
                  menor_A when ((current_state = entrada) and (diferente = '1') and (a_Menor = '1')) else

                  menor_B when ((current_state = entrada) and (diferente = '1') and (a_Menor = '0')) else

                  final when (current_state = entrada) and (diferente = '0');

    -- Decodifica o estado para gerar sinais de controle

    --Controla os registradores 
    h1 <= '1' when (current_state = espera) or (current_state = menor_A) else '0';
    h2 <= '1' when (current_state = espera) or (current_state = menor_B) else '0';

    --Controla as adicoes & o nSoma
    s1 <= '1' when (current_state = menor_A) else '0'; -- Esse sinal avisa o FD que a < b
    s2 <= '1' when (current_state = menor_B) else '0'; -- Esse sinal avisa o FD que b < a

    -- Saídas de controle 
    fim <= '1' when (current_state = final) or (current_state = entrada) else '0';
    x1 <= '1' when (current_state = entrada) else '0'; -- Esse sinal avisa o FD que a = b

end arch_UC;

-- Fluxo de Dados

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

architecture arc_mmc of mmc is

    component UC is
        port(
            clock, reset: in bit; -- Sinais de controle global
            inicia: in bit; -- Entrada de controle
            dif_Zero, diferente,a_Menor: in bit; --Sinais de Status (vem do FD)
            fim: out bit; -- Saida de controle
            h1, h2, s1, s2, x1: out bit --Sinais de Controle para o FD  
        );
    end component; 

    component FD is
        port(
            clock: in bit;
            h1, h2, s1, s2, x1: in bit;
            dif_Zero, diferente,a_Menor: out bit; --Sinais de Status
            a_en, b_en: in bit_vector(7 downto 0);
            n_Somas: out  bit_vector(8 downto 0);
            inicia: in bit;
            mmc_out: out bit_vector(15 downto 0)
            
        );
    end component;

    signal h1, h2, s1, s2, x1, diferente, dif_Zero, a_Menor: bit; 
    signal clock_n: bit;

    begin

        clock_n <= not(clock);

        xUC: UC
        port map(clock, reset, inicia, dif_Zero, diferente, a_Menor, fim, h1, h2, s1, s2, x1);

        xFD: FD
        port map(clock_n, h1, h2, s1, s2, x1, dif_Zero, diferente,a_Menor,A, B,nSomas, inicia, MMC);
    
    
end arc_mmc;
