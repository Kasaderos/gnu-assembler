
.text
.global bar 
bar:
    push %ebp
    mov %esp, %ebp

    mov 8(%ebp), %eax # старшая часть A
    mov 12(%ebp), %ecx # младшая часть A
    mov 16(%ebp), %edx # число B

    add %ecx, %ecx
    adc $0, eax
    add %edx, %ecx
    adc $0, %eax 

    # результат в параметре А
    mov %eax, 8(%ebp) 
    mov %ecx, 12(%ebp) 

    mov %ebp, %esp
    pop %ebp
    ret
