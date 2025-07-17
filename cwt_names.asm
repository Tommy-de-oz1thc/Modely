
global Radio_cwt_names
extern _strcmp
extern  _printf, _getch, _rand, _srand, _time, _system, _putchar
extern _scanf, choose, current_room, retur_value
extern show_text, Radio
extern system


section .data
    
	%include "db\\cwt_names-db.asm"
%include "powershell.asm"



play_cmd   db "play cwplay wait", 0
close_cmd  db "close cwplay", 0

info_txt   db "Radio US States",10,0
go_to_txt db "Radio(1), CWT Names(2): ", 0
cw_txt     db "I sent you 10 sentences to answer: ", 10, 0
fmt_word   db "%s ",10, 0
cls_cmd    db "cls",0
input_format  db "%s", 0
input_prompt  db "Type your answer: ", 0
correct_txt   db "Well done!", 10, 0
wrong_txt     db "Oops! That's not it.", 10, 0
keypress      db "Press any key to continue", 0
choose_format db "%d", 0
result_txt db "You have %d correct!", 10, 0
not_enough_txt db "You Failed, you need 6 to Pass!", 10, 0
pass_txt db "PASS, Congratulation you passed!", 10, 0
say_sentences db "Say\\say_text.exe You choosed cwt names", 0


section .bss
    used          resb 25        ; 0/1-flags for allerede valgte ord
selected_ptrs resd 10        ; plads til 10 pointere
cur_time      resd 1         ; buffer til time()
user_input    resb 32
correct_count  resd 1

section .text
    

Radio_cwt_names:
    push cls_cmd
    call _system
	
	push say_sentences
    call _system

start:	
    push cls_cmd
    call _system
	
    push info_txt
	call _printf
	add esp, 4
	
    push go_to_txt
	call _printf
	add esp, 4
	
	
	.wait_input:
    call _getch
    movzx eax, al

    cmp eax, '1'         
    je Radio

    cmp eax, '2'
    je Start_CW
    
   
	
    jmp .wait_input

Start_CW:	
	mov ecx, 25
    xor eax, eax
	
	
clr_loop:
    mov [used + ecx - 1], al
    loop clr_loop

    ; seed rand()
    lea  eax,[cur_time]
    push eax
    call _time
    add  esp,4
    mov  eax,[cur_time]
    push eax
    call _srand
    add  esp,4

    push cls_cmd
    call _system
    add  esp,4

    push cw_txt      ; eller ny tekst fx: "CW færdig – tilbage til spillet"
    call _printf
    add  esp,4

   

    ; vælg 10 unikke ord
    xor ebx, ebx        ; valgt antal ord = 0
select_loop:
    call _rand
    xor edx, edx
    mov ecx, 25
    div ecx             ; edx = rand() % 25
    mov esi, edx

    cmp byte [used + esi], 1
    je select_loop

    mov byte [used + esi], 1
    mov eax, [word_ptrs + esi*4]
    mov [selected_ptrs + ebx*4], eax

    inc ebx
    cmp ebx, 10
    jne select_loop

        xor edi, edi

ask_loop:
        ; hent pointer til ord og find index
    mov eax, [selected_ptrs + edi*4]  ; pointer til ord
    mov ecx, 0

find_wav_index:
    cmp ecx, 25
    jge skip_play
    mov ebx, [word_ptrs + ecx*4]
    cmp eax, ebx
    je play_wav
    inc ecx
    jmp find_wav_index

play_wav:
    push esi
    push edi
    push ecx

    mov esi, eax        ; pointer til ordet
.next_letter:
    mov al, [esi]
    cmp al, 0
    je .done

    cmp al, ' '
    jne .check_letter

    ; Det er et mellemrum → afspil pause
    push wav_pause_cmd
    call _system
    add esp, 4
    jmp .skip_letter

.check_letter:
    cmp al, '.'
    jne .check_comma
    ; Punktum → afspil dot.wav
    push wav_dot_cmd
    call _system
    add esp, 4
    jmp .skip_letter

.check_comma:
    cmp al, ','
    jne .check_alpha
    ; Komma → afspil comma.wav
    push wav_comma_cmd
    call _system
    add esp, 4
    jmp .skip_letter
	
.check_question:
    cmp al, '?'
    jne .check_alpha
    ; Komma → afspil comma.wav
    push wav_question_cmd
    call _system
    add esp, 4
    jmp .skip_letter

.check_alpha:
    cmp al, 'A'
    jl .not_upper
    cmp al, 'Z'
    jg .not_upper
    add al, 32        ; konverter til lille bogstav

.not_upper:


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



.done:
    pop ecx
    pop edi
    pop esi
    jmp skip_play   ; <-- fortsæt til næste trin i ask_loop




skip_play:

    ; vis ét ord
    mov eax, [selected_ptrs + edi*4]
    push eax
	
	mov al, [show_text]
    cmp al, 1
    jne .skip_text
	
    push fmt_word
    call _printf
    add esp, 8

.skip_text:
    ; bed om gæt
    push input_prompt
    call _printf
    add esp, 4

    ; læs brugerens gæt
lea eax, [user_input]
push eax
push input_format
call _scanf
add esp, 8

; Fjern newline eller mellemrum til sidst
lea esi, [user_input]
.trim_loop:
    mov al, [esi]
    cmp al, 0
    je .done_trim
    cmp al, 10       ; line feed
    je .trim
    cmp al, ' '
    je .trim
    inc esi
    jmp .trim_loop

.trim:
    mov byte [esi], 0
    jmp .done_trim

.done_trim:

; sammenlign brugerens input med det rigtige ord
mov eax, [selected_ptrs + edi*4]
push eax
lea ebx, [user_input]
push ebx
call _strcmp
add esp, 8


    test eax, eax
    jne wrong_guess

    push correct_txt
    call _printf
    add esp, 4
	mov eax, [correct_count]
    inc eax
    mov [correct_count], eax
    jmp next_word

wrong_guess:
    push wrong_txt
    call _printf
    add esp, 4

next_word:
    inc edi
    cmp edi, 10
    jl ask_loop
	mov eax, [correct_count]
    push eax
    push result_txt
    call _printf
    add esp, 8
    ; Tjek om spilleren har mere end 6 rigtige
    mov eax, [correct_count]
    cmp eax, 6
    jl not_enough


pass:
    push pass_txt
    call _printf
    add esp, 4
	push keypress
	
	call _printf
	add esp, 4
	call _getch
    jmp Radio_cwt_names
    


 
not_enough:
    ; Udskriv besked hvis der ikke er nok rigtige
    push not_enough_txt
    call _printf
    add esp, 4

	push keypress
	call _printf
	add esp, 4
	
