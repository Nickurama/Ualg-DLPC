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
	cvtsi2sdl %eax, %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	movsd %xmm0, .gvar_f64+0(%rip)
	call .f_main
	popq %rbp
	movq $0, %rax
	ret
.f_funcuwu:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl 16(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl .csts_i32+4(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl 0(%rsp), %edi
	addq $4, %rsp
	addl %edi, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl %eax, -4(%rbp)
	movl -4(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	addq $16, %rsp
	popq %rbp
	ret
	addq $16, %rsp
	popq %rbp
	ret
.f_func_owo:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movsd 16(%rbp), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movl .csts_i32+8(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	cvtsi2sdl %eax, %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	movsd 0(%rsp), %xmm1
	addq $8, %rsp
	divsd %xmm0, %xmm1
	subq $8, %rsp
	movsd %xmm1, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	cvttsd2si %xmm0, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	addq $16, %rsp
	popq %rbp
	ret
	addq $16, %rsp
	popq %rbp
	ret
.f_owo:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	addq $16, %rsp
	popq %rbp
	ret
.f_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	subq $16, %rsp
	call .f_owo
	addq $16, %rsp
	movsd .gvar_f64+0(%rip), %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	subq $12, %rsp
	movl .csts_i32+8(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	call .f_funcuwu
	addq $16, %rsp
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	cvtsi2sdl %eax, %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	movsd 0(%rsp), %xmm0
	addq $8, %rsp
	movsd 0(%rsp), %xmm1
	addq $8, %rsp
	addsd %xmm0, %xmm1
	subq $8, %rsp
	movsd %xmm1, 0(%rsp)
	subq $8, %rsp
	movl .csts_i32+12(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	cvtsi2sdl %eax, %xmm0
	subq $8, %rsp
	movsd %xmm0, 0(%rsp)
	call .f_func_owo
	addq $16, %rsp
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	cvtsi2sdl %eax, %xmm0
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
	.int 3, 1, 2, 6
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
	.quad 
.gvar_f32:
	.float 
.gvar_f64:
	.double 0.000000
