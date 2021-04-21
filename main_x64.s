	.global main 


# push %ebx колич символов
# call getchar может портить edx, eax, ecx

	.text

formatstr:	
	.string "sum symbols latin = %lu\n" 
main:
	push %rbx
	mov $0, %rbx
lp:
	call getchar
	cmp $-1, %eax
	je after_lp
	# al >= 'A' && al <= 'Z'
	# al >= 'a' && al <= 'z'
	cmp $'A', %al
	jb small_letter
	cmp $'Z', %al
	jg small_letter
	add $1, %rbx
	jmp lp

small_letter:
	cmp $'a', %al
	jb lp
	cmp $'z', %al
	jg lp
	add $1, %rbx
	jmp lp
after_lp:
	# printf("sum symbols lating = %lu\n", sum); 
	mov %rbx, %rsi
	mov $formatstr, %rdi 
	call printf

	pop %rbx
	xor %rax, %rax
	ret







