library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_bit.all;

entity testbench is
end testbench;

architecture arch_tb of testbench is

    component signExtend is 
    port(
        i: in bit_vector(31 downto 0);
        o: out bit_vector(63 downto 0)
    );
end component;
    
    signal i_in: bit_vector(31 downto 0);
    signal o_out: bit_vector(63 downto 0);
    constant clockPeriod : time := 2 ns;
    signal clock_in: bit := '0';
    signal simulando: bit := '0';
    
begin

	DUT: signExtend
    port map (i_in, o_out);
    clock_in <= (simulando and (not clock_in)) after clockPeriod/2;

    stimulus: process is

		type test_record is record
  			i: bit_vector(31 downto 0); --00 and 01 or 10 soma 11 lst
            o: bit_vector(63 downto 0);
			str : string(1 to 2);
		end record;

		type tests_array is array (natural range <>) of test_record;
		constant tests : tests_array :=
       
      (
      ("11111000010100101101000000000100", "1111111111111111111111111111111111111111111111111111111100101101","L1"),  
      ("11111000010001101101001110010001", "0000000000000000000000000000000000000000000000000000000001101101","L0"),
      
      
      ("11111000000000101100001111101010", "0000000000000000000000000000000000000000000000000000000000101100", "S0"),
      ("11111000000101100111000001101101", "1111111111111111111111111111111111111111111111111111111101100111", "S1"),
      
      
      ("10110100101111110110110110001001", "1111111111111111111111111111111111111111111111011111101101101100", "C1"),
      ("10110100001010010010011101011110", "0000000000000000000000000000000000000000000000010100100100111010", "C0"),
      
      
      ("00010100011001100110100011100110", "0000000000000000000000000000000000000000011001100110100011100110", "B1"),
      ("00010111101110101100011101001001", "1111111111111111111111111111111111111111101110101100011101001001", "B0")
        );
           
		begin 
			assert false report "Test start." severity note;
			simulando <= '1';
    
		for k in tests'range loop
			

            wait for clockPeriod;
			i_in <= tests(k).i;

            wait for 1*clockPeriod;
            
          assert (tests(k).o = o_out)
                report "Fail: o " & tests(k).str severity error;


		end loop;

		assert false report "Test done." severity note;
		simulando <= '0';
		wait;
	end process;
end architecture;