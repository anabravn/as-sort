
.section .text

alloc_array:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ecx # Tamanho do vetor

    // Tamanho * sizeof(float)
    movl $4, %eax
    mull %ecx

    pushl %eax
    call malloc
    addl $4, %esp
    // Ponteiro em eax

    popl %ebp
    ret

