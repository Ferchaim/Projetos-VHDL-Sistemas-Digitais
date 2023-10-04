entity controlunit is
    port(
        --To Datapath
        reg2loc: out bit; --
        uncondBranch: out bit;
        branch: out bit; --
        memRead: out bit; --
        memToReg: out bit; --
        aluOp: out bit_vector(1 downto 0); --
        memWrite: out bit; --
        aluSrc: out bit; --
        regWrite: out bit; --
        --From Datapath
        opcode: in bit_vector(10 downto 0)
    );
end entity;

architecture arch_controlunit of controlunit is

        signal STUR, LDUR, CBZ, B, R: bit;

    begin

        STUR <= '1' when (opcode = "11111000000") else '0';
        LDUR <= '1' when (opcode = "11111000010") else '0';
        R <= '1' when (opcode = "10001011000" or opcode = "11001011000" or opcode = "10001010000" or opcode = "10101010000")  else '0';
        CBZ <= '1' when (opcode(10 downto 3) = "10110100") else '0'; --Talvez seja opcode(10 downto 3) no lugar de 7 downto 0
        B <= '1' when (opcode(10 downto 5) = "000101") else '0'; --Talvez seja opcode(10 downto 5) no lugar de 5 downto 0 
        
        reg2loc <= '0' when (R = '1') else
                   '1' when (STUR = '1' or CBZ = '1') else
                   '0'; --Catch all, n sei o pra B ainda
        aluSrc <= '0' when (R = '1' or CBZ = '1') else
                  '1' when (STUR = '1' or LDUR = '1') else
                  '0'; --Catch all, n sei o pra B ainda
        memToReg <= '0' when (R = '1') else
                    '1' when (LDUR = '1') else
                    '0'; --Catch all, n sei o pra B ainda
        regWrite <= '0' when (STUR = '1' or CBZ = '1') else
                    '1' when (R = '1' or LDUR = '1') else
                    '0'; --Catch all, n sei o pra B ainda
        memRead <= '0' when (R = '1' or STUR = '1' or CBZ = '1') else
                   '1' when LDUR = '1' else
                   '0'; --Catch all + B n sei
        memWrite <= '0' when (R = '1' or LDUR = '1' or CBZ = '1') else
                    '1' when STUR = '1' else
                    '0'; --Catch all + B n sei
        branch <= '0' when (R = '1' or LDUR = '1' or STUR = '1') else
                  '1' when CBZ = '1' else
                  '0'; --Catch all + B n sei
        aluOp <= "00" when (LDUR = '1' or STUR = '1') else
                 "01" when CBZ = '1' else
                 "10" when R = '1' else
                 "11"; --Catch all, mas acho q eh o B
        uncondBranch <= '1' when B = '1' else '0';
                  

end arch_controlunit ; -- _controlunit