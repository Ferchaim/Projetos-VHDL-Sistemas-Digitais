--! Code your testbench here
--! or browse Examples

library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;

entity testbench is

end testbench;

architecture tb of testbench is

component jokempo is
port(
  a : in bit_vector (1 downto 0); --! gesto do jogador A
  b : in bit_vector (1 downto 0); --! gesto do jogador B
  y : out bit_vector (1 downto 0) --! resultado do jogo
);
end component;
    
    Signal  a_in, b_in, y_out: bit_vector (1 downto 0);
    
    begin
      
      DUT: jokempo port map(a_in, b_in, y_out);
      process
      type test_add is record
      	a, b, y: bit_vector(1 downto 0); str: string (1 to 3);
      end record;

	type tests_array is array (natural range <>) of test_add; 
    							   --  a    b    y   test
	constant tests: tests_array := (("01","11","10","A>B"), --! A=Pedra(01), B=Tesoura(11)
                                    ("10","01","10","A>B"), --! A=Papel(10), B=Pedra(01)
                                    ("11","10","10","A>B"), --! A=Tesoura(11), B=Papel(10)
                                    ("01","10","01","B>A"), --! A=Pedra(01), B=Papel(10)
                                    ("10","11","01","B>A"), --! A=Papel(10), B=Tesoura(11)
                                    ("11","01","01","B>A"), --! A=Tesoura(11), B=Pedra(01)
                                    ("01","01","11","A=B"), --! A=Pedra(01), B=Pedra(01)
                                    ("10","10","11","A=B"), --! A=Papel(10), B=Papel(10)
                                    ("11","11","11","A=B"), --! A=Tesoura(11), B=Tesoura(11)
                                    ("11","00","00","AB?"), --! A=Tesoura(11), B=Espera(11)
                                    ("00","11","00","A?B")); --! A=Espera(00), B=Tesoura(11)
    begin
      for k in tests' range loop -- dentro do process, após begin
        a_in <= tests(k).a; 
        b_in <= tests(k).b;
	    wait for 1 ns; -- espera estabilizar e verifica saída
        assert (y_out = tests(k).y) report "Fail:" & tests(k).str severity error;
      end loop;
        a_in <= "00"; b_in <= "00"; -- Limpa entradas (opcional)
        
        assert false report "Test done." severity note; 
        
        wait; -- Interrompe execução
        end process;
end tb;