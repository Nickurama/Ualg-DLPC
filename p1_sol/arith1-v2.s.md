```assembly
        ## calculamos com a pilha

	.text
        .globl  main
main:
        pushq   $4              # 4 + 6
	pushq   $6
        popq    %rdi
        popq    %rbx
        add     %rbx, %rdi
        call    print_int

        pushq   $21             # 21 * 2
        pushq   $2
        popq    %rdi
        popq    %rbx
        imul    %rbx, %rdi
        call    print_int

        pushq   $4              # 4 + 7 / 2
        pushq   $7
        pushq   $2
        popq    %rbx
        mov     $0, %rdx
        popq    %rax
        idivq   %rbx            # divide %rdx::%rax por %rbx
        pushq   %rax            # o quotiente está em %rax
        popq    %rbx
        popq    %rdi
        add     %rbx, %rdi
        call    print_int

        pushq   $3              # 3 - 6 * (10 / 5)
        pushq   $6
        pushq   $10
        pushq   $5
        popq    %rbx
        mov     $0, %rdx
        popq    %rax
        idivq   %rbx            # divide %rdx::%rax por %rbx dem %rax
        pushq   %rax
        popq    %rbx
        popq    %rax
        imul    %rbx, %rax
        pushq   %rax
        popq    %rbx
        popq    %rdi
        sub     %rbx, %rdi
        call    print_int
        
				mov     $0, %rax        # termina-se de forma conveniente
        ret

        ## uma rotina para mostrar um inteiro (%rdi) com printf
print_int:
        mov     %rdi, %rsi
        mov     $message, %rdi  # argumentos para printf
        mov     $0, %rax
        call    printf
        ret

	.data
message:
	.string "%d\n"

## Local Variables:
## compile-command: "gcc arith1-v2.s && ./a.out"
## End:
```