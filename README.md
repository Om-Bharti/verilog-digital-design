# Verilog Digital Design Library

This repository contains my **VLSI digital design projects implemented in Verilog HDL**, progressing from basic combinational circuits to a **system-level datapath and CPU architecture**.

Each module is designed, simulated, and verified using testbenches with a structured RTL approach.

---

# Tools Used

* **Icarus Verilog** – RTL simulation
* **GTKWave** – waveform visualization
* **VS Code** – development environment
* **Git & GitHub** – version control

---

# Implemented Modules

## 1️⃣ Half Adder

Adds two 1-bit numbers.

**Logic**

```
SUM   = A XOR B
CARRY = A AND B
```

```
half_adder/
 ├── rtl/
 │   └── half_adder.v
 └── testbench/
     └── half_adder_tb.v
```

---

## 2️⃣ Full Adder

Adds three inputs:

```
A + B + Cin
```

Outputs:

```
SUM
Cout
```

Implemented using **two half adders + OR gate**.

```
full_adder/
 ├── rtl/
 │   └── full_adder.v
 └── testbench/
     └── full_adder_tb.v
```

---

## 3️⃣ 4-bit Ripple Carry Adder

Constructed using four full adders connected in series.

* Carry propagates from LSB → MSB
* Demonstrates delay propagation in adders

```
ripple_carry_adder/
 ├── rtl/
 │   └── rca_4bit.v
 └── testbench/
     └── rca_tb.v
```

---

## 4️⃣ 4-bit ALU

Performs arithmetic and logical operations.

| Opcode | Operation |
| ------ | --------- |
| 000    | ADD       |
| 001    | SUB       |
| 010    | AND       |
| 011    | OR        |
| 100    | XOR       |

```
alu/
 ├── rtl/
 │   └── alu_4bit.v
 └── testbench/
     └── alu_tb.v
```

---

## 5️⃣ Register File

A small memory unit used to store intermediate values in a processor.

### Features

* 4 registers (each 4-bit)
* 2 read ports
* 1 write port
* Synchronous write
* Asynchronous read

```
register_file/
 ├── rtl/
 │   └── register_file.v
 └── testbench/
     └── regfile_tb.v
```

---

## 6️⃣ Datapath

Connects the Register File and ALU to enable computation and storage.

### Data Flow

```
Register File → ALU → Register File
```

### Features

* Reads operands from registers
* Performs ALU operation
* Writes result back

```
datapath/
 ├── rtl/
 │   └── datapath.v
 └── testbench/
     └── datapath_tb.v
```

---

## 7️⃣ Program Counter

A sequential circuit that holds the address of the current instruction.

### Features

* Increments every clock cycle
* Asynchronous reset
* 4-bit counter

### Behavior

```
if reset → PC = 0
else → PC = PC + 1
```

```
program_counter/
 ├── rtl/
 │   └── pc.v
 └── testbench/
     └── pc_tb.v
```

---
## 8️⃣ Instruction Memory

Stores instructions to be executed by the CPU.

### Features

* ROM-based design (preloaded instructions)
* 16 instruction locations
* 8-bit instruction width

### Instruction Format

```
[7:5] Opcode
[4:3] Source Register 1
[2:1] Source Register 2
[0]   Unused / Future use
```

### Function

* Takes address from Program Counter
* Outputs corresponding instruction

### Directory

```
instruction_memory/
 ├── rtl/
 │   └── instruction_memory.v
 └── testbench/
     └── imem_tb.v
```

---
## 9️⃣ Control Unit

Decodes instructions and generates control signals for the datapath.

### Function

Converts instruction into:

* Opcode
* Register addresses
* Write enable signal

### Instruction Breakdown

```
[7:5] Opcode
[4:3] Source Register 1
[2:1] Source Register 2
```

### Directory

```
control_unit/
 ├── rtl/
 │   └── control_unit.v
 └── testbench/
     └── cu_tb.v
```
---

# Simulation Flow

```
iverilog <rtl_files> <testbench_file>
vvp a.out
gtkwave wave.vcd
```

Example:

```
iverilog half_adder/rtl/half_adder.v half_adder/testbench/half_adder_tb.v
vvp a.out
gtkwave wave.vcd
```

---

# Project Structure

```
verilog-digital-design
│
├── half_adder
├── full_adder
├── ripple_carry_adder
├── alu
├── register_file
├── datapath
├── program_counter
├── instruction_memory
├── control_unit
└── README.md
```

---

# Future Work

This repository is progressing toward building a **simple CPU architecture**.

Upcoming modules:

* Simple CPU

---

# Key Learning Outcome

This project demonstrates:

* RTL design using Verilog
* Modular hardware design approach
* Datapath and control flow understanding
* Foundations of CPU architecture
