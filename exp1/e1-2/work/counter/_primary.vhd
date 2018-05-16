library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        clk_in          : in     vl_logic;
        rst             : in     vl_logic;
        cnt             : out    vl_logic_vector(3 downto 0)
    );
end counter;
