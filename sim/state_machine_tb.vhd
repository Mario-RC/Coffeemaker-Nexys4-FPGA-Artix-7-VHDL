library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity maquina_estados_tb is
end maquina_estados_tb;

architecture Behavioral of maquina_estados_tb is
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT maquina_estados
    PORT( clk : in STD_LOGIC; -- 1 Hz
          reset : in STD_LOGIC;
          encendido : in STD_LOGIC;
          corto : in STD_LOGIC;
          doble : in STD_LOGIC;
          largo : in STD_LOGIC;
          milk : in STD_LOGIC;
          leche_caliente : in STD_LOGIC;
          leche_fria : in STD_LOGIC;
          sugar : in STD_LOGIC;
          more_sugar : in STD_LOGIC;
          less_sugar : in STD_LOGIC;
          start : in STD_LOGIC;
          encendido_led : out STD_LOGIC;
          corto_led : out STD_LOGIC;
          doble_led : out STD_LOGIC;
          largo_led : out STD_LOGIC;
          milk_led : out STD_LOGIC;
          milk_led_red : out STD_LOGIC;
          milk_led_blue : out STD_LOGIC;
          sugar_led : out STD_LOGIC;
          bomba_led_red : out STD_LOGIC;
          done_led_green : out STD_LOGIC;
          apagado_led : out STD_LOGIC;
          ud : out STD_LOGIC_VECTOR (3 downto 0);
          dc : out STD_LOGIC_VECTOR (3 downto 0);
          ml : out STD_LOGIC_VECTOR (3 downto 0);
          lc : out STD_LOGIC_VECTOR (3 downto 0);
          az_1 : out STD_LOGIC_VECTOR (3 downto 0);
          az_2 : out STD_LOGIC_VECTOR (3 downto 0);
          az_3 : out STD_LOGIC_VECTOR (3 downto 0);
          az_4 : out STD_LOGIC_VECTOR (3 downto 0)
          );
    END COMPONENT;

    -- Inputs
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal encendido : STD_LOGIC := '0';
    signal corto : STD_LOGIC := '0';
    signal doble : STD_LOGIC := '0';
    signal largo : STD_LOGIC := '0';
    signal milk : STD_LOGIC := '0';
    signal leche_caliente : STD_LOGIC := '0';
    signal leche_fria : STD_LOGIC := '0';
    signal sugar : STD_LOGIC := '0';
    signal more_sugar : STD_LOGIC := '0';
    signal less_sugar : STD_LOGIC := '0';
    signal start : STD_LOGIC := '0';
    
 	-- Outputs
    signal encendido_led : STD_LOGIC;
    signal corto_led : STD_LOGIC;
    signal doble_led : STD_LOGIC;
    signal largo_led : STD_LOGIC;
    signal milk_led : STD_LOGIC;
    signal milk_led_red : STD_LOGIC;
    signal milk_led_blue : STD_LOGIC;
    signal sugar_led : STD_LOGIC;
    signal bomba_led_red : STD_LOGIC;
    signal done_led_green : STD_LOGIC;
    signal apagado_led : STD_LOGIC;
    signal ud : STD_LOGIC_VECTOR(3 downto 0);
    signal dc : STD_LOGIC_VECTOR(3 downto 0);
    signal ml : STD_LOGIC_VECTOR(3 downto 0);
    signal lc : STD_LOGIC_VECTOR(3 downto 0);
    signal az_1 : STD_LOGIC_VECTOR(3 downto 0);
    signal az_2 : STD_LOGIC_VECTOR(3 downto 0);
    signal az_3 : STD_LOGIC_VECTOR(3 downto 0);
    signal az_4 : STD_LOGIC_VECTOR(3 downto 0);
    
    -- Clock period definitions
    constant clk_period : time := 1000 ms; -- 1 Hz
    --constant clk_out_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut_maquina_estados: maquina_estados
    PORT MAP (
        -- in
        clk  => clk, -- 1 Hz
        reset => reset,
        encendido => encendido,
        corto => corto,
        doble => doble,
        largo => largo,
        milk => milk,
        leche_caliente => leche_caliente,
        leche_fria => leche_fria, 
        sugar => sugar,
        more_sugar => more_sugar,
        less_sugar => less_sugar,
        start => start,
        -- out
        encendido_led => encendido_led,
        corto_led => corto_led,
        doble_led => doble_led,
        largo_led => largo_led,
        milk_led => milk_led,
        milk_led_red => milk_led_red,
        milk_led_blue => milk_led_blue,
        sugar_led => sugar_led,
        bomba_led_red => bomba_led_red,
        done_led_green => done_led_green,
        apagado_led => apagado_led,
        ud => ud,
        dc => dc,
        ml => ml,
        lc => lc,
        az_1 => az_1,
        az_2 => az_2,
        az_3 => az_3,
        az_4 => az_4
        );

    -- Clock process definitions
    clk_process_1Hz: process
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
        wait for 100 ms;
        
        -- cafe doble con leche caliente y tres niveles de azucar
        encendido <= '1';
        wait for 150 ms;
        doble <= '1';
        wait for 150 ms;
        milk <= '1'; -- se activa nievl 1 azucar como predeterminado
        wait for 150 ms;
        sugar <= '1';
        wait for 3000 ms;
        leche_caliente <= '1';
        wait for 550 ms;
        leche_caliente <= '0';
        wait for 550 ms;
        more_sugar <= '1'; -- nivel 2 azucar
        wait for 550 ms;
        more_sugar <= '0';
        wait for 550 ms;
        more_sugar <= '1'; -- nivel 3 azucar
        wait for 550 ms;
        more_sugar <= '0';
        wait for 2100 ms;
        start <= '1';
        wait for 1100 ms;
        start <= '0';
        wait for 50 ms;
        doble <= '0';
        wait for 50 ms;
        milk <= '0';
        wait for 50 ms;
        sugar <= '0';
        wait for 16000 ms;
        encendido <= '0';
        wait for 750 ms;
        
        assert false
        report "Fin de la simulación..."
        severity failure;
    end process;

end Behavioral;