.global scalar_mul

.text
.type scalar_mul, @function

scalar_mul:

	push %ebp
	mov %esp, %ebp
	push %esi
	push %edi
	push %ebx
	call save_eip_in_ebx@PLT

	mov vector1@GOT(%ebx), %ecx	
	mov vector2@GOT(%ebx), %edx	

	# счетчик цикла
	xor %esi, %esi
	
	# в xmm0 храним сумму
	xorps %xmm0, %xmm0

    	# сохраняем длину массива в %eax 
	mov 4(%ebp), %eax
	mov %eax, %edi
	and $-4, %edi

scalar_mul_lp:

	# вычитаем из rsi rdi 
	cmp %edi, %esi
	jae scalar_mul_tail_lp
		
	movaps (%ecx, %esi, 4), %xmm1
	movaps (%edx, %esi, 4), %xmm2 
	
    	mulps %xmm1, %xmm2 
	
	addps %xmm2, %xmm0

	# т.к. float
	add $4, %esi
	jmp scalar_mul_lp

# 0.0 1.0 2.0 3.0 4.0
# 0.0 1.0 2.0 3.0 4.0

# 0.0 2.0 4.0 6.0 xmm0
# 4.0             xmm1
# 0.0 2.0 4.0 10.0 xmm0
# 10.0 2.0 4.0 0.0 xmm3
scalar_mul_tail_lp:
    
	cmp %esi, %eax
	je scalar_mul_lp_end

	movss (%ecx, %esi, 4), %xmm1
	movss (%edx, %esi, 4), %xmm2 

	mulss %xmm1, %xmm2

	addss %xmm2, %xmm0

    	add $1, %esi
    	jmp scalar_mul_tail_lp

scalar_mul_lp_end:
    	

	movaps %xmm0, %xmm3
	# сложение частичных сумм 
   	
	#11 10 01 00
	#3  2  1   0
	#
	#00 10 01 11
	#0  2  1  3
	#
	#11 00 01 10
	#3  0  1  2
	#
	#11 10 00 01
	#3  2  0  1
   	
	#shufps $0b11100100, %xmm3, %xmm1
    	#addsd %xmm1, %xmm0

	shufps $0b00100111, %xmm3, %xmm1
    	addsd %xmm1, %xmm0
	
	shufps $0b11000110, %xmm3, %xmm1
    	addsd %xmm1, %xmm0

	shufps $0b11100001, %xmm3, %xmm1
    	addsd %xmm1, %xmm0
    
    	sub $4, %esp
    	movss %xmm0, (%esp)
	flds (%esp)
	add $4, %esp

	pop %ebx
	pop %edi
	pop %esi

	mov %ebp, %esp
	pop %ebp
	ret







