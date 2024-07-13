

module programcounter(
    input reset,
    input select,
    input [4:0] jumpingaddress,
    output [4:0] nextaddress,
    input stall,
    input clk,
    output reg [4:0] currentaddress
);
reg [4:0] counter;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter = 0;
    end else if (!stall) begin

            counter <= nextaddress;
        
    end
end
always@(counter or select)
begin
if(select)
  currentaddress<=jumpingaddress;
else  
  currentaddress<=counter;

end

assign nextaddress[4:0]= (currentaddress[4:0] + 1) ;

endmodule


module progrmemory(input [4:0]  address,input reset,output reg [31:0] data);
 reg [31:0] programline [16:0];
 integer i;
always@(*)
begin

 if(reset)
  begin
    for(i=0;i<17;i=i+1)
     begin
      programline[i]=0;
     end
	 programline[1]=32'b000000000010_00011111_00010_0110111;//load value in load reg2
	 programline[2]=32'b000000000011_00011111_00011_0110111;//load value in reg 3
	 programline[3]=32'b000000000001_00011111_00101_0110111;//load zero in result reg 5
	 programline[4]=32'b0000000_00100_00010_000_00100_0110011;//add reg 4 and reg 2
	 programline[5]=32'b0100000_00101_00011_000_00011_0110011;// decrement reg ister 3 by 1
	programline[6]=32'b0000000_00000_00011_001_11110_1100011;//branch
	 programline[7]=32'b000000001111_00011111_00111_0110111;//l
	 programline[8]=32'b000000001111_00011111_00111_0110111;//l
	 programline[9]=32'b000000001111_00011111_00111_0110111;//l
	 programline[10]=32'b000000001111_00011111_00111_0110111;//l
  end
else
  data=programline[address];
  
end

endmodule







module instructionreg(input [4:0] currentaddin,nxtaddin,input [31:0] datain,input stall,input clk,input reset,output reg [31:0] dataout,output reg [4:0] currentadd,nxtadd);

always@(posedge clk or posedge reset)
begin
 if(reset)
  begin
   dataout<=32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	
  end
 else if(!stall)
  begin
   dataout<=datain;
	currentadd<=currentaddin;
	nxtadd<=nxtaddin;
  end
end
endmodule


module instructionfetch(
    input stall,
    input reset,
    input clk,
    input [4:0] branching,jumping,
    output [31:0] dataout,
    input  branch,jump,
	 input clr,
	 output [4:0] nextaddressoutput,
	output  [4:0] addressoutput,
	output  [31:0] datain,
	output [4:0] address
	 
);
   
   //output  [31:0] datain
	wire [4:0] nextaddress,addressskip;
	wire decidejump;
	
	assign decidejump=branch|| jump;
	//output [4:0] address;
    // Instantiate sub-modules
    /*programadder programadder_inst(
        .clk(clk),
        .reset(reset),
        .stall(stall),
        .branch(branch),
        .jumping(jumping),
        .address(address)
    );*/
	 
	 
	assign addressskip = branch ?  branching:jumping ;
	 programcounter    programcounter_inst(.reset(reset),
	                                       .select(branch),
														.jumpingaddress(branching),
														.nextaddress(nextaddress),
														.stall(stall), 
														.clk(clk),
														.currentaddress(address));

    progrmemory progrmemory_inst(
        .address(address),
        .reset(reset),
        .data(datain)
    );

    instructionreg instructionreg_inst(
	     .currentaddin(address),
		  .nxtaddin(nextaddress),
        .datain(datain),
		  .stall(stall), 
        .clk(clk),
        .reset(clr),
        .dataout(dataout),
		  .currentadd(addressoutput),
		  .nxtadd(nextaddressoutput)
    );

endmodule

