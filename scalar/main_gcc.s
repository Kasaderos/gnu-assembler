.global main 
.global vector1
.global vector2

.data
# (vector1, vector2) = 56
.align 16
vector1:
	.int 0, 1, 2, 3, 4, 5, 6, 7
	
.align 16
vector2:
	.int 7, 6, 5, 4, 3, 2, 1, 0

.text
formatstr:
	.string "scalar_mul result = %lu\n"

main:
	xor %rbp, %rbp
	# выравнивание стэека
	and $-16, %rsp 
	# передаем длину вектора
	mov $8, %rdi
	call scalar_mul@PLT

	# result in rax
	
	# передаем адрес форматной строки в rdi
	lea formatstr(%rip), %rdi
	mov %rax, %rsi
	call printf@PLT

	mov $0, %rdi
	call exit@PLT
	


	

	

	


