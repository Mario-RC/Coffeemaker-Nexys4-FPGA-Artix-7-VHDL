library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_tb is
end decoder_tb;

architecture Behavioral of decoder_tb is

    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT decoder
    PORT( code : in STD_LOGIC_VECTOR(3 downto 0);
          led : out STD_LOGIC_VECTOR(6 downto 0)
          );
    END COMPONENT;
    
    -- Inputs
    signal code : STD_LOGIC_VECTOR(3 downto 0);
    
    -- Outputs
    signal led : STD_LOGIC_VECTOR(6 downto 0);
    
    TYPE vtest is record
        code : STD_LOGIC_VECTOR(3 downto 0);
        led : STD_LOGIC_VECTOR(6 downto 0);
    END RECORD;
    
    TYPE vtest_vector is array (natural range <>) of vtest;
    constant test: vtest_vector := (
        (code => "0000", led => "1000000"), -- "0"
        (code => "0001", led => "1111001"), -- "1"
        (code => "0010", led => "0100100"), -- "2"
        (code => "0011", led => "0110000"), -- "3"
        (code => "0100", led => "0011001"), -- "4"
        (code => "0101", led => "0010010"), -- "5"
        (code => "0110", led => "0000010"), -- "6"
        (code => "0111", led => "1111000"), -- "7"
        (code => "1000", led => "0000000"), -- "8"
        (code => "1001", led => "0010000"), -- "9"
        (code => "1010", led => "0111111"), -- "-"
        (code => "1011", led => "1111111"), -- " "
        (code => "1101", led => "1000111"), -- "L"
        (code => "1100", led => "1000110"), -- "C"
        (code => "1111", led => "0001110"), -- "F"
        (code => "1110", led => "1111111")  -- " "
        );
        
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut_decoder: decoder 
    PORT MAP(
	    -- in
        code => code,
        -- out
        led => led
        );
    
    -- Stimulus process
    stim_proc: process
    BEGIN
    
        for i in 0 to test'HIGH loop
        code <= test(i).code;
            wait for 20 ns;
            assert led = test(i).led
            report "Salida incorrecta."
            severity failure;
        end loop;
        
        wait for 10 ms;
                
        assert false
        report "Simulación finalizada. Test superado."
        severity failure;
    end process;
    
end Behavioral;