.data
motd:
.asciz "hello\n"

.bss
len:
.byte 4

.text

.globl _start

print:
	movl $0x04, %eax
	movl $0x01, %ebx
	movl $len, %edx
	int $0x80
	ret

exit:
	movl $0x01, %eax
	movl $0x00, %ebx
	int $0x80

_start:
	movl $motd, %ecx
	call print
	call exit
