global PlayRandomWordsFromFile
extern _printf, _scanf, _fopen, _fgets, _strcmp, _getch, _srand, _rand, _time
extern _strcpy, _system
extern selected_file


section .data

wav_a_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\a.wav").PlaySync()', 0
wav_b_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\b.wav").PlaySync()', 0
wav_c_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\c.wav").PlaySync()', 0
wav_d_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\d.wav").PlaySync()', 0
wav_e_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\e.wav").PlaySync()', 0
wav_f_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\f.wav").PlaySync()', 0
wav_g_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\g.wav").PlaySync()', 0
wav_h_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\h.wav").PlaySync()', 0
wav_i_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\i.wav").PlaySync()', 0
wav_j_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\j.wav").PlaySync()', 0
wav_k_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\k.wav").PlaySync()', 0
wav_l_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\l.wav").PlaySync()', 0
wav_m_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\m.wav").PlaySync()', 0
wav_n_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\n.wav").PlaySync()', 0
wav_o_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\o.wav").PlaySync()', 0
wav_p_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\p.wav").PlaySync()', 0
wav_q_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\q.wav").PlaySync()', 0
wav_r_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\r.wav").PlaySync()', 0
wav_s_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\s.wav").PlaySync()', 0
wav_t_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\t.wav").PlaySync()', 0
wav_u_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\u.wav").PlaySync()', 0
wav_v_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\v.wav").PlaySync()', 0
wav_w_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\w.wav").PlaySync()', 0
wav_x_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\x.wav").PlaySync()', 0
wav_y_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\y.wav").PlaySync()', 0
wav_z_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\z.wav").PlaySync()', 0

wav_cmd_ptrs:
    dd wav_a_cmd, wav_b_cmd, wav_c_cmd, wav_d_cmd, wav_e_cmd
    dd wav_f_cmd, wav_g_cmd, wav_h_cmd, wav_i_cmd, wav_j_cmd
    dd wav_k_cmd, wav_l_cmd, wav_m_cmd, wav_n_cmd, wav_o_cmd
    dd wav_p_cmd, wav_q_cmd, wav_r_cmd, wav_s_cmd, wav_t_cmd
    dd wav_u_cmd, wav_v_cmd, wav_w_cmd, wav_x_cmd, wav_y_cmd, wav_z_cmd
	
    read_mode db "r", 0
    max_words equ 100
    max_len equ 32
    word_array times max_words db 0

    cls_cmd db "cls", 0
   header_txt    db "CW Test - Listen and guess the word!", 10, 0
prompt_txt    db "Your guess: ", 0
input_format  db "%s", 0
correct_txt   db "Correct!", 10, 0
wrong_txt     db "Wrong!", 10, 0
result_txt    db "You had %d correct.", 10, 0
pass_txt      db "Access granted!", 10, 0
fail_txt      db "Sorry, you did not get enough correct.", 10, 0
fejl_open_file_txt db "File not open", 0
open_file_text db "File is open", 0
  press_txt db "Press any key to continue...", 10, 0
debug_fmt db "Word: %s", 10, 0
letter_fmt db " %c", 0

    input_buffer db 32 dup(0)

section .bss
    file_ptr resd 1
    words resd max_words
    word_storage resb max_words * max_len
    correct_count resd 1

section .text
PlayRandomWordsFromFile:
    ; clear screen
    push cls_cmd
    call _system

    ; print overskrift
    push header_txt
    call _printf
    add esp, 4

    ; åbn fil
    push read_mode
  ; Udskriv valgt filnavn
push selected_file
push debug_fmt           ; debug_fmt db "Word: %s", 10, 0
call _printf
add esp, 8

; Åbn filen
push read_mode           ; read_mode db "r", 0
push selected_file
call _fopen
add esp, 8
mov [file_ptr], eax

; Tjek om filen blev åbnet korrekt
cmp eax, 0
je .file_error
push open_file_text
call _printf
add esp, 4


   call _getch
   

    ; init srand
    call _time
    movzx eax, al
    push eax

    call _srand
    add esp, 4
 
    ; læs ord
    xor edi, edi
.read_loop:
    cmp edi, max_words
    jge .done_reading

    ; korrekt beregning af adresse
    mov eax, edi
    imul eax, max_len
    mov esi, word_storage
    add esi, eax

    push dword [file_ptr]       ; FILE *stream
push max_len                ; int n
push esi                    ; char *str
call _fgets
add esp, 12

    add esp, 8
    test eax, eax
    jz .done_reading

    ; fjern newline
    mov ecx, esi
.find_nl:
    cmp byte [ecx], 0
    je .store_word
    cmp byte [ecx], 10
    je .zero_it
    inc ecx
    jmp .find_nl
.zero_it:
    mov byte [ecx], 0

.store_word:
    ; korrekt adresse igen
    mov eax, edi
    imul eax, max_len
    add eax, word_storage
    mov [words + edi*4], eax
    inc edi
    jmp .read_loop
.done_reading:
    ; spil 10 ord
    xor esi, esi
    xor ecx, ecx
    mov [correct_count], ecx
	


	
.play_loop:
    cmp esi, 10
    jge .done_test

    ; vælg tilfældigt ord
    call _rand
    xor edx, edx
    mov ecx, edi
    div ecx
    mov eax, edx
    mov ebx, [words + eax*4]

    ; vis ordet (debug)
    push ebx
    push debug_fmt
    call _printf
    add esp, 8

    ; vent på tast – bare så man kan se ordet
    call _getch

   ; (Midlertidig test – vis bogstaver ét for ét uden lyd)
mov edi, ebx

.print_letters:
push ebx
push debug_fmt
call _printf
add esp, 8
call _getch
    mov al, [edi]
    cmp al, 0
    je .done_print_letters
    movzx eax, al         ; ← Rigtig løsning
    push eax
    push letter_fmt
    call _printf
    add esp, 8
    inc edi
    jmp .print_letters
.done_print_letters:




.done_playing:
    ; gæt ordet
    push prompt_txt
    call _printf
    add esp, 4

    push input_buffer
    push input_format
    call _scanf
    add esp, 8

    push ebx
    push input_buffer
    call _strcmp
    add esp, 8
    test eax, eax
    jnz .wrong

    push correct_txt
    call _printf
    add esp, 4
    mov eax, [correct_count]
    inc eax
    mov [correct_count], eax
    jmp .next

.wrong:
    push wrong_txt
    call _printf
    add esp, 4

.next:
    inc esi
    call _getch
    jmp .play_loop

.done_test:
    ; vis resultat
    push dword [correct_count]
    push result_txt
    call _printf
    add esp, 8

    mov eax, [correct_count]
    cmp eax, 5
    jl .fail
    push pass_txt
    call _printf
    add esp, 4
    jmp .after
.fail:
    push fail_txt
    call _printf
    add esp, 4

.after:
    push press_txt
    call _printf
    add esp, 4
    call _getch
    ret

.file_error:
    push fejl_open_file_txt
    call _printf
    add esp, 4
    call _getch
    ret
