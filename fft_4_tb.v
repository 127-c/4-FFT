`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/07 20:59:26
// Design Name: 
// Module Name: fft_4_tb
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
module fft_4_tb;
//信号
reg clk;
reg rst_n;
reg signed [15:0]       x0_real;
reg signed [15:0]       x0_imag;
reg signed [15:0]       x1_real;
reg signed [15:0]       x1_imag;
reg signed [15:0]       x2_real;
reg signed [15:0]       x2_imag;
reg signed [15:0]       x3_real;
reg signed [15:0]       x3_imag;
wire signed [15:0]      X0_real;
wire signed [15:0]      X0_imag;
wire signed [15:0]      X1_real;
wire signed [15:0]      X1_imag;
wire signed [15:0]      X2_real;
wire signed [15:0]      X2_imag;
wire signed [15:0]      X3_real;
wire signed [15:0]      X3_imag;


fft_4 fft_4(
        //system
                .clk(clk),
                .rst_n(rst_n),

        //输入
                .x0_real(x0_real),// 默认解释为Q1.15
                .x0_imag(x0_imag),
                .x1_real(x1_real),
                .x1_imag(x1_imag),
                .x2_real(x2_real),
                .x2_imag(x2_imag),
                .x3_real(x3_real),
                .x3_imag(x3_imag),
                .X0_real(X0_real),
                .X0_imag(X0_imag),
                .X1_real(X1_real),
                .X1_imag(X1_imag),            
                .X2_real(X2_real),
                .X2_imag(X2_imag),
                .X3_real(X3_real),
                .X3_imag(X3_imag)
);

initial clk =1;
always #10 clk = ~clk;

initial begin
    //复位
x0_real = 0;
x0_imag = 0;
x1_real = 0;
x1_imag=  0;
x2_real=  0;
x2_imag=  0;
x3_real=  0;
x3_imag=  0;
rst_n = 0;
#2001
rst_n = 1;
x1_real = 16'h4000;
x3_real = 16'h4000;
#40000
$stop;
end
endmodule
