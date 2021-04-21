	.global main 

	.section .rodata
formatstr:	
	.string "sum symbols latin = %d\n"

# push %ebx колич символов
# call getchar может портить edx, eax, ecx

	.text
main:
	push %ebx
	mov $0, %ebx
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
	add $1, %ebx
	jmp lp

small_letter:
	cmp $'a', %al
	jb lp
	cmp $'z', %al
	jg lp
	add $1, %ebx
	jmp lp
after_lp:
	# printf("sum symbols lating = %d\n", sum); 
	push %ebx
	push $formatstr # это адрес
	call printf
	add $8, %esp

	pop %ebx
	xor %eax, %eax
	ret







