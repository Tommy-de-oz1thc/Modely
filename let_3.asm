; === let_3.asm (rettet) ===
global Let_3
%include "powershell.asm"
extern _printf, _scanf, _strcmp, _rand, _getch
extern Letters

%define WORD_COUNT 5

section .data
    words db "Koch CW Test:", 10, 0
    prompt db "Write: ", 0
    correct_txt db "Correct!", 10, 0
    wrong_txt db "Wrong!", 10, 0
    fmt_word db "%s", 0
    input_format db "%s", 0
    cls_cmd db "cls", 0       ; define the clear screan
    
	word1 db "k", 0
    word2 db "m", 0
    word3 db "u", 0
    word4 db "r", 0
    word5 db "e", 0
	word6 db "s", 0
    word7 db "n", 0
    word8 db "a", 0
    word9 db "p", 0
    word10 db "t", 0  

    word_ptrs dd word1, word2, word3, word4, word5
	          dd word6, word7, word8, word9, word10
			  
    failed_txt db "You Failed, you need 4 to Pass!", 10, 0
    passed_txt db "PASS, Congratulation you passed!", 10, 0
    correct_count_fmt db "You had %d correct out of %d.", 10, 0
    Let_1_info db "Lesson 3 letters", 10, 0
	Let_1_link db "Letters(Esc), 3 Level(1): ", 0
	say_letters db "Say\\say_text.exe You choose Level 3", 0
    sent_cw_txt db "I will sent you 5 random letters from Level 3", 10, 0
    keypress      db "Press any key to continue", 0

section .bss
    selected_ptrs resd WORD_COUNT
    used resb WORD_COUNT
    user_input resb 32
    correct_count resd 1

section .text
    

Let_3:
    push cls_cmd
    call _system
	
	push say_letters
    call _system

start:	
    push cls_cmd
    call _system
	
    push Let_1_info
	call _printf
	add esp, 4
	
    push Let_1_link
	call _printf
	add esp, 4
	
	
	.wait_input:
    call _getch
    movzx eax, al

    cmp eax, 27         
    je Letters

    cmp eax, '1'
    je Start_CW
    
   
	
    jmp .wait_input

Start_CW:
    push cls_cmd
    call _system
	
	push sent_cw_txt
	call _printf
	add esp, 4
	
    call _rand
    mov dword [correct_count], 0
    call select_words
    call ask_words
    ret

select_words:
    xor ebx, ebx
    mov ecx, WORD_COUNT
    mov edi, used
    xor eax, eax
    mov eax, edi
    mov ecx, WORD_COUNT
    mov edi, used
    xor eax, eax
    mov ecx, WORD_COUNT
.clear_loop:
    mov byte [edi + eax], 0
    inc eax
    cmp eax, WORD_COUNT
    jne .clear_loop

.select_loop:
    call _rand
    xor edx, edx
    mov ecx, WORD_COUNT
    div ecx
    mov esi, edx
    mov al, [used + esi]
    cmp al, 0
    jne .select_loop

    mov byte [used + esi], 1
    mov eax, [word_ptrs + esi*4]
    mov [selected_ptrs + ebx*4], eax
    inc ebx
    cmp ebx, WORD_COUNT
    jne .select_loop
    ret

ask_words:
    xor edi, edi
ask_loop:
    mov esi, [selected_ptrs + edi*4]
.next_letter:
    mov al, [esi]
    cmp al, 0
    je .done_word

    cmp al, ' '
    jne .check_comma
    push wav_pause_cmd
    call _system
    add esp, 4
    jmp .skip_letter

.check_comma:
    cmp al, ','
    jne .check_question
    push wav_comma_cmd
    call _system
    add esp, 4
    jmp .skip_letter

.check_question:
    cmp al, '?'
    jne .check_alpha
    push wav_question_cmd
    call _system
    add esp, 4
    jmp .skip_letter

.check_alpha:
    cmp al, 'a'
    jl .skip_letter
    cmp al, 'z'
    ja .skip_letter

    sub al, 'a'
    movzx ecx, al
    mov eax, [wav_cmd_ptrs + ecx*4]
    push eax
    call _system
    add esp, 4

.skip_letter:
    inc esi
    jmp .next_letter

.done_word:
    push prompt
    call _printf
    add esp, 4

    lea eax, [user_input]
    push eax
	
    call _getch
	mov [user_input], al       ; gem tegnet
    mov byte [user_input+1], 0 ; null-terminér

    mov eax, [selected_ptrs + edi*4]
    push eax
    lea ebx, [user_input]
    push ebx
    call _strcmp
    add esp, 8

    test eax, eax
    jne .wrong_guess

    push correct_txt
    call _printf
    add esp, 4
    mov eax, [correct_count]
    inc eax
    mov [correct_count], eax
    jmp .next

.wrong_guess:
    push wrong_txt
    call _printf
    add esp, 4

.next:
    inc edi
    cmp edi, WORD_COUNT
    jl ask_loop
    jmp .done

.done:
    ; Vis korrekt antal
    mov eax, [correct_count]
    push WORD_COUNT       ; maks antal
    push eax              ; korrekte svar
    push correct_count_fmt
    call _printf
    add esp, 12


    ; Tjek om brugeren bestod (mindst 4 rigtige fx)
    mov eax, [correct_count]
    cmp eax, 4
    jl .failed

    push passed_txt
    call _printf
    add esp, 4
    jmp .exit

.failed:
    push failed_txt
    call _printf
    add esp, 4

.exit:
    push keypress
	call _printf
	add esp, 4
    
	call _getch
    
	jmp start
