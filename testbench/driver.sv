class my_driver extends uvm_driver #(transact);
    
    `uvm_component_utils(my_driver)
    `uvm_register_cb(my_driver, driver_base_callback)

    virtual dut_interface m_vif;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db #(dut_interface)::get(this, "", "vif", m_vif);
    endfunction

    virtual function void pre_reset_phase(uvm_phase phase);
        super.pre_reset_phase(phase);
        `uvm_info("TRACE",$sformatf("%m"),UVM_HIGH)
        phase.raise_objection(this);
            //initialize driver virtual interface
            m_vif.driver_sb.frame_n <= `x;//initialize x
            ...
        phase.drop_objection(this);
    endfunction

    virtual function void reset_phase(uvm_phase phase);
        phase.raise_objection(this);
            #100;
            super.reset_phase(phase);
            `uvm_info("my_driver", "Reset phase", UVM_MEDIUM)
            //reset driver virtual interface
            m_vif.driver_sb.frame_n <= 1'b0;//initialize x
        phase.drop_objection(this);
    endfunction

    virtual function void configure_phase(uvm_phase phase);
        phase.raise_objection(this);
        super.connect_phase(phase);
        `uvm_info("my_driver", "Configure phase", UVM_MEDIUM)
        phase.drop_objection(this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            logic [7:0] temp;
            repeat(10) @(m_vif.driver_cb);//wait 10 clock cycles
            seq_item_port.get_next_item(req);//driver requests item from sequencer
            rsp = my_transaction::type_id::create("rsp");//create response transaction
            $cast(rsp,req.clone());
            rsp.set_id_info(req);
            seq_item_port.put_response(rsp);//send response to sequencer
            `uvm_info("my_driver", $sformatf("Sending request: %s", req.to_string()), UVM_MEDIUM)
            //send data in req to m_vif
            //...

            seq_item_port.item_done();//event triggered to sequencer
        end
    endtask
endclass

