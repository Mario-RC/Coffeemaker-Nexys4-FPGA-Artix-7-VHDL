library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_refresh_tb is
end display_refresh_tb;

architecture Behavioral of display_refresh_tb is 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT display_refresh
    PORT( clk : in  STD_LOGIC; -- 400 Hz
          reset : in STD_LOGIC;
          segment_ud : in STD_LOGIC_VECTOR (6 downto 0); -- numero unidad
          segment_dc : in STD_LOGIC_VECTOR (6 downto 0); -- numero decimal
          segment_ml : in STD_LOGIC_VECTOR (6 downto 0); -- temperatura leche
          segment_lc : in STD_LOGIC_VECTOR (6 downto 0); -- letra L leche
          segment_sg_1 : in STD_LOGIC_VECTOR (6 downto 0); -- nivel azucar 1
          segment_sg_2 : in STD_LOGIC_VECTOR (6 downto 0); -- nivel azucar 2
          segment_sg_3 : in STD_LOGIC_VECTOR (6 downto 0); -- nivel azucar 3
          segment_sg_4 : in STD_LOGIC_VECTOR (6 downto 0); -- nivel azucar 4
          display_select : out STD_LOGIC_VECTOR (7 downto 0); -- seleccionado display
          display_number : out STD_LOGIC_VECTOR (6 downto 0) -- numero display
          );
    END COMPONENT;
    
    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal segment_ud : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal segment_dc : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal segment_ml : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal segment_lc : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal segment_sg_1 : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal segment_sg_2 : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal segment_sg_3 : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal segment_sg_4 : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
 	-- Outputs
 	signal display_select : STD_LOGIC_VECTOR (7 downto 0);
    signal display_number : STD_LOGIC_VECTOR (6 downto 0);
    
    -- Clock period definitions
    constant clk_period : time := 2500 us; -- 400 Hz
    --constant clk_out_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut_display_refresh: display_refresh
    PORT MAP (
        -- in
        clk => clk, -- 400 Hz
        reset => reset,
        segment_ud => segment_ud,
        segment_dc => segment_dc,
        segment_ml => segment_ml,
        segment_lc => segment_lc,
        segment_sg_1 => segment_sg_1,
        segment_sg_2 => segment_sg_2,
        segment_sg_3 => segment_sg_3,
        segment_sg_4 => segment_sg_4,
        -- out
        display_select => display_select,
        display_number => display_number
        );
        
    -- Clock process definitions
    clk_process_400Hz: process
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
        
        wait for 2500 us;
        segment_ud <= "0010000" after 5 ms; -- "9" unidades
        segment_dc <= "1111001" after 5 ms; -- "1" decenas
        segment_ml <= "0001110" after 5 ms; -- "F" leche fria
        segment_lc <= "1000111" after 5 ms; -- "L" letra L
        segment_sg_1 <= "1111001" after 5 ms; -- "1" nivel 1 azucar
        segment_sg_2 <= "1111001" after 5 ms; -- "1" nivel 2 azucar
        segment_sg_3 <= "1111111" after 5 ms; -- " " sin numero
        segment_sg_4 <= "1111111" after 5 ms; -- " " sin numero
        wait for 46 ms;
                
        assert false
        report "Fin de la simulacion..."
        severity failure;
    end process;

end Behavioral;