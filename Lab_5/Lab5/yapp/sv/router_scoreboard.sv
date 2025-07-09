class router_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(router_scoreboard)

  yapp_packet q0[$];   
  yapp_packet q1[$];   
  yapp_packet q2[$];                             
  

 int channel_zero_matched_pkts = 0;
 int channel_one_matched_pkts= 0;
 int channel_two_matched_pkts= 0;
 int channel_zero_unmatched_pkts= 0;
 int channel_one_unmatched_pkts= 0;
 int channel_two_unmatched_pkts= 0;

    
 `uvm_analysis_imp_decl(_yapp)
 `uvm_analysis_imp_decl(_chan0)
 `uvm_analysis_imp_decl(_chan1)
 `uvm_analysis_imp_decl(_chan2)

  uvm_analysis_imp_yapp#(yapp_packet, router_scoreboard) yapp_in;
  uvm_analysis_imp_chan0#(channel_packet, router_scoreboard) chan0_in;
  uvm_analysis_imp_chan1#(channel_packet, router_scoreboard) chan1_in;
  uvm_analysis_imp_chan2#(channel_packet, router_scoreboard) chan2_in;
  

  
  function new (string name = "router_scoreboard", uvm_component parent);
    super.new(name, parent);    
     yapp_in  = new("yapp_in", this);
     chan0_in = new("chan0_in", this);
     chan1_in = new("chan1_in", this);
     chan2_in = new("chan2_in", this);
  endfunction
  
 
 

  function void write_yapp(input yapp_packet packet);
   yapp_packet ypkt;
   $cast(ypkt, packet.clone() );
   case(ypkt.addr)
	2'b00: q0.push_back(ypkt);
	2'b01: q1.push_back(ypkt);
	2'b10: q2.push_back(ypkt);
   endcase
  endfunction


 function void write_chan0 (input channel_packet cp);
  yapp_packet yp_pkt;
   if((q0.size)) begin
   yp_pkt = q0.pop_front();
   if((ccomp(yp_pkt,cp)))
   begin
	channel_zero_matched_pkts++;
   end
   else
        channel_zero_unmatched_pkts++; 
   end
  endfunction
   
 
 function void write_chan1 (input channel_packet cp);
  yapp_packet yp_pkt;
   if((q1.size())) begin
   yp_pkt = q1.pop_front();
   if((ccomp(yp_pkt,cp)) == 1)
   begin
	channel_one_matched_pkts++;
   end
   else
        channel_one_unmatched_pkts++; 
   end
  endfunction

 
 function void write_chan2 (input channel_packet cp);
  yapp_packet yp_pkt;

   if((q2.size())) begin
   yp_pkt = q2.pop_front();
   if((ccomp(yp_pkt,cp)) == 1)
   begin
	channel_two_matched_pkts++;
   end
   else
        channel_two_unmatched_pkts++; 
   end
  endfunction


function void report_phase(uvm_phase phase);
    `uvm_info("Scoreboard",$sformatf("Total packets received by channel zero: %0d, Matched packets: %0d, Failed Packets: %0d", channel_zero_matched_pkts+channel_zero_unmatched_pkts, channel_zero_matched_pkts, channel_zero_unmatched_pkts ),UVM_LOW)
       `uvm_info("Scoreboard",$sformatf("Total packets received by channel zero: %0d, Matched packets: %0d, Failed Packets: %0d", channel_one_matched_pkts+channel_one_unmatched_pkts, channel_one_matched_pkts, channel_one_unmatched_pkts ),UVM_LOW)
      `uvm_info("Scoreboard",$sformatf("Total packets received by channel zero: %0d, Matched packets: %0d, Failed Packets: %0d", channel_zero_matched_pkts+channel_zero_unmatched_pkts, channel_two_matched_pkts, channel_two_unmatched_pkts ),UVM_LOW)
    
    `uvm_info("Scoreboard",$sformatf("Packets left in Queue1: %0d, Packets left in Queue2: %0d, Packets left in Queue3: %0d", q0.size(), q1.size(), q2.size() ),UVM_LOW)
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

