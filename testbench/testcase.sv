class my_test extends uvm_test;
    `uvm_component_utils(my_test)
    my_env env;
    env_config m_env_cfg;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_env_cfg = new("env_cfg");
        env = my_env::type_id::create("env", this);
        //set default sequence
        /*
        uvm_config_db#(uvm_object_wrapper)::set(this,
                                                "*.seq.run_phase",//reletive path, sequence object run_phase function
                                                "defalut_sequence", //name
                                                my_sequence::get_type());//type
        */
        //set sequence manually in run_phase

        //set data in config object
        m_env_cfg.item_num = 10;
        //get virtual interface
        if(!uvm_config_db#(virtual dut_interface)::get(this,"","top_if",,m_env_cfg.m_agent_cfg.m_vif))begin
            `uvm_fatal("CONFIG_ERROR","no interface found")
        end
        uvm_config_db#(env_config)::set(this,"","env_cfg",m_env_cfg);

            `uvm_fatal("NO_VIF","virtual interface not found")
        env = my_env::type_id::create("env", this);
        uvm_config_db#(uvm_object_wrapper)::set(this,
                                                "*.seq.run_phase",//reletive path, sequence object run_phase function
                                                "defalut_sequence", //name
                                                my_sequence::get_type());//type
        //set configuration db
        uvm_config_db#(int)::set(this,"*.seq","item_num",20);
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);//reride the function
        super.start_of_simulation_phase(phase);
        //$dumpfile("dump.vcd");
        //$dumpvars(0, test_top);
        uvm_top.print_topology(uvm_default_printer);
    endfunction

    virtual function void run_phase(uvm_phase phase);
        //set sequence manually 
        my_sequence seq_;
        seq_ = my_sequence::type_id::create("seq",this);
        phase.raise_objection(this);
        seq_.start(env.ma.seq);//set sequencer
        phase.drop_objection(this);
    endfunction

endclass

class my_test_type_d3 extends my_test;
    `uvm_component_utils(my_test_type_d3)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        set_type_override_by_type(my_transaction::get_type(), my_transaction_d3::get_type());
    endfunction
    
    //print factory overrides
    virtual function void report_phase(uvm_component phase);
        super.report_phase(phase);
        factory.print();
    endfunction
endclass

class my_inst_type_d3 extends my_test;
    `uvm_component_utils(my_inst_type_d3)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        set_inst_override_by_type("env.ma.seq",my_transaction::get_type(), my_transaction_d3::get_type());
    endfunction
    
    //print factory overrides
    virtual function void report_phase(uvm_component phase);
        super.report_phase(phase);
        factory.print();
    endfunction
endclass
