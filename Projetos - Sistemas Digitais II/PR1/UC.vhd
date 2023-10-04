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