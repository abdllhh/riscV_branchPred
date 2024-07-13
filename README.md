# riscV_branchPred

**5 STAGE PIPELINED RISCV WITH BRANCH PREDICTION**

Using rv32i to implement 5 stages: Instruction Fetch, Instruction Decode, Execute, Memory Read, and Memory Write, and implement R, I, S, B, U, J type instructions along with a branch predictor to improve processor efficiency while running conditional statements.

**Microarchitecure**
![image](https://github.com/user-attachments/assets/98ff967e-64ab-4154-a78d-998dd45692a0)

**ISA**
![image](https://github.com/user-attachments/assets/778e9b57-2bd8-4fd5-a44a-132760e24b3c)

**RTL Diagram**
![image](https://github.com/user-attachments/assets/4a86a73e-c9e9-4feb-b4f4-fb6634b99a4b)

**Fmin & Fmax**
![image](https://github.com/user-attachments/assets/b4d6d332-2a10-492d-bcd9-4ec323b93d5e)

**Results**
![image](https://github.com/user-attachments/assets/0854ee91-bc5e-4949-b3c7-d74c69cffca7)
 The instructions in the program memory first load the values 2 and 3 into registers x2 and x3 respectively while a value of 1 is loaded into x5 using 3 LOAD instructions. The value in x2 is the multiplicand, x3 holds the multiplier’s value and x5 holds the value for the 
decrement.The process of multiplication begins by adding the value of x2 in to x4(initialized to 0) and then decrementing the value in x3 using x5 using 2 ADD commands. A BRANCH command is then used to compare the value in x3 to 0. If they are equal then the current address moves to 7, otherwise it loops back to 4 and the multiplication continues. As we can see in the waveform above, the final value of 6 can be seen as the result.

