	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	movl .csts_i32+0(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movslq %eax, %rax
	pushq %rax
	movq .csts_i64+0(%rip), %rax
	pushq %rax
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	popq %rax
	cvtsi2ssq %rax, %xmm0
	subq $4, %rsp
	movss %xmm0, 0(%rsp)
	movss 0(%rsp), %xmm0
	addq $4, %rsp
	movss %xmm0, .gvar_f32+0(%rip)
	movss .gvar_f32+0(%rip), %xmm0
	subq $4, %rsp
	movss %xmm0, 0(%rsp)
	movss 0(%rsp), %xmm0
	addq $4, %rsp
	call print_float
	popq %rbp
	movq $0, %rax
	ret
print_int:
	pushq %rbp
	movq %rsp, %rbp
	movq %rdi, %rsi
	leaq .Sprint_int, %rdi
	movq $0, %rax
	call printf
	popq %rbp
	ret
print_long:
	pushq %rbp
	movq %rsp, %rbp
	movq %rdi, %rsi
	leaq .Sprint_long, %rdi
	movq $0, %rax
	call printf
	popq %rbp
	ret
print_float:
	pushq %rbp
	movq %rsp, %rbp
	cvtss2sd %xmm0, %xmm0
	leaq .Sprint_float, %rdi
	movq $1, %rax
	call printf
	popq %rbp
	ret
print_double:
	pushq %rbp
	movq %rsp, %rbp
	leaq .Sprint_double, %rdi
	movq $1, %rax
	call printf
	popq %rbp
	ret
	.data
.Sprint_int:
	.string "%d\n"
.Sprint_long:
	.string "%ld\n"
.Sprint_float:
	.string "%f\n"
.Sprint_double:
	.string "%lf\n"
.csts_i8:
	.byte 
.csts_i16:
	.word 
.csts_i32:
	.int 2147483647
.csts_i64:
	.quad 1
.csts_f32:
	.float 
.csts_f64:
	.double 
.gvar_i8:
	.byte 
.gvar_i16:
	.word 
.gvar_i32:
	.int 
.gvar_i64:
	.quad 
.gvar_f32:
	.float 0.000000
.gvar_f64:
	.double 
