.section .text

min:
    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %esi # Endereço do vetor

    // Primeiro elemento
    movl %esi, %eax

    min_loop:
        // Compara (%esi) e (%eax)
        movl (%eax), %ebx
        cmpl (%esi), %ebx

        jl min_continue # Salvar esi se (%esi) < (%eax) 
        movl %esi, %eax # Endereço do menor elemento em %eax

        min_continue:
        addl $4, %esi # Incrementa esi (próximo elemento)
        loop min_loop

    popl %ebp

    // Retorna endereço do menor elemento em eax
    ret
  
selection_sort:
    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %esi # Endereço do vetor

    selection_loop:
        pushl %esi
        pushl %ecx

        // Seleciona o menor valor
        call min

        popl %ecx
        popl %esi

        // Troca esi elemento com o menor elemento
        movl (%esi), %ebx
        xchgl (%eax), %ebx
        movl %ebx, (%esi)

        // Decrementa o tamanho do vetor
        // e aponta esi para o próx. elemento
        addl $4, %esi
        loop selection_loop

    popl %ebp
    ret

