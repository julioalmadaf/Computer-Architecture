
module SYSTEM(SRST, SCLK, SINT, PHIT_A, PHIT_B, PHITM_A, PHITM_B, PLCK_A, PLCK_B, SLCK_A, SLCK_B);
input SRST;
input SCLK;
input SINT;
input PHIT_A;
input PHITM_A;
input PHIT_B;
input PHITM_B;
input PLCK_A;
input PLCK_B;
output reg SLCK_A;
output reg SLCK_B;
reg reinicio;

always @(posedge SCLK) begin
        if(SRST && SINT) begin
                SLCK_A <= 0;
                SLCK_B <= 1;
                reinicio <= 1;
                if(~PLCK_A) begin
                   SLCK_A <=  1;
                   SLCK_B <=  0;   
                end
                if(~PLCK_B) begin
                        reinicio <= 0;   
                end
            end
    if(~reinicio)begin       
        if(PLCK_A && ~(PHIT_A ^ PHITM_A) ) begin // si A pide el control y hay un hit modified o hitmiss, entonces es prioritario 
                                            // dar el control a A y quitárselo a B, para que actualice 
            SLCK_A <= 0;
            SLCK_B <= 1;
        end
      else if(PLCK_B && ~(PHIT_B ^ PHITM_B))begin
            SLCK_A <= 1;
            SLCK_B <= 0;
        end
    end  
end
endmodule