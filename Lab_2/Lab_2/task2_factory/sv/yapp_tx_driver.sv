class yapp_tx_driver extends uvm_driver #(yapp_packet);

	`uvm_component_utils(yapp_tx_driver)

	function new(string name = "yapp_tx_driver", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
	super.run_phase(phase);
		forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
	endtask
	
	task send_to_dut(yapp_packet ypt);
			`uvm_info(get_type_name(), $sformatf("Packet is \n%s", req.sprint()), UVM_LOW)
			#10;
	endtask
	
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "Simulation Phase - driver", UVM_HIGH);
	endfunction
	
endclass: yapp_tx_driver
