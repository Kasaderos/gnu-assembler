.global _start 
.global vector1
.global vector2

.data
# (vector1, vector2) = 56
.align 16
vector1:
	.double 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0
	
.align 16
vector2:
	.double 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0, 0.0

.text
formatstr:
	.string "scalar_mul result = %lf\n"

_start:
	xor %rbp, %rbp
	# выравнивание стэека
	and $-16, %rsp 
	# передаем длину вектора
	mov $8, %rdi
	call scalar_mul@PLT

	# result in rax
	
	# передаем адрес форматной строки в rdi
	lea formatstr(%rip), %rdi
    # передаем printf(аргумент) в rax
    # результат уже в xmm0
    mov $1, %rax 
	call printf@PLT

	mov $0, %rdi
	call exit@PLT
	


	

	

	


