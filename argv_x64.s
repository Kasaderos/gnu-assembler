.text
# ./a.out param1 param2
#my_puts:
#	push %rbp
#	mov %rsp, %rbp
#
#	mov 8(%rbp), %rax # aдрес строчки
#	mov 12(%rbp), %rcx # длина	
#
#	# выделение локальных переменных
#
##  
##		|      |
##esp-ecx-1	|      |
##esp-ecx->	|      |
##		|      |
##		    ..
##		|      |
##	esp ->  |      |
##		| ebp  |
##		| ret  |
##		| *ptr |
##		| size |
##
#	sub %rcx, %rsp 
#	sub $1, %rsp
#	# выравнение стека по 16
#	and $-16, %rsp
#	
#	push %rsi
#	
#	mov $0, %rsi
#lp_my_puts:
#	cmp %rcx, %rsi
#	je lp_end_my_puts
#	
#	mov (%rax, %rsi), %dl
#
#	mov %dl, 4(%rsp, %rsi) # запушали esi поэтому дополнительно 4
#	
#	add $1, %rsi
#	jmp lp_my_puts
#lp_end_my_puts:
#	movb $'\n', 4(%rsp, %rsi) 
#	mov $4, %rax
#	mov $1, %rbx
#	
#	mov %rsp, %rcx 
#	add $4, %rcx # потому что запушали esi, здесь адрес скопированной строки
#	mov %rsi, %rdx
#	add $1, %rdx # строка стало длиннее на \n
#	int $0x80
#	
#	pop %rsi  
#
#	mov %rbp, %rsp
#	pop %rbp
#	ret
#
#.global my_strlen
#my_strlen:
#	push %rbp
#	mov %rsp, %rbp
#	mov 8(%rbp), %rax
#	mov %rax, %rcx
#Lp2:
#	cmpb $0, (%rax)
#	je End2
#	add $1, %rax
#	jmp Lp2
#End2:
#	sub %rcx, %rax	
#	pop %rbp
#	ret
.global my_print
.global _start	

my_print:
	push %rbp
	mov %rsp, %rbp
	
	pop %rbp
	ret


_start:
	xor %rbp, %rbp
	call my_print
#	xor %rsi, %rsi
#Lp:	
#	cmp %rsi, %rdi
#	je End
#	mov (%rsp, %rsi, 4), %rcx
#	push %rcx
#	call my_strlen
#	pop %rcx # очищаем стэк
#	
#	push %rax
#	push %rcx
#	call my_puts
#	add $8, %rsp
#
#	add $1, %rsi
#	jmp Lp
#End:
	mov $0, %rbx 
	mov $1, %rax  # exit(0) 
	int $0x80 
		

