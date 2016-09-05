#Skeleton
.data
.bss
.text

.globl _start

_start:

exit:
	movl $0x01, %eax
	movl $0x00, %ebx
	int $0x80
