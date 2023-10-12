.section .text

bubble_sort:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %edx # Tamanho do vetor
    movl 12(%ebp), %esi # Endereço do vetor

    xorl %ebx, %ebx

    bubble_outer:

        movl %edx, %ecx
        decl %ecx

        bubble_inner:

        cmpl %ebx, %ecx
        decl %ecx
        jle bubble_outer_continue 

         // Comparar elemento j com elementp j - 1
        movl -4(%esi, %ecx, 4), %eax
        cmpl (%esi, %ecx, 4), %eax
        jle bubble_inner

        xchgl (%esi, %ecx, 4), %eax
        movl %eax, -4(%esi, %ecx, 4)

        jmp bubble_inner
   
    bubble_outer_continue:

    incl %ebx
    cmpl %edx, %ebx
    jl bubble_outer

    bubble_end:
        popl %ebp
        ret
