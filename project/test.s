	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	call .f_main
	popq %rbp
	movq $0, %rax
	ret
.f_func_uwu:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl 16(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl .csts_i32+0(%rip), %eax
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
	movl .csts_i32+4(%rip), %eax
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
.f_bool_test:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.if_bool_test_0_0:
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
	cmpl %eax, %edi
	setl %al
	movzbl %al, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	test %eax, %eax
	jz .if_bool_test_0_1
	movl .csts_i32+4(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
	jmp .if_bool_test_0_end
.if_bool_test_0_1:
	movl 16(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl .csts_i32+8(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl 0(%rsp), %edi
	addq $4, %rsp
	cmpl %eax, %edi
	setl %al
	movzbl %al, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	test %eax, %eax
	jz .if_bool_test_0_2
	movl .csts_i32+8(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
	jmp .if_bool_test_0_end
.if_bool_test_0_2:
	movl 16(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl .csts_i32+12(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl 0(%rsp), %edi
	addq $4, %rsp
	cmpl %eax, %edi
	setl %al
	movzbl %al, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	test %eax, %eax
	jz .if_bool_test_0_3
	movl .csts_i32+12(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
	jmp .if_bool_test_0_end
.if_bool_test_0_3:
	movl 16(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl .csts_i32+16(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl 0(%rsp), %edi
	addq $4, %rsp
	cmpl %eax, %edi
	setl %al
	movzbl %al, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	test %eax, %eax
	jz .if_bool_test_0_4
	movl .csts_i32+16(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
	jmp .if_bool_test_0_end
.if_bool_test_0_4:
	movl .csts_i32+20(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
.if_bool_test_0_end:
	addq $16, %rsp
	popq %rbp
	ret
.f_fact:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
.if_fact_0_0:
	movq 16(%rbp), %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
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
	movq 0(%rsp), %rdi
	addq $8, %rsp
	cmpq %rax, %rdi
	setle %al
	movzbl %al, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	test %eax, %eax
	jz .if_fact_0_end
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
	addq $16, %rsp
	popq %rbp
	ret
	jmp .if_fact_0_end
.if_fact_0_end:
	movq 16(%rbp), %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	subq $8, %rsp
	movq 16(%rbp), %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
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
	movq 0(%rsp), %rdi
	addq $8, %rsp
	subq %rax, %rdi
	movq %rdi, %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	call .f_fact
	addq $16, %rsp
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq 0(%rsp), %rax
	addq $8, %rsp
	movq 0(%rsp), %rdi
	addq $8, %rsp
	imulq %rdi, %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq 0(%rsp), %rax
	addq $8, %rsp
	addq $16, %rsp
	popq %rbp
	ret
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
	movl .csts_i32+24(%rip), %eax
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
	subq $12, %rsp
	movl .csts_i32+4(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	call .f_func_uwu
	addq $16, %rsp
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
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
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
	movq .csts_i64+8(%rip), %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq .csts_i64+0(%rip), %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq 0(%rsp), %rax
	addq $8, %rsp
	movq 0(%rsp), %rdi
	addq $8, %rsp
	cmpq %rax, %rdi
	sete %al
	movzbl %al, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl .csts_i32+28(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl 0(%rsp), %edi
	addq $4, %rsp
	cmpl %eax, %edi
	test %eax, %eax
	sete %al
	movzbl %al, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
	subq $12, %rsp
	movl .csts_i32+20(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	call .f_bool_test
	addq $16, %rsp
	subq $8, %rsp
	movl .csts_i32+8(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movslq %eax, %rax
	subq $8, %rsp
	movq %rax, 0(%rsp)
	call .f_fact
	addq $16, %rsp
	subq $8, %rsp
	movq %rax, 0(%rsp)
	movq 0(%rsp), %rdi
	addq $8, %rsp
	call print_long
	movl .csts_i32+32(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl %eax, -4(%rbp)
.while_main_0_start:
	movl -4(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl .csts_i32+28(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl 0(%rsp), %edi
	addq $4, %rsp
	cmpl %eax, %edi
	setge %al
	movzbl %al, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	test %eax, %eax
	jz .while_main_0_end
	movl -4(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %edi
	addq $4, %rsp
	call print_int
	movl -4(%rbp), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl .csts_i32+0(%rip), %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl 0(%rsp), %edi
	addq $4, %rsp
	subl %eax, %edi
	movl %edi, %eax
	subq $4, %rsp
	movl %eax, 0(%rsp)
	movl 0(%rsp), %eax
	addq $4, %rsp
	movl %eax, -4(%rbp)
	jmp .while_main_0_start
.while_main_0_end:
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
	.int 1, 2, 4, 6, 8, 10, 3, 0, 5
.csts_i64:
	.quad 1, 2
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
	.double 
