.global _start

.section .data
    vetor: .int 4, 10, 3, 45, 1 

.section .text
    _start:
    
    pushl $vetor
    pushl $5
    call output
    addl $8, %esp

    pushl $vetor
    pushl $5
    call heap_build
    addl $12, %esp

    pushl $vetor
    pushl $5
    call output
    addl $8, %esp

    // Exit Syscall
    movl $1, %eax # Syscall number
    movl $0, %ebx # Exit status
    int $0x80
