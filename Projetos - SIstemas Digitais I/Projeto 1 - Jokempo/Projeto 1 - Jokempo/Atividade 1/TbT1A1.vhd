entity testbench is

    end testbench;
    
    architecture tb of testbench is
    
    component jokempo is
    port(
        a: in bit_vector (1 downto 0);
        b:in bit_vector (1 downto 0);
        y: out bit_vector (1 downto 0)
    );
    end component; 
    
        signal a_in, b_in, y_out: bit_vector(1 downto 0);
    
    begin
    
      DUT: jokempo port map(a_in, b_in, y_out);
    
    process
    begin
        a_in <= "01";
        b_in <= "01";
        wait for 1 ns;
           assert(y_out = "11") report "Fail 01+01" severity error;	
    
          a_in <= "10";
        b_in <= "10";
        wait for 1 ns;
         assert(y_out = "11") report "Fail 10+10" severity error;
      
          a_in <= "11";
        b_in <= "11";
        wait for 1 ns;
          assert(y_out = "11") report "Fail 11+11" severity error;
          
          a_in <= "01";
        b_in <= "10";
        wait for 1 ns;
          assert(y_out = "01") report "Fail 01+10" severity error;
          
          a_in <= "10";
        b_in <= "11";
        wait for 1 ns;
          assert(y_out = "01") report "Fail 10+11" severity error;
      
          a_in <= "11";
        b_in <= "01";
        wait for 1 ns;
          assert(y_out = "01") report "Fail 11+10" severity error;
          
          a_in <= "01";
        b_in <= "11";
        wait for 1 ns;
          assert(y_out = "10") report "Fail 01+11" severity error;
      
          a_in <= "10";
        b_in <= "01";
        wait for 1 ns;
          assert(y_out = "10") report "Fail 10+01" severity error;
          
          a_in <= "11";
        b_in <= "10";
        wait for 1 ns;
          assert(y_out = "10") report "Fail 11+10" severity error;
      
          a_in <= "00";
        b_in <= "01";
        wait for 1 ns;
          assert(y_out = "00") report "Fail 00+01" severity error;
      
          a_in <= "00";
        b_in <= "10";
        wait for 1 ns;
          assert(y_out = "00") report "Fail 00+10" severity error;
          
          a_in <= "00";
        b_in <= "11";
        wait for 1 ns;
          assert(y_out = "00") report "Fail 00+11" severity error;
      
          a_in <= "01";
        b_in <= "00";
        wait for 1 ns;
          assert(y_out = "00") report "Fail 01+00" severity error;
      
          a_in <= "10";
        b_in <= "00";
        wait for 1 ns;
          assert(y_out = "00") report "Fail 10+00" severity error;
      
          a_in <= "11";
        b_in <= "00";
        wait for 1 ns;
          assert(y_out = "00") report "Fail 11+00" severity error;
    
        a_in <= "00";
        b_in <= "00";
        wait for 1 ns;
          assert(y_out = "00") report "Fail 00+00" severity error;		  
    
        assert false report "Test done." severity note;
        wait;
    end process;
    end tb;