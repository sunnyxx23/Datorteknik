
    MOV r0, #1
	LDR r1, =numbers
	LDR r2, [r1] // first elem in numbers arr
	CMP r2, #0 // check if end of arr, pretty much like a while loop
	BEQ _end
	
	BL factorial // if not end, Branch and link to factorial
	BL print_number // print the number. But since factorial is recrusive, we won't print every number along the way.
	POP {lr, r0}
	B _end
