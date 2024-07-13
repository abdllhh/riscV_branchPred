
module testbench;

reg clk;
reg reset;
//wire [31:0] data;
//wire branchOrOut;
wire [3:0] data4bitpart1,data4bitpart2;
//wire [6:0] sout;
wire [31:0]ResultW;
wire [6:0] sout1, sout2;
/*
wire [4:0] addressoutput;
wire [4:0] addressTowhichToBranch;
wire [31:0] instuctionfetchdata32;
wire [4:0] addressinsfetchcurrent;
wire [2:0]count;
wire branchoperand;
wire [4:0] currentregbranch, addregbranch;
wire flag;
wire [1:0] ForwardAE, ForwardBE;
wire [31:0] Aout,Bout;
wire [31:0] solm;
wire [31:0] regdatam;
*/
 RISCV_2 riscv_instance (
        .clk(clk),
        .reset(reset),
       // .clr(clr),
        //.stall(stall),
        .data4bitpart1(data4bitpart1),
        .data4bitpart2(data4bitpart2),
       // .sout(sout),
		  .ResultW(ResultW),
		  /*
	     . addressoutput(addressoutput),
		  .addressTowhichToBranch(addressTowhichToBranch),
		  .instuctionfetchdata32(instuctionfetchdata32),
		  .addressinsfetchcurrent(addressinsfetchcurrent),
		  .count(count),
		  .branchoperand(branchoperand),
		  .currentregbranch(currentregbranch), 
		  .addregbranch(addregbranch),
		  .flag(flag),
		  .branchOrOut(branchOrOut),
		  .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
		  .Bout(Bout),
		  .Aout(Aout),
		  .solm(solm),
		  .regdatam(regdatam)
		  */
		  .sout1(sout1),
		  .sout2(sout2)
    );

// Clock generation
always begin
    clk = 0;
    #15;
    clk = 1;
    #15;
end

// Reset generation
initial begin
    //clr=0;
	 //stall=0;
    reset = 1;
    #300; // Reset for 100 ns
    reset = 0;
    #10000;
    $finish;
end

endmodule

