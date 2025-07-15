global Words

extern _system, _printf, _getch
extern PlayRandomWordsFromFile
extern selected_file
extern _strcpy
extern main, _3_letters, _3_4_letters, _3_5_letters, _4_letters, _4_5_letters, _5_letters, _4_6_letters, _5_6_letters, _6_letters, Top_100, Top_200, Top_500

section .data
	cls_cmd db "cls", 0       ; define the clear screan
    word_info db "Welcome to Words", 10, 10, 10, 0
    say_words db "Say\\say_text.exe Welcome to Words. Choose a file to practice with. Or press Escape to go back", 0
    Words_display db "(Esc) Go back", 10
                  db "(1) 3 letters", 10
				  db "(2) 3-4 letters", 10
				  db "(3) 3-5 letters", 10
				  db "(4) 4 letters", 10 
				  db "(5) 4-5 letters", 10
				  db "(6) 5 letters", 10 
				  db "(7) 4-6 letters", 10
				  db "(8) 5-6 letters", 10
				  db "(9) 6 letters", 10
				  db "(a) Top 100", 10
				  db "(b) Top 200", 10
				  db "(c) Top 500", 10, 0
	menu_title db 10, "Choose a file:", 10, 10, 0
	menu_prompt db "Choose: ", 0

section .text

Words:
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

    push menu_prompt
    call _printf
    add esp, 4


.wait_input:
    call _getch
    movzx eax, al

    cmp eax, 27         ; ESC
    je main

    cmp eax, '1'
    je _3_letters    
	cmp eax, '2'
	je _3_4_letters 
	cmp eax, '3'
	je _3_5_letters
	cmp eax, '4'
	je _4_letters
	cmp eax, '5'
	je _4_5_letters
	cmp eax, '6'
	je _5_letters
	cmp eax, '7'
	je _4_6_letters
	cmp eax, '8'
	je _5_6_letters
	cmp eax, '9'
	je _6_letters
	cmp eax, 'a'
	je Top_100
	cmp eax, 'b'
	je Top_200
	cmp eax, 'c'
	je Top_500
	
    jmp .wait_input

.exit:
    ret

	
	
	
	