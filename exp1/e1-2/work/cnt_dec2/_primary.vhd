library verilog;
use verilog.vl_types.all;
entity cnt_dec2 is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        LED0            : out    vl_logic_vector(6 downto 0)
    );
end cnt_dec2;
