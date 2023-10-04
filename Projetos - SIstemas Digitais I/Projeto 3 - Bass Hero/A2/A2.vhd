entity bass_hero_versus is
    port (clk, reset: in bit;
          target: in bit_vector(3 downto 0);
          played: in bit_vector(3 downto 0);
          jam: in bit;
          score: out bit_vector(2 downto 0);
          cheers: out bit
    );
end entity;

 architecture arch of bass_hero_versus is

    type state_type is (A,B,C,D,E,F);
    signal present_state, next_state : state_type;

begin
    
    ESTADO_ATUAL: process (reset, clk) is
        begin 
            if (reset = '1' and clk'EVENT and clk='1') then
                present_state <= A;
            elsif clk'EVENT and clk='1' then
                present_state <= next_state;
            end if;
    end process ESTADO_ATUAL;

    next_state <= 
        E when (present_state = F) and (target = played) and (jam = '0') else  -- começo de played = target
        A when (present_state = E) and (target = played) and (jam = '0') else
        B when (present_state = A) and (target = played) and (jam = '0') else 
        C when (present_state = B) and (target = played) and (jam = '0') else
        D when (present_state = C) and (target = played) and (jam = '0') else
        D when (present_state = D) and (target = played) and (jam = '0') else  -- fim de played = target
        B when (present_state = D) and (target /= played) and (jam = '0') else -- começo de played /= target
        B when (present_state = C) and (target /= played) and (jam = '0') else
        A when (present_state = B) and (target /= played) and (jam = '0') else
        E when (present_state = A) and (target /= played) and (jam = '0') else  
        F when (present_state = E) and (target /= played) and (jam = '0') else  
        F when (present_state = F) and (target /= played) and (jam = '0') else -- fim de played /= target
        A when (present_state = D) and (jam = '1') else -- começo de jam = '1' 
        A when (present_state = C) and (jam = '1') else
        E when (present_state = B) and (jam = '1') else
        F when (present_state = A) and (jam = '1') else
        F when (present_state = E) and (jam = '1') else
        F when (present_state = F) and (jam = '1') else -- fim de jam = '1'
        A; --catch all       
    
    score <=
        "000" when (present_state = A) else
        "001" when (present_state = B) else
        "010" when ((present_state = C) or ((present_state = D))) else
        "111" when (present_state = E) else
        "110" when (present_state = F) else
        "000"; --catch all
    
    cheers <= '1' when (present_state = D) else
              '0';
end arch; 