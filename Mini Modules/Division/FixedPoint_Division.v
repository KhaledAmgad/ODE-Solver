module fixedpoint_Division (
	input 	[15:0] dividend,
	input 	[15:0] divisor,
	input 	 clk,
	output 	[15:0] quotient_out,
	output	 overflow,
	output  divbyzero,
	output  error,
	output finished,
	input reg enable
	);
 
	reg [36:0]	temp_quotient;	
	reg [15:0] 		final_quotient;				
	reg [36:0] 	temp_dividend;	
	reg [36:0]	temp_divisor;		
	reg [15:0] i; 		
	reg					  done;			
	reg					reg_overflow;		
  reg					  quotient_sign;	
  reg       dividebyzero;
  reg errorr;
  reg [14:0] zer0 ;
	wire[36:0] subout;
	wire overflowFlag;
	wire[14:0] subdividend;
	wire [14:0] subdivisor;
	wire [14:0] subquotint;
	
  FixedPoint_AdderSub_CarrySelect#(37) adder  (.a(temp_dividend),.b(temp_divisor),.op(1'b1),.sum(subout),.overflowFlag(overflowFlag));
  FixedPoint_AdderSub_CarrySelect#(15) adder2 (.a(zer0),.b(dividend[14:0]),.op(1'b1),.sum(subdividend),.overflowFlag(overflowFlag));
  FixedPoint_AdderSub_CarrySelect#(15) adder3 (.a(zer0),.b(divisor[14:0]),.op(1'b1),.sum(subdivisor),.overflowFlag(overflowFlag));
  FixedPoint_AdderSub_CarrySelect#(15) adder4 (.a(zer0),.b(temp_quotient[14:0]),.op(1'b1),.sum(subquotint),.overflowFlag(overflowFlag));
 
  assign quotient_out[14:0] = final_quotient[14:0];	
  assign quotient_out[15] = quotient_sign;		
  assign overflow = reg_overflow;
  assign divbyzero = dividebyzero;
  assign error = errorr ;
  assign finished = done;
  
always @(clk or enable  ) begin
	  
 if(  enable ) begin		
		  

		  if (	divisor ==0) begin   // if divide by zero
							
				final_quotient <= temp_quotient;
				dividebyzero <=	1'b1;
				errorr <= 1'b1;
				done <= 1'b1;	
			end	
			else begin
			done <= 1'b0;
			reg_overflow <= 1'b0;			
	    final_quotient <= 0;						 
 	    dividebyzero <=0;
 	    errorr <=0;				
 	    zer0  <= 15'b000000000000000 ;							
			i <= 22;		 //Total - fraction -1									
			temp_quotient <= 0  ;								
			temp_dividend <= 0;									
			temp_divisor <= 0;		
										
			if (dividend[15] ==1)begin
			  temp_dividend[21:7] <= subdividend;
			 end
			 else
			   temp_dividend[21:7] <= dividend[14:0];
			   
			   
			if (divisor[15] ==1)begin
					temp_divisor[36:22] <= subdivisor;
			end
			else
			 temp_divisor[36:22] <= divisor[14:0];	
			     
			// sign of quotient
			 if (dividend[15] == 1 & divisor[15] == 1)
			  quotient_sign = 1'b0;
			else if (dividend[15] == 1)
			   quotient_sign = 1'b1;
			else if (divisor[15] == 1)
			   quotient_sign = 1'b1;
			 else
			   quotient_sign = 0'b0;
			  end 
			 end
			
			
		else if(!done) begin
		   
		   dividebyzero <=	1'b0;
			 temp_divisor <= temp_divisor >> 1;	//	Right shift the divisor (divide it by two reduce the divisor)
			 i <= i - 1;								

			 if(temp_dividend >= temp_divisor) begin
				temp_quotient[i] <= 1'b1;			
				temp_dividend <= subout;
			 end
 
			 if(i == 0) begin //finished
			  
				 done <= 1'b1;			
				 if (temp_quotient[36:15]>0)begin
				   	reg_overflow <= 1'b1;
				   	errorr <= 1'b1;
				 end
				else
				    reg_overflow <= 1'b0;
			  				
			  				
				if 	(quotient_sign==1)begin
				     final_quotient[14:0] <= subquotint;
				end		
				else
				     final_quotient <= temp_quotient;
				
	
			  end  
			else 
				  i <= i - 1;	
		  
		end
	end
		
endmodule