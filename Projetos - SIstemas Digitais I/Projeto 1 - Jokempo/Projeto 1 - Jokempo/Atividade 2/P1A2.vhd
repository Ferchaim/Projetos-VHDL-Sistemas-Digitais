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