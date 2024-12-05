// Symbolic constants
.equ UART_BASE, 0xff201000
.equ UART_DATA_REGISTER_ADDRESS, 0xff201000
.equ UART_CONTROL_REGISTER_ADDRESS, 0xff201004

.global _start
_start:
    // UART write, simple example
    LDR r0, =UART_DATA_REGISTER_ADDRESS    // Base address for UART data register
    MOV r1, #'L'               // ASCII value for 'A'
    STR r1, [r0]                // Write to the terminal
    MOV r1, #'i'                // ASCII value for 'B'
    STR r1, [r0]                // Write to the terminal
	MOV r1, #'n'
	STR r1, [r0]
	MOV r1, #'u'
	STR r1, [r0]
	MOV r1, #'s'
	STR r1, [r0]
	
_halt:
    B _halt