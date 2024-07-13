# riscV_branchPred

# **5 STAGE PIPELINED RISCV WITH BRANCH PREDICTION**

Using rv32i to implement 5 stages: Instruction Fetch, Instruction Decode, Execute, Memory Read, and Memory Write, and implement R, I, S, B, U, J type instructions along with a branch predictor to improve processor efficiency while running conditional statements.

### **Branch Predictor** 
 A branch predictor is a digital circuit that tries to guess which way a branch will go before this is known definitively. Without branch prediction, the processor would wait until the conditional jump passes the execute stage before the next instruction can enter the fetch stage in the pipeline If it is later detected that the guess was wrong, then the speculatively executed or partially executed instructions are discarded and the pipeline starts over with the correct branch The time that is wasted in case of a branch misprediction is equal to the number of stages in the pipeline from the fetch stage to the execute stage.. As a result, making a pipeline longer increases the need for a more advanced branch predictor.
 
In our case, we chose to implement a 1 bit branch predictor which uses only 1 bit to store the previous ‘taken’ or ‘not taken’ cases for each type of branch.
In order to accommodate our 1-bit branch predictor block, we had to take the jumpD flag directly from the control unit, thus eliminating the need to pass it through the pipeline. Then we used ALU flags e.g BLT needs the neg flag, and the instruction itself is also fed into the branch predictor block whose func3 is used to determine what kind of branch it is by matching it to the table.
The BP block has a table which has 2 columns one for the types of branch instructions and another to tell if in the previous instruction of this type, was the branch taken or not (using a 1 bit flag). Each row contains the func3 part of the instruction that represents the type of branch and after that whether the branch was taken or not when said instruction was previously executed. To forward the address of the destination where the jump needs to be, the address is output from the block into a mux that then passes to the instruction memory.

## **Microarchitecure**

![image](https://github.com/user-attachments/assets/98ff967e-64ab-4154-a78d-998dd45692a0)

## **Instruction Set Architecture**

![image](https://github.com/user-attachments/assets/778e9b57-2bd8-4fd5-a44a-132760e24b3c)

## **RTL Diagram**

![image](https://github.com/user-attachments/assets/4a86a73e-c9e9-4feb-b4f4-fb6634b99a4b)

## **Fmin & Fmax**

![image](https://github.com/user-attachments/assets/b4d6d332-2a10-492d-bcd9-4ec323b93d5e)

## **Results**

![image](https://github.com/user-attachments/assets/0854ee91-bc5e-4949-b3c7-d74c69cffca7)

 The instructions in the program memory first load the values 2 and 3 into registers x2 and x3 respectively while a value of 1 is loaded into x5 using 3 LOAD instructions. The value in x2 is the multiplicand, x3 holds the multiplier’s value and x5 holds the value for the 
decrement.The process of multiplication begins by adding the value of x2 in to x4(initialized to 0) and then decrementing the value in x3 using x5 using 2 ADD commands. A BRANCH command is then used to compare the value in x3 to 0. If they are equal then the current address moves to 7, otherwise it loops back to 4 and the multiplication continues. As we can see in the waveform above, the final value of 6 can be seen as the result.

### **Reference:** Sarah Harris, David Harris - Digital Design and Computer Architecture_ RISC-V Edition 
