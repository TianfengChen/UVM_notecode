class my_env extends uvm_env;
    `uvm_component_utils(my_env)

    master_agent m_agent;
    env_config m_env_cfg;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        m_agent = master_agent::type_id::create("m_agent", this);

        if(!uvm_config_db#(env_config)::get(this,"","env_cfg",m_env_cfg))begin
            `uvm_fatal("CONFIG_ERROR","no interface found")
        end

        uvm_config_db#(agent_config)::set(this,"m_agent","m_agent_cfg",m_env_cfg.m_agent_cfg);

        if(m_env_cfg.is_coverage)begin
            `uvm_info("COVERAGE ENABLE","coverage is enabled",UVM_MEDIUM)
        end
        if(m_env_cfg.is_check)begin
            `uvm_info("CHECK ENABLE","check is enabled",UVM_MEDIUM)
        end
    endfunction

    //reference model

    //scoreboard
endclass