.global _start

.section .data
    vetor: .int 0, 0, 0, 0, 0, 0, 0, 0

.section .text
    _start:

    pushl $vetor
    pushl $8

    call input
    call selection
    call output

    addl $8, %esp # Align stack

    // Exit Syscall
    movl $1, %eax # Syscall number
    movl $0, %ebx # Exit status
    int $0x80
