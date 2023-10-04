library ieee ;
use ieee.numeric_bit.all;

entity upcount is
PORT ( Clock, Resetn, E : in bit ;
Q : out bit_vector(8 downto 0)) ;
end upcount ;

architecture Behavior of upcount is
    signal Count : bit_vector(8 downto 0) ;

begin
    process ( Clock, Resetn )
        begin
            if Resetn = '0' then
                Count <= "000000000" ;
            elsif (Clock'EVENT and Clock = '1') then
                if E = '1' THEN
                    Count <= Count + "000000001" ;
                else
                    Count <= Count ;
                end if ;
            end if ;
    end process ;

Q <= Count ;

end Behavior ;