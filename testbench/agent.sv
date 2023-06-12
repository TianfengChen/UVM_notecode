//initiate MON, DRV,SEQ
//connect
class master_agent extends uvm_agent;
    //passive only has monitor
    //active has monitor, driver, sequencer
    `uvm_component_utils(master_agent)
    my_sequencer seq;
    my_driver drv;
    my_monitor mon;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(is_active == UVM_ACTIVE)begin
            seq = my_sequencer::type_id::create("seq", this);//static member::static function
            drv = my_driver::type_id::create("drv", this);
        end
        mon = my_monitor::type_id::create("mon", this);//factory mechanism
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if(is_active == UVM_ACTIVE)begin
            drv.seq_item_port.connect(seq.seq_item_export);//seq_item_export is an import, connect driver and seqr
        end
    endfunction
endclass



