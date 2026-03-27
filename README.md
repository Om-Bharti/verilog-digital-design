# Verilog Digital Design Library

This repository contains my **VLSI learning projects implemented in Verilog HDL**.
Each module is designed, simulated, verified using testbenches, and organized in a modular RTL structure.

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

Directory:

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

Implementation uses **two half adders and an OR gate**.

Directory:

```
full_adder/
 ├── rtl/
 │   └── full_adder.v
 └── testbench/
     └── full_adder_tb.v
```

---

## 3️⃣ 4-bit Ripple Carry Adder

Constructed using **four full adders** connected in series.

Carry propagates from the least significant bit to the most significant bit.

Directory:

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

Supported operations:

| Opcode | Operation |
| ------ | --------- |
| 000    | ADD       |
| 001    | SUB       |
| 010    | AND       |
| 011    | OR        |
| 100    | XOR       |

Directory:

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
* Synchronous write (clock-based)
* Asynchronous read

### Inputs

* clk
* write enable (we)
* write address
* read addresses
* write data

### Outputs

* read_data1
* read_data2

### Directory

```
register_file/
 ├── rtl/
 │   └── register_file.v
 └── testbench/
     └── regfile_tb.v
```
## 6️⃣ Datapath

The datapath connects the Register File and ALU to enable computation and data storage.

### Data Flow

```
Register File → ALU → Register File
```

### Features

* Reads two operands from registers
* Performs operation using ALU
* Writes result back to register file

### Components Used

* Register File
* 4-bit ALU

### Directory

```
datapath/
 ├── rtl/
 │   └── datapath.v
 └── testbench/
     └── datapath_tb.v
```

---

# Simulation Flow

Example simulation command:

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
└── README.md
```

---

# Future Work

The repository will expand toward building a **simple processor datapath**.

Upcoming modules:

* Program Counter
* Control Unit
* Simple CPU
