# Precision Linear Variable-Gain Differential Amplifier (VGDA)

[![Tool: LTspice](https://img.shields.io/badge/Simulator-LTspice-darkred.svg)](https://www.analog.com/en/resources/design-tools-and-calculators/ltspice-simulator.html)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2022b%2B-blue.svg)](https://www.mathworks.com/products/matlab.html)
[![Component: AD8676](https://img.shields.io/badge/OpAmp-AD8676%20(Ultralow%20Noise)-orange.svg)](https://www.analog.com/en/products/ad8676.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Design, SPICE simulation, and small-signal AC/noise characterization of a precision **Variable-Gain Differential Amplifier (VGDA)** with linear gain control from 10 to 100 over a 20 kHz audio and sensor bandwidth.

The topology solves non-linear potentiometer tuning issues by inserting an inverting active stage into the feedback loop, allowing single-resistor linear gain scaling while maintaining high Common-Mode Rejection Ratio (CMRR) without degrading resistor bridge matching.

---

## Circuit Topology & Transfer Function

Traditional differential instrumentation amplifiers exhibit inverse hyperbolic gain laws when tuned via a single gain resistor ($A_d \propto 1/R_G$). 

This design embeds an inverting operational amplifier stage in the feedback path of the differential stage:

$$V_{\text{out}} = (V_{\text{IN2}} - V_{\text{IN1}}) \cdot \frac{R_4}{R_3} \cdot \frac{R_G}{R_F}$$

- **Linearity:** The differential voltage gain $A_d$ scales **strictly proportional** to the potentiometer resistance $R_G$.
- **Resistor Matching Preservation:** Bridge resistors ($R_1 = R_3 = 39\text{ k}\Omega$, $R_2 = R_4 = 78\text{ k}\Omega$) remain fixed, preserving common-mode matching independent of the chosen gain setting.
- **Active Core:** Dual ultralow noise, precision operational amplifiers **AD8676** ($e_n \approx 2.8\text{ nV}/\sqrt{\text{Hz}}$ at $1\text{ kHz}$) powered with dual rails $\pm 15\text{ V}$.

---

## Design Evolution & Optimization

| Design Revision | Bridge Resistors ($R_{1..4}$) | Potentiometer $R_G$ | Feedback $R_F$ | Bandwidth & Peaking | Input-Referred Noise |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Rev. 0.0 (Initial)** | $390\text{ k}\Omega \,/\, 780\text{ k}\Omega$ | $50\text{ k}\Omega - 500\text{ k}\Omega$ | $10\text{ k}\Omega$ | Peaking at $30\text{ kHz}$ (+20% gain error at cutoff) | Large resistor thermal noise |
| **Rev. 1.0 / 1.1 (Final)** | $39\text{ k}\Omega \,/\, 78\text{ k}\Omega$ | $5\text{ k}\Omega - 50\text{ k}\Omega$ | $1\text{ k}\Omega$ | **Flat passband up to $83\text{ kHz}$** (no resonance peak) | $6.5\text{ }\mu\text{V}_{\text{rms}} - 62\text{ }\mu\text{V}_{\text{rms}}$ |

---

## Performance Summary

- **Differential Gain Range:** Linearly adjustable between $10$ ($R_G = 5\text{ k}\Omega$), $50$ ($R_G = 25\text{ k}\Omega$), and $100$ ($R_G = 50\text{ k}\Omega$).
- **Bandwidth:** Cutoff frequency $f_{-3\text{dB}} \approx 83\text{ kHz}$, guaranteeing flat gain response across the entire audio spectrum ($20\text{ Hz} - 20\text{ kHz}$).
- **Common-Mode Rejection Ratio (CMRR):**
  - $R_G = 5\text{ k}\Omega$ ($A_d = 10$): **$86.03\text{ dB}$** at $20\text{ kHz}$
  - $R_G = 25\text{ k}\Omega$ ($A_d = 50$): **$86.18\text{ dB}$** at $20\text{ kHz}$
  - $R_G = 50\text{ k}\Omega$ ($A_d = 100$): **$85.84\text{ dB}$** at $20\text{ kHz}$
- **Time-Domain Verification:** Transient simulation with Vin,diff = 140 mVpeak at 10 kHz confirms clean linear amplification to 7.0 Vpeak at RG = 25 kΩ (Ad = 50) with zero phase inversion.

---

## Repository Structure

```text
├── docs/
│   └── Relazione.pdf                   # Full technical engineering report
│
├── sim/
│   ├── VGDA_Rev1_1.asc                 # LTspice schematic netlist
│   └── cmrr.m                          # MATLAB validation script for CMRR calculations
│
├── .gitignore
├── LICENSE
└── README.md
