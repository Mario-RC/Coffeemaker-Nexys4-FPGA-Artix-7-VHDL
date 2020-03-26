library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_divider_tb is
end clk_divider_tb;
 
architecture Behavioral of clk_divider_tb is
 
    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT clk_divider
	generic ( relacion : integer := 10000000);
    PORT( clk : in STD_LOGIC; -- 100 MHz
          reset : in STD_LOGIC;
          clk_out : out STD_LOGIC
          );
    END COMPONENT;

    -- Inputs
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';

    -- Outputs
    signal clk_out : STD_LOGIC;
    
    -- Clock period definitions
    constant clk_period : time := 10 ns; -- 100 MHz
    --constant clk_out_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut_clk_divider: clk_divider
    --GENERIC MAP ( relacion => 50000000) -- 1 Hz
	GENERIC MAP ( relacion => 125000) -- 400 Hz
	PORT MAP (
	    -- in
        clk => clk, -- 100 MHz
        reset => reset,
        -- out
        clk_out => clk_out
        );

    -- Clock process definitions
    clk_process_100MHz: process
    BEGIN
        clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
    end process;

    -- Clock out process definitions
    --clk_out_process: process
    --BEGIN
    --    clk_out <= '0';
    --    wait for clk_out_period/2;
    --    clk_out <= '1';
    --    wait for clk_out_period/2;
    --end process;

    -- Stimulus process
    stim_proc: process
    BEGIN
    
        -- hold reset state for 100 ns
        reset <= '0';
        wait for 50 ns;
        
        reset <= '1'; -- Initial conditions
        wait for 50 ns;
        
        reset <= '0'; -- Down to work
        wait for 10 ns;
        
        --wait for 2020 ms; -- tiempo simulacion 1 Hz
        wait for 5200 us; -- tiempo simulacion 200 Hz
        
        assert false
        report "Fin de la simulacion..."
        severity failure;
    end process;
    
end Behavioral;