module LFSR(clock, reset, cont1, cont2, cont3, x0, x1, x2, x3, x4, x5);
  
input clock;
  
input reset;

input cont1;
input cont2;
input cont3;

  
output x0;
  
output x1;
  
output x2;
 

output x3;
 
output x4;
 
output x5;
 
 
wire sum1;
  
wire sum2;
  
wire w_nor; 
 
wire flop4;


wire sum3;
  
wire sum4;
wire sum5;
wire sum6;
wire sum7;
 
wire w_nor2; 
 
wire flop4_2;


wire or1;
wire or2;
wire or3;
  
  
OR OR1(cont1,x0,or1);
OR OR2(cont2,x1,or2);
OR OR3(cont3,x2,or3);

//Arriba

XOR XOR1(x0, sum2, sum1);
  
XOR XOR2(x2, w_nor, sum2);

  
NOR NOR1 (x0, x1, w_nor);
  

FF ff1(clock, reset, sum1, x0);
  
FF ff2(clock, reset, x0, x1);
  
FF ff3(clock, reset, x1, x2);
  
FF ff4(clock, reset, x2, flop4);

//abajo

XOR XOR3(x3, sum4, sum3);
  //
XOR XOR4(x5, w_nor2, sum4);
 //

XOR XOR5(or1, x3, sum5);
  
XOR XOR6(or2, x4, sum6);

XOR XOR7(or3, x5, sum7);

  
NOR NOR2 (x3, x4, w_nor2);
  

FF ff5(clock, reset, sum3, x3);
  //
FF ff6(clock, reset, sum5, x4);
  
FF ff7(clock, reset, sum6, x5);
  
FF ff8(clock, reset, sum7, flop4_2);


endmodule