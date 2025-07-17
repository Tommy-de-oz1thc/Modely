global Radio

extern Radio_US_States, Radio_numbers_2_digit_standard, Radio_numbers_3_digit_standard, Radio_numbers_4_digit_standard
extern main, Radio_cwt_names, Radio_sst_names, Radio_cwops_calls, Radio_cqww_calls, Radio_dit_challenge
extern Radio_comment_qso_phrases, Radio_callsigns
extern _printf, _system, _getch

section .data
	cls_cmd db "cls", 0       ; define the clear screan
    word_info db "Welcome to Radio", 10, 10, 10, 0
    say_words db "Say\\say_text.exe Welcome to Radio. Choose a file to practice with. Or press Escape to go back", 0
    Words_display db "(Esc) Go back", 10
                  db "(a) US-states", 10
				  db "(b) 2 digit", 10
				  db "(c) 3 digit", 10
				  db "(d) 4 digit", 10 
				  db "(e) cwt names", 10
				  db "(f) sst names", 10 
				  db "(g) cwops Calls", 10
				  db "(h) cqww qso", 10
				  db "(i) digit challenger", 10
				  db "(j) comment qso", 10
				  db "(k) Callsigns", 10
				  
	menu_title db 10, "Choose a file:", 10, 10, 0
	menu_prompt db "Choose: ", 0

section .text
Radio:
    ; ryd skærmen (Windows 'cls')
    push cls_cmd
    call _system
	
	push say_words
    call _system
	
vis_words_menu:
    push word_info
    call _printf
    add esp, 4

    push Words_display
	call _printf
	add esp, 4

.wait_input:
    call _getch
    movzx eax, al

    cmp eax, 27         ; ESC
    je main

    cmp eax, 'a'
    je Radio_US_States    
	cmp eax, 'b'
	je Radio_numbers_2_digit_standard
	cmp eax, 'c'
	je Radio_numbers_3_digit_standard
	cmp eax, 'd'
	je Radio_numbers_4_digit_standard
	cmp eax, 'e'
	je Radio_cwt_names
	cmp eax, 'f'
	je Radio_sst_names
	cmp eax, 'g'
	je Radio_cwops_calls
	cmp eax, 'h'
	je Radio_cqww_calls
	cmp eax, 'i'
	je Radio_dit_challenge
	cmp eax, 'j'
	je Radio_comment_qso_phrases
	cmp eax, 'k'
	je Radio_callsigns
	
    jmp .wait_input

.exit:
    ret