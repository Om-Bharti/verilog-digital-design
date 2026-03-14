# Verilog Digital Design

This repository contains my VLSI learning projects implemented in Verilog HDL.

## Tools Used

* Icarus Verilog
* GTKWave
* VS Code

## Project 1: Half Adder

A half adder adds two 1-bit inputs.

### Logic

SUM = A XOR B
CARRY = A AND B

### Simulation Flow

```
iverilog rtl/half_adder.v testbench/half_adder_tb.v
vvp a.out
gtkwave wave.vcd
```

### Project Structure

```
rtl/        → Verilog RTL modules
testbench/  → Testbenches for verification
```
