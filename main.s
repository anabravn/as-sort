.global _start

.section .data
    prompt: .asciz "Digite 5 números: "
    vetor: .int 0, 0, 0, 0 

.section .text
    _start:
    
    pushl $prompt
    call printf
    addl $4, %esp

    pushl $vetor
    pushl $5

    call input
    call output
    call heap_sort
    call output

    addl $8, %esp

    // Exit Syscall
    movl $1, %eax # Syscall number
    movl $0, %ebx # Exit status
    int $0x80
