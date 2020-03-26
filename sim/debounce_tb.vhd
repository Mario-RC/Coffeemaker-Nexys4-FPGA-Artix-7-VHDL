library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce_tb is
end debounce_tb;
 
architecture Behavioral of debounce_tb is
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT debounce
    PORT ( clk : in STD_LOGIC; -- 100 MHz
           reset : in STD_LOGIC;
           btn_in : in std_logic;
           btn_out : out std_logic
           );
    END COMPONENT;
    
    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal btn_in : std_logic := '0';
    
    -- Outputs
    signal btn_out : std_logic;
    
    -- Clock period definitions
    constant clk_period : time := 10 ns; -- 100 MHz
    --constant clk_out_period : time := 10 ns;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut_debounce: debounce
    PORT MAP (
        -- in
        clk => clk, -- 100 MHz
        reset => reset,
        btn_in => btn_in,
        -- out
        btn_out => btn_out
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
        wait for 10 ms;
        
        -- first activity
        btn_in <= '1';
        wait for 4 ms;
        btn_in <= '0';
        wait for 2 ms;
        btn_in <= '1'; 
        wait for 2 ms;
        btn_in <= '0';
        wait for 12 ms;
        
        -- second activity
        btn_in <= '1';
        wait for 2 ms;
        btn_in <= '0';
        wait for 2 ms;
        btn_in <= '1';
        wait for 2 ms;
        btn_in <= '0';
        wait for 4 ms;
        btn_in <= '1';
        wait for 20 ms;
        btn_in <= '0';
        wait for 10 ms;
        
        assert false
        report "Fin de la simulacion..."
        severity failure;
    end process;

end Behavioral;