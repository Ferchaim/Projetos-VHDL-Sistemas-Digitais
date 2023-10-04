,entity testbench2 is

    end testbench2;
    
    architecture tb of testbench2 is
    
    component melhordetres is
    port(
        resultado1 : in bit_vector(1 downto 0);
        resultado2 : in bit_vector(1 downto 0);
        resultado3 : in bit_vector(1 downto 0);
        z : out bit_vector(1 downto 0)
    );
    end component; 
    
        signal r1_in, r2_in, r3_in, z_out: bit_vector(1 downto 0);
    
    begin
    
      DUT: melhordetres port map(r1_in, r2_in, r3_in, z_out);
    
    process
    begin

        --0
        r1_in <= "00";
        r2_in <= "00";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+00+00" severity error;	

        --1
        r1_in <= "00";
        r2_in <= "00";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+00+01" severity error;
        
        --2
        r1_in <= "00";
        r2_in <= "00";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+00+10" severity error;	

        --3
        r1_in <= "00";
        r2_in <= "00";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+00+11" severity error;	

        --4
        r1_in <= "00";
        r2_in <= "01";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+01+00" severity error;	
    
        --5
        r1_in <= "00";
        r2_in <= "01";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+01+01" severity error;	

        --6
        r1_in <= "00";
        r2_in <= "01";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+01+10" severity error;	

        --7
        r1_in <= "00";
        r2_in <= "01";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+01+11" severity error;	

        --8
        r1_in <= "00";
        r2_in <= "10";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+10+00" severity error;	

        --9
        r1_in <= "00";
        r2_in <= "10";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+10+01" severity error;	

        --10
        r1_in <= "00";
        r2_in <= "10";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+10+10" severity error;	

        --11
        r1_in <= "00";
        r2_in <= "10";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+10+11" severity error;	

        --12
        r1_in <= "00";
        r2_in <= "11";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+11+00" severity error;	

        --13
        r1_in <= "00";
        r2_in <= "11";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+11+01" severity error;	

        --14
        r1_in <= "00";
        r2_in <= "11";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+11+10" severity error;	

        --15
        r1_in <= "00";
        r2_in <= "11";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 00+11+11" severity error;	
        
        --16
        r1_in <= "01";
        r2_in <= "00";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 01+00+00" severity error;	

        --17
        r1_in <= "01";
        r2_in <= "00";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 01+00+01" severity error;	

        --18
        r1_in <= "01";
        r2_in <= "00";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 01+00+10" severity error;	

        --19
        r1_in <= "01";
        r2_in <= "00";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 01+00+11" severity error;	

        --20
        r1_in <= "01";
        r2_in <= "01";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 01+01+00" severity error;	

        --21
        r1_in <= "01";
        r2_in <= "01";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 01+01+01" severity error;	

        --22
        r1_in <= "01";
        r2_in <= "01";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 01+01+10" severity error;	

        --23
        r1_in <= "01";
        r2_in <= "01";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 01+01+11" severity error;	

        --24
        r1_in <= "01";
        r2_in <= "10";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 01+10+00" severity error;	

        --25
        r1_in <= "01";
        r2_in <= "10";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 01+10+01" severity error;	

        --26
        r1_in <= "01";
        r2_in <= "10";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 01+10+10" severity error;	

        --27
        r1_in <= "01";
        r2_in <= "10";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "11") report "Fail 01+10+11" severity error;	

        --28
        r1_in <= "01";
        r2_in <= "11";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 01+11+00" severity error;	

        --29
        r1_in <= "01";
        r2_in <= "11";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 01+11+01" severity error;	

        --30
        r1_in <= "01";
        r2_in <= "11";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "11") report "Fail 01+01+10" severity error;	

        --31
        r1_in <= "01";
        r2_in <= "11";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 01+11+11" severity error;	

        --32
        r1_in <= "10";
        r2_in <= "00";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 10+00+00" severity error;	

        --33
        r1_in <= "10";
        r2_in <= "00";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 10+00+01" severity error;	

        --34
        r1_in <= "10";
        r2_in <= "00";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 10+00+10" severity error;	

        --35
        r1_in <= "10";
        r2_in <= "00";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 10+00+11" severity error;	

        --36
        r1_in <= "10";
        r2_in <= "01";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 10+01+00" severity error;	

        --37
        r1_in <= "10";
        r2_in <= "01";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 10+01+01" severity error;	

        --38
        r1_in <= "10";
        r2_in <= "01";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 10+01+10" severity error;	

        --39
        r1_in <= "10";
        r2_in <= "01";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "11") report "Fail 10+01+11" severity error;	

        --40
        r1_in <= "10";
        r2_in <= "10";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 10+10+00" severity error;	

        --41
        r1_in <= "10";
        r2_in <= "10";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 10+10+01" severity error;	

        --42
        r1_in <= "10";
        r2_in <= "10";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 10+10+10" severity error;	

        --43
        r1_in <= "10";
        r2_in <= "10";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 10+10+11" severity error;	

        --44
        r1_in <= "10";
        r2_in <= "11";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 10+11+00" severity error;	

        --45
        r1_in <= "10";
        r2_in <= "11";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "11") report "Fail 10+11+01" severity error;	

        --46
        r1_in <= "10";
        r2_in <= "11";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 10+11+10" severity error;	

        --47
        r1_in <= "10";
        r2_in <= "11";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 10+11+11" severity error;	

        --48
        r1_in <= "11";
        r2_in <= "00";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 11+00+00" severity error;	

        --49
        r1_in <= "11";
        r2_in <= "00";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 11+00+01" severity error;	

        --50
        r1_in <= "11";
        r2_in <= "00";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 11+00+10" severity error;	

        --51
        r1_in <= "11";
        r2_in <= "00";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 11+00+11" severity error;	

        --52
        r1_in <= "11";
        r2_in <= "01";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 11+01+00" severity error;	

        --53
        r1_in <= "11";
        r2_in <= "01";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 11+01+01" severity error;	

        --54
        r1_in <= "11";
        r2_in <= "01";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "11") report "Fail 11+01+10" severity error;	

        --55
        r1_in <= "11";
        r2_in <= "01";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 11+01+11" severity error;	

        --56
        r1_in <= "11";
        r2_in <= "10";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 11+10+00" severity error;	

        --57
        r1_in <= "11";
        r2_in <= "10";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "11") report "Fail 11+10+01" severity error;	

        --58
        r1_in <= "11";
        r2_in <= "10";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 11+10+10" severity error;	

        --59
        r1_in <= "11";
        r2_in <= "10";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 11+10+11" severity error;
        
        --60
        r1_in <= "11";
        r2_in <= "11";
        r3_in <= "00";
        wait for 1 ns;
        assert(z_out = "00") report "Fail 11+11+00" severity error;	

        --61
        r1_in <= "11";
        r2_in <= "11";
        r3_in <= "01";
        wait for 1 ns;
        assert(z_out = "01") report "Fail 11+11+01" severity error;	

        --62
        r1_in <= "11";
        r2_in <= "11";
        r3_in <= "10";
        wait for 1 ns;
        assert(z_out = "10") report "Fail 11+11+10" severity error;	

        --63
        r1_in <= "11";
        r2_in <= "11";
        r3_in <= "11";
        wait for 1 ns;
        assert(z_out = "11") report "Fail 11+11+11" severity error;	

        assert false report "Test done." severity note;
        wait;
    end process;
    end tb;