`timescale 1ns/1ps

interface my_mem_if(input logic clk);

    logic write   = 0;
    logic read    = 0;
    logic [7:0]  data_in  = 0;
    logic [15:0] address  = 0;
    logic [8:0]  data_out = 0;

    // (2) Checker: prevent read and write at the same time
    function void check_RW();
        if (read && write)
            $fatal("ERROR: read and write active at same time! time=%0t", $time);
    endfunction

    initial begin
        forever begin
            @(posedge clk);
            check_RW();
        end
    end

    // (3) Clocking block - posedge clk domain
    clocking cb @(posedge clk);
        default input #0 output #1ns;
        output write;
        output read;
        output data_in;
        output address;
        input  data_out;
    endclocking

    // Modport for DUT (no clocking block per spec)
    modport DUT (
        input  clk,
        input  write,
        input  read,
        input  data_in,
        input  address,
        output data_out
    );

    // Modport for TB (clocking block only)
    modport TB (
        clocking cb
    );

endinterface
