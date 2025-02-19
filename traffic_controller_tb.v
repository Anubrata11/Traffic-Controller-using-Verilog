`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2025 10:55:59
// Design Name: 
// Module Name: traffic_controller_tb
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


module traffic_controller_tb();
reg clk,rst,input_ped_ns,input_ped_ew;
wire [2:0]signal_ns,signal_ew;
wire output_ped_ns,output_ped_ew;
traffic_controller uut(.clk(clk),.rst(rst),.in_ped_ns(input_ped_ns),.in_ped_ew(input_ped_ew),.out_ped_ns(output_ped_ns),.out_ped_ew(output_ped_ew),.signal_ns(signal_ns),.signal_ew(signal_ew));

//clock generation
initial clk=1;
always #5clk=~clk;

initial begin
rst=1;
#10 rst=0;input_ped_ns=1;
#80 input_ped_ns=0; input_ped_ew=1;
#80 $finish;
end
endmodule
