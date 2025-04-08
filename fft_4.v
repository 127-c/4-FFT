`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/07 15:26:01
// Design Name: 
// Module Name: fft_4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fft_4(
        //system
        input               clk,
        input               rst_n,

        //输入
        input wire signed [ 15:0]                   x0_real,// 默认解释为Q1.15
        input wire signed [ 15:0]                   x0_imag,
        input wire signed [ 15:0]                   x1_real,
        input wire signed [ 15:0]                   x1_imag,
        input wire signed [ 15:0]                   x2_real,
        input wire signed [ 15:0]                   x2_imag,
        input wire signed [ 15:0]                   x3_real,
        input wire signed [ 15:0]                   x3_imag,
        //输出
        output reg signed [ 15:0]                   X0_real,
        output reg signed [ 15:0]                   X0_imag,
        output reg signed [ 15:0]                   X1_real,
        output reg signed [ 15:0]                   X1_imag,            
        output reg signed [ 15:0]                   X2_real,
        output reg signed [ 15:0]                   X2_imag,
        output reg signed [ 15:0]                   X3_real,
        output reg signed [ 15:0]                   X3_imag
    );
//旋转因子参数 Q1.15格式
parameter W4_0_real = 16'h7FFF;//1-2^-15        1
parameter W4_0_imag = 16'h0000;
parameter W4_1_real = 16'h0000;
parameter W4_1_imag = 16'h8000;//-j �??1的补码）
parameter W4_2_real = 16'h8000;//-1
parameter W4_2_imag = 16'h0000; 
parameter W4_3_real = 16'h0000;   
parameter W4_3_imag = 16'h7FFF;//j



//内部寄存器定�??
//第一级蝶形运算单�??
        reg signed [ 15:0]              s0_real;
        reg signed [ 15:0]              s0_imag;
        reg signed [ 15:0]              s1_real;
        reg signed [ 15:0]              s1_imag;
        reg signed [ 15:0]              s2_real;
        reg signed [ 15:0]              s2_imag;
        reg signed [ 15:0]              s3_real;
        reg signed [ 15:0]              s3_imag;
//第二级蝶形运算单�??
        reg signed [ 15:0]              r0_real;
        reg signed [ 15:0]              r0_imag;
        reg signed [ 15:0]              r1_real;
        reg signed [ 15:0]              r1_imag;
        reg signed [ 15:0]              r2_real;
        reg signed [ 15:0]              r2_imag;
        reg signed [ 15:0]              r3_real;
        reg signed [ 15:0]              r3_imag;       



///================main code ==============\\\
//=========================================\\\

//第一级蝶形运�??
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        s0_real     <=      'h0;
        s0_imag     <=      'h0;      
        s1_real     <=      'h0;
        s1_imag     <=      'h0;
        s2_real     <=      'h0;
        s2_imag     <=      'h0;
        s3_real     <=      'h0;
        s3_imag     <=      'h0;
    end
    else begin
        //蝶形1
        s0_real     <=      x0_real + x1_real;
        s0_imag     <=      x0_imag + x1_imag;
        s1_real     <=      x0_real - x1_real;
        s1_imag     <=      x0_imag - x1_imag;  
        //蝶形2
        s2_real     <=      x2_real + x3_real;
        s2_imag     <=      x2_imag + x3_imag;
        s3_real     <=      x2_real - x3_real;
        s3_imag     <=      x2_imag - x3_imag;
    end
end

//�??2级蝶形运�??
always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        r0_real     <=      'h0;      
        r0_imag     <=      'h0;
        r1_real     <=      'h0;
        r1_imag     <=      'h0;
        r2_real     <=      'h0;
        r2_imag     <=      'h0;
        r3_real     <=      'h0;
        r3_imag     <=      'h0;
    end
    else begin
        //蝶形1
        r0_real     <=      s0_real + s2_real;
        r0_imag     <=      s0_imag + s2_imag;
        r2_real     <=      s0_real - s2_real;
        r2_imag     <=      s0_imag - s2_imag;
        //蝶形2
        r1_real     <=      s1_real + s3_imag;
        r1_imag     <=      s1_imag - s3_real;
        r3_real     <=      s1_real - s3_imag;
        r3_imag     <=      s1_imag + s3_real;
    end
end

always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        X0_real    <=       'b0;    
        X0_imag    <=       'b0; 
        X1_real    <=       'b0; 
        X1_imag    <=       'b0; 
        X2_real    <=       'b0; 
        X2_imag    <=       'b0; 
        X3_real    <=       'b0; 
        X3_imag    <=       'b0;
    end
    else begin
        X0_real    <=       r0_real;
        X0_imag    <=       r0_imag;
        X1_real    <=       r1_real;
        X1_imag    <=       r1_imag;
        X2_real    <=       r2_real;
        X2_imag    <=       r2_imag;
        X3_real    <=       r3_real;
        X3_imag    <=       r3_imag;
        end
end

endmodule
