	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	call .f_main
	popq %rbp
	movq $0, %rax
	ret
.f_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl .csts_i32+0(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl %eax, -20(%rbp)
	movsd .csts_f64+0(%rip), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	movsd %xmm0, -16(%rbp)
	movsd .csts_f64+8(%rip), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	movsd %xmm0, -8(%rbp)
	movsd -16(%rbp), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	call print_double
	movsd -8(%rbp), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	call print_double
	movsd .csts_f64+16(%rip), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	movsd %xmm0, -8(%rbp)
	movsd -16(%rbp), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd -8(%rbp), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	movsd 0(%rsp), %xmm1
	addq $8, %rsp
	addsd %xmm0, %xmm1
	subq $8, %rsp
	movsd %xmm1, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	call print_double
	addq $32, %rsp
	popq %rbp
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
	.int 5
.csts_i64:
	.quad 
.csts_f32:
	.float 
.csts_f64:
	.double 4.000000, 3.200000, 10.000000
.gvar_i8:
	.byte 
.gvar_i16:
	.word 
.gvar_i32:
	.int 
.gvar_i64:
	.quad 
.gvar_f32:
	.float 
.gvar_f64:
	.double 
