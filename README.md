# Verilog Digital Design Library

This repository contains my VLSI learning projects implemented in **Verilog HDL**.
Each module is designed, simulated, verified, and organized using a clean RTL structure.

## Tools Used

* **Icarus Verilog** – RTL simulation
* **GTKWave** – waveform analysis
* **VS Code** – development environment
* **Git & GitHub** – version control

---

# Implemented Modules

## 1️⃣ Half Adder

A half adder adds two single-bit binary numbers.

### Logic

SUM = A XOR B
CARRY = A AND B

### Directory

```
half_adder/
 ├── rtl/
 │   └── half_adder.v
 └── testbench/
     └── half_adder_tb.v
```

---

## 2️⃣ Full Adder

A full adder adds **three inputs**:

* A
* B
* Carry-in (Cin)

Outputs:

* SUM
* Carry-out (Cout)

### Logic

SUM = A ⊕ B ⊕ Cin
Cout = (A · B) + (Cin · (A ⊕ B))

### Implementation

The full adder is implemented using **two half adders and an OR gate** (hierarchical design).

### Directory

```
full_adder/
 ├── rtl/
 │   └── full_adder.v
 └── testbench/
     └── full_adder_tb.v
```

---

# Simulation Flow

To simulate any module:

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
│
├── full_adder
│
└── README.md
```

---

# Upcoming Modules

The repository will gradually expand into a **complete digital design library**:

* Ripple Carry Adder
* Arithmetic Logic Unit (ALU)
* Register File
* Simple CPU
