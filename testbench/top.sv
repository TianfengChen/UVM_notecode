//compile
//uvm-1.2/src/uvm_pkg.sv top.sv
//run
`timescale 1ns/100ps
import uvm_pkg::*;
`include "../uvm-1.2/src/uvm_macros.svh"
`include "sys_def.svh"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "testcase.sv"
`include "top.sv"


module top;
    //initialize
    logic clk;
    dut_interface dut_if(clk);

    initial begin
        //set interface
        uvm_config_db#(virtual dut_interface)::set(null, "*.m_gant", "vif", dut_if);
        
        $dumpfile("dump.vcd");
        $dumpvars(0, test);
        $display("Start test");
        run_test();
        $display("End test");
        $finish;

    end


endmodule