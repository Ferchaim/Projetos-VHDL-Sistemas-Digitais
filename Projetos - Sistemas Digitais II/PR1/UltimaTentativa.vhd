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

library ieee;
use ieee.numeric_bit.all;
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

    type state is (espera, ter_a_b, zero, looping, a_igl_b, a_menor_b, b_menor_a);
    signal next_state, current_state: state;

    signal a_in, b_in: bit_vector(7 downto 0);
    signal ma, mb,memec, a_en, b_en: bit_vector(15 downto 0);
    signal n_somas: bit_vector(8 downto 0);
    signal x1, e, l: bit;
    --signal nao_Zero, diferente, ma_menor_mb: bit;
    
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

     ter_a_b when ((current_state = espera) and (inicia = '1')) else

     zero when ((current_state = ter_a_b) and ((A /= "00000000") and (B /= "00000000"))) else 

     looping when ((current_state = ter_a_b) and ((A /= "00000000") and (B /= "00000000"))) else
     looping when (current_state = a_menor_b) else
     looping when (current_state = b_menor_a) else
         
     a_igl_b when ((current_state = looping) and (ma = mb)) else 

     a_menor_b when ((current_state = looping) and ((ma /= mb) and (ma < mb))) else
         
     b_menor_a when ((current_state = looping) and ((ma /= mb) and (ma > mb))) else
     
     espera;

     --Saidas de controle 

     x1 <= '1' when ((current_state = zero) or (current_state = a_igl_b)) else '0';
     e <= '1' when (current_state = espera) else '0';
     l <= '1' when (current_state = looping) else '0';

     --Operacoes:

     fim <= '1' when ((current_state = zero) or (current_state = a_igl_b)) else '0';

     a_en <= "00000000" & a_in when (current_state = espera) else 
            bit_vector((unsigned(ma) + unsigned(a_in))) when (current_state = a_menor_b)
            else ma when (current_state = looping);

     b_en <= "00000000" & a_in when (current_state = espera) else 
           bit_vector((unsigned(mb) + unsigned(b_in))) when (current_state = b_menor_a)
           else mb when (current_state = looping);

    n_somas <= "000000000" when ((current_state = ter_a_b) or (current_state = zero)) else
    bit_vector((unsigned(n_somas)) + "000000001") when ((current_state = a_menor_b) or (current_state = b_menor_a));

    memec <= ma when (current_state = a_igl_b) else "0000000000000000" when (current_state = zero);

    --Registradores:
    
    regA: register8
    port map (clock, '0', e, A, a_in);

    regB: register8 
    port map (clock, '0', e, B, b_in);
    --Se der errado, tentar tirar esses 2 register e usar o vetor A direto

    regma:register16
    port map (clock, '0', l, a_en, ma);

    regmb: register16
    port map (clock, '0', l, b_en, mb);

    regMMC: register16
    port map (clock, '0', x1, memec, MMC);

    regnSomas: register9
    port map(clock, '0', x1, n_somas, nSomas);
end architecture;
