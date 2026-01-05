	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $1, %rax
	pushq %rax
	movq $100, %rax
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
