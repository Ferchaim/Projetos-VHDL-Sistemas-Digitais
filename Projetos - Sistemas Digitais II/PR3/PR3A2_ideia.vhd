library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
  port(
    outA        : out std_logic_vector(63 downto 0);
    outB        : out std_logic_vector(63 downto 0);
    inputt       : in  std_logic_vector(63 downto 0);
    writeEnable : in  std_logic;
    regASel     : in  std_logic_vector(3 downto 0);
    regBSel     : in  std_logic_vector(3 downto 0);
    writeRegSel : in  std_logic_vector(3 downto 0);
    clk         : in  std_logic
    );
end register_file;


architecture behavioral of register_file is
  type registerFile is array(0 to regn) of std_logic_vector(63 downto 0);
  signal registers : registerFile;
begin
  regFile : process (clk) is
  begin
    if rising_edge(clk) then
      -- Read A and B before bypass
      outA <= registers(to_integer(unsigned(regASel)));
      outB <= registers(to_integer(unsigned(regBSel)));
      -- Write and bypass
      if writeEnable = '1' then
        registers(to_integer(unsigned(writeRegSel))) <= inputt;  -- Write
        if regASel = writeRegSel then  -- Bypass for read A
          outA <= inputt;
        end if;
        if regBSel = writeRegSel then  -- Bypass for read B
          outB <= inputt;
        end if;
      end if;
    end if;
  end process;
end behavioral;





      begin
        regFile : process (clk,reset) is
        begin
          if clock'event and clock = '1' then
            -- Read A and B before bypass
            q1 <= registers(to_integer(unsigned(rr1)));
            q2 <= registers(to_integer(unsigned(rr2)));
            -- Write and bypass
            if regWrite = '1' then
              registers(to_integer(unsigned(wr))) <= d;  -- Write
          if rr1 = wr then  -- Bypass for read A
            q1 <= d;
          end if;
          if rr2 = wr then  -- Bypass for read B
            q2 <= d;
          end if;
            end if;
          end if;
        end process;


        regFile: process(clock,reset)
        begin
            if reset = '1' then
              registers(to_integer(unsigned(wr))) <= (others => '0'); 
            elsif (clock'event and clock = '1') then
                if regWrite = '1' then
                  registers(to_integer(unsigned(wr))) <= d;  -- Write
                end if;
            end if; 
        end process;
        q1 <= registers(to_integer(unsigned(rr1)))
        q2 <= registers(to_integer(unsigned(rr2)))