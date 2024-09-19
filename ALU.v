module ALU (
            input [31:0] A,B,
            input [3:0] ALUsel,
            output reg [31:0] D
            output reg Zero, Carry, Overflow 
    );

    reg [31:0] ALUout;
    assign D = ALUout;
    
    always @(*) begin
        Zero = 0;
        Carry = 0;
        Overflow = 0;
        case (ALUsel)
            4'b0000: begin
                {Carry,ALUout} = A + B;
                Overflow = (A[31] == B[31] && ALUout[31] != A[31]);
            end
            4'b0001: ALUout = A << B[4:0];
            4'b0010: ALUout = (A>B)?32'd1:32'd0;
            4'b0011: ALUout = ($signed(A)>$signed(B))?32'd1:32'd0;
            4'b0100: ALUout = A ^ B;
            4'b0101: ALUout = A >> B[4:0];
            4'b0110: ALUout = A | B;
            4'b0111: ALUout = A & B;
            4'b1000: begin
                {Carry,ALUout} = A - B;
                Overflow = (A[31] == B[31] && ALUout[31] != A[31]);
            end
            4'b1101: ALUout = A >>> B[4:0];
            default: ALUout = 32'd0;
        endcase
        Zero = (ALUout == 32'd0);
    end
endmodule