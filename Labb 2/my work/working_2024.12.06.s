// Constants
.equ UART_BASE, 0xff201000
.equ DISPLAY_1, 0xff200020     // SSD register address
.equ w_key, 0x77
.equ s_key, 0x73
.equ q_key, 0x71

.data
hex_patterns: // 0-9, A-F
	.word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

.global _start
.text
_start:
	LDR	r2, =DISPLAY_1
	LDR r3, =hex_patterns
	MOV r4, #0              // Set index to 0
	LDR r5, [r3]            // First element in r3 (0x3F, representing 0)
	STR r5, [r2]            // Write value in r5 to SSD

poll_loop:
	LDR r0, =UART_BASE
	LDR r6, [r0]            // Read UART status register
	ANDS r7, r6, #0x8000
	BEQ poll_loop           // No data available, keep polling
	AND r6, r6, #0x00ff
	
	CMP r6, #w_key
    BEQ inc
    CMP r6, #s_key
    BEQ dec
	CMP r6, #q_key
	BEQ _end
	
	B poll_loop

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
	B poll_loop

_end:
	BAL _end
.end