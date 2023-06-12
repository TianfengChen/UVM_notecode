class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)
    uvm_blocking_put_port#(my_transaction) mon2rfm_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        this.mon2rfm_port = new("mon2rfm_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            `uvm_info("MON_RUN_PHASE","MONITOR RUN!",UVM_MEDIUM)
            my_transaction tr;
            this.mon2rfm_port.put(tr);
        end
    endtask

endclass