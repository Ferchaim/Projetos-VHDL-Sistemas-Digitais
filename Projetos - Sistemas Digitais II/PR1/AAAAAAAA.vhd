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

entity UC is
    port(
        clock, reset: in bit;
        inicia: in bit; -- Entrada de controle
        nao_Zero, diferente,  ma_menor_mb: in bit;
        e, t, l, x0, x1, s1, s2: out bit;
        fim: out bit
    );
end entity;

architecture arch_UC of UC is

    type state is (espera, ter_a_b, zero, looping, a_igl_b, a_menor_b, b_menor_a);
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

        --Logica prox estados
        next_state <= espera when (current_state = espera) and (inicia = '0') else
        espera when ((current_state = zero) or (current_state = a_igl_b)) else

        ter_a_b when (current_state = espera) and (inicia = '1') else

        zero when (current_state = ter_a_b) and (nao_Zero = '0') else 

        looping when (current_state = ter_a_b) and (nao_Zero = '1') else
        looping when (current_state = a_menor_b) else
        looping when (current_state = b_menor_a) else
            
        a_igl_b when (current_state = looping) and (diferente = '0') else 

        a_menor_b when (current_state = looping) and (ma_menor_mb = '1') else
            
        b_menor_a when (current_state = looping) and (ma_menor_mb = '0');

    -- Decodifica o estado para gerar sinais de controle

    e <= '1' when (current_state = espera) else '0'; --estado atual: espera
    t <= '1' when (current_state = ter_a_b) else '0'; --estado atual: ter_a_b
    l <= '1' when (current_state = looping) else '0'; --estado atual: looping
    x0 <= '1' when (current_state = zero) else '0'; --estado atual: zero 
    x1 <= '1' when (current_state = a_igl_b) else '0'; --estado atual: a_igl_b
    --x2 <= '1' when ((current_state = a_igl_b) or (current_state = zero)) else
    s1 <= '1' when (current_state = a_menor_b) else '0'; --estado atual: a_menor_b
    s2 <= '1' when (current_state = b_menor_a) else '0'; --estado atual: b_menor_a
    fim <= '1' when ((current_state = zero) or (current_state = a_igl_b)) else '0';

end architecture;

library ieee;
use ieee.numeric_bit.all;

entity FD is
    port(
        clock: in bit;
        A,B: in bit_vector(7 downto 0);
        e, t, l, x0, x1, s1, s2: in bit;
        fim: in bit;
        nao_Zero, diferente,  ma_menor_mb: out bit;
        nSomas: out bit_vector(8 downto 0); --FD
        MMC: out bit_vector(15 downto 0) --FD
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

    signal inter_somas: bit_vector(8 downto 0);
    signal a_in, b_in: bit_vector(7 downto 0);
    signal ma, mb: bit_vector(15 downto 0);

    begin

        regAain: register8
        port map (clock, '0', e, A, a_in);

        regBbin: register8
        port map (clock, '0', e, B, b_in);

        --regMain: register16
        --port map(clock, '0' , t , "00000000" & a_in, ma); --Erro

        --regMbin: register16 
       -- port map(clock, '0' , t , "00000000" & b_in, mb); --Erro

        --regMaMa: register16
        --port map(clock, '0' , l , ma, ma); --Erro

       -- regMbMb: register16
       -- port map(clock, '0' , l , mb, mb); --Erro

        --regNSomas0: register9
        --port map (clock, '0', t , "000000000", nSomas);

        --regNSomas0: register9
        --port map(clock, '0' , x0, inter_somas, nSomas);

        regNSomas:register9
        port map (clock, '0', fim, inter_somas, nSomas);

        --regMMC0: register16
        --port map (clock, '0', x0, "0000000000000000", MMC);

        regMMC: register16
        port map (clock, '0', fim, ma, MMC);

    -- Operações que devem ocorrer

    ma <= bit_vector((unsigned(ma) + unsigned(A))) when (s1 = '1') else
          ("00000000" & a_in) when (t = '1') else ma;
    mb <= bit_vector((unsigned(mb) + unsigned(B))) when (s2 = '1') else
          ("00000000" & b_in) when (t = '1') else mb;
    inter_somas <= bit_vector((unsigned(inter_somas)) + "000000001") when ((s1 = '1') or (s2 = '1')) else
                    "000000000" when (t = '1');
    -- Sinais de Status p/ a Uc:

    nao_Zero <= '1' when ((a_in /= "00000000") and (b_in /= "00000000")) else '0';
    diferente <= '1' when (ma /= mb) else '0';
    ma_menor_mb <= '1' when (ma < mb) else '0';

end architecture;


entity mmc is
    port(
    reset, clock: in bit; --Clock e reset na UC, mas so clock no FD
    inicia: in bit; -- A principio nos 2, mas acho que e so na UC
    A,B: in bit_vector(7 downto 0); -- So no FD
    fim: out bit; -- A principio so na UC
    nSomas: out bit_vector(8 downto 0); --FD
    MMC: out bit_vector(15 downto 0) --FD
    );
    end mmc;
architecture arch_mmc of mmc is
    component UC is
        port(
            clock, reset: in bit;
            inicia: in bit; -- Entrada de controle
            nao_Zero, diferente,  ma_menor_mb: in bit;
            e, t, l, x0, x1, s1, s2: out bit;
            fim: out bit
        );
    end component;

    component FD is
        port(
            clock: in bit;
            A,B: in bit_vector(7 downto 0);
            e, t, l, x0, x1, s1, s2: in bit;
            fim: in bit;
            nao_Zero, diferente,  ma_menor_mb: out bit;
            nSomas: out bit_vector(8 downto 0); --FD
            MMC: out bit_vector(15 downto 0) --FD
        );
    end component;

    signal e, t, l, x0, x1, s1, s2, nao_Zero, diferente,  ma_menor_mb: bit;
    signal clock_n: bit;

    begin

        clock_n <= not(clock);

        xUC: UC
        port map(clock, reset, inicia, nao_Zero, diferente, ma_menor_mb,e, t, l, x0, x1, s1, s2, fim);

        xFD: FD
        port map(clock_n, A, B,e, t, l, x0, x1, s1, s2, fim, nao_Zero, diferente,  ma_menor_mb, nSomas, MMC);



end architecture;
