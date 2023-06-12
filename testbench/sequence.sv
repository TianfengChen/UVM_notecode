class my_sequence extends uvm_sequence #(transact);
    `uvm_object_utils(my_sequence)
    
    int item_num = 10;
    transact tr;
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    function void pre_randomize();
        uvm_config_db#(int)::get(m_sequencer,"","item_num",item_num);
    endfunction


    virtual task body();//to do

    /*
        
        `uvm_info("my_sequence", "Starting my_sequence", UVM_MEDIUM)
        fork
            tr = transact::type_id::create("tr");
            tr.randomize();
            tr.print();
            finish_item(tr);
            //seq_item_port.write(tr);
        join_none
    */

    if(starting_phase != null)
        starting_phase.raise_objection(this);
    
    repeat(item_num) begin
        `uvm_do(req)
        //macro, same as the code in the comment above
        //req is pointer which points to transact tr
        get_response(rsp);
    end

    #100
    if(starting_phase != null)
        starting_phase.drop_objection(this);

    endtask

endclass

/*
class top_sequence extends uvm_sequence#(transact);
    
    virtual task body();
        m_sequencer.set_arbitration(SEQ_ARB_STRICT_FIFO);
        fork
            `uvm_do_pri(t_seq,100);//seq_or_item object, priority
            `uvm_do_pri(r_seq,100);
            `uvm_do_pri(w_seq,100);
        join_none
    endtask
endclass

class my_sequence_lib extends uvm_sequence_library#(transact);
    `uvm_object_utils(my_sequence_lib)
    function new(string name = "my_sequence_lib");
        super.new(name);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        phase.m_sequencer.add_sequence(t_seq);
        phase.m_sequencer.add_sequence(r_seq);
        phase.m_sequencer.add_sequence(w_seq);
    endfunction
endclass

*/