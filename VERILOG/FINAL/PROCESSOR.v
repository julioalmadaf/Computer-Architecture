module PROCESSOR(SCLK, SLCK, DR, SRST, SINT, reemplazo, AR, PLCK, PINV_I, PINV_O, ADDR_I, DATA_I, DATA_O, PHIT_I,PHITM_I, PHIT_O,PHITM_O, RW);
  input SCLK;
  input SLCK;
  input DR;
  input SRST;
  input SINT;
  input [23:0 ]ADDR_I ;
  input [31:0] DATA_I;
  input PINV_I;
  input PHIT_I;
  input PHITM_I;
  input reemplazo;
  output PHIT_O;
  output PHITM_O;
  output PINV_O;
  output AR;
  output PLCK;
  output DATA_O;
  output RW;
  
  reg snoopy;
  reg ST;
  
  
  CACHE cache1(ADDR_I,DATAB_I, snoopy, SCLK, SRST, SINT, DR, RW, PINV_I, PHIT_I, PHITM_I, DATA_O, ST, AR);
  SNOOP snoop1(SRST, SCLK, PLCK, SLCK, SINT, PHIT_O, PHITM_O, PINV_O, ST, snoopy, RW);
  READWRITE RW1(DR, SRST, SCLK, SINT, reemplazo, PHITM_O, PHIT_O, RW, PLCK);
  
endmodule