// Constants
.equ UART_BASE, 0xff201000
.equ DISPLAY_1, 0xff200020     // SSD register address
.equ w_key, 0x77
.equ s_key, 0x73

.data
hex_patterns: // 0-9, A-F
	.word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

.global _start
.text
_start:
	LDR r0, =UART_BASE
	LDR	r2, =DISPLAY_1
	LDR r3, =hex_patterns
	MOV r4, #0              // Set index to 0
	LDR r5, [r3]            // First element in r3 (0x3F, representing 0)
	STR r5, [r2]            // Write value in r5 to SSD

poll_loop:
	LDR r6, [r0]            // Read UART data register
	TST r6, #1              // Check if least bit is set
    BEQ poll_loop           // If not, no key available

	MOV r6, #0              // Clear the keypress for the next loop
	LDR r7, [r0]            // Read the keypress value
	CMP r7, #w_key
	BEQ inc
	CMP r7, #s_key
	BEQ dec
	B poll_loop             // If not W or S, go back

inc:
	ADD r4, r4, #1
	CMP r4, #15
	MOVGT r4, #0
	B update_display

dec:
	SUB r4, r4, #1
	CMP r4, #0
	MOVLT r4, #15
	B update_display

update_display:
	ADD r5, r3, r4, LSL #2
	LDR r5, [r5]
	STR r5, [r2]
	MOV r6, #0
	B poll_loop
