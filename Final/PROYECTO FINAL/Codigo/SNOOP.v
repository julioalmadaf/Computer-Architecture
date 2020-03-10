module SNOOP(SRST, SCLK, PLCK, SLCK, SINT, PHIT, PHITM, PINV, STATUS, snoop, RW);

input SRST;
input SCLK;
input SLCK;
input[1:0] STATUS;
input SINT;
input RW;
output reg PHIT;
output reg PHITM;
output reg PINV;
output reg snoop;
output PLCK;

always @(posedge SCLK) begin
if(~SINT)begin
if(SLCK)begin
  PINV <= 0;
    snoop <= 1;
    if (STATUS == 2'b00) begin 
        PHITM <= 0; 
        PHIT <= 0;
    end
    else if (STATUS == 2'b01) begin
        PHITM <= 0;
        PHIT <= 1;
    end
    else if (STATUS == 2'b10) begin 
      PHITM <= 0;
      PHIT <= 1;
    end 
    else if (STATUS == 2'b11) begin
      PHITM <= 1;
      PHIT <= 1; 
    end
end

else begin 
  snoop <= 0;
  if (~RW) begin 
    PINV <= 1;
  end
end
end
end
endmodule