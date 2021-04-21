.text
# ./a.out param1 param2
my_puts:
	push %ebp
	mov %esp, %ebp

	mov 8(%ebp), %eax # aдрес строчки
	mov 12(%ebp), %ecx # длина	

	# выделение локальных переменных

#  
#		|      |
#esp-ecx-1	|      |
#esp-ecx->	|      |
#		|      |
#		    ..
#		|      |
#	esp ->  |      |
#		| ebp  |
#		| ret  |
#		| *ptr |
#		| size |
#
	sub %ecx, %esp 
	sub $1, %esp
	# выравнение стека по 16
	and $-16, %esp
	
	push %esi
	
	mov $0, %esi
lp_my_puts:
	cmp %ecx, %esi
	je lp_end_my_puts
	
	mov (%eax, %esi), %dl

	mov %dl, 4(%esp, %esi) # запушали esi поэтому дополнительно 4
	
	add $1, %esi
	jmp lp_my_puts
lp_end_my_puts:
	movb $'\n', 4(%esp, %esi) 
	mov $4, %eax
	mov $1, %ebx
	
	mov %esp, %ecx 
	add $4, %ecx # потому что запушали esi, здесь адрес скопированной строки
	mov %esi, %edx
	add $1, %edx # строка стало длиннее на \n
	int $0x80
	
	pop %esi  

	mov %ebp, %esp
	pop %ebp
	ret

.global my_strlen
my_strlen:
	push %ebp
	mov %esp, %ebp
	mov 8(%ebp), %eax
	mov %eax, %ecx
Lp2:
	cmpb $0, (%eax)
	je End2
	add $1, %eax
	jmp Lp2
End2:
	sub %ecx, %eax	
	pop %ebp
	ret
	
.global _start	

_start:
	xor %ebp, %ebp
	pop %edi
	xor %esi, %esi
Lp:	
	cmp %esi, %edi
	je End
	mov (%esp, %esi, 4), %ecx
	push %ecx
	call my_strlen
	pop %ecx # очищаем стэк
	
	push %eax
	push %ecx
	call my_puts
	add $8, %esp

	add $1, %esi
	jmp Lp
End:
	mov $0, %ebx 
	mov $1, %eax  # exit(0) 
	int $0x80 
		

