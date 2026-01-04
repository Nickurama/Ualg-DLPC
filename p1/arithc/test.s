	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq .csts_i32+4(%rip), %rax
	pushq %rax
	movq .csts_i32+0(%rip), %rax
	pushq %rax
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	popq %rdi
	call print_int
	movq .csts_i64+8(%rip), %rax
	pushq %rax
	movq .csts_i64+0(%rip), %rax
	pushq %rax
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	popq %rdi
	call print_int
	popq %rbp
	movq $0, %rax
	ret
convert_i_to_f:
	pushq %rbp
	movq %rsp, %rbp
	movq %rdi, %rax
	popq %rbp
	ret
print_int:
	pushq %rbp
	movq %rdi, %rsi
	leaq .Sprint_int, %rdi
	movq $0, %rax
	call printf
	popq %rbp
	ret
	.data
.Sprint_int:
	.string "%d\n"
.csts_i8:
	.byte 
.csts_i16:
	.word 
.csts_i32:
	.int 2, 1
.csts_i64:
	.quad 2, 1
.csts_f32:
	.float 
.csts_f64:
	.double 
