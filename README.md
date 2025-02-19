# Traffic Controller using Verilog
This project involves building a 4 way traffic controller using Verilog HDL on Xilinx Vivado 2016.3, and its subsequent execution using a testbench and on the Nexys 4 DDR FPGA Board.

## Theory
A traffic controller for a 4 way street was built using a mealy machine, which is a type of finite state machine (FSM), where the next state after a particular state depends on both the present inputs and the present state. Here, there are two directions in which the vehicles can move, north to south and east to west. Along with that, pedestrians can also cross over in both the directions. Vehicle signals are of three types, RED, YELLOW and GREEN, and the pedestrian signals are of two types, RED and GREEN. There are a total of six internal states based on the signal state of the two vehicle signals and the delay between the signal changes. The state diagram is as follows : 

![Screenshot 2025-02-19 122209](https://github.com/user-attachments/assets/5e8dc0ff-e110-441c-8bd7-6a20d75892ef)

Here, the RED and YELLOW signals are changing after 1 clock cycle delay and the GREEN signal is changing after a delay of 5 clock cycles. When the vehicle signal for the particular direction is RED, only then the corresponding pedestrian signal is turned GREEN, otherwise it is RED. Upon hardware RESET, the vehicle signals for both the directions will be RED.

## Testbench Results 
![Screenshot 2025-02-19 141221](https://github.com/user-attachments/assets/40979576-7b1f-42ad-8782-2546dc4278e1)


On the 3 bit output signal, if the LSB is high, it indicates GREEN signal, if the middle bit is high, it indicates YELLOW signal, and if the MSB is high, it indicates RED signal. There are two input buttons for the pedestrians, one for each direction. When the input button for north-south direction is high (from 10ns to 90ns), the output pedestrian signal for the north-south direction is high as the east-west signal is RED during that time. The exactly opposite situation arises during 90ns to 150ns, when the input button for the east-west direction is high.
