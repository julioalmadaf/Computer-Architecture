module LFSR(clock, reset, x0, x1, x2);
  input clock;
  input reset;
  output x0;
  output x1;
  output x2;
  
  wire sum1;
  wire sum2;
  wire w_nor; 
  wire flop4;
  
  //XOR XOR1(x0, sum2, sum1);
  //XOR XOR2(x2, w_nor, sum2);
  //NOR NOR1 (x0, x1, w_nor);
  //FF ff1(clock, reset, sum1, x0);
  //FF ff2(clock, reset, x0, x1);
  //FF ff3(clock, reset, x1, x2);
  //FF ff4(clock, reset, x2, flop4);
 
  
endmodule
