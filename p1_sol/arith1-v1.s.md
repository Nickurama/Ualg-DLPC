```assembly
        ## calculamos para %rsi, porque é o segundo parâmetro para printf

	.text
        .globl  main
main:
        mov     $4, %rdi        # 4 + 6
	add     $6, %rdi
        call    print_int

        mov     $21, %rdi       # 21 * 2
        imul    $2, %rdi
        call    print_int

        mov     $21, %rdi       # ou alternativamente com uma operação de shift
        sal     $1, %rdi
        call    print_int

        mov     $0, %rdx        # 4 + 7 / 2
        mov     $7, %rax
        mov     $2, %rbx
        idivq   %rbx            # divide %rdx::%rax por %rbx, dem %rax
        mov     $4, %rdi
        add     %rax, %rdi
        call    print_int

        mov     $7, %rdi        # ou alternativamente com um shift
        sar     $1, %rdi
        add     $4, %rdi
        call    print_int

        mov     $0, %rdx        # 3 - 6 * (10 / 5)
        mov     $10, %rax
        mov     $5, %rbx
        idivq   %rbx            # divide %rdx::%rax por %rbx em %rax
        imul    $6, %rax
        mov     $3, %rdi
        sub     %rax, %rdi
        call    print_int

				mov     $0, %rax        # concluimos de forma conveniente
        ret

        ## uma rotina para mostrar um inteiro (%rdi) com printf
print_int:
        mov     %rdi, %rsi
        mov     $message, %rdi  # parâmetros para printf
        mov     $0, %rax
        call    printf
        ret

	.data
message:
	.string "%d\n"


## Local Variables:
## compile-command: "gcc -no-pie arith1-v1.s && ./a.out"
## End:
```