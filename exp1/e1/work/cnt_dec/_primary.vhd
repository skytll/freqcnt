library verilog;
use verilog.vl_types.all;
entity cnt_dec is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        LED0            : out    vl_logic_vector(7 downto 0)
    );
end cnt_dec;
