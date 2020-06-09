module ODE_TB#(parameter N=2,parameter M=3)();
    
    reg clk;
    reg enableODE;
    reg enable;
    reg [15:0]h;
    reg  [((16*N)-1):0] Xo ;
    reg  [((16*N)-1):0] A;  
    reg  [((16*M)-1):0] Uk;
    reg  [((16*M)-1):0] B;
    reg [15:0]expected;
	  wire	 error; 
    wire [15:0] Xnext;
    localparam period = 20;  
    
    ODE ode (.clk(clk), .enableODE(enableODE),.enable(enable), .h(h), .Xo(Xo),.A(A),.Uk(Uk),.B(B),.error(error),.Xnext(Xnext));
    
    //Can't test overflow by multiplication bec. multiplication is'nt compeleted

	always 
	begin
		clk = 1'b1; 
		#5; 

		clk = 1'b0;
		#5; 
	end
initial begin

    
    // h=2 A=[1 1] X= [1 2]  B= [1 2 3] U=[1 2 3]  Xnext =35
    assign h   = 16'b000000010_0000000;
    assign Xo  = 32'b000000001_0000000_000000010_0000000;
    assign A   = 32'b000000001_0000000_000000001_0000000;
    assign Uk  = 48'b000000001_0000000_000000010_0000000_000000011_0000000;
    assign B   = 48'b000000001_0000000_000000010_0000000_000000011_0000000;
    assign expected=  16'b000100011_0000000;
    assign enableODE= 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #1000;
    if(Xnext!= expected)  
        $display("Test Case [ 1 ] failed Xnext should be b000100011_0000000");
    if(error!= 0)  
        $display("Test Case [ 1 ] failed error should be 0 ");  
     
     
   // h=1 A=[14.5 16.75] X= [3 2.5]  B= [15.3 1.5 6] U=[4.6 4.8 3.7]  Xnext =249.    
    assign h   = 16'b000000001_0000000;
    assign Xo  = 32'b0000000110000000_0000000101000000;
    assign A   = 32'b0000001001000000_0000000011100000;
    assign Uk  = 48'b0000010001001100_0000001001100110_0000000111011001;
    assign B   = 48'b0000001010100110_0000000011000000_0000001100000000;
    assign expected=  16'b0010111111100001;
    assign enableODE= 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #1000;
  
    if(Xnext!= expected)  
        $display("Test Case [ 2 ] failed Xnext should be b000100011_0000000");
    if(error!= 0)  
        $display("Test Case [ 2 ] failed error should be 0 ");  
     
    
    // h= 0.75 A=[4.5 1.75] X= [3 2.5]  B= [10.5 12.5 6] U=[3.5 4.5 3.75]  Xnext = 103.03125 
    assign h   = 16'b0000000001100000;
    assign Xo  = 32'b0000000110000000_0000000101000000;
    assign A   = 32'b0000001001000000_0000000011100000;
    assign Uk  = 48'b0000000111000000_0000001001000000_0000000111100000;
    assign B   = 48'b0000010101000000_0000011001000000_0000001100000000;
    assign expected=  16'b0011001110000100;
    assign enableODE= 1'b1;
    assign enable= 1'b1;
    #10;
 	  assign enable= 1'b0;
    #1000;
    if(Xnext!= expected)  
        $display("Test Case [ 3 ] failed Xnext should be b000100011_0000000");
    if(error!= 0)  
        $display("Test Case [ 3 ] failed error should be 0 "); 
        
        
        
     // h=0.5 A=[11.5 2.3] X= [4.3 16.75]  B= [3 6.4 1.5] U=[7.4 6 3.5]  Xnext =81.212
    assign h   = 16'b000000000_1000000;
    assign Xo  = 32'b0000001000100110_0000100001100000;
    assign A   = 32'b0000010111000000_0000000100100110;
    assign Uk  = 48'b0000001110110011_0000001100000000_0000000111000000;
    assign B   = 48'b0000000110000000_0000001100110011_0000000011000000;
    assign expected=  16'b0010100010010011;
    assign enableODE= 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #1000;
    if(Xnext!= expected)  
        $display("Test Case [ 4 ] failed Xnext should be b000100011_0000000");
    if(error!= 0)  
        $display("Test Case [ 4 ] failed error should be 0 ");  
      
      
    // h=1 A=[-2.4 3.4] X= [-5.5 4.3]  B= [3 -6.4 1.5] U=[4.4 6 3.5]  Xnext =2.37  Test negative numbers
    assign h   = 16'b0000000010000000;
    assign Xo  = 32'b1111110101000000_0000001000100110;
    assign A   = 32'b1111111011001101_0000000110110011;
    assign Uk  = 48'b0000001000110011_0000001100000000_0000000111000000;
    assign B   = 48'b0000000110000000_1111110011001101_0000000011000000;
    assign expected=  16'b0000000100101100;
    assign enableODE= 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #1000;
   
    if(Xnext!= expected)  
        $display("Test Case [ 5 ] failed Xnext should be b000100011_0000000");
    if(error!= 0)  
        $display("Test Case [ 5 ] failed error should be 0 ");  
    
    
    // h=1 A=[12.4 3.4] X= [2 2.3]  B= [ 13.5 1.7 2.32] U=[5.75 6 3.5]  Xnext =130.565 
    assign h   = 16'b0000000010000000;
    assign Xo  = 32'b0000000100000000_0000000100100110;
    assign A   = 32'b0000011000110011_0000000110110011;
    assign Uk  = 48'b0000001011100000_0000001100000000_0000000111000000;
    assign B   = 48'b0000011011000000_0000000011011001_0000000100101000;
    assign expected=  16'b0100000100111111;
    assign enableODE= 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #1000;
    if(Xnext!= expected)  
        $display("Test Case [ 6 ] failed Xnext should be b000100011_0000000");
    if(error!= 0)  
        $display("Test Case [ 6 ] failed error should be 0 ");  



    // h=1 A=[25.75 2.7] X= [5.75 7.8]  B= [ -3.8 -30.8 2.32] U=[5.75 8 3.5]  Xnext =-85.2575  
    //test overflow ( get overflow) 
    assign h   = 16'b0000000010000000;
    assign Xo  = 32'b0000001011100000_0000001111100110;
    assign A   = 32'b0000110011100000_0000000101011001;
    assign Uk  = 48'b0000001011100000_0000010000000000_0000000111000000;
    assign B   = 48'b1111111000011010_1111000010011010_0000000100101000;
    assign expected=  16'b1101010101011010;
    assign enableODE= 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #1000;
    if(Xnext!= expected)  
        $display("Test Case [ 7 ] failed Xnext should be b000100011_0000000");
    if(error!= 1)  
        $display("Test Case [ 7 ] failed error should be 0 ");  

   
   
    // h=1 A=[10.5 2.7] X= [3.6 8.5]  B= [ 2.5 6 2.8] U=[5.4 7.5 2.7]  Xnext =130.41
   
    assign h   = 16'b0000000010000000;
    assign Xo  = 32'b0000000111001100_0000010001000000;
    assign A   = 32'b0000010101000000_0000000101011001;
    assign Uk  = 48'b0000001010110011_0000001111000000_0000000101011001;
    assign B   = 48'b0000000101000000_0000001100000000_0000000101100110;
    assign expected=  16'b0100000100100001;
    assign enableODE= 1'b1;
    assign enable= 1'b1;
    #10;
	  assign enable= 1'b0;
    #1000;

    if(Xnext!= expected)  
        $display("Test Case [ 8 ] failed Xnext should be b000100011_0000000");
    if(error!= 0)  
        $display("Test Case [ 8 ] failed error should be 0 ");  




    $stop;   // end of simulation
end
endmodule
