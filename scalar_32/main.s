.global _start 
.global vector1
.global vector2
.global save_eip_in_ebx

.data
# (vector1, vector2) = 56
.align 32
vector1:
	.float 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0
	
.align 32
vector2:
	.float 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0, 0.0

.align 32
ans_scalar:
	.float 0.0

.text
formatstr:
	.string "scalar_mul result = %lf\n"

save_eip_in_ebx:
	mov (%esp), %ebx
	ret

_start:
	xor %ebp, %ebp
	# выравнивание стэека
	and $-16, %esp 
	# передаем длину вектора
	push $9
	call scalar_mul@PLT
	add $4, %esp

	# получили eip
	call save_eip_in_ebx
	add $_GLOBAL_OFFSET_TABLE_, %ebx
	mov ans_scalar@GOT(%ebx), %edi
	# result in st(0) 
	fstps (%edi)
	
	pushl (%edi)
	# передаем адрес форматной строки в rdi
	lea formatstr@GOTOFF(%ebx), %edi
	push %edi
	call printf@PLT
	add $8, %esp

	push $0
	call exit@PLT
	

	


	

	

	


