// Symbolic constants
.equ LEDS_BASE, 0xff200000
.equ SWITCHES_BASE, 0xff200040

.global _start
_start:
    LDR r0, =SWITCHES_BASE   // Switches in r0
    LDR r1, =LEDS_BASE       // LED's in r1

loop:
    LDR r2, [r0]             // Read all switch values
    STR r2, [r1]             // Write switch values to led'stack
    B loop                   // Inf loop

_halt:
    B _halt                  // never reached, good to have
