--! Code your testbench here
--! or browse Examples

library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;

entity testbench is

end testbench;

architecture tb of testbench is

component jkp3auto is
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
      
      DUT: jkp3auto port map(reset, clock, loadA, loadB, atualiza, 
                         a1_in, a2_in, a3_in,b1_in,b2_in, b3_in, z_out);
      
      process
      type test_add is record
      	t_A1, t_A2, t_A3, t_B1, t_B2, t_B3: bit_vector(1 downto 0);
        t_loadA, t_loadB, t_atualiza, t_reset, t_clock1, t_clock2: bit;
        t_z: bit_vector(1 downto 0);
        str: string (1 to 3);
      end record;

	type tests_array is array (natural range <>) of test_add;
    -- Pedra = 01, Papel = 10, Tesoura = 11, Espera = 00; ASSUME-SE AQUI QUE JOKEMPOTRIPLO FUNCIONA
    
    -- A vence = 10, B vence = 01, Empate = 11
   
	constant tests: tests_array := (
--A1    A2    A3    B1    B2    B3   loadA  loadB atlz  reset clock1 clock2  z    test
("01", "10", "11", "11", "01", "10",  '0',   '0',  '0',  '0',  '0',   '1',  "00",  "T1 "),--!

("01", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "10",  "T2 "),--!TUDO OK
("01", "01", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "10",  "T3 "),--!TUDO OK
("01", "01", "01", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "11",  "T4 "),--!TUDO OK
    
("10", "01", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "11",  "T5 "),--!TUDO OK
("10", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "10",  "T6 "),--!TUDO OK
("10", "10", "10", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "11",  "T7 "),--!TUDO OK
  
("01", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "10",  "T8 "),--!TUDO OK
("01", "11", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "10",  "T9 "),--!TUDO OK
("11", "11", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "11",  "T10"),--!TUDO OK
    
("01", "01", "01", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "11",  "T11"),--!TUDO OK
("10", "10", "10", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "11",  "T12"),--!TUDO OK
("11", "11", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "11",  "T13"),--!TUDO OK
    
("01", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "10",  "T14"),--!TUDO OK
("01", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "10",  "T15"),--!TUDO OK
("01", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "10",  "T16"),--!TUDO OK   
    
--A1    A2    A3    B1    B2    B3   loadA  loadB atlz  reset clock3 clock4  z    test
("11", "11", "11", "11", "11", "11",  '1',   '1',  '1',  '0',  '0',   '1',  "00",  "T17"),--!RESSETA;

("01", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '0',  "00",  "T18"),--!CLK N SOBE;
("01", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '1',   '1',  "00",  "T19"),--!CLK FICA ALTO;


--A1    A2    A3    B1    B2    B3   loadA  loadB atlz  reset clock3 clock4  z     test 
("01", "10", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "10",  "T20"),--!ATUALIZA;
("01", "01", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "10",  "T21"),--!ATUALIZA;
("01", "01", "01", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "11",  "T22"),--!ATUALIZA;
    
("10", "01", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "11",  "T23"),--!ATUALIZA;
("10", "10", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "10",  "T24"),--!ATUALIZA;
("10", "10", "10", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "11",  "T25"),--!ATUALIZA;
  
("01", "10", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "10",  "T26"),--!ATUALIZA;
("01", "11", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "10",  "T27"),--!ATUALIZA;
("11", "11", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "11",  "T28"),--!ATUALIZA;
    
("01", "01", "01", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "11",  "T29"),--!ATUALIZA;
("10", "10", "10", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "11",  "T30"),--!ATUALIZA;
("11", "11", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "11",  "T31"),--!ATUALIZA;
    
("01", "10", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "10",  "T32"),--!ATUALIZA;
("01", "10", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "10",  "T33"),--!ATUALIZA;
("01", "10", "11", "11", "01", "10",  '1',   '1',  '0',  '1',  '0',   '1',  "10",  "T34"),--!ATUALIZA;

--A1    A2    A3    B1    B2    B3   loadA  loadB atlz  reset clock3 clock4  z    test
("01", "10", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T35"),--!LOAD A N SOBE
("01", "10", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T36"),--!LOAD A N SOBE
("01", "01", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T37"),--!LOAD A N SOBE
("01", "01", "01", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T38"),--!LOAD A N SOBE
    
("10", "01", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T39"),--!LOAD A N SOBE
("10", "10", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T40"),--!LOAD A N SOBE
("10", "10", "10", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T41"),--!LOAD A N SOBE
  
("01", "10", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T42"),--!LOAD A N SOBE
("01", "11", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T43"),--!LOAD A N SOBE
("11", "11", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T44"),--!LOAD A N SOBE
    
("01", "01", "01", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T45"),--!LOAD A N SOBE
("10", "10", "10", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T46"),--!LOAD A N SOBE
("11", "11", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T47"),--!LOAD A N SOBE
    
("01", "10", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T48"),--!LOAD A N SOBE
("01", "10", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T49"),--!LOAD A N SOBE
("01", "10", "11", "11", "01", "10",  '0',   '1',  '1',  '1',  '0',   '1',  "00",  "T50"),--!LOAD A N SOBE

--A1    A2    A3    B1    B2    B3   loadA  loadB atlz  reset clock3 clock4  z    test
("01", "10", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T51"),--!LOAD B N SOBE
("01", "10", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T52"),--!LOAD B N SOBE
("01", "01", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T53"),--!LOAD B N SOBE
("01", "01", "01", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T54"),--!LOAD B N SOBE
    
("10", "01", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T55"),--!LOAD B N SOBE
("10", "10", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T56"),--!LOAD B N SOBE
("10", "10", "10", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T57"),--!LOAD B N SOBE
  
("01", "10", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T58"),--!LOAD B N SOBE
("01", "11", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T59"),--!LOAD B N SOBE
("11", "11", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T60"),--!LOAD B N SOBE
    
("01", "01", "01", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T61"),--!LOAD B N SOBE
("10", "10", "10", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T62"),--!LOAD B N SOBE
("11", "11", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T63"),--!LOAD B N SOBE
    
("01", "10", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T64"),--!LOAD B N SOBE
("01", "10", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T65"),--!LOAD B N SOBE
("01", "10", "11", "11", "01", "10",  '1',   '0',  '1',  '1',  '0',   '1',  "00",  "T66"),--!LOAD B N SOBE


("00", "00", "00", "00", "00", "00",  '1',   '1',  '1',  '1',  '0',   '1',  "00",  "T67"),--!ENTRADAS NULAS

("10", "10", "10", "10", "10", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "11",  "T68"),--!TUDO OK EMPATE
  
--A1    A2    A3    B1    B2    B3   loadA  loadB atlz  reset clock3 clock4  z    test
("00", "10", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "00",  "T69"),--! 
("01", "00", "11", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "00",  "T70"),--! 
("01", "10", "00", "11", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "00",  "T71"),--! 
("01", "10", "11", "00", "01", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "00",  "T72"),--! 
("01", "10", "11", "11", "00", "10",  '1',   '1',  '1',  '1',  '0',   '1',  "00",  "T73"),--! 
("01", "10", "11", "11", "01", "00",  '1',   '1',  '1',  '1',  '0',   '1',  "00",  "T74"),--! 
    
--A1    A2    A3    B1    B2    B3   loadA  loadB atlz  reset clock3 clock4  z    test
("01", "00", "11", "11", "01", "10",  '1',   '1',  '1',  '0',  '0',   '1',  "00",  "T75"),--! 
("01", "10", "11", "11", "00", "10",  '1',   '1',  '1',  '0',  '0',   '1',  "00",  "T76") --!
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
        clock    <= '1';-- t=-1
        
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
        
        clock <= tests(k).t_clock1; -- clk = 0
        
	    wait for 1 ns; -- espera estabilizar e verifica saída
        
-- Aqui, a saida de melhor de tres é 0, pois clk n subiu desde que existem as entradas
        assert (z_out = "00") report "Fail p1: " & tests(k).str severity error; 
        
        clock <= tests(k).t_clock2; -- clk = 1 t= 0
        wait for 1 ns; -- espera estabilizar e verifica saída
		-- após este instante, as entradas foram carregadas se load ='1' e o load ativo foi armazenado.
        
-- Aqui, a saida de melhor de tres está correta, mas z ainda não foi atualizada pois clk n subiu desde a estabilização da saída de melhordetres 
        clock <= tests(k).t_clock1; -- clk = 0
        wait for 1 ns;
        
-- para ativar o "AtualizaAuto", é necessário que os loads voltem para zero, indicando que não há mais sinal de carga ainda ativo
        clock <= tests(k).t_clock2; -- clk = 1 t=1
        wait for 1 ns;
        loadA <= '0';
        loadB <= '0';
        
        -- load zerados
        -- condições estabelecidas
        
        clock <= tests(k).t_clock1; -- clk = 0
        wait for 1 ns;
        clock <= tests(k).t_clock2; -- clk = 1 t=2
        wait for 1 ns;

        clock <= tests(k).t_clock1; -- clk = 0
        wait for 1 ns;
        clock <= tests(k).t_clock2; -- clk = 1 t=3
        wait for 1 ns;
		
-- Apos mais um ciclo de clock, a saída deveria estar atualizada em t=3
		assert (z_out = tests(k).t_z) 
		report "Fail p2:" & bit'image(z_out(1)) & bit'image(z_out(0)) & tests(k).str severity error;
       end loop;   
        
       assert false report "Test done." severity note; 
        
       wait; -- Interrompe execução
       end process;
end tb;