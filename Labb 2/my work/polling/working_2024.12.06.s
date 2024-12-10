// Constants
.equ UART_BASE, 0xff201000
.equ DISPLAY_1, 0xff200020
.equ TIMER, 0xff202000
.equ w_key, 0x77
.equ s_key, 0x73
.equ q_key, 0x71


.data
hex_patterns: // 0-9, A-F
	.word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

.global _start
.text
_start:
	LDR r0, =UART_BASE
	LDR	r1, =DISPLAY_1
	LDR r2, =hex_patterns
	MOV r3, #0
	LDR r4, [r2]            // first element in r2 (0x3F = 0)
	STR r4, [r1]            // write value in r4 to SSD

poll_loop:
	LDR r5, [r0]            // Read UART status register
	ANDS r6, r5, #0x8000
	BEQ poll_loop           // No data available, keep polling
	AND r5, r5, #0x00ff
	
	CMP r5, #w_key
    BEQ inc
    CMP r5, #s_key
    BEQ dec
	CMP r5, #q_key
	BEQ _end
	
	B poll_loop

inc:
	ADD r3, r3, #1
	CMP r3, #15
	MOVGT r3, #0
	B update_display

dec:
	SUB r3, r3, #1
	CMP r3, #0
	MOVLT r3, #15
	B update_display

update_display:
	ADD r4, r2, r3, LSL #2
	LDR r4, [r4]
	STR r4, [r1]
	B poll_loop

_end:
	BAL _end
.end