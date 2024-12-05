.equ LEDS_BASE, 0xff200000  // LEDS adress

.global _start
_start:
    LDR r0, =LEDS_BASE       // LEDs address
    MOV r1, #0x3ff           // Will turn on all LEDs
    STR r1, [r0]             // Write to LEDs data register

_halt:
    B _halt