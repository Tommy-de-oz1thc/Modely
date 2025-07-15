global Sentences

extern _system, _printf, _getch
extern main, _2_words, _3_words, _4_words, _5_words, _6_words, _7_words, _8_words, Top_100_words, Top_200_words, Top_600_words

section .data
	cls_cmd db "cls", 0       ; define the clear screan
    sentences_info db "Welcome to Sentences", 10, 10, 0
    say_sentences db "Say\\say_text.exe Welcome to Sentences. Choose a file to practice with. Or press Escape to go back", 0
    Sentences_display db "(Esc) Go back", 10
                  db "(1) 2 words", 10
				  db "(2) 3 words", 10
				  db "(3) 4 words", 10 
				  db "(4) 5 words", 10
				  db "(5) 6 words", 10 
				  db "(6) 7 words", 10
				  db "(7) 8 words", 10
				  db "(a) Top 100 words", 10
				  db "(b) Top 200 words", 10
				  db "(c) Top 600 words", 10, 0			  

menu_title db 10, "Choose a file:", 10, 0

menu_prompt db "Choose: ", 0

section .text
Sentences:
    push cls_cmd
    call _system
     
    push say_sentences
    call _system

    push sentences_info
	call _printf
	add esp, 4

    vis_words_menu:
    push menu_title
    call _printf
    add esp, 4

    push Sentences_display
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
    je _2_words
    cmp eax, '2'
	je _3_words
    cmp eax, '3'
	je _4_words
	cmp eax, '4'
	je _5_words
	cmp eax, '5'
	je _6_words
	cmp eax, '6'
	je _7_words
	cmp eax, '7'
	je _8_words
	cmp eax, 'a'
	je Top_100_words
	cmp eax, 'b'
	je Top_200_words
	cmp eax, 'c'
	je Top_600_words
	
    jmp .wait_input


.exit:
    ret




