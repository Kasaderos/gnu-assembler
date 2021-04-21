.global scalar_mul

.text
.type scalar_mul, @function

scalar_mul:

        push %rbp
        mov %rsp, %rbp

        mov vector1@GOTPCREL(%rip), %r8
        mov vector2@GOTPCREL(%rip), %r9

        # счетчик цикла
        xor %rsi, %rsi

        # в xmm0 храним сумму
        xorps %xmm0, %xmm0

    # сохраняем длину массива в r10
    mov %rdi, %r10
    and $-2, %rdi

scalar_mul_lp:

        # вычитаем из rsi rdi
        cmp %rdi, %rsi
        jae scalar_mul_tail_lp

        movapd (%r8, %rsi, 8), %xmm1
        movapd (%r9, %rsi, 8), %xmm2

    mulpd %xmm1, %xmm2

        addpd %xmm2, %xmm0

        add $2, %rsi
        jmp scalar_mul_lp

scalar_mul_tail_lp:

    cmp %rsi, %r10
    je scalar_mul_lp_end

        movsd (%r8, %rsi, 8), %xmm1
        movsd (%r9, %rsi, 8), %xmm2

    mulsd %xmm1, %xmm2

    addsd %xmm2, %xmm0

    add $1, %rsi
    jmp scalar_mul_tail_lp

scalar_mul_lp_end:

    # сложение частичных сумм
    shufps $0b11100100, %xmm0, %xmm1
    addsd %xmm1, %xmm0

    # результат хранится в xmm0
        mov %rbp, %rsp
        pop %rbp
        ret