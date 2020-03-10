module cache (ADDR, snoop, SCLK, SRST, SINT, PLCK, RW, PINV, STATUS);
 //MM
input snoop;
input [23:0] ADDR;
input SRST;
input SINT; 
input PLCK;

input SCLK;
input RW;
output PINV;
output STATUS;

integer i;

reg [31:0] data[255:0]; //tablas datos o: integer[255:0]

reg[23:0] addr[255:0]; //directorios : 16 ref, 8 indice

reg[1:0] status[255:0]; // estado en directorios

reg p_ref[15:0];

reg indice_bus[7:0];

always @(posedge SCLK)
begin
  if(SRST && SINT)begin 
 //reset
    for(i=0; i<256; i=i+1)
    begin
    status[i]<= 2'b00;
    end

end
  if(snoop==1)begin // hay snoop
    indice_bus<= ADDR[7:0];  
//8 bits de indice de la direccion que se encuentra en el bus de direcc
   
 if(addr[indice_bus][23:8]!= ADDR[23:8])begin 
//si las pags ref en esa linea son dif 
      
STATUS<=00;
    end
     
else begin // si las pags ref en esa linea son iguales
 
     
STATUS<= status[indice_bus]; // va a mandar a snoop el status en que se encuentra esa direcc 
     end
end
end
endmodule



