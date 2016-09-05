#searches for largest number in data_items
# eax - Holds current value
# ebx - Holds current largest value
# edi - pointer to current value for calculation

.data
data_items:
.long 3,222,66,10,0

.bss
.text
.globl _start

_start:
	movl $0, %edi			#move 0 into index register
	movl data_items(,%edi,4), %eax  #load the first byte of data
	movl %eax, %ebx			#since this is the first item its the biggest
	
start_loop:
	cmpl $0, %eax			#check to see if we've hit the end
	je loop_exit
	
	incl %edi			#load next value
	movl data_items(,%edi,4), %eax
	cmpl %ebx, %eax			#compare values
	jle start_loop			#jump to beginning of loop if new number isn't bigger

	movl %eax, %ebx			#move value as largest
	jmp start_loop			#jmp back to loop beginning

loop_exit:	
	movl $1, %eax			#exit
	int $0x80
	
