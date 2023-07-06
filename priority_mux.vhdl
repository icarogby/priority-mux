library ieee;
use ieee.std_logic_1164.all;

entity priority_mux is
    port(
        priority: in std_logic_vector(1 downto 0);

        data_in_0: in std_logic_vector(3 downto 0);
        data_in_1: in std_logic_vector(3 downto 0);
        data_in_2: in std_logic_vector(3 downto 0);
        data_in_3: in std_logic_vector(3 downto 0);

        data_out: out std_logic_vector(3 downto 0)

    );

end priority_mux;

architecture behavioral of priority_mux is
    signal data_sorted_0: std_logic_vector(3 downto 0);
    signal data_sorted_1: std_logic_vector(3 downto 0);
    signal data_sorted_2: std_logic_vector(3 downto 0);
    signal data_sorted_3: std_logic_vector(3 downto 0);

    signal req_0, req_1, req_2, req_3: std_logic;
    signal req_accord_0, req_accord_1, req_accord_2, req_accord_3: std_logic;
    signal served_req: std_logic_vector(3 downto 0);

    signal mux_out: std_logic_vector(3 downto 0);

begin
    -- Sorting signals by priority
    with priority select data_sorted_0 <=
        data_in_0 when "00",
        data_in_1 when "01",
        data_in_2 when "10",
        data_in_3 when "11",
        "XXXX"    when others;

    with priority select data_sorted_1 <=
        data_in_1 when "00",
        data_in_2 when "01",
        data_in_3 when "10",
        data_in_0 when "11",
        "XXXX"    when others;

    with priority select data_sorted_2 <=
        data_in_2 when "00",
        data_in_3 when "01",
        data_in_0 when "10",
        data_in_1 when "11",
        "XXXX"    when others;

    with priority select data_sorted_3 <=
        data_in_3 when "00",
        data_in_0 when "01",
        data_in_1 when "10",
        data_in_2 when "11",
        "XXXX"    when others;

    -- Request signals
    req_0 <= '1' when data_sorted_0 /= "0000" else '0';
    req_1 <= '1' when data_sorted_1 /= "0000" else '0';
    req_2 <= '1' when data_sorted_2 /= "0000" else '0';
    req_3 <= '1' when data_sorted_3 /= "0000" else '0';

    -- requests accordance. Tell what request is will be served
    req_accord_0 <=     req_0;
    req_accord_1 <= not req_0 and     req_1;
    req_accord_2 <= not req_0 and not req_1 and     req_2;
    req_accord_3 <= not req_0 and not req_1 and not req_2 and req_3;

    -- Choosing which requirement will be served
    served_req <= req_accord_0 & req_accord_1 & req_accord_2 & req_accord_3;

    with served_req select mux_out <=
        data_sorted_0 when "1000",
        data_sorted_1 when "0100",
        data_sorted_2 when "0010",
        data_sorted_3 when "0001",
        "0000"        when others;

    data_out <= mux_out;

end behavioral;
