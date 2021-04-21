.section .rodata
formatstr:
	.string "%lu\n"

.text
.global bar 
bar:
    push %rbp
    mov %rsp, %rbp

    add %rdi, %rdi  
    add %rdi, %rsi  

    mov %rsi, %rax
    mov %rbp, %rsp
    pop %rbp
    ret
