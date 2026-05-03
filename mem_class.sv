`timescale 1ns/1ps
package mem_pkg;

    class Transaction;

        rand bit [15:0] address;
        rand bit [7:0]  data_in;

        bit [8:0] expected_data;
        bit [8:0] data_out;

        static int error = 0;

        // (a) Custom constructor
        function new();
            address = $urandom;
            data_in = $urandom;
            expected_data = {^data_in, data_in};
            data_out = 9'b0;
        endfunction

        // (b) print_data_out
        function void print_data_out();
            $display("Time = %0t | data_out = %b", $time, data_out);
        endfunction

        // (c) static error - declared above

        // (d) static print_error
        static function void print_error();
            $display("Time = %0t | Total errors = %0d", $time, error);
        endfunction

        // (e) check expected_data with data_out
        function void check_data();
            if (expected_data !== data_out) begin
                error++;
                $display("ERROR at time %0t", $time);
                $display("Address       = %h", address);
                $display("Data in       = %h", data_in);
                $display("Expected data = %b", expected_data);
                $display("Actual data   = %b", data_out);
            end
            else begin
                $display("PASS at time %0t | address = %h | data_out = %b",
                         $time, address, data_out);
            end
        endfunction

        // (f) deep_copy
        function Transaction deep_copy();
            Transaction copy;
            copy = new();
            copy.address       = this.address;
            copy.data_in       = this.data_in;
            copy.expected_data = this.expected_data;
            copy.data_out      = this.data_out;
            return copy;
        endfunction

    endclass

endpackage
