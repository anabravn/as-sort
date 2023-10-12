.section .data
    gap_value: .int 10
    shrink_factor: .double 1.3
    fpu_control: .word 0

.section .text

bubble_sort:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %edx # Tamanho do vetor
    movl 12(%ebp), %esi # Endereço do vetor

    xorl %ebx, %ebx

    // Enquanto %ebx < %edx
    bubble_outer:
        movl %edx, %ecx

        bubble_inner:
            // Enquanto %ecx > %ebx
            decl %ecx
            cmpl %ebx, %ecx
            jle bubble_outer_continue 

            // Comparar elemento j com elemento j - 1
            movl -4(%esi, %ecx, 4), %eax
            cmpl (%esi, %ecx, 4), %eax
            jle bubble_inner

            // Trocar elementos
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

update_gap:
    // Fator de encolhimento
    movl $shrink_factor, %ebx
    fldl (%ebx)

    // Valor atual
    movl $gap_value, %eax
    filds (%eax)

    // Divisão
    fdiv %st(1), %st(0)

    // Atualizar modo de arredondamento
    // Arredondar pra baixo
    movl $fpu_control, %eax
    fstcw (%eax)
    orw $0xfdf, fpu_control
    fldcw (%eax) 

    // Atualiza valor
    movl $gap_value, %eax
    fistpl (%eax) 

    ret

