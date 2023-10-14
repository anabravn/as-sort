.global _start

.section .data
    str_size: .asciz "Tamanho do array: "
    fmt_scanf: .asciz " %d"
    fmt_printf: .asciz "Digite %d números:\n"
    str_menu: .asciz "Selecione o algoritmo de ordenação:\n\t[1] Selection Sort\n\t[2] Bubble Sort\n\t[3] Heap Sort\n\t[4] Comb Sort\n> "
    option: .int 0
    size: .int 0

.section .text

_start:
    // Selecionar algoritmo
    pushl $str_menu
    call printf
    addl $4, %esp

    pushl $option
    pushl $fmt_scanf
    call scanf
    addl $8, %esp

    // Ler tamanho
    pushl $str_size 
    call printf
    addl $4, %esp

    pushl $size
    pushl $fmt_scanf
    call scanf
    addl $8, %esp

    // Ler números
    pushl size
    pushl $fmt_printf
    call printf
    addl $4, %esp

    call alloc_array
    addl $4, %esp

    pushl %eax
    pushl size

    call input
    
    switch_algo:
        movl option, %eax

        cmpl $1, %eax
        je switch_selection

        cmpl $2, %eax
        je switch_bubble

        cmpl $3, %eax
        je switch_heap

        cmpl $4, %eax
        je switch_comb

        jmp switch_end

        switch_selection:
            call selection_sort
            jmp switch_end
        switch_bubble:
            call bubble_sort
            jmp switch_end
        switch_heap:
            call heap_sort
            jmp switch_end
        switch_comb:
            call comb_sort

    switch_end:

    call output

    addl $4, %esp

    call free
    addl $4, %esp

    pushl $0
    call exit
