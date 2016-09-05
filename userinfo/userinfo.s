.section .bss
  .lcomm pid, 4
  .lcomm uid, 4
  .lcomm gid, 4
  .lcomm egid, 4
  .lcomm euid, 4

.section .text

.globl _start

_start:
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

  end:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
