module READWRITE(DR, SRST, SCLK, SINT, reemplazo, PHITM, PHIT, RW, PLCK);

input SRST;
input DR;
input SCLK; 
input SINT;
input PHITM; 
input PHIT;
input reemplazo;
output reg RW; 
output reg PLCK; 
integer i;

always @(posedge SCLK) begin
 
if(SRST)begin  //al haber un reset, comienza ciclos de lectura para llenar sus lineas
  if(~SRST && ~SINT)begin                      //o hit miss
   for(i=0; i<10; i= i+1)begin
    PLCK <= 1;
    RW <= 1;
       if(DR && i==9)begin
      PLCK <=0;
      end
  end
    
  end
end
if(~SINT) begin
if(~PHIT && ~PHITM)begin 
  PLCK <= 1;
    RW <= 1;   
    if(DR)begin
      PLCK <=0;
    end
end

if((PHITM && PHIT) || reemplazo) begin
  PLCK <= 1;
  RW<=0;
    if(DR)begin
      PLCK <=0;
  end
end
end
end
endmodule


