library verilog;
use verilog.vl_types.all;
entity cnt_dec1 is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        LED0            : out    vl_logic_vector(6 downto 0);
        ud              : in     vl_logic
    );
end cnt_dec1;
