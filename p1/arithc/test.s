	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	popq %rdi
	call print_int
	movq $100, %rax
	pushq %rax
	movq $2, %rax
	pushq %rax
	popq %rax
	popq %rdi
	movq %rax, %rsi
	movq %rdi, %rax
	cqto
	idivq %rsi
	pushq %rax
	popq %rdi
	call print_int
	movq $2, %rax
	pushq %rax
	movq $100, %rax
	pushq %rax
	popq %rax
	popq %rdi
	movq %rax, %rsi
	movq %rdi, %rax
	cqto
	idivq %rsi
	pushq %rax
	popq %rdi
	call print_int
	movq $10, %rax
	pushq %rax
	movq 0(%rsp), %rax
	pushq %rax
	popq %rdi
	call print_int
	movq 8(%rsp), %rax
	pushq %rax
	movq 8(%rsp), %rax
	pushq %rax
	movq $1, %rax
	pushq %rax
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	popq %rax
	popq %rdi
	imulq %rdi, %rax
	pushq %rax
	movq $2, %rax
	pushq %rax
	popq %rax
	popq %rdi
	movq %rax, %rsi
	movq %rdi, %rax
	cqto
	idivq %rsi
	pushq %rax
	movq 0(%rsp), %rax
	pushq %rax
	popq %rdi
	call print_int
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	popq %rdi
	call print_int
	movq $20, %rax
	pushq %rax
	movq 8(%rsp), %rax
	pushq %rax
	popq %rdi
	call print_int
	movq 8(%rsp), %rax
	pushq %rax
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	movq 8(%rsp), %rax
	pushq %rax
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	movq 8(%rsp), %rax
	pushq %rax
	popq %rdi
	call print_int
	popq %rax
	popq %rax
	popq %rbp
	movq $0, %rax
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
x:
	.quad 1
y:
	.quad 1
.Sprint_int:
	.string "%d\n"
