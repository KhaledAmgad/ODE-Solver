
module Division_TB;
    reg [15:0] dividend, divisor ;
    reg clk;
    reg [15:0]expected;
    reg over;
	  wire	 overflow;
	  wire divbyzero;
	  wire error,ready;
	  reg enable;
    localparam sf = 2.0**-7.0; //  scaling factor is first 8 bits
    wire [15:0] quotient_out;
    localparam period = 20;  
    
    fixedpoint_Division div (.dividend(dividend), .divisor(divisor),.clk(clk), .quotient_out(quotient_out), .overflow(overflow),.divbyzero(divbyzero),.enable(enable),.error(error),.finished(ready));
    
    

	always 
	begin
		clk = 1'b1; 
		#5; 

		clk = 1'b0;
		#5; 
	end
initial begin

    
    // 7 / - 2 = - 3.5
    assign dividend = 16'b00000111_00000000;
    assign divisor  = 16'b11111110_00000000;
    assign expected=  16'b111111100_1000000;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 1 ] failed quotient should be b100000011_1000000");
    if(overflow!= over)  
        $display("Test Case [ 1 ] failed overflow should be 0 ");
    if(divbyzero!= 0)  
        $display("Test Case [ 1 ] failed quotient divbyzero should be 0 "); 
    if(error!= 0)  
        $display("Test Case [ 1 ] failed quotient error should be 0 ");  
     
    
    // -7 / - 2 =  3.5
    assign dividend = 16'b111111001_0000000;
    assign divisor  = 16'b111111110_0000000;
    assign expected=  16'b000000011_1000000;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 2 ] failed quotient should be b000000011_1000000");
    if(overflow!= over)  
        $display("Test Case [ 2 ] failed overflow should be 0 ");
    if(divbyzero!= 0)  
        $display("Test Case [ 2 ] failed divbyzero should be 0 "); 
    if(error!= 0)  
        $display("Test Case [ 2 ] failed quotient error should be 0 ");  
     

    
    // 7 / 0   undefined
    assign dividend = 16'b00000111_0000000;
    assign divisor  = 16'b00000000_0000000;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
	  #120;
    if(overflow!= over )  
        $display("Test Case [ 3 ] failed overflow should be 0 "); 
    if(divbyzero!= 1)  
        $display("Test Case [ 3 ] failed divbyzero should be 1 ");
    if(error!= 1)  
        $display("Test Case [ 3 ] failed quotient error should be 1");  
      

    
    
    // 75 / 0.5 = 150
    assign dividend = 16'b001001011_0000000;
    assign divisor  = 16'b000000000_1000000;
    assign expected=  16'b010010110_0000000;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 4 ] failed quotient should be b010010110_0000000");
    if(overflow!= over )  
        $display("Test Case [ 4 ] failed overflow should be 1 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 4 ] failed divbyzero should be 0 "); 
    if(error!= 0)  
        $display("Test Case [ 4 ] failed quotient error should be 0 ");  
     

    
    // 128 / 0.5 = 256   test overflow (overflow)
    assign dividend = 16'b010000000_0000000;
    assign divisor  = 16'b000000000_1000000;
    assign expected=  16'b000000000_0000000;
    assign over = 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 5 ] failed quotient should be b0000000000_0000000");
    if(overflow!= over )  
        $display("Test Case [ 5 ] failed overflow should be 1 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 5 ] failed divbyzero should be 0 ");  
    if(error!= 1)  
        $display("Test Case [ 5 ] failed quotient error should be 1 ");  
    

    
    // 74.7 / -4 = -18.665 
    assign dividend = 16'b001001010_1011001;
    assign divisor  = 16'b111111100_0000000;
    assign expected=  16'b111101101_0101010;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120; 
    if(quotient_out!= expected)  
        $display("Test Case [ 6 ] failed quotient should be b000001001_1000100");
    if(overflow!= over )  
        $display("Test Case [ 6 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 6 ] failed divbyzero should be 0 "); 
    if(error!= 0)  
        $display("Test Case [ 6 ] failed quotient error should be 0 ");  
     

    
    // 35.75 / 3.75 = 9.533   
    assign dividend = 16'b000100011_1100000;
    assign divisor  = 16'b000000011_1100000;
    assign expected=  16'b000001001_1000100;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 7 ] failed quotient should be b000001001_1000100");
    if(overflow!= over )  
        $display("Test Case [ 7 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 7 ] failed divbyzero should be 0 "); 
    if(error!= 0)  
        $display("Test Case [ 7 ] failed quotient error should be 0 ");  
     

    
    
    // 9.5 / 11.45 = 0.8296  
    assign dividend = 16'b000001001_1000000;
    assign divisor  = 16'b000001011_0111001;
    assign expected=  16'b00000000_01101010;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 8 ] failed quotient should be b00000000_01101010");
    if(overflow!= over )  
        $display("Test Case [ 8 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 8 ] failed divbyzero should be 0 ");
        
    if(error!= 0)  
        $display("Test Case [ 8 ] failed quotient error should be 0 ");  
      
  
  
   // - 200 /  0.5 =  - 400 overflow
    assign dividend = 16'b100111000_0000000;
    assign divisor  = 16'b000000000_1000000;
    assign expected=  16'b101110000_0000000;
    assign over = 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 9 ] failed quotient should be b101110000_0000000");
    if(overflow!= over )  
        $display("Test Case [ 9 ] failed overflow should be 1 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 9 ] failed divbyzero should be 0 "); 
    if(error!= 1)  
        $display("Test Case [ 9 ] failed quotient error should be 1 ");  
     

    
     // 200 /  0.5 =   400  overflow
    assign dividend = 16'b011001000_0000000;
    assign divisor  = 16'b000000000_1000000;
    assign expected=  16'b010010000_0000000;
    assign over = 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120; 
    if(quotient_out!= expected)  
        $display("Test Case [ 10 ] failed quotient should be b010010000_0000000");
    if(overflow!= over )  
        $display("Test Case [ 10 ] failed overflow should be 1 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 10 ] failed divbyzero should be 0 ");
    if(error!= 1)  
        $display("Test Case [ 10 ] failed quotient error should be 1 ");  
      


   // 120 /  0.5 =   240
    assign dividend = 16'b001111000_0000000;
    assign divisor  = 16'b000000000_1000000;
    assign expected=  16'b011110000_0000000;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 11 ] failed quotient should be 011110000_0000000");
    if(overflow!= over )  
        $display("Test Case [ 11 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 11 ] failed divbyzero should be 0 "); 
    if(error!= 0)  
        $display("Test Case [ 11 ] failed quotient error should be 0 ");  
     

    
    // -120 /  0.5 =   -240
    assign dividend = 16'b110001000_0000000;
    assign divisor  = 16'b000000000_1000000;
    assign expected=  16'b100010000_0000000;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 12 ] failed quotient should be 100010000_0000000");
    if(overflow!= over )  
        $display("Test Case [ 12 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 12 ] failed divbyzero should be 0 "); 
    if(error!= 0)  
        $display("Test Case [ 12 ] failed quotient error should be 0 ");  
     

    
    
    // 8.3125 / 5.6 = 1.48
    assign dividend = 16'b000001000_0101000;
    assign divisor  = 16'b000000101_1001100;
    assign expected=  16'b000000001_0111110;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120; 
    if(quotient_out!= expected)  
        $display("Test Case [ 13 ] failed quotient should be 000000001_0111110");
    if(overflow!= over )  
        $display("Test Case [ 13 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 13 ] failed divbyzero should be 0 ");
    if(error!= 0)  
        $display("Test Case [ 13 ] failed quotient error should be 0 ");  
      

    
    
    
    // 12.4 / 5.25 = 2.4
    assign dividend = 16'b000001100_0110011;
    assign divisor  = 16'b000000101_0100000;
    assign expected=  16'b000000010_0101110;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #120; 
    if(quotient_out!= expected)  
        $display("Test Case [ 14 ] failed quotient should be 000000010_0101110");
    if(overflow!= over )  
        $display("Test Case [ 14 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 14 ] failed divbyzero should be 0 ");
    if(error!= 0)  
        $display("Test Case [ 14 ] failed quotient error should be 0 ");  
      

    
    // 53.6 / 4.25 = 2.4
    assign dividend = 16'b000110101_1001100;
    assign divisor  = 16'b000000100_0100000;
    assign expected=  16'b000001100_1001110;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0; 
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 15 ] failed quotient should be 000001100_1001111");
    if(overflow!= over )  
        $display("Test Case [ 15 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 15 ] failed divbyzero should be 0 ");  
    if(error!= 0)  
        $display("Test Case [ 15 ] failed quotient error should be 0 ");  


    
    // 36.278 / 7.321 = 4.953
    assign dividend = 16'b000100100_0100011;
    assign divisor  = 16'b000000111_0101001;
    assign expected=  16'b000000100_1111010;
    assign over = 1'b0;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0; 
    #120;
    if(quotient_out!= expected)  
        $display("Test Case [ 16 ] failed quotient should be 000001100_1001111");
    if(overflow!= over )  
        $display("Test Case [ 16 ] failed overflow should be 0 "); 
    if(divbyzero!= 0)  
        $display("Test Case [ 16 ] failed divbyzero should be 0 ");  
    if(error!= 0)  
        $display("Test Case [ 16 ] failed quotient error should be 0 ");  

    
     $stop;   // end of simulation
end
endmodule
