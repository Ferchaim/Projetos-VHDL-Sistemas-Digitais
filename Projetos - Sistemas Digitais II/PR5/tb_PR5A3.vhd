library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_bit.all;

entity testbench is
end testbench;

architecture arch_tb of testbench is

    component alucontrol is 
    port(
    aluop: in bit_vector(1 downto 0);
    opcode: in bit_vector(10 downto 0);
    aluCtrl: out bit_vector(3 downto 0)
    );
end component;
    
signal aluop_in: bit_vector(1 downto 0);
signal opcode_in: bit_vector(10 downto 0);
signal aluctrl_out: bit_vector(3 downto 0);
constant clockPeriod : time := 2 ns;
signal clock_in: bit := '0';
signal simulando: bit := '0';
    
begin

	DUT: alucontrol
    port map (aluop_in, opcode_in, aluctrl_out);
    clock_in <= (simulando and (not clock_in)) after clockPeriod/2;

    stimulus: process is

		type test_record is record
  			aluop: bit_vector(1 downto 0); 
            opcode: bit_vector(10 downto 0);
            aluctrl: bit_vector(3 downto 0);
			str : string(1 to 2);
		end record;

		type tests_array is array (natural range <>) of test_record;
		constant tests : tests_array :=
       
      (
      ("00", "00001001110", "0010", "D1"),  
      ("01", "10010011011", "0111", "C1"),
      ("10", "10001011000", "0010", "R1"),
      ("10", "11001011000", "0110", "R2"),
      ("10", "10001010000", "0000", "R3"),
      ("10", "10101010000", "0001", "R4")
        );
           
		begin 
			assert false report "Test start." severity note;
			simulando <= '1';
    
		for k in tests'range loop
			

            wait for clockPeriod;
			aluop_in <= tests(k).aluop;
			opcode_in <= tests(k).opcode;

            wait for 1*clockPeriod;
            
          assert (tests(k).aluctrl = aluctrl_out)
                report "Fail: aluctrl" & tests(k).str severity error;


		end loop;

		assert false report "Test done." severity note;
		simulando <= '0';
		wait;
	end process;
end architecture;