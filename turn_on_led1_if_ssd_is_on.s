// Symbolic constants
.equ LEDS_BASE, 0xff200000
.equ SWITCHES_BASE, 0xff200040
.equ PUSH_BASE, 0xff200050
.equ DISPLAY_1, 0xff200020
.equ DISPLAY_2, 0xff200030

.global _start
_start:
    // Write hex pattern for "A" to DISPLAY_1
    LDR r0, =DISPLAY_1
    MOV r1, #0x77              // Hex pattern for A
    STR r1, [r0]               // Write to DISPLAY_1

    // Logic to control LEDs
    LDR r2, =LEDS_BASE         // Load LED base address
    CMP r1, #0                 // Compare r1 (0x77) with 0
    BEQ _led_off               // If r1 == 0, turn off LEDs
    MOV r3, #0x1               // If r1 != 0, set r3 to 1 (LEDs on)
    STR r3, [r2]               // Write r3 to LEDs
    B _halt                    // Jump to halt

_led_off:
    MOV r3, #0                 // Set r3 to 0 (LEDs off)
    STR r3, [r2]               // Write r3 to LEDs

_halt:
    B _halt                    // Infinite loop
