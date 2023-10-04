library ieee;
use ieee.numeric_bit.all;

entity testbench is
end testbench;

architecture tb of testbench is
	component ram is
		generic (
			addressSize : natural := 5;
			wordSize : natural := 8
		);
		port (
			ck, wr : in bit;
			addr : in bit_vector (addressSize - 1 downto 0);
			data_i : in bit_vector (wordSize - 1 downto 0);
			data_o : out bit_vector (wordSize - 1 downto 0)
		);
	end component;
	constant ADDRESS_SIZE_GEN : natural := 4;
	constant WORD_SIZE_GEN : natural := 6;
	signal ck_in : bit := '0';
    signal wr_in, wr_gen : bit;
	signal addr_in :  bit_vector (4 downto 0);
	signal data_in, data_out : bit_vector (7 downto 0);
	signal addr_gen : bit_vector (ADDRESS_SIZE_GEN - 1 downto 0);
	signal data_in_gen, data_out_gen : bit_vector (WORD_SIZE_GEN - 1 downto 0);
    signal ativa_clock : bit := '0';
    constant CLOCK_PERIOD : time := 80 ns; 
begin
	DUT_original : ram port map (ck_in, wr_in, addr_in, data_in, data_out);
	DUT_generica : ram 
	generic map (ADDRESS_SIZE_GEN, WORD_SIZE_GEN)
	port map (ck_in, wr_gen, addr_gen, data_in_gen, data_out_gen);
	clk : process
    begin
    	ck_in <= '0';
        wait for CLOCK_PERIOD/2;
        ck_in <= '1';
        wait for CLOCK_PERIOD/2;
        if ativa_clock = '0' then
        	wait;
        end if;
    end process;
	process
	begin
		wr_in <= '1';
		addr_in <= "10000";
		data_in <= "01010111";
        ativa_clock <= '1';
		wait until rising_edge (ck_in);
		wr_in <= '0';
		wait for CLOCK_PERIOD/4;
		assert data_out = "01010111" report "ERRO TESTE 1" & " de 01010111 para " & integer'image(to_integer(unsigned(data_out))) severity error; 
		data_in <= "11110000";
		wait for CLOCK_PERIOD/8;
		assert data_out = "01010111" report "ERRO TESTE 2" & " de 01010111 para " & integer'image(to_integer(unsigned(data_out))) severity error; 
                wait until rising_edge(ck_in);
                assert data_out = "01010111" report "ERRO TESTE 3" & " de 01010111 para " & integer'image(to_integer(unsigned(data_out))) severity error; 
                wr_in <= '1';
                 wait until rising_edge(ck_in);
                assert data_out = "01010111" report "ERRO TESTE 4" & " de 01010111 para " & integer'image(to_integer(unsigned(data_out))) severity error;
                wr_in <= '0';
		wait for CLOCK_PERIOD/4;
                assert data_out = "11110000" report "ERRO TESTE 5" & " de 11110000 para " & integer'image(to_integer(unsigned(data_out))) severity error;
                wr_gen <= '1';
                addr_gen <= "0111";
                data_in_gen <= "101111";
                wait until rising_edge (ck_in);
                wr_gen <= '0';
		wait for CLOCK_PERIOD/4;
		assert data_out_gen = "101111" report "ERRO TESTE 6" & " de 101111 para " & integer'image(to_integer(unsigned(data_out_gen))) severity error;
        wait for CLOCK_PERIOD/4;
        assert false report "Test done" severity note;
        ativa_clock <= '0';
		wait;
        end process;
end tb;