/*
module testbench2342;

// Parameters
parameter MEM_DEPTH = 32;
parameter MEM_WIDTH = 32;

// Testbench signals
reg clk;
reg reset;
reg [31:0] addr;
reg [31:0] writeData;
reg memWrite;
wire [31:0] readData;

// Instantiate the DataMemory module
DataMemory #(MEM_DEPTH, MEM_WIDTH) uut (
    .clk(clk),
    .reset(reset),
    .addr(addr),
    .writeData(writeData),
    .memWrite(memWrite),
    .readData(readData)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period clock
end

// Test sequence
initial begin
    // Initialize inputs
    reset = 1;
    addr = 0;
    writeData = 0;
    memWrite = 0;
    #6
    
    #10 reset = 0;
    
    // Write some data to memory
    #10 addr = 5; writeData = 32'hDEADBEEF; memWrite = 1;
    #10 addr = 10; writeData = 32'hCAFEBABE; memWrite = 1;
    #10 memWrite = 0;
    
    // Read data from memory
    #10 addr = 10;
    
    
    #10 addr = 5;
   
    // Reset memory and check
    #10 reset = 1;
    #10 reset = 0;
    #10 addr = 5;
    #10 $display("Read data at address 5 after reset: %h (Expected: 00000000)", readData);
    
    // End simulation
    #10 $finish;
end

endmodule


module  testbenchefsczds;

// Declare testbench variables
reg stall;
reg reset;
reg clk;
reg [4:0] jumping;
wire [31:0] dataout;
reg branch;
reg clr;
wire [4:0] nextaddressoutput;
wire [4:0] addressoutput;
wire [31:0] datain;
wire [4:0] address;

// Instantiate the instructionfetch module
instructionfetch uut (
    .stall(stall),
    .reset(reset),
    .clk(clk),
    .jumping(jumping),
    .dataout(dataout),
    .branch(branch),
    .clr(clr),
    .nextaddressoutput(nextaddressoutput),
    .addressoutput(addressoutput),
    .datain(datain),
    .address(address)
);

// Clock generation
always begin
    #5 clk = ~clk;  // Toggle clock every 5 time units
end

// Testbench procedure
initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    stall = 0;
    jumping = 5'b00000;
    branch = 0;
    clr = 0;

    // Apply reset
    #10 reset = 0;
  #10
    // Test normal operation
    #10;
    jumping = 5'b00001;
    branch = 1;
    
    #10;
    branch = 0;
    stall = 0;

    #10;
    stall = 0;
    clr = 0;

    #10;
    clr = 0;

    // Test jumping
    #10;
    jumping = 5'b01010;
    branch = 1;
    #10
	 branch=0;
    // Finish simulation
    #50;
    $finish;
end



endmodule


module th;


    // Inputs
	 reg flag;
    reg [6:0] ins;
    reg clk;
    reg [4:0] currentadd;
    reg [4:0] additionadd;
    reg branch;
    // Outputs
    wire reset;
    wire branchop;
    wire [4:0] add;
	 wire w1,w2,w3,w4,w5;
    wire [2:0] count;
    // Instantiate the branch predictor module
    branchpredictor dut (
        .ins(ins),
        .clk(clk),
        .currentadd(currentadd),
        .additionadd(additionadd),
		  .branch(branch),
		  .flag(flag),
        .add(add),
        .reset(reset),
        .branchop(branchop),
		  .w1(w1),
		  .w2(w2),
		  .w3(w3),
		  .w4(w4),
		  .w5(w5),
		  .count(count)
		  
		  
		  
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin
        // Initialize inputs
		  clk=0;
		  flag=0;
        ins = 7'b1101111;
        currentadd = 5'b00010;
        additionadd = 5'b00100;
        // Apply inputs
        #5 ins = 7'b1100011; // branch instruction
		  currentadd = 5'b10011;
        #5 ins = 7'b0000011; // lw instruction
		  currentadd = 5'b00110;
        #5 ins = 7'b0010011;
		  branch=0;flag=1;
		  currentadd = 5'b11100; // I type instruction
        #5 ins = 7'b0100011;
		  
		  // sw instruction
        #5 ins = 7'b0110011; // R type instruction
        #5 ins = 7'b0110111;
		  // U type instruction
        #5 ins = 7'b1101111;
		 branch=1; // jal instruction
        // Finish simulation
        #100 $finish;
    end
    
endmodule


module testbench123;

    // Define parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Declare signals
    reg stall;
    reg reset;
    reg clk;
    reg [4:0] jumping;
    wire [31:0] dataout;
    reg branch;
    reg clr;
    wire [4:0] nextaddressoutput;
    wire [4:0] addressoutput;

    // Instantiate the instructionfetch module
    instructionfetch dut (
        .stall(stall),
        .reset(reset),
        .clk(clk),
        .jumping(jumping),
        .dataout(dataout),
        .branch(branch),
        .clr(clr),
        .nextaddressoutput(nextaddressoutput),
        .addressoutput(addressoutput)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk; // Toggle the clock every half period

    // Initial stimulus
    initial begin
        // Initialize inputs
        
        clk = 0;
       
        clr=0;
	 stall=0;

        // Apply reset
        reset = 1;
        #20; // Wait for a few clock cycles
        reset = 0;

        // Wait for a few clock cycles
        #50;

        
        
        // Wait for a few clock cycles
        #50;

        
        // Wait for a few clock cycles
        #50;

        // Add more stimulus as needed...

        // Finish simulation
        $finish;
    end

endmodule


module te;

    // Define parameters
    parameter CLK_PERIOD = 20; // Clock period in ns

    // Declare signals
    reg clk;
    reg reset;
    reg stall;
    reg [31:0] ins;
    reg [4:0] currentaddress;
    reg [4:0] nxtadd;
    reg [4:0] regadd;
    reg wen;
    reg [31:0] Dwrite;
    wire [1:0] ResultSrc;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire Jump;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl;
    wire [31:0] RD1E;
    wire [31:0] RD2E;
    wire [31:0] immext;
    wire branch;
    wire [4:0] currentaddressout;
    wire [4:0] nxtaddout;
    wire [4:0] RS1E;
    wire [4:0] RS2E;
    wire [4:0] RDE;

    // Instantiate the instructiondecode module
    instructiondecode dut (
        .clk(clk),
        .reset(reset),
        .stall(stall),
        .ins(ins),
        .currentaddress(currentaddress),
        .nxtadd(nxtadd),
        .regadd(regadd),
        .wen(wen),
        .Dwrite(Dwrite),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .immext(immext),
        .branch(branch),
        .currentaddressout(currentaddressout),
        .nxtaddout(nxtaddout),
        .RS1E(RS1E),
        .RS2E(RS2E),
        .RDE(RDE)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk; // Toggle the clock every half period

    // Initial stimulus
    initial begin
        // Initialize inputs
		  clk=0;
        
        

        // Apply reset
        reset = 1;
        #30; // Wait for a few clock cycles
        reset = 0;
        stall = 0;
        ins = 32'b0000000_00000_00001_000_00011_1100011;
        currentaddress = 5'b00000;
        nxtadd = 5'b00001;
      
        // Wait for a few clock cycles
        #50;
        reset = 0;
        stall = 0;
        ins =32'b0100000_00000_00001_000_00011_0110011;
        currentaddress = 5'b00001;
        nxtadd = 5'b00010;
      #50;
        reset = 0;
        stall = 0;
       ins = 32'b000000000111_00000_000_00100_0010011;
        currentaddress = 5'b00010;
        nxtadd = 5'b00011;
        
#50;
        reset = 0;
        stall = 0;
       ins = 32'b0000000_00000_00001_110_00101_0110011;
        currentaddress = 5'b00011;
        nxtadd = 5'b00100;
        // Wait for a few clock cycles
		  #50;
        reset = 0;
        stall = 0;
        ins = 32'b0000000_00000_00010_000_00110_0110011;
        currentaddress = 5'b00100;
        nxtadd = 5'b00101;
        // Wait for a few cl
		  #50;
        reset = 0;
        stall = 0;
       // ins = 32'b0100000_00000_00001_000_00011_0110011;
        currentaddress = 5'b00101;
        nxtadd = 5'b00110;
        #50;

        // Add more stimulus as needed...

        // Finish simulation
        $finish;
    end

endmodule


module testbench1q;

    // Inputs
    reg clk, RegWrite, MemWrite, Jump, branch, ALUSrc;
    reg [1:0] ResultSrc;
    reg [2:0] ALUControl;
    reg [31:0] RD1E, RD2E, immext;
    reg [4:0] currentaddress, nxtadd, Rde;
    
    // Outputs
    wire branchchoice, regwitem, memwritem, zeroFlag;
    wire [1:0] resultsrcm;
    wire [31:0] solm, regdatam;
    wire [4:0] nxtaddoutm, Rdm, jumping;
    
    // Instantiate the module to be tested
    execute dut (
        .clk(clk),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .Jump(Jump),
        .branch(branch),
        .ALUSrc(ALUSrc),
        .ResultSrc(ResultSrc),
        .ALUControl(ALUControl),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .immext(immext),
        .currentaddress(currentaddress),
        .nxtadd(nxtadd),
        .Rde(Rde),
        .branchchoice(branchchoice),
        .regwitem(regwitem),
        .memwritem(memwritem),
        .resultsrcm(resultsrcm),
        .solm(solm),
        .regdatam(regdatam),
        .nxtaddoutm(nxtaddoutm),
        .Rdm(Rdm),
        .jumping(jumping),
        .zeroFlag(zeroFlag)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initialize inputs
    initial begin
        clk = 0;
     

        // Provide some time for initialization
        #10;

          clk = 0;
        RegWrite = 1;
        MemWrite = 0;
        Jump = 0;
        branch = 0;
        ALUSrc = 1;
        ResultSrc = 2'b00;
        ALUControl = 3'b000;
        RD1E = 17;
        RD2E = 34;
        immext = 7;
        currentaddress = 5'b00000;
        nxtadd = 5'b00001;
        Rde = 4;

        // Provide some time for initialization
        #10;
        #1000 $finish;
    end

    // Monitor the outputs
    always @(posedge clk) begin
        // Your output monitoring code here
        // Monitor the outputs and display them
        // ...
    end

endmodule
module testbench2;

    // Inputs
    reg clk, reset, RegWrite, MemWrite;
    reg [1:0] ResultSrc;
    reg [4:0] Rdm, nxtadd;
    reg [31:0] ALUResultm, regdata;
    
    // Outputs
    wire [4:0] nxtaddout, Rdw;
    wire [31:0] ALUResultw, ResultW, readDataw;
    wire RegWritew;
    wire [1:0] ResultSrcw;
    wire MemWritew;
    
    // Instantiate the module to be tested
    storeStage dut (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .Rdm(Rdm),
        .nxtadd(nxtadd),
        .ALUResultm(ALUResultm),
        .regdata(regdata),
        .nxtaddout(nxtaddout),
        .Rdw(Rdw),
        .ALUResultw(ALUResultw),
        .RegWritew(RegWritew),
        .ResultSrcw(ResultSrcw),
        .MemWritew(MemWritew),
        .ResultW(ResultW),
        .readDataw(readDataw)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initialize inputs
    initial begin
        clk = 0;
        reset = 0;
        RegWrite = 0;
        MemWrite = 0;
        ResultSrc = 2'b00;
        Rdm = 5'b00100;
        nxtadd = 5'b00001;
        ALUResultm = 24;
        regdata = 32'h00000000;

        // Provide some time for initialization
        #10;

        // Toggle reset
       

        // Test case 1
        // Provide input values for the test case
        // Your inputs here
        // ...

        // Test case 2
        // Provide input values for the test case
        // Your inputs here
        // ...
        
        // Add more test cases if needed
        
        // End simulation after some time
        #1000 $finish;
    end

    // Monitor the outputs
    always @(posedge clk) begin
        // Your output monitoring code here
        // Monitor the outputs and display them
        // ...
    end

endmodule
*/