class router_reference extends uvm_component;

	`uvm_component_utils(router_reference)
	
	
////////////////Imports Declaration//////////////////////	
	`uvm_analysis_imp_decl(_yapp)
	`uvm_analysis_imp_decl(_hbus)
	
	 uvm_analysis_imp_yapp#(yapp_packet, router_reference) yapp_in;
	 uvm_analysis_imp_hbus#(hbus_transaction, router_reference) hbus_in;
///////////////Port Declaration//////////////////
	uvm_analysis_port #(yapp_packet) valid_data_out_to_sb;
//////////////Variables Declaration //////////////////////

int maxpktsize;
int router_en;
int valid_packets;
int invalid_packets_dropped;
////////////////Constructor///////////////////
	function new(string name, uvm_component parent);
		super.new(name,parent);
		yapp_in = new("yapp_in", this);
		hbus_in = new("hbus_in", this);
		
		valid_data_out_to_sb = new("valid_data_out_to_sb", this);
		
	endfunction
////////////////HBUS Write Implementation Method //////////////

	 function void write_hbus(input hbus_transaction hbus_write);
			if(hbus_write.haddr == 16'h1000 && hbus_write.hwr_rd == HBUS_WRITE)
				begin
					maxpktsize = hbus_write.hdata;				
				end
			if(hbus_write.haddr == 16'h1001 && hbus_write.hwr_rd == HBUS_WRITE)
				begin
					router_en = hbus_write.hdata;				
				end				
				`uvm_info("Write HBUS", $sformatf("router_en = %0d,maxpktsize = %0d", router_en,maxpktsize), UVM_LOW) 
	  endfunction

///////////////Yapp Write Implementation Method////////////////

	function void write_yapp(input yapp_packet packet);
				if(router_en[0] && packet.length < maxpktsize && packet.addr < 3)
					begin
						valid_data_out_to_sb.write(packet);
						valid_packets++;
					end
				else
					begin
						invalid_packets_dropped++;
					end	
	endfunction
	
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("Report Phase", $sformatf("Invalid Packets = %0d, Valid Packets = %0d", invalid_packets_dropped,valid_packets), UVM_LOW) 
	endfunction
endclass
