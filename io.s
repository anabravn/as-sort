.section .data
    fmt_in: .asciz " %d"
    fmt_out: .asciz "%d "
    linebreak: .ascii "\n"

.section .text

input:
    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %esi # Endereço do vetor

    input_loop:
        pushl %ecx # Salva ecx

        pushl %esi # Endereço do elemento
        pushl $fmt_in # Formato de entrada
        call scanf

        addl $8, %esp # Alinha a pilha

        // Incrementa esi (próximo elemento)
        addl $4, %esi 

        popl %ecx # Recupera ecx

        loop input_loop

    popl %ebp
    ret

output:
    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %esi # Endereço do vetor

    output_loop:
        pushl %ecx # Salva ecx

        pushl (%esi) # Valor do elemento
        pushl $fmt_out # Formato de saída
        call printf

        addl $8, %esp # Alinha a pilha

        // Incrementa esi (próximo elemento)
        addl $4, %esi

        // Recupera ecx depois de alinhar a pilha
        popl %ecx

        loop output_loop

    pushl linebreak
    call putchar
    addl $4, %esp

    popl %ebp
    ret

