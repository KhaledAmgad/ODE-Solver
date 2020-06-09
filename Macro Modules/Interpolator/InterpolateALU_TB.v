module interpolateALU_TB#(parameter WIDTH = 16)();
	reg [WIDTH-1:0] Tk,Tn,Tz,Uz,Un;
	reg clk,start;
	wire [WIDTH-1:0] Uk;
	wire error,ready;
	integer intUk,intTk_intTn,intUz_intUn,intTz_intTn,intUz_intUn_OVER_intTz_intTn,mul_intTk_intTn,i,j;
	localparam sf = 2.0**-7.0; //  scaling factor is first 7 bits
	localparam sfUP = 2.0**7.0; //  scaling factor is first 7 bits
	
	interpolateALU#(WIDTH) iALu(Tk,Tn,Tz,Uz,Un,Uk,error,clk,start,ready);
	

	
	initial begin
	
	
	
	 assign Tk=500;

	 assign Tn=Tk; 

	 assign Tz=Tk; 

	 assign Uz=600; 

	 assign Un=Uz-(512); 


	 assign start= 1'b1;
	 #10;
	 assign intTk_intTn=($signed(Tk)-$signed(Tn));
	 assign intUz_intUn=($signed(Uz)-$signed(Un));
	 assign intTz_intTn=($signed(Tz)-$signed(Tn));
	 assign intUz_intUn_OVER_intTz_intTn=(intUz_intUn/intTz_intTn)*sfUP;
	 assign mul_intTk_intTn=(intTk_intTn*  intUz_intUn_OVER_intTz_intTn)>>>7;

	 assign intUk= $signed(Un) + mul_intTk_intTn ;

	assign start= 1'b0;
	#120;
	if($signed (Uk)==$signed (intUk) && error==0 && ready==1)
	$display("Uk = %f, error = %f,  intUk= (%f) + ( (%f-%f) * (%f-%f) / (%f-%f) ) =  %f ",  $signed (Uk)*sf,(error),  $signed (Un)*sf,$signed (Tk)*sf,$signed (Tn)*sf,$signed (Uz)*sf,$signed (Un)*sf,$signed (Tz)*sf,$signed (Tn)*sf,$signed (intUk)*sf);			
	else
	$display(" wrong(Divide Over Zero) Uk = %f, error = %f,  intUk= (%f) + ( (%f-%f) * (%f-%f) / (%f-%f) ) =  %f ",  $signed (Uk)*sf,(error),  $signed (Un)*sf,$signed (Tk)*sf,$signed (Tn)*sf,$signed (Uz)*sf,$signed (Un)*sf,$signed (Tz)*sf,$signed (Tn)*sf,$signed (intUk)*sf);	

	
		for(i=1;i<20;i=i+1) begin
			for(j=0;j<20;j=j+1) begin
			
				 assign Tk=$urandom(j**i)%32768;

				 assign Tn=Tk-64; 
			
				 assign Tz=Tk+(64); 
		
				 assign Uz=($urandom((j**i)+1)%32768)*i; 
			
				 assign Un=Uz-(512)*i; 
	 

				 assign start= 1'b1;
				 #10;
				 assign intTk_intTn=($signed(Tk)-$signed(Tn));
				 assign intUz_intUn=($signed(Uz)-$signed(Un));
				 assign intTz_intTn=($signed(Tz)-$signed(Tn));
				 assign intUz_intUn_OVER_intTz_intTn=(intUz_intUn/intTz_intTn)*sfUP;
				 assign mul_intTk_intTn=(intTk_intTn*  intUz_intUn_OVER_intTz_intTn)>>>7;

				 assign intUk= $signed(Un) + mul_intTk_intTn ;
				 
				 assign start= 1'b0;
				 #120;
				  if($signed (Uk)==$signed (intUk) && error==0 && ready==1)
					$display("(Loop) Uk = %f, error = %f,  intUk= (%f) + ( (%f-%f) * (%f-%f) / (%f-%f) ) =  %f ",  $signed (Uk)*sf,(error),  $signed (Un)*sf,$signed (Tk)*sf,$signed (Tn)*sf,$signed (Uz)*sf,$signed (Un)*sf,$signed (Tz)*sf,$signed (Tn)*sf,$signed (intUk)*sf);			
				  else
					$display(" wrong (Loop) Uk = %f, error = %f,  intUk= (%f) + ( (%f-%f) * (%f-%f) / (%f-%f) ) =  %f ",  $signed (Uk)*sf,(error),  $signed (Un)*sf,$signed (Tk)*sf,$signed (Tn)*sf,$signed (Uz)*sf,$signed (Un)*sf,$signed (Tz)*sf,$signed (Tn)*sf,$signed (intUk)*sf);	
					
					

			end  
		end
	end
	
	always 
	begin
		clk = 1'b1; 
		#5; 

		clk = 1'b0;
		#5; 
	end


endmodule
