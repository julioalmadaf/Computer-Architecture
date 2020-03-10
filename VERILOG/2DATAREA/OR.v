module OR(A, B, out);


input A;
  
input B;
  
output reg out;
 	
always @* begin 
		
out = A||B; 
	
end

endmodule