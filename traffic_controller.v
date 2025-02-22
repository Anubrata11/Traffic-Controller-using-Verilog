`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2025 09:49:28
// Design Name: 
// Module Name: traffic_controller
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


module traffic_controller(
    input clk,rst,
    input in_ped_ns, in_ped_ew,
    output reg[2:0] signal_ns,signal_ew,
    output reg out_ped_ns,out_ped_ew
    );
    reg[2:0]current_state;
    parameter [2:0]s0=3'b000; //north_south signal=RED, east-west signal=RED
    parameter [2:0]s1=3'b001; //north_south signal=YELLOW, east-west signal=RED
    parameter [2:0]s2=3'b010; //north_south signal=GREEN, east-west signal=RED
    parameter [2:0]s3=3'b011; //north_south signal=YELLOW, east-west signal=YELLOW
    parameter [2:0]s4=3'b100; //north_south signal=RED, east-west signal=GREEN
    parameter [2:0]s5=3'b101; //north_south signal=RED, east-west signal=YELLOW
    
    parameter[2:0]sig0=3'b100; //RED signal for car
    parameter[2:0]sig1=3'b010; //YELLOW signal for car
    parameter[2:0]sig2=3'b001; //GREEN signal for car
    
    reg[2:0]count=3'b000; //for counting the delay in case of GREEN signal
    
    always@(posedge clk) begin
    if(rst) begin
        signal_ns=sig0;
        signal_ew=sig0;
        current_state=s0;
        out_ped_ns=0;
        out_ped_ew=0;
    end
    else begin
        case(current_state)
        s0:begin
           count<=count+1;
           signal_ns<=sig0;
           signal_ew<=sig0;
           if(in_ped_ns) 
             out_ped_ns=1;
           if(in_ped_ew)
             out_ped_ew=1;
           if(count<=3'd1) begin
                current_state<=s1;
                count<=3'd0;
           end
           else 
                current_state<=s0;   
           end
        s1:begin
           count<=count+1;
           signal_ns<=sig1;
           signal_ew<=sig0;
           if(in_ped_ns)
                out_ped_ns=1;
           else if(in_ped_ew)
                out_ped_ew=0;
           if(count<=3'd1) begin
                     current_state<=s2;
                     count<=3'd0;
           end
           else 
                     current_state<=s1;   
           end
        s2:begin
           count<=count+1;
           signal_ns<=sig2;
           signal_ew<=sig0;
           if(in_ped_ns)
                out_ped_ns=1;
           if(in_ped_ew)
                out_ped_ew=0;
           if(count==3'd4)begin
                current_state<=s3;
                count<=3'd0;
           end
           else
                current_state<=s2;
           end
        s3:begin
           count<=count+1;
           signal_ns<=sig1;
           signal_ew<=sig1;
           if(in_ped_ns)
                out_ped_ns<=0;
           if(in_ped_ew)
                out_ped_ew<=0;
           if(count<=3'd1) begin
                     current_state<=s4;
                     count<=3'd0;
                end
                else 
                     current_state<=s3;   
           end
        s4:begin
           count<=count+1;
           signal_ns<=sig0;
           signal_ew<=sig2;
           if(in_ped_ns)
                out_ped_ns=0;
           if(in_ped_ew)
                out_ped_ew=1;
           if(count==3'd4) begin
                current_state<=s5;
                count<=3'd0;
           end
           else
                current_state<=s4;
           end
        s5:begin
           count<=count+1;
           signal_ns<=sig0;
           signal_ew<=sig1;
           if(in_ped_ns)
                out_ped_ns<=0;
           if(in_ped_ew)
                out_ped_ew<=1;
           if(count<=3'd1) begin
                     current_state<=s0;
                     count<=3'd0;
                end
                else 
                     current_state<=s5;   
           end
         endcase
       end
    end
endmodule
