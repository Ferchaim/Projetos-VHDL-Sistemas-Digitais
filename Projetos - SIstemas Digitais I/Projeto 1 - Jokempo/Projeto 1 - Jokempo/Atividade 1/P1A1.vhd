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