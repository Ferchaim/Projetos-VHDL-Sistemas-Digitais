--! Code your testbench here
--! or browse Examples

library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;

entity testbench is

end testbench;

architecture tb of testbench is

component melhordetres is
port (
resultado1 : in bit_vector (1 downto 0); --! resultado dos jogo1
resultado2 : in bit_vector (1 downto 0); --! resultado dos jogo2
resultado3 : in bit_vector (1 downto 0); --! resultado dos jogo3
z: out bit_vector (1 downto 0) --! resultado da disputa
);
end component;
    
    Signal  r1_in, r2_in,r3_in, z_out: bit_vector (1 downto 0);
    
    begin
      
      DUT: melhordetres port map( r1_in, r2_in,r3_in, z_out);
      process
      type test_add is record
      	J1, J2, J3, RF: bit_vector(1 downto 0); str: string (1 to 3);
      end record;

	type tests_array is array (natural range <>) of test_add; 
    							   -- J1   J2   J3    RF   test
                                   -- A vence de B
	constant tests: tests_array := (("10","10","01","10","T1 "), --! A = J1, J2 B = J3
                                    ("01","10","10","10","T2 "), --! A = J2, J3 B = J1
                                    ("10","01","10","10","T3 "), --! A = J1, J3 B = J2
                                    
                                    ("10","10","11","10","T4 "), --! A = J1, J2; J3 = Empate
                                    ("11","10","10","10","T5 "), --! A = J2, J3; J1 = Empate
                                    ("10","11","10","10","T6 "), --! A = J1, J3; J2 = Empate
                                    
                                    ("10","11","11","10","T7 "), --! A = J1; J2, J3 = Empate
                                    ("11","10","11","10","T8 "), --! A = J2; J3, J1 = Empate
                                    ("11","11","10","10","T9 "), --! A = J3; J1, J2 = Empate
                                    
                                    ("10","10","10","10","T10"), --! A = J1, J2, J3
                                    
                                    -- B vence de A
                                    ("01","01","10","01","T11"), --! B = J1, J2 A = J3
                                    ("10","01","01","01","T12"), --! B = J2, J3 A = J1
                                    ("01","10","01","01","T13"), --! B = J1, J3 A = J2
                                    
                                    ("01","01","11","01","T14"), --! B = J1, J2; J3 = Empate
                                    ("11","01","01","01","T15"), --! B = J2, J3; J1 = Empate
                                    ("01","11","01","01","T16"), --! B = J1, J3; J2 = Empate
                                    
                                    ("01","11","11","01","T17"), --! B = J1; J2, J3 = Empate
                                    ("11","01","11","01","T18"), --! B = J2; J3, J1 = Empate
                                    ("11","11","01","01","T19"), --! B = J3; J1, J2 = Empate
                                    
                                    ("01","01","01","01","T20"), --! A = J1, J2, J3
                                    
                                    -- Empate
                                    ("10","11","01","11","T21"), --! A = J1, B = J3; J2 = Empate
                                    ("10","01","11","11","T22"), --! A = J1, B = J2; J3 = Empate
                                    ("11","10","01","11","T23"), --! A = J2, B = J3; J1 = Empate
                                    ("01","10","11","11","T24"), --! A = J2, B = J1; J3 = Empate
                                    ("11","01","10","11","T25"), --! A = J3, B = J2; J1 = Empate
                                    ("01","11","10","11","T26"), --! A = J3, B = J1; J2 = Empate
                                    ("11","11","11","11","T27"), --! J1, J2, J3 = Empate
                                    
                                    -- Espera
                                    ("10","00","01","00","T23"), --! A = J1, B = J3; J2 = Espera
                                    ("10","01","00","00","T24"), --! A = J1, B = J2; J3 = Espera
                                    ("00","10","01","00","T25"), --! A = J2, B = J3; J1 = Espera
                                    ("01","10","00","00","T26"), --! A = J2, B = J1; J3 = Espera
                                    ("00","01","10","00","T27"), --! A = J3, B = J2; J1 = Espera
                                    ("01","00","10","00","T28"), --! A = J3, B = J1; J2 = Espera
                                    ("10","00","00","00","T29"), --! A = J1; J2, J3 = Espera
                                    ("00","10","00","00","T30"), --! A = J2; J1, J3 = Espera
                                    ("00","00","10","00","T31"), --! A = J3; J2, J1 = Espera
                                    ("01","00","00","00","T32"), --! B = J1; J2, J3 = Espera
                                    ("00","01","00","00","T33"), --! B = J2; J1, J3 = Espera
                                    ("00","00","01","00","T34"), --! B = J3; J2, J1 = Espera
                                    ("00","00","00","00","T35")); --! J1, J2, J3 = Espera
    begin
      for k in tests' range loop -- dentro do process, após begin
        r1_in <= tests(k).J1; 
        r2_in <= tests(k).J2;
        r3_in <= tests(k).J3;
	    wait for 1 ns; -- espera estabilizar e verifica saída
        assert (z_out = tests(k).RF) report "Fail:" & tests(k).str severity error;
      end loop;
        r1_in <= "00"; r2_in <= "00"; r3_in <= "00";-- Limpa entradas (opcional)
        
        assert false report "Test done." severity note; 
        
        wait; -- Interrompe execução
        end process;
end tb;