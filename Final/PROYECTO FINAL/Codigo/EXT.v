module EXT(clock, reset, data, flop);
  input clock;
  input reset;
  input data;
  output reg flop;
  always@(posedge reset or posedge clock) begin
    if(reset)begin
      flop<=0;
    end
    else begin
      flop<=data;
    end 
  end
endmodule