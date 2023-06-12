class my_transaction extends uvm_sequence_item;
    rand bit [6:0] sa;
    rand bit [6:0] da;
    rand reg [7:0] payload_data[$];

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(sa, UVM_ALL_ON)
        `uvm_field_int(da, UVM_ALL_ON)
        `uvm_field_int(payload_data, UVM_ALL_ON)
    `uvm_object_utils_end

    constraint c1{
        payload_data.size() inside {[2:10]};
    }

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

endclass

class my_transaction_d3 extends my_transaction;
    
    `uvm_object_utils_begin(my_transaction_d3)
    
    function new(string name = "my_transaction_d3");
        super.new(name);
    endfunction

    constraint d3{
        payload_data.size() inside {[2:3]};
    }
    
endclass