.data

motdtext:
	.asciz "hello\n"

motdlen:
	.equ len, motdlen - motdtext
.bss
.text

.globl _start

_start:

motd:
	movl $0x04, %eax
	movl $0x01, %ebx
	movl $motdtext, %ecx
	movl $0x06,%edx
	int $0x80

exit:
	movl $0x01, %eax
	movl $0x00, %ebx
	int $0x80
