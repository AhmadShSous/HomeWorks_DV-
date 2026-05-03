`timescale 1ns/1ps

module my_mem(my_mem_if.DUT mem_bus);
    logic [8:0] mem_array[int];

    always @(posedge mem_bus.clk) begin
        if (mem_bus.write) begin
            mem_array[mem_bus.address] = {^mem_bus.data_in, mem_bus.data_in};
        end
        else if (mem_bus.read) begin
            mem_bus.data_out = mem_array[mem_bus.address];
        end
    end

endmodule
