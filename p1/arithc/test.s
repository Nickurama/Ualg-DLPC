	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $10, %rax
	pushq %rax
	movq $15, %rax
	pushq %rax
	movq -8(%rsp), %rax
	pushq %rax
	movq $5, %rax
	pushq %rax
	popq %rax
	popq %rdi
	addq %rdi, %rax
	pushq %rax
	popq %rdi
	call print_int
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
.Sprint_int:
	.string "%d\n"
