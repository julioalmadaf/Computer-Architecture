module Pages (t_cycle, SCLK, SRST, SINT, PLCK, RW, PINV, STATUS); //MM
input t_cycle;
input SRST;
input SINT; 
input PLCK;
input SCLK;
input RW;

output PINV;
output STATUS;
integer i;
reg [7:0] index;
reg [31:0] data[255:0]; //tablas datos o: integer[255:0]
reg[23:0] addr[255:0]; //directorios : 16 ref, 8 indice
reg[1:0] status[255:0]; // estado en directorios
//if(SRST=1) begin
 reg p_ref[15:0];
always @(posedge SCLK)begin
  for(i=0; i<256; i=i+1)
  begin
  p_ref= 16'b0000000000000000;
  index= index+1;
  addr[i]= {p_ref, i}; //16 bits ref  y 8 indice 
  data[i]=i;
  status[i]= 2'b01;
  end



end

endmodule

