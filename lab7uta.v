`timescale 1ns / 1ps

module lab7uta( 
	input[31:0] A_in, B_in,
	input [5:0] cmd,
	input [1:0] op,
	output reg[31:0] result=0,
	output  [3:0] flag  //flags for zero, negative, carry and overflow
    );
	 	 reg[1:0] carry_ovf;
	 always @(*)
	 begin
	 case (op)
	 0: begin //data
		case(cmd)//AND, XOR, ORR, SUB, RSB, ADD, CMP
		0: begin //and 
			result=A_in&B_in;	
			carry_ovf=0;
			end
		1: begin //xor
			result=A_in^B_in;
			carry_ovf=0;
			end
		2: begin //sub
			result=A_in-B_in;
			if(A_in<B_in)
			carry_ovf[1]=1; //generating carry
			else
			carry_ovf[1]=0;
			if(A_in[31]!=B_in[31]&&result[31] !=A_in[31])
			carry_ovf[0]=1; //generating overflow
			else
			carry_ovf[0]=0; 
			end
		4: begin //add
			result=A_in+B_in;
			if((A_in>result)||(B_in>result))
			carry_ovf[1]=1;  //for unsigned
			else
			carry_ovf[1]=0;
			if(A_in[31]==B_in[31] &&A_in[31]!=result[31])
			carry_ovf[0]=1;
			else
			carry_ovf[0]=0; //for signed
			end
			
		3: begin //rsb
			result=B_in-A_in;
			if(A_in>B_in)
			carry_ovf[1]=1;
			else
			carry_ovf[1]=0;
			if(A_in[31]!=B_in[31]&&result[31] !=B_in[31])
			carry_ovf[0]=1;
			else
			carry_ovf[0]=0;
			end
		
		10:begin //cmp
			result=A_in-B_in;
			if(A_in<B_in)
			carry_ovf[1]=1;
			else
			carry_ovf[1]=0;
			if(A_in[31]!=B_in[31]&&result[31] !=A_in[31])
			carry_ovf[0]=1;
			else
			carry_ovf[0]=0;
			
		   end	
		12:begin //orr
			result=A_in|B_in;
			carry_ovf=0;			
			end 
 	default: begin result=0;
							end 
		endcase
		end
	 1: begin //memory
			if(cmd[3]==1)
				result=A_in+B_in;//Bis anoffset, A is a base adress
			else
				result=A_in;
		 if((A_in>result)||(B_in>result))
			carry_ovf[1]=1;  //for unsigned
			else
			carry_ovf[1]=0;
			if(A_in[31]==B_in[31] &&A_in[31]!=result[31])
			carry_ovf[0]=1;
			else
			carry_ovf[0]=0; //for signed
		 end
	 2: begin //branch
		 result=A_in+B_in; //A next instruction, B how many steps to jump over
		 if((A_in>result)||(B_in>result))
			carry_ovf[1]=1;  //carry when unsigned
			else
			carry_ovf[1]=0; 
			if(A_in[31]==B_in[31] &&A_in[31]!=result[31])
			carry_ovf[0]=1;
			else
			carry_ovf[0]=0; //overflow when signed
		 end 
	 default: begin result=0;
				end  
	endcase
	end 
	
	assign  flag[1:0] = carry_ovf;
	assign  flag[2]= (result==0) ? 1:0;
	assign  flag[3]= (result[31]==1) ? 1:0;
	 
	

endmodule
