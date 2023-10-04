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
