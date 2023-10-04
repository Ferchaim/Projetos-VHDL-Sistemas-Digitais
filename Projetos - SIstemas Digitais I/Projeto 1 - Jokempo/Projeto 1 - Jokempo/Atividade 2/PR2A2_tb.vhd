,entity testbench2 is

    end testbench2;
    
    architecture tb of testbench2 is
    
    component rom_arquivo is
        port(
            addr: in bit_vector(4 downto 0);
            data: out bit_vector(7 downto 0)
        );
    end component;

        signal addr_in: bit_vector(4 downto 0);
        signal data_out: bit_vector(7 downto 0);
    
    begin
    
      DUT: rom_arquivo port map(addr_in, data_out);
    
    process
    begin

        addr_in <= "00001";
        wait for 1 ns;
        assert(z_out = "") report "Fail 0" severity error;

        addr_in <= "00000";
        wait for 1 ns;
        assert(z_out = "00000000") report "Fail 0" severity error;	

        addr_in <= "00001";
        wait for 1 ns;
        assert(z_out = "00000011") report "Fail 1" severity error;

        addr_in <= "00010";
        wait for 1 ns;
        assert(z_out = "11000000") report "Fail 2" severity error;

        addr_in <= "00011";
        wait for 1 ns;
        assert(z_out = "00001100") report "Fail 3" severity error;

        addr_in <= "00100";
        wait for 1 ns;
        assert(z_out = "00110000") report "Fail 4" severity error;

        addr_in <= "00101";
        wait for 1 ns;
        assert(z_out = "01010101") report "Fail 5" severity error;

        addr_in <= "00110";
        wait for 1 ns;
        assert(z_out = "10101010") report "Fail 6" severity error;

        addr_in <= "00111";
        wait for 1 ns;
        assert(z_out = "11111111") report "Fail 7" severity error;

        addr_in <= "01000";
        wait for 1 ns;
        assert(z_out = "11100000") report "Fail 8" severity error;

        addr_in <= "01001";
        wait for 1 ns;
        assert(z_out = "11100111") report "Fail 9" severity error;

        addr_in <= "01010";
        wait for 1 ns;
        assert(z_out = "00000111") report "Fail 10" severity error;

        addr_in <= "01011";
        wait for 1 ns;
        assert(z_out = "00011000") report "Fail 11" severity error;

        addr_in <= "01100";
        wait for 1 ns;
        assert(z_out = "11000011") report "Fail 12" severity error;


        addr_in <= "01101";
        wait for 1 ns;
        assert(z_out = "00111100") report "Fail 13" severity error;

        addr_in <= "01110";
        wait for 1 ns;
        assert(z_out = "11110000") report "Fail 14" severity error;

        addr_in <= "01111";
        wait for 1 ns;
        assert(z_out = "00001111") report "Fail 15" severity error;

        addr_in <= "10000";
        wait for 1 ns;
        assert(z_out = "10001010") report "Fail 16" severity error;

        addr_in <= "10001";
        wait for 1 ns;
        assert(z_out = "00100100") report "Fail 17" severity error;

        addr_in <= "10010";
        wait for 1 ns;
        assert(z_out = "01010101") report "Fail 18" severity error;

        addr_in <= "10011";
        wait for 1 ns;
        assert(z_out = "01001100") report "Fail 19" severity error;

        addr_in <= "10100";
        wait for 1 ns;
        assert(z_out = "01000100") report "Fail 20" severity error;

        addr_in <= "10101";
        wait for 1 ns;
        assert(z_out = "01110011") report "Fail 21" severity error;

        addr_in <= "10110";
        wait for 1 ns;
        assert(z_out = "01011101") report "Fail 22" severity error;

        addr_in <= "10111";
        wait for 1 ns;
        assert(z_out = "11100101") report "Fail 23" severity error;

        addr_in <= "11000";
        wait for 1 ns;
        assert(z_out = "01111001") report "Fail 24" severity error;

        addr_in <= "11001";
        wait for 1 ns;
        assert(z_out = "01010000") report "Fail 25" severity error;

        addr_in <= "11010";
        wait for 1 ns;
        assert(z_out = "01000011") report "Fail 26" severity error;

        addr_in <= "11011";
        wait for 1 ns;
        assert(z_out = "01010011") report "Fail 27" severity error;

        addr_in <= "00001";
        wait for 1 ns;
        assert(z_out = "10110000") report "Fail 28" severity error;

        addr_in <= "00001";
        wait for 1 ns;
        assert(z_out = "") report "Fail 0" severity error;

        addr_in <= "00001";
        wait for 1 ns;
        assert(z_out = "") report "Fail 0" severity error;

        addr_in <= "00001";
        wait for 1 ns;
        assert(z_out = "") report "Fail 0" severity error;





        assert false report "Test done." severity note;
        wait;
    end process;
    end tb;