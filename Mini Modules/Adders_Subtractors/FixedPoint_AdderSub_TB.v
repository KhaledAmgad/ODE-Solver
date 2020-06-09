module FixedPoint_Adder_Baseline_TB#(parameter WIDTH = 16)();
  reg signed [WIDTH-1:0]a,aS,aL;
  reg signed [WIDTH-1:0]b,bS,bL;
  reg op;
  wire overflowFlag,overflowFlagS,overflowFlagL;
  reg signed [WIDTH-1:0]expected;
  localparam sf = 2.0**-7.0; //  scaling factor is first 7 bits
  wire signed [WIDTH-1:0]sum,sumS,sumL;    
  integer i,j,intSum;
  FixedPoint_AdderSub_Baseline#(WIDTH) b1(a,b,op,sum,overflowFlag);
  FixedPoint_AdderSub_CarrySelect#(WIDTH) S1(aS,bS,op,sumS,overflowFlagS);
  FixedPoint_AdderSub_CarryLookAhead#(WIDTH) L1(aL,bL,op,sumL,overflowFlagL);

  initial begin
		
	  assign a =16'b0000_1000_0000_0000;
	  assign b= 16'b0000_0000_0000_0000;
	  
	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b1;
	  assign expected= 16'b0000_1000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

		
		
		
		
		
	  assign a =16'b0000_0000_0000_0000;
	  assign b= 16'b0000_0000_0000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b0000_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

		
		
		
		
		
	  assign a =16'b1100_0000_0000_0000;
	  assign b= 16'b1000_0000_0000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b1;
	  assign expected= 16'b0100_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

		
		
		
		
	  assign a =16'b1100_0000_0000_0000;
	  assign b= 16'b0000_0000_0000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b1100_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

		
		
		
	  assign a =16'b1100_0000_0000_0000;
	  assign b= 16'b1100_0000_0000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b1000_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");


		
		
		
	  assign a =16'b0100_0000_0000_0000;
	  assign b= 16'b0100_0000_0000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b0000_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

		
		
		
	  assign a =16'b0100_0000_0000_0000;
	  assign b= 16'b0100_0000_0000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b1;
	  assign expected= 16'b0000_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

			
			
					
	  assign a =16'b0111_1111_1111_1111;
	  assign b= 16'b0100_0000_0000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b1;
	  assign expected= 16'b0011_1111_1111_1111;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

			
			
			
					
	  assign a =16'b0111_1111_1111_1111;
	  assign b= 16'b0111_1111_1111_1111;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b0000_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

			
			
			
			
			
					
	  assign a =16'b0111_1111_1111_1111;
	  assign b= 16'b0011_1111_1111_1111;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b1;
	  assign expected= 16'b0100_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

			
			
			
					
	  assign a =16'b0100_0000_0000_0000;
	  assign b= 16'b0000_0000_1000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b1;
	  assign expected= 16'b0011_1111_1000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

			
			
			
					
	  assign a =16'b1100_0000_0000_0000;
	  assign b= 16'b0000_0000_1000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b1100_0000_1000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

			
			
					
	  assign a =16'b0000_0000_1000_0000;
	  assign b= 16'b0100_0000_0000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b1;
	  assign expected= 16'b1100_0000_1000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

			
			
			
								
	  assign a =16'b1000_0000_1000_0000;
	  assign b= 16'b1000_0000_1000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b0000_0001_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

			
			
						
								
	  assign a =16'b0001_0000_1000_0000;
	  assign b= 16'b0111_0000_1000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b1000_0000_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");


											
	  assign a =16'b1111_1111_1000_0000;
	  assign b= 16'b1111_1111_1000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b1111_1111_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
						
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");



											
	  assign a =16'b0111_1111_1000_0000;
	  assign b= 16'b0111_1111_1000_0000;
	  	  
	  assign aS=a;
	  assign aL=a;
	  
	  assign bS=b;
	  assign bL=b;

	  assign op=1'b0;
	  assign expected= 16'b1111_1111_0000_0000;
	  #10;
	  if(sum==expected && overflowFlag==0)
		if(op==1)
			$display("%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
	  	
	  else
		if(op==1)
			$display("wrong %f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
		else
			$display("wrong %f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));
			
			
	  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
			$display("they are not the same !!! ");

      $display("test Cases for addition Generated by loops !!");

	  for(i=0;i<65535;i=i+2000) begin
            for(j=0;j<65535;j=j+2000) begin
                 assign a = i;
                 assign b = j;
				 
				 assign aS = i;
                 assign bS = j;
				 
				 assign aL = i;
                 assign bL = j;
				 
				 assign intSum=$signed (a) +$signed (b);
				 assign op=1'b0;
                 #10;
				  if($signed (sum)==$signed (intSum) && overflowFlag==0)
					$display("(Loop +)%f + %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));				
				  else
					$display("wrong (Loop +) %f + %f = %f, overflowFlag = %f,  intSum= %f ",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag),$signed (intSum)*sf);
					
				  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
					$display("they are not the same !!! ");

            end  
      end
	  
	  
	  $display("test Cases for subtraction Generated by loops !!");
	  
	  for(i=0;i<65535;i=i+2000) begin
		for(j=0;j<65535;j=j+2000) begin
			 assign a = i;
			 assign b = j;
			 
			 				 
			 assign aS = i;
			 assign bS = j;
			 
			 assign aL = i;
			 assign bL = j;
			 
			 
			 assign intSum=$signed (a) -$signed (b);
			 assign op=1'b1;
			 #10;
			  if($signed (sum)==$signed (intSum) && overflowFlag==0)
				$display("(Loop -)%f - %f = %f, overflowFlag = %f",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag));				
			  else
				$display("wrong (Loop -) %f - %f = %f, overflowFlag = %f,  intSum= %f ",  $signed(a)*sf,$signed (b)*sf,$signed (sum)*sf,(overflowFlag),$signed (intSum)*sf);
				
			  if($signed (sum)!=$signed (sumS) ||$signed (sumS)!=$signed (sumL) || overflowFlag!=overflowFlagS || overflowFlagS!=overflowFlagL )
				$display("they are not the same !!! ");
		end  
      end
	  
	  
    end

  


endmodule