.section .data
    fmt: .asciz "edi: %d, ecx: %d, ebx: %d, eax: %d\n"

.section .text

heap_build:
    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %edi # Endereço do vetor

    movl %ecx, %edx

    // %ecx = %ecx / 2
    sarl $1, %ecx

    heap_build_loop:
        pushl %edi
        pushl %ecx
        pushl %edx

        call heapify

        popl %edx
        popl %ecx
        popl %edi

        decl %ecx
        cmp $0, %ecx
        jge heap_build_loop

    heap_build_end:
        popl %ebp
        ret

heap_sort:

    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %edi # Endereço do vetor

    pushl %edi
    pushl %ecx
    call heap_build
    popl %ecx
    addl $4, %esp

    heap_sort_loop:
        // Troca primeiro e ultimo elemento
        movl (%edi), %eax
        xchgl -4(%edi, %ecx, 4), %eax
        movl %eax, (%edi) 

        decl %ecx

        pushl %edi
        pushl $0
        pushl %ecx

        call heapify

        popl %ecx
        addl $8, %esp

        cmp $0, %ecx
        jg heap_sort_loop

   heap_sort_end:
        popl %ebp
        ret


heapify:
    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %esi # Índice do nó raiz 
    movl 16(,%ebp,), %edi # Endereço do vetor

    // Maior elemento = eax
    // Nó pai = esi
    movl %esi, %eax

    heapify_left:
        // Esquerda = 2i + 1
        // %ebx = (2 * %esi)
        movl %esi, %ebx
        sall $1, %ebx # %ebx = ebx * 2
        incl %ebx

        // Esquerda > Tamanho
        cmp %ecx, %ebx
        jge heapify_end

        // Comparar maior elemento e nó filho
        movl (%edi, %ebx, 4), %edx
        cmpl (%edi, %eax, 4), %edx

        jle heapify_right
        movl %ebx, %eax # eax = Maior elemento

    heapify_right:
        // Direita = 2i + 1
        // %ebx = (2 * %esi) + 2
        movl %esi, %ebx
        sall $1, %ebx # %ebx = ebx * 2
        addl $2, %ebx

        // Direita > Tamanho
        cmpl %ecx, %ebx
        jge heapify_swap

        // Comparar maior elemento e nó filho
        movl (%edi, %ebx, 4), %edx
        cmpl (%edi, %eax, 4), %edx

        jle heapify_swap
        movl %ebx, %eax # eax = Maior elemento 

    heapify_swap:
        cmpl %esi, %eax
        je heapify_end

        # Troca raiz e maior elemento
        movl (%edi, %eax, 4), %edx
        xchgl %edx, (%edi, %esi, 4)
        movl %edx, (%edi, %eax, 4)

    heapify_recursion_call:
        pushl %edi # Endereço do vetor
        pushl %eax # Indice do maior elemento
        pushl %ecx # Tamanho do vetor
        call heapify
        addl $12, %esp

    heapify_end:
        popl %ebp
        ret

print_reg:
    pusha

    pushl %eax
    push %ebx
    push %ecx
    push %edi
    pushl $fmt
    call printf
    addl $20, %esp

    popa
    ret



