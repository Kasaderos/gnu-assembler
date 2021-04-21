
.bss
a:
	.int
.data
b:
	.int 12

.section .rodata
c:
	.int 13

.data
str:
	.string "Да да - строка1"

.section .rodata
cstr:
	.string "снова строка" 

.section .data
d:
	.word 15
.align 4
symb:
	.byte '\r'
.align 4 
#pi:
#	.double 3.14
#
#
