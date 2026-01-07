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
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq 0(%rsp), %rax
	addq $8, %rsp
	movq %rax, .gvar_i64+0(%rip)
	call .f_main
	popq %rbp
	movq $0, %rax
	ret
.f_func:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl .csts_i32+4(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl %eax, -4(%rbp)
	movl -4(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
	addq $16, %rsp
	popq %rbp
	ret
.f_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl .csts_i32+8(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movslq %eax, %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq 0(%rsp), %rax
	addq $8, %rsp
	movq %rax, -12(%rbp)
	movl .csts_i32+4(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movslq %eax, %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq 0(%rsp), %rax
	addq $8, %rsp
	movq %rax, -12(%rbp)
	movl .csts_i32+4(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl %eax, -4(%rbp)
	movq -12(%rbp), %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq 0(%rsp), %rdi
	addq $8, %rsp
	call print_long
	addq $16, %rsp
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
	.int 23, 5, 2
.csts_i64:
	.quad 
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
	.quad 0
.gvar_f32:
	.float 
.gvar_f64:
	.double 
