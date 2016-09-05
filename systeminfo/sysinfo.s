.section .data
	# cpuid storage
	output:
	.ascii "The processor vendor ID is 'xxxxxxxxxxxx'\n"

	output_end:
 	.equ len, output_end - output

	# sysinfo storage
	result:
		uptime:
  		.int 0
		load1:
		.int 0
		load5:
		.int 0
		load15:
		.int 0
		totalram:
		.int 0
		freeram:
		.int 0
		sharedram:
		.int 0
		bufferram:
		.int 0
		totalswap:
		.int 0
		freeswap:
		.int 0
		procs:
		.byte 0x00, 0x00
		totalhigh:
		.int 0
		memunit:
		.int 0

.section .bss
  .lcomm pid, 4
  .lcomm uid, 4
  .lcomm gid, 4
  .lcomm egid, 4
  .lcomm euid, 4

.section .text

.globl _start

_start:
	movl $0, %eax
	cpuid

	movl $output, %edi
	movl %ebx, 28(%edi)
	movl %edx, 32(%edi)
	movl %ecx, 36(%edi)
	movl $4, %eax
	movl $1, %ebx
	movl $output, %ecx
	movl $output_end, %edx
	int $0x80

	# sysinfo command
	movl $result, %ebx
	movl $116, %eax
	int $0x80

	# user info command
	movl $20, %eax
	int $0x80
	movl %eax, pid

	movl $24, %eax
	int $0x80
	movl %eax, uid

	movl $47, %eax
	int $0x80
	movl %eax, gid

	movl $49, %eax
	int $0x80
	movl %eax, euid

	movl $50, %eax
	int $0x80
	movl %eax, egid

	# exit
	end:
	movl $0, %ebx
	movl $1, %eax
	int $0x80
