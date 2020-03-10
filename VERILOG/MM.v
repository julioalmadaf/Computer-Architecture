module Pages (t_cycle, SCLK, SRST, SINT, PLCK, RW, PINV, STATUS);
input reg t_cycle;
input signal SCLK;
input signal SRST;
input signal SINT; 
input signal PLCK;
RW, PINV, STATUS
reg [31:0] data[255:0]; //tablas datos o: integer[255:0]
reg[23:0] addr[255:0]; //directorios : 16 ref, 8 indice
//llenado 
for(int i=0; addr<256; addr=addr+1);
addr[7:0]=addr;
endmodule
