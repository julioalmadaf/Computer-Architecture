module CACHE (ADDR_I,DATA_I, snoop, SCLK, SRST, SINT, DR, RW, PINV, PHIT_i, PHITM_i, DATA_O, STATUS_O, AR);

input snoop;

input SRST;

input SINT; 

input SCLK;

input PINV;

input PHIT_i;

input PHITM_i;

input RW;

input DR;

input [23:0] ADDR_I;

input [31:0] DATA_I;

output  reg[31:0] DATA_O;

output reg[1:0] STATUS_O;

output reg AR;


reg [31:0] data[255:0]; //tablas datos o: integer[255:0]

reg[15:0] addr[255:0]; //directorios : 16 ref, 8 indice. Solo almacenara la pagina

reg[1:0] status[255:0]; // estado en directorios

integer i;

always @(posedge SCLK) begin

if(SRST && SINT)begin //cuando se manda reset
  for(i = 0; i<256;i=i+1) begin
  status[i]<=2'b00; // se invalidan todos los estados de toda la cache
  end 
end

if(~SINT)begin //ya que se detiene la interrupcion
  if(snoop)begin
	 if(PINV)begin // cuando el procesador MRM modifica su dato, manda PINV al que esta haciendo snoop y éste invalida su linea
	   status[ADDR_I[7:0]]<= 00; 	 
	   end
	  
	 if((addr[ADDR_I[7:0]]!=ADDR_I[23:8]))begin //compara paginas de ref , en caso de miss
		  STATUS_O <= 2'b00; // si no son iguales las paginas de referencia manda estado inv, para que el modulo snoop lo interprete como hit miss
		 // PLCK <= 1;
	   end
    else begin //al ser las direcciones iguales, pasa a comparar los estados de memoria cache
      if(status[ADDR_I[7:0]]==2'b00)begin //invalido
        STATUS_O <= 2'b00; 
      end
      else if(status[ADDR_I[7:0]]==2'b01)begin //exclusivo
        STATUS_O <= 2'b01;
      end
      else if(status[ADDR_I[7:0]]==2'b10)begin //shared
        STATUS_O <= 2'b10;
      end
    else if(status[ADDR_I[7:0]]==2'b11)begin  //modified
      STATUS_O <= 2'b11;
    end
    end
    end
else begin
  if(RW && DR)begin // ciclo de lectura y ya está lista la dirección en el bus ya puede leer el dato
    addr[ADDR_I[7:0]] <= ADDR_I[23:8]; //asignar direccion a la tabla de acuerdo a lo  que esta en el bus
    data[ADDR_I[7:0]] <= DATA_I;
    
   // PLCK <= 0; // una vez que jala el dato, PLCK baja
      if(~PHIT_i && ~PHITM_i )begin
      status[ADDR_I[7:0]] <= 2'b01; //exclusivo
      end
      else begin
      status[ADDR_I[7:0]] <= 2'b10; //shared
    end
  end
  else if (~RW) begin //see escribe en el buffer 
    DATA_O <= data[ADDR_I[7:0]];
    AR <= 1;
    if(~PHIT_i && ~PHITM_i )begin
      status[ADDR_I[7:0]] <= 2'b01; //exclusivo
    end
    else begin
      status[ADDR_I[7:0]] <= 2'b10; //shared
    end
  end
end
end
end
endmodule