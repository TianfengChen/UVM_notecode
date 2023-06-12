class my_reference_model extends uvm_component;
    `uvm_component_utils(my_reference_model)
    uvm_blocking_put_imp#(my_transaction, my_reference_model) rfm_import;
    function new(string name, uvm_component parent);
        super.new(name, parent);
        this.rfm_import = new("rfm_import", this);
    endfunction

    task put(my_transaction t);
        // do something with the transaction
        
    endtask
endclass