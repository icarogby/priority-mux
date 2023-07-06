library ieee;
use ieee.std_logic_1164.all;

entity testbench is end;

architecture behavioral of testbench is
    signal priority: std_logic_vector(1 downto 0);

    signal data_in_0: std_logic_vector(3 downto 0);
    signal data_in_1: std_logic_vector(3 downto 0);
    signal data_in_2: std_logic_vector(3 downto 0);
    signal data_in_3: std_logic_vector(3 downto 0);

    signal data_out: std_logic_vector(3 downto 0);

    component priority_mux is
        port(
            priority: in std_logic_vector(1 downto 0);

            data_in_0: in std_logic_vector(3 downto 0);
            data_in_1: in std_logic_vector(3 downto 0);
            data_in_2: in std_logic_vector(3 downto 0);
            data_in_3: in std_logic_vector(3 downto 0);

            data_out: out std_logic_vector(3 downto 0)

        );

    end component;

begin
    mux: priority_mux
        port map(
            priority => priority,

            data_in_0 => data_in_0,
            data_in_1 => data_in_1,
            data_in_2 => data_in_2,
            data_in_3 => data_in_3,

            data_out => data_out
        );

    process begin
        priority <= "00";

        data_in_0 <= "0000";
        data_in_1 <= "1001";
        data_in_2 <= "0000";
        data_in_3 <= "0111";

        wait for 10 ns;

        priority <= "01";

        wait for 10 ns;

        priority <= "10";

        wait for 10 ns;

        priority <= "11";

        wait;

    end process;

end behavioral;
