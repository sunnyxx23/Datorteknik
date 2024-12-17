.data
    inBuf:  .space 256
    inPos:  .count 0

.text
.global inImage
# void inImage();
inImage:
    movq    $inBuf, %rdi
    mov     $6, %rsi
    mov     stdin, %rdx
    call    fgets
    call    puts