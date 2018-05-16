library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        clk             : in     vl_logic;
        cnt             : out    vl_logic_vector(3 downto 0);
        rst             : in     vl_logic
    );
end counter;
