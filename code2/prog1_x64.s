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
# Получение параметров
    mov %rdi, %rax
    mov %rsi, %rcx

# Начало цикла
loop_label:
    cmp $0, %ecx
    jz end_label
    sub $1, %ecx
    mov (%rax, %rcx, 4), %edx
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
# Печать ответа
#   обращ к переменной к 
#    mov formatstr(%rip), %rdi
    mov $formatstr, %rdi
    mov pos_ans, %esi
    mov neg_ans, %edx
    call printf

    ret
