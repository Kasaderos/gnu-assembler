# Инициализация переменных для хранения ответа
.data
pos_ans:
    .int 0
neg_ans:
    .int 0

# Форматная строка для вывода ответа
.section .rodata
formatstr:
	.string "sum pos numbers = %d,\nsum neg numbers = %d\n"

# Начало фукнции
.text
.global pos_neg_sum
pos_neg_sum:
    mov 4(%rsp), %eax
    mov 8(%rsp), %ecx

# Начало цикла
loop_label:
    cmp $0, %ecx
    jz end_label
    sub $1, %ecx
    mov (%eax, %ecx, 4), %edx
    cmp $0, %edx
    jl sum_neg
# Следующее число положительное
    add %edx, pos_ans
    jno loop_label
    movl $0x7FFFFFFF, pos_ans
    jmp loop_label
# Следующее число отрицательное
sum_neg:
    add %edx, neg_ans
    jno loop_label
    movl $0x80000000, neg_ans
    jmp loop_label

# Конец программы
end_label:
# Передача ответов
    mov neg_ans, %rdi
    mov pos_ans, %rsi
# Печать ответа
#   обращ к переменной к 
    mov formatstr(%rip), %rdx
    call printf

    ret
