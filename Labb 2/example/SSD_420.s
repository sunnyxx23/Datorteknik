// Symbolic constants
.equ LEDS_BASE, 0xff200000
.equ SWITCHES_BASE, 0xff200040
.equ PUSH_BASE, 0xff200050
.equ DISPLAY_1, 0xff200020
.equ DISPLAY_2, 0xff200030

.global _start
_start:
	LDR r0, =DISPLAY_1
    MOV r1, #0x66              // Hex pattern for 4
    LSL r1, r1, #16            // Shift 4 to the 3rd display position
    MOV r2, #0x5B              // Hex pattern for 2
    LSL r2, r2, #8             // Shift 2 to the 2nd display position
    ORR r1, r1, r2             // Combine 4 and 2
    MOV r3, #0x3F              // Hex pattern for 0
    ORR r1, r1, r3             // Combine with 0
    STR r1, [r0]               // Write to DISPLAY_1
	
_halt:
    B _halt