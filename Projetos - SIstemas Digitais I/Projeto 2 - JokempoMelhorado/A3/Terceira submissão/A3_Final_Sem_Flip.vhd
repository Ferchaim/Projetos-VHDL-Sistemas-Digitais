entity jokempo is
      port(
        a: in bit_vector(1 downto 0);
        b: in bit_vector(1 downto 0);
        y: out bit_vector(1 downto 0)
      );
      end jokempo;
      
      architecture arch_jokem of jokempo is
      
      begin
        
        y <= "11" when ((a = "01" and b = "01") or (a = "10" and b = "10") or (a = "11" and b = "11")) else
             "01" when ((a = "01" and b = "10") or (a = "10" and b = "11") or (a = "11" and b = "01")) else
             "10" when ((a = "01" and b = "11") or (a = "10" and b = "01") or (a = "11" and b = "10"))  else
             "00";  
  end arch_jokem;
  
  
  entity melhordetres is
      port(
          resultado1 : in bit_vector(1 downto 0);
          resultado2 : in bit_vector(1 downto 0);
          resultado3 : in bit_vector(1 downto 0);
          z : out bit_vector(1 downto 0)
      );
  end melhordetres; 
  
  architecture mdtresarc of melhordetres is
  
      begin
  
              z <= "01" when ((resultado1 = "01" and resultado2 = "01" and resultado3 = "01") or (resultado1 = "01" and resultado2 = "01" and resultado3 = "10")
                    or  (resultado1 = "01" and resultado2 = "01" and resultado3 = "11") or (resultado1 = "01" and resultado2 = "10" and resultado3 = "01")
                    or (resultado1 = "01" and resultado2 = "11" and resultado3 = "01") or (resultado1 = "01" and resultado2 = "11" and resultado3 = "11") 
                    or (resultado1 = "10" and resultado2 = "01" and resultado3 = "01") or (resultado1 = "11" and resultado2 = "01" and resultado3 = "01")
                    or (resultado1 = "11" and resultado2 = "01" and resultado3 = "11") or (resultado1 = "11" and resultado2 = "11" and resultado3 = "01")) else
                   "10" when ((resultado1 = "01" and resultado2 = "10" and resultado3 = "10") or (resultado1 = "10" and resultado2 = "01" and resultado3 = "10")
                    or (resultado1 = "10" and resultado2 = "10" and resultado3 = "01") or (resultado1 = "10" and resultado2 = "10" and resultado3 = "10")
                    or (resultado1 = "10" and resultado2 = "10" and resultado3 = "11") or (resultado1 = "10" and resultado2 = "11" and resultado3 = "10")
                    or (resultado1 = "10" and resultado2 = "11" and resultado3 = "11") or (resultado1 = "11" and resultado2 = "10" and resultado3 = "10")
                    or (resultado1 = "11" and resultado2 = "10" and resultado3 = "11") or (resultado1 = "11" and resultado2 = "11" and resultado3 = "10")) else
                   "11" when ((resultado1 = "01" and resultado2 = "10" and resultado3 = "11") or (resultado1 = "01" and resultado2 = "11" and resultado3 = "10")
                    or (resultado1 = "10" and resultado2 = "01" and resultado3 = "11") or (resultado1 = "10" and resultado2 = "11" and resultado3 = "01")
                    or (resultado1 = "11" and resultado2 = "01" and resultado3 = "10") or (resultado1 = "11" and resultado2 = "10" and resultado3 = "01")
                    or (resultado1 = "11" and resultado2 = "11" and resultado3 = "11")) else
                   "00"; --"00" when (resultado1 = "00" or resultado2 = "00" or resultado3 = "00") 
                       
          
  end mdtresarc; 
  
  
  entity jokempotriplo is
      port(
          a1,a2,a3: in bit_vector(1 downto 0);
          b1,b2,b3: in bit_vector(1 downto 0);
          z: out bit_vector(1 downto 0)
      );
  end jokempotriplo;
      
      architecture jokempotriplotb of jokempotriplo is
  
          component jokempo is
          port(a,b : in bit_vector(1 downto 0); y: out bit_vector(1 downto 0));
          end component;
  
          component melhordetres is
          port(resultado1, resultado2, resultado3 : in bit_vector(1 downto 0); z : out bit_vector(1 downto 0));
          end component;
          
          signal vj1, vj2, vj3 : bit_vector (1 downto 0);
          
      begin
  
         j1: jokempo port map (a1,b1,vj1);
         j2: jokempo port map (a2,b2,vj2);
         j3: jokempo port map (a3,b3,vj3);
         vfj: melhordetres port map(vj1,vj2,vj3,z);
  
  end jokempotriplotb;
  
  
  entity jkp3auto is
      port(
          reset, clock: in bit;
          loadA, loadB: in bit;
          atualiza: in bit;
          a1,a2,a3: in bit_vector(1 downto 0);
          b1,b2,b3: in bit_vector(1 downto 0);
          z: out bit_vector(1 downto 0)
      );
  end jkp3auto;
  
      architecture arch3 of jkp3auto is
  
          component jokempo is
          port(a,b : in bit_vector(1 downto 0); y: out bit_vector(1 downto 0));
          end component;
  
          component melhordetres is
          port(resultado1, resultado2, resultado3 : in bit_vector(1 downto 0); z : out bit_vector(1 downto 0));
          end component;
  
          component jokempotriplo is
          port(a1,a2,a3: in bit_vector(1 downto 0); b1,b2,b3: in bit_vector(1 downto 0); z: out bit_vector(1 downto 0));
          end component;
  
          component flipflopd is
          port(D, reset, clock, EN: in  bit; Q: out bit);
          end component;
  
          signal a_1, a_2, a_3, b_1, b_2, b_3,z_parcial,z_parcial1, z_parcial2: bit_vector(1 downto 0);
          signal att: bit;
  
          begin
            
          a_A1_0: flipflopd port map (a1(0),reset,clock,loadA,a_1(0));
          a_A1_1: flipflopd port map (a1(1),reset,clock,loadA,a_1(1));
          a_A2_0: flipflopd port map (a2(0),reset,clock,loadA,a_2(0)); 
          a_A2_1: flipflopd port map (a2(1),reset,clock,loadA,a_2(1));
          a_A3_0: flipflopd port map (a3(0),reset,clock,loadA,a_3(0));
          a_A3_1: flipflopd port map (a3(1),reset,clock,loadA,a_3(1));
          a_B1_0: flipflopd port map (b1(0),reset,clock,loadB,b_1(0));
          a_B1_1: flipflopd port map (b1(1),reset,clock,loadB,b_1(1));
          a_B2_0: flipflopd port map (b2(0),reset,clock,loadB,b_2(0));
          a_B2_1: flipflopd port map (b2(1),reset,clock,loadB,b_2(1));
          a_B3_0: flipflopd port map (b3(0),reset,clock,loadB,b_3(0));
          a_B3_1: flipflopd port map (b3(1),reset,clock,loadB,b_3(1));
          att <= '1' when ((loadA = '0') and (loadB = '0')) else '0';
          disput_parci: jokempotriplo port map(a_1,a_2,a_3,b_1,b_2,b_3,z_parcial);
          disputa_0: flipflopd port map (z_parcial(0),reset,clock,att,z_parcial1(0));
          disputa_1: flipflopd port map (z_parcial(1),reset,clock,att,z_parcial1(1));
          disputa_A0: flipflopd port map (z_parcial(0),reset,clock,atualiza,z_parcial2(0));
          disputa_A1: flipflopd port map (z_parcial(1),reset,clock,atualiza,z_parcial2(1));
          z <= z_parcial1 or z_parcial2;
          
  
  end arch3;