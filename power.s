.section .bss

len:
.byte 4

.lcomm data,4


.section .data
.section .text

.globl _start
_start:
	pushl $30		#push second arg	
	pushl $20		#push first arg
	call power		#call function
	addl $8, %esp		#scrub stack ptr

	pushl %eax		#save answer 

	pushl $2		#push second arg
	pushl $5		#push first arg
	call power		#call function
	addl $8, %esp		#scrub stack ptr

	popl %ebx		#pop first answer off stack, second in eax register
	addl %eax, %ebx		#add results, store in ebx

	#movl %ebx, data
	pushl %ebx
	call print

	#exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80

# Print results
.type print, @function
print:
        pushl %ebp
        movl %esp, %ebp
        movl $0x04, %eax
        movl $0x01, %ebx
	movl -8(%ebp), %ecx
	#movl $data, %ecx
        movl $len, %edx
        int $0x80
        movl %ebp, %esp
        popl %ebp
        ret	

# Power function two arguments
# ebx holds base power
# ecx holds power value
# eax temp storage

.type power, @function
power:
	pushl %ebp		#Preserve base pointer
	movl %esp, %ebp		#move stackptr into baseptr
	subl $4, %esp		#make room for local storage
	movl 8(%ebp), %ebx	#move first arg in eax
	movl 12(%ebp), %ecx	#move second arg in ecx
	
	movl %ebx, -4(%ebp)	#store result

power_loop_start:
	cmpl $1, %ecx		#if power =1 were done
	je end_power
	movl -4(%ebp), %eax	#move the current result in eax
	imull %ebx, %eax	#multiply the current result by base number
	movl %eax, -4(%ebp)	#store current result

	decl %ecx		#decrease the power
	jmp power_loop_start	#run for next power

end_power:
	movl -4(%ebp), %eax

	movl %ebp, %esp
	popl %ebp
	ret
