module MM (RW_A, RW_B, snoop_A, snoop_B, AR, data_i, addr_i,SCLK, SRST, SINT, data_o, DR);
input SCLK;
input SRST;
input SINT; 
input AR;
input RW_A;
input RW_B;
input snoop_A;
input snoop_B;
input [31:0] data_i; 
input [23:0] addr_i; 
reg [15:0] tags[255:0]; // 256 líneas con datos enteros (Números traducibles a 16 bits) 
reg [1:0] status [255:0];
reg [31:0] data [255:0];
integer i;
integer ref;
output reg [31:0] data_o;
//output reg [15:0] addr_o;
output reg DR;
//Llenado: 64 diferentes direcciones repetidas 8 veces

//Referencias van de 32 a 2080
always @ (posedge SCLK) begin
ref = 32; // Auxiliar para generar el valor de la referencia
  if (SRST && SINT) begin
    for(i=0; i <256; i = i + 1) begin 
        tags[i] = ref;
        data[i] = i;
        ref = ref + 32; 
        	status[i] = 2'b01; //Exclusivo porque 1 = 01 en bits
        if (ref == 2080) begin //para que se repita 64 veces y comience de nuevo
          ref <= 32;
        end
    end
  end
if(~SINT) begin
  if(AR)begin
    if((RW_A && snoop_B) || (RW_B && snoop_A))begin   //ciclo lectura
      data_o <= data[addr_i[7:0]];
      status[addr_i[7:0]] <= 10; // pasa a estado shared
      DR <= 1; 
    end
    else if((~RW_A && snoop_B) || (~RW_B && snoop_A))begin // ciclo escritura
      data[addr_i[7:0]] <= data_i;
      tags[addr_i[7:0]] <= addr_i[23:8];
      status[addr_i[7:0]] <= 10; // pasa a estado shared
      DR <= 1;
  end
  end
  end
  end 
 endmodule