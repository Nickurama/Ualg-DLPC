```assembly
        .text
        .globl  main
main:
        ## true && false
        mov     $1, %rdi
        test    %rdi, %rdi
        jz      .T0             # o operasdor && é "lazy"
        mov     $0, %rdi
.T0:
        call    print_bool

        ## if 3 <> 4 then 10 * 2 else 14
        mov     $3, %rdi
        cmp     $4, %rdi
        je      .T1false
        mov     $10, %rdi
        imul    $2, %rdi
        jmp     .T1
.T1false:
        mov     $14, %rdi
.T1:
        call    print_int

        ## 2 = 3 || 4 <= 2*3
        mov     $2, %rdi
        cmp     $3, %rdi
        sete    %dil
        movzbq  %dil, %rdi      # movzbq = mov with zero extension
        test    %rdi, %rdi
        jnz     .T2             # a operação || é "lazy"
        mov     $4, %rbx
        mov     $2, %rcx
        imul    $3, %rcx
        cmp     %rcx, %rbx      # CUIDADO com o sentido !
        setle   %bl
        movzbq  %bl, %rdi
.T2:
        call    print_bool

	mov     $0, %rax        # Termona-se convenientemente
        ret

        ## uma rotina para mostrar um inteiro (%rdi) com printf
print_int:
        mov     %rdi, %rsi
        mov     $message, %rdi  # parâmetros para printf
        mov     $0, %rax
        call    printf
        ret

        ## uma rotina para mostrar um booleano (%rdi) com printf
print_bool:
        cmp     $0, %rdi
        je      .Lfalse
        mov     $true, %rdi
        jmp     .Lprint
.Lfalse:
        mov     $false, %rdi
.Lprint:
        mov     $0, %rax
        call    printf
        ret

        .data
message:
        .string "%d\n"
true:
        .string "true\n"
false:
        .string "false\n"

## Local Variables:
## compile-command: "gcc -no-pie bool.s && ./a.out"
## End:
```