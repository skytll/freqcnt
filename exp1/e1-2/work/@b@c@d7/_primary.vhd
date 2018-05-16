library verilog;
use verilog.vl_types.all;
entity BCD7 is
    port(
        din             : in     vl_logic_vector(3 downto 0);
        dout            : out    vl_logic_vector(6 downto 0)
    );
end BCD7;
