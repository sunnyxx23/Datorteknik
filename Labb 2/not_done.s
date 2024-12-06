// Constants
.equ UART_BASE, 0xff201000     // UART base address
.equ UART_CONTROL_REG_OFFSET, 4 // UART control register.equ 
.equ DISPLAY_1, 0xff200020     // SSD register address
.equ W, 77 // W key FIFO 
.equ S, 73 // S key FIFO

.data
hex_patterns: // 0-9, A-F
	.word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

.global _start
.text
_start:
	LDR r0, =UART_BASE
    LDR r1, =UART_CONTROL_REG_OFFSET
	LDR	r2, =DISPLAY_1
	LDR r3, =hex_patterns
	LDR r5, [r3] // first elem
	MOV r4, #0 // set index to 0
	STR r5, [r2]

poll_loop:
    LDR r6, [r0]			// read status register (LDR = läs, STR = skriv)
	TST r6, #1				// check if least bit is set
    BEQ poll_loop			// if not, no key available
    LDR r6, [r1]			// key press detected

	CMP r6, #W
	BEQ inc
	CMP r6, #S
	BEQ dec
	B poll_loop // if not W or S, go back

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