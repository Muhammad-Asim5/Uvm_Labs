typedef enum {GOOD_PARITY, BAD_PARITY} parity_type_e;

class yapp_packet extends uvm_sequence_item;

	rand bit [1:0] addr;
	rand bit [5:0] length;
	rand bit [7:0] payload[];
	bit [7:0] parity;
	rand parity_type_e parity_type;
	rand int packet_delay; 

	constraint c1{addr inside {[2'd0:2'd2]};}
	constraint c3{length == payload.size();}
	constraint c4{parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1};}
	constraint c5{packet_delay inside {[1:20]};}
	
	function new(string name = "yapp_packet");
		super.new(name);
	endfunction
	
	`uvm_object_utils_begin(yapp_packet)
		`uvm_field_int(addr, UVM_ALL_ON)
		`uvm_field_int(length, UVM_ALL_ON)
		`uvm_field_array_int(payload, UVM_ALL_ON)
		`uvm_field_int(parity, UVM_ALL_ON)
		`uvm_field_int(packet_delay, UVM_ALL_ON)
	`uvm_object_utils_end

	function bit [7:0] calc_parity();
		bit [7:0] result;
		result = {length,addr};
		foreach (payload[i])
			result = result ^ payload[i];
		return result;
	endfunction
	
	function void set_parity();
		if(parity_type == GOOD_PARITY)
			parity = calc_parity();
		else
			parity = ~calc_parity();
	endfunction
	
	function void post_randomize();
		super.post_randomize();
		set_parity();
	endfunction

endclass: yapp_packet

class short_yapp_packet extends yapp_packet;
	`uvm_object_utils(short_yapp_packet)
	
	constraint c2 {length < 15;}
	//constraint c6 {addr != 2;}
	
	function new(string name = "short_yapp_packet");
		super.new(name);
	endfunction
	
endclass
