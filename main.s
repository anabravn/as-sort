.global _start

.section .data
    prompt: .asciz "Tamanho: "
    fmt_scanf: .asciz " %d"
    fmt_printf: .asciz "Digite %d números:\n"
    size: .int 0

.section .text

_start:
    pushl $prompt 
    call printf
    addl $4, %esp

    pushl $size
    pushl $fmt_scanf
    call scanf
    addl $8, %esp

    pushl size
    pushl $fmt_printf
    call printf
    addl $4, %esp

    call alloc_array
    addl $4, %esp

    pushl %eax
    pushl size

    call input
    call comb_sort
    call output

    addl $4, %esp

    call free
    addl $4, %esp

    pushl $0
    call exit
