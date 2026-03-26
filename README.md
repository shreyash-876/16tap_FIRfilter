# MATLAB-to-VLSI Design of a Fixed-Point FIR Filter

##  Overview
This project demonstrates a complete **MATLAB-to-RTL design flow** for a **16-tap low-pass FIR filter**. The filter is designed and analyzed in MATLAB, converted to fixed-point representation, and implemented in Verilog for hardware realization. The RTL design is verified using Vivado simulation.

---

##  Objectives
- Design an FIR filter in MATLAB
- Analyze frequency and time-domain characteristics
- Convert floating-point coefficients to fixed-point (Q1.15)
- Implement FIR filter in Verilog (RTL)
- Simulate and verify hardware behavior in Vivado

---

##  FIR Filter Theory
The FIR filter is defined as:

`y[n] = Σ b[k] · x[n-k]`

where:
- \( b_k \) are filter coefficients  
- \( x[n-k] \) are delayed input samples  

---

##  Design Flow

### 1. MATLAB Design
- Designed a **16-tap low-pass FIR filter** using `fir1`
- Plotted:
  - Frequency response
  - Time-domain response
  - Tap comparison (4, 16, 32 taps)

### 2. Fixed-Point Implementation
- Converted coefficients to **Q1.15 format**
- Compared:
  - Floating vs fixed coefficients
  - Output signals
  - Quantization error

### 3. RTL Implementation (Verilog)
- Implemented **Direct Form FIR architecture**
- Components:
  - Shift registers (delay line)
  - Multipliers (coefficients)
  - Adders (accumulation)

### 4. Simulation (Vivado)
- Applied sinusoidal input signal
- Observed filtered output waveform
- Verified correct FIR behavior

---

##  Hardware Architecture

### FIR Datapath
- Shift-register-based delay line
- Parallel multipliers
- Adder chain (multiply-accumulate)

### RTL Datapath
- One output per clock cycle
- Fixed-point arithmetic (Q1.15)
- Sequential processing using registers

---

##  Results

### MATLAB Results
- Accurate frequency response
- Effective filtering of signal
- Very small quantization error (~10⁻⁵)

### RTL Results (Vivado)
- Output waveform matches expected FIR behavior
- Correct delay and smoothing observed
- Minor differences due to fixed-point arithmetic

---

##  Notes on MATLAB vs RTL

- MATLAB uses floating-point → smooth output  
- RTL uses fixed-point → discrete output  
- Small differences arise due to quantization and scaling  

---

##  Project Structure

```text
FIR_Filter_Project/

│── README.md

│── matlab/
│     └── final_script.m

│── rtl/
│     └── fir_filter.v

│── testbench/
│     └── tb_fir.v

│── results/
│     ├── freq_response.png
│     ├── time_response.png
│     ├── tap_comparison.png
│     ├── output_comparison.png
│     ├── coeff_comparison.png
│     ├── error_plot.png
│     ├── vivado_waveform.png
│     └── rtl_datapath.png

│── report/
      └── FIR_16tap.pdf
```
---

##  How to Run

### MATLAB
1. Open MATLAB
2. Run:
   ```matlab
   fir_design.m
3. View generated plots

### Vivado
1. Open Vivado project
2. Add:
    fir_filter.v
    testbench_fir.v

3. Run:
    Run Simulation → Behavioral Simulation
    Observe waveform

## Key Learnings
1. DSP to hardware mapping
2. Fixed-point vs floating-point trade-offs
3. FIR filter architecture design
4. RTL design and simulation
5. Hardware-aware optimization

## Conclusion
This project successfully demonstrates the transition from MATLAB-based DSP design to hardware implementation using Verilog. The FIR filter achieves correct functionality with efficient hardware realization.

## Author 
Shreyash Sharma

## Acknowledgement
Developed as part of the Paripath PS2 (VLSI/DSP) selection process.
