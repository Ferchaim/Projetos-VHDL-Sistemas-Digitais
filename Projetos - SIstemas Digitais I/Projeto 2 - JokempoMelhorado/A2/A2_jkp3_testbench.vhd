--! Code your testbench here
--! or browse Examples

library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;

entity testbench2 is

end testbench2;

architecture tb of testbench2 is

component jkp3 is
port(
reset, clock :	in bit;
    loadA, loadB :	in bit;
    atualiza :		in bit;
    a1, a2, a3 :	in bit_vector(1 downto 0);
    b1, b2, b3 :	in bit_vector(1 downto 0);
    z :				out bit_vector(1 downto 0)
);
end component;

	signal a1_in, a2_in, a3_in, b1_in, b2_in, b3_in : bit_vector (1 downto 0);
	signal loadA, loadB, atualiza, reset, clock : bit;
    Signal z_out : bit_vector(1 downto 0);
    
    begin
      
      DUT: jkp3 port map(reset, clock, loadA, loadB, atualiza, a1_in, a2_in, a3_in,
      					 b1_in,b2_in, b3_in, z_out);
      
      process
      type test_add is record
      	t_A1, t_A2, t_A3, t_B1, t_B2, t_B3: bit_vector(1 downto 0);
        t_loadA, t_loadB, t_atualiza, t_reset, t_clock1, t_clock2: bit;
        t_z: bit_vector(1 downto 0);
        str: string (1 to 3);
      end record;

	type tests_array is array (natural range <>) of test_add;
    
    							   -- Pedra = 01, Papel = 10, Tesoura = 11, Espera = 00; ASSUME-SE AQUI QUE JOKEMPOTRIPLO FUNCIONA
    							   -- t_A1 t_A2  t_A3  t_B1  t_B2  t_B3 t_loadA t_loadB t_atualiza  t_reset  t_clock1 t_clock2  t_z    test 
	constant tests: tests_array := (("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '1',    "00",  "T1 "), --! COMANDOS ZERADOS
    								("01", "10", "11", "11", "01", "10",  '1',   '1',    '1',        '1',      '0',     '1',    "10",  "T2 "), --! TUDO OK
                                    ("11", "11", "11", "11", "11", "11",  '1',   '1',    '1',        '0',      '0',     '1',    "00",  "T3 "), --! RESSETA;
                                    ("01", "10", "11", "11", "01", "10",  '1',   '1',    '1',        '1',      '0',     '0',    "00",  "T4 "), --! CLK N SOBE ;
    								("01", "10", "11", "11", "01", "10",  '1',   '1',    '1',        '1',      '1',     '1',    "00",  "T5 "), --! CLK FICA ALTO ;
                                    ("01", "10", "11", "11", "01", "10",  '1',   '1',    '0',        '1',      '0',     '1',    "00",  "T6 "), --! N ATUALIZA;
                                    ("01", "10", "11", "11", "01", "10",  '0',   '1',    '1',        '1',      '0',     '1',    "00",  "T7 "), --! LOAD A N SOBE
                                    
                                    ("01", "10", "11", "11", "01", "10",  '1',   '0',    '1',        '1',      '0',     '1',    "00",  "T8 "), --! LOAD B N SOBE
                                    ("00", "00", "00", "00", "00", "00",  '1',   '1',    '1',        '1',      '0',     '1',    "00",  "T9 "), --! ENTRADAS NULAS
                                    ("10", "10", "10", "10", "10", "10",  '1',   '1',    '1',        '1',      '0',     '1',    "11",  "T10"), --! TUDO OK EMPATE
                                    ("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '0',    "00",  "T11"), --! 
                                   
                                   ("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '0',    "00",  "T13"), --! 
    							   ("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '0',    "00",  "T14"), --! 
                                   ("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '0',    "00",  "T15"), --! 
                                   ("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '0',    "00",  "T16"), --! 
    							   ("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '0',    "00",  "T17"), --! 
                                   ("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '0',    "00",  "T18"), --! 
                                   ("01", "10", "11", "11", "01", "10",  '0',   '0',    '0',        '0',      '0',     '0',    "00",  "T19")  --!
                                   ); 
    begin
     
      for k in tests' range loop -- dentro do process, após begin
      	a1_in    <= "00"; -- forçar saida em t-1 = 00
        a2_in    <= "00";
        a3_in    <= "00";
        b1_in    <= "00";
        b2_in    <= "00";
        b3_in    <= "00";
        loadA    <= '1';
        loadB    <= '1';
        atualiza <= '1';
        reset    <= '0';
        clock    <= '0';
      	wait for 1 ns; -- espera estabilizar e verifica saída
        clock    <= '1'; 
        
      	wait for 1 ns; -- espera estabilizar e verifica saída
        assert (z_out = "00") report "Erro ao zerar a saída com reset " & tests(k).str severity error;
      
        a1_in <= tests(k).t_A1; 
        a2_in <= tests(k).t_A2;
        a3_in <= tests(k).t_A3;
        b1_in <= tests(k).t_B1;
        b2_in <= tests(k).t_B2;
        b3_in <= tests(k).t_B3;
        loadA <= tests(k).t_loadA;
        loadB <= tests(k).t_loadB;
        atualiza <= tests(k).t_atualiza;
        reset <= tests(k).t_reset;
        
        wait for 1 ns;
        
        clock <= tests(k).t_clock1;
        
	    wait for 1 ns; -- espera estabilizar e verifica saída
        
        -- Aqui, a saida de melhor de tres é 0, pois clk n subiu desde que existem as entradas
        assert (z_out = "00") report "Fail part one: " & tests(k).str severity error;

        clock <= tests(k).t_clock2;
        
        wait for 1 ns; -- espera estabilizar e verifica saída
        -- Aqui, a saida de melhor de tres está correta, mas z ainda não foi atualizada pois clk n subiu desde a estabilização da saída de melhordetres
        clock <= tests(k).t_clock1;
        wait for 1 ns;
        clock <= tests(k).t_clock2;
        wait for 1 ns;
		
        
        assert (z_out = tests(k).t_z) report "Fail part two:" & tests(k).str severity error;
      end loop;   
            
      
        
       assert false report "Test done." severity note; 
        
       wait; -- Interrompe execução
       end process;
end tb;