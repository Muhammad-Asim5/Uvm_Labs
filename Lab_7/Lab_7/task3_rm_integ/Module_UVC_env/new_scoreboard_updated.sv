class router_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(router_scoreboard)


 int channel_zero_matched_pkts = 0;
 int channel_one_matched_pkts= 0;
 int channel_two_matched_pkts= 0;
 int channel_zero_unmatched_pkts= 0;
 int channel_one_unmatched_pkts= 0;
 int channel_two_unmatched_pkts= 0;
 int invalid_packet = 0;
 int Packets_Remained;
       	int maxpktsize = 0;
    	bit router_en; 
    	
	uvm_tlm_analysis_fifo #(yapp_packet)      yapp_fifo;
	uvm_tlm_analysis_fifo #(channel_packet)   Channel0_fifo;
	uvm_tlm_analysis_fifo #(channel_packet)   Channel1_fifo;
	uvm_tlm_analysis_fifo #(channel_packet)   Channel2_fifo;
	uvm_tlm_analysis_fifo #(hbus_transaction) Hbus_fifo;
	
	
	function new(string name = "router_scoreboard", uvm_component parent);
		super.new(name,parent);
		
		yapp_fifo     = new("yapp_fifo",this);
		Channel0_fifo = new("Channel0_fifo",this);
		Channel1_fifo = new("Channel1_fifo",this);
		Channel2_fifo = new("Channel2_fifo",this);
		Hbus_fifo 	  = new("Hbus_fifo",this);

	endfunction	
  
 
 	task run_phase(uvm_phase phase);
		  super.run_phase(phase);

		  fork
		  	begin
		      		forever begin
				yapp_packet y_Package;
				channel_packet CH_Package;
				yapp_fifo.get(y_Package);


				if (!router_en) continue;

				case (y_Package.addr)
				  0: begin
				  	
				  	Channel0_fifo.get(CH_Package);
				  	if (ccomp(y_Package, CH_Package))
				  	begin
				  		channel_zero_matched_pkts++;
					end else begin
				  		channel_zero_unmatched_pkts++;
					end
				end
				  1: begin
				  	
				  	Channel1_fifo.get(CH_Package);
				  	if (ccomp(y_Package, CH_Package))
				  	begin
				  		channel_one_matched_pkts++;
					end else begin
				  		channel_one_unmatched_pkts++;
					end
				end
				  2: begin
				  	
				  	Channel2_fifo.get(CH_Package);
				  	if (ccomp(y_Package, CH_Package))
				  	begin
				  		channel_two_matched_pkts++;
					end else begin
				  		channel_two_unmatched_pkts++;
					end
				end
				default: begin
					`uvm_error("PKT_COMPARE","Invalid Address")
					invalid_packet++;
				end
				endcase
			      end
			    end
			    begin
			      forever begin
				hbus_transaction hbus_packet;
				Hbus_fifo.get(hbus_packet);

				if (hbus_packet.hwr_rd == HBUS_WRITE) begin
				  case (hbus_packet.haddr)
				    16'h1000 : maxpktsize = hbus_packet.hdata;
				    16'h1001: router_en= hbus_packet.hdata;
				  endcase
				end
			      end
			    end
		  	join
	endtask
  function void check_phase(uvm_phase phase);
  	if (Hbus_fifo.is_empty()) begin
  		`uvm_info("HBUS FIFO", "This FIFO is Empty", UVM_LOW) 
  	end
  	else begin
  		`uvm_info("HBUS FIFO", "This FIFO is not Empty", UVM_LOW) 
  		Packets_Remained += Hbus_fifo.size();
  	end
  	if (yapp_fifo.is_empty()) begin
  		`uvm_info("YAPP FIFO", "This FIFO is Empty", UVM_LOW) 
  	end
  	else begin
  		`uvm_info("YAPP FIFO", "This FIFO is not Empty", UVM_LOW) 
  		Packets_Remained += yapp_fifo.size();
  	end
  	if (Channel0_fifo.is_empty()) begin
  		`uvm_info("Chan0 FIFO", "This FIFO is Empty", UVM_LOW) 
  	end
  	else begin
  		`uvm_info("Chan0 FIFO", "This FIFO is not Empty", UVM_LOW) 
  		Packets_Remained += Channel0_fifo.size();
  	end
  	if (Channel1_fifo.is_empty()) begin
  		`uvm_info("Chan1 FIFO", "This FIFO is Empty", UVM_LOW) 
  	end
  	else begin
  		`uvm_info("Chan1 FIFO", "This FIFO is not Empty", UVM_LOW) 
  		Packets_Remained += Channel1_fifo.size();
  	end
  	
  	if (Channel2_fifo.is_empty()) begin
  		`uvm_info("Chan2 FIFO", "This FIFO is Empty", UVM_LOW) 
  	end
  	else begin
  		`uvm_info("Chan2 FIFO", "This FIFO is not Empty", UVM_LOW) 
  		Packets_Remained += Channel2_fifo.size();
  	end
  endfunction  
function void report_phase(uvm_phase phase);
    `uvm_info("Scoreboard",$sformatf("\n Total packets received by channel zero: %0d\n Matched packets: %0d\n Failed Packets: %0d\n", channel_zero_matched_pkts+channel_zero_unmatched_pkts, channel_zero_matched_pkts, channel_zero_unmatched_pkts ),UVM_LOW)
       `uvm_info("Scoreboard",$sformatf("\n Total packets received by channel one: %0d\n Matched packets: %0d\n Failed Packets: %0d\n", channel_one_matched_pkts+channel_one_unmatched_pkts, channel_one_matched_pkts, channel_one_unmatched_pkts ),UVM_LOW)
      `uvm_info("Scoreboard",$sformatf("\n Total packets received by channel two: %0d\n Matched packets: %0d\n Failed Packets: %0d\n", channel_two_matched_pkts+channel_two_unmatched_pkts, channel_two_matched_pkts, channel_two_unmatched_pkts ),UVM_LOW)
    
    `uvm_info("Scoreboard",$sformatf("\n Packets left in Fifo1: %0d\n Packets left in Fifo2: %0d\n Packets left in Fifo3: %0d\n", Channel0_fifo.size(), Channel1_fifo.size(), Channel2_fifo.size() ),UVM_LOW)
  endfunction



 
//----------UVM Scoreboard comparison

function bit ccomp(input yapp_packet yp, input channel_packet cp, uvm_comparer comparer = null);
    if(comparer==null)
        comparer=new();

    ccomp = comparer.compare_field("addr",yp.addr,cp.addr,2);
    ccomp &= comparer.compare_field("length",yp.length,cp.length,6);
    ccomp &= comparer.compare_field("parity",yp.parity,cp.parity,1);
    foreach (yp.payload [i])
        ccomp &= comparer.compare_field("payload",yp.payload[i],cp.payload[i],8);
   endfunction 

 
   // custom packet compare function using inequality operators
   /*function bit comp_equal (input yapp_packet yp, input channel_packet cp);
      // returns first mismatch only
      if (yp.addr != cp.addr) begin
        `uvm_error("PKT_COMPARE",$sformatf("Address mismatch YAPP %0d Chan %0d",yp.addr,cp.addr))
        return(0);
      end
      if (yp.length != cp.length) begin
        `uvm_error("PKT_COMPARE",$sformatf("Length mismatch YAPP %0d Chan %0d",yp.length,cp.length))
        return(0);
      end
      foreach (yp.payload [i])
        if (yp.payload[i] != cp.payload[i]) begin
        
  `uvm_error("PKT_COMPARE",$sformatf("Payload[%0d] mismatch YAPP %0d Chan %0d",i,yp.payload[i],cp.payload[i]))
          return(0);
        end
      if (yp.parity != cp.parity) begin
        `uvm_error("PKT_COMPARE",$sformatf("Parity mismatch YAPP %0d Chan %0d",yp.parity,cp.parity))
        return(0);
      end
      return(1);
   endfunction*/

endclass

