`timescale 1ns/1ps

module top;

    logic clk;

    // (6) 10 MHz clock - period = 100ns, half period = 50ns
    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end

    // Interface instance
    my_mem_if mem_bus(clk);

    // DUT instance (via DUT modport)
    my_mem dut(mem_bus);

    // Program block instance (via TB modport)
    test_program tb(mem_bus);

    // Waveform dump
    
    initial begin
        $fsdbDumpfile("wave.fsdb");
        $fsdbDumpvars(0, top);
    end

endmodule
