library ieee;
use ieee.numeric_std.all;

entity signExtend is
    port(
        i: in bit_vector(31 downto 0); -- input
        o: out bit_vector(63 downto 0) -- output
    );
end signExtend;

architecture arch_signExtend of signExtend is

    --signal i_in,o_out1, o_out2 : bit_vector(31 downto 0);
    signal opcode_D: bit_vector(10 downto 0);
    signal opcode_CBZ: bit_vector(7 downto 0);
    signal opcode_B: bit_vector(5 downto 0);
    signal add_B: bit_vector(25 downto 0);
    signal add_D: bit_vector(8 downto 0);
    signal add_CBZ: bit_vector(18 downto 0);
    signal address: bit_vector(25 downto 0);
    signal o_B, o_D, o_CBZ: bit_vector(63 downto 0);
    --signal o_out1, o_out2 : bit_vector(63 downto 0);

begin

    opcode_D <= i(31 downto 21);
    opcode_CBZ <= i(31 downto 24);
    opcode_B <= i(31 downto 26);

    add_B <= i(25 downto 0);
    add_D <= i(20 downto 12);
    add_CBZ <= i(23 downto 5);

    o_B <= ("11111111111111111111111111111111111111" & add_B) when (add_B(25) = '1') else ("00000000000000000000000000000000000000" & add_B);
    o_D <= ("1111111111111111111111111111111111111111111111111111111" & add_D) when (add_D(8) = '1') else ("0000000000000000000000000000000000000000000000000000000" & add_D);
    o_CBZ <= ("111111111111111111111111111111111111111111111" & add_CBZ) when (add_CBZ(18) = '1') else ("000000000000000000000000000000000000000000000" & add_CBZ);


    o <=  o_B when (opcode_B = "000101") else
          o_CBZ when (opcode_CBZ = "10110100") else
          o_D when (opcode_D = "11111000000" or opcode_D = "11111000010");

    --i_in <= i;
    --o_out1(31 downto 0) <= i_in;
    --o_out2 <= "00000000000000000000000000000000000000"; --38 bits
    --o <= o_out2 & o_out1;

    --"00000000000000000000000000000000000000"   "0000000000000000000000000000000000000000000000000000000"  "000000000000000000000000000000000000000000000"
    --"11111111111111111111111111111111111111"   "1111111111111111111111111111111111111111111111111111111"  "111111111111111111111111111111111111111111111"
end arch_signExtend; -- arch