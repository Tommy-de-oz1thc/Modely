global Letters

extern _system, _printf, _getch
extern main, Let_1, Let_2, Let_3, Let_4, Let_5, Let_6, Let_7, Let_8, Let_9, Let_10, Let_11, Let_12, Let_13, Let_14, Let_15

section .data
	cls_cmd db "cls", 0       ; define the clear screan
    sentences_info db "Welcome to Letters", 10, 10, 0
    say_letters db "Say\\say_text.exe Welcome to Letters. Choose a file to practice with. Or press Escape to go back", 0
    Sentences_display db "(Esc) Go back", 10
                      db "(a) kmure", 10
					  db "(b) snapt", 10
				      db "(c) kmuresnapt", 10 
				      db "(d) lowij", 10
				      db "(e) kmuresnaptlowij", 10 
				      db "(f) hxdbc", 10
				      db "(g) kmuresnaptlowijhxdbc", 10
				      db "(h) ygzqf", 10
				      db "(i) kmuresnaptlowijhxdbcygzqf", 10
				      db "(j) v5432", 10 	
				      db "(k) kmuresnaptlowijhxdbcygzqfv5432", 10	
					  db "(l) 16789", 10 	
					  db "(m) kmuresnaptlowijhxdbcygzqfv543216789", 10 	
					  db "(n) 0?/=.", 10
					  db "(o) ALL Letters", 10, 0

menu_title db 10, "Choose a file:", 10, 0

menu_prompt db "Choose: ", 0


section .text

Letters:
    push cls_cmd
    call _system
     
    push say_letters
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

    cmp eax, 'a'
    je Let_1
    cmp eax, 'b'
    je Let_2
	cmp eax, 'c'
    je Let_3
	cmp eax, 'd'
    je Let_4
	cmp eax, 'e'
    je Let_5
	cmp eax, 'f'
    je Let_6
	cmp eax, 'g'
    je Let_7
	cmp eax, 'h'
    je Let_8
	cmp eax, 'i'
    je Let_9
	cmp eax, 'j'
    je Let_10
	cmp eax, 'k'
    je Let_11
	cmp eax, 'l'
    je Let_12
	cmp eax, 'm'
    je Let_13
	cmp eax, 'n'
    je Let_14
	cmp eax, 'o'
    je Let_15
	
    jmp .wait_input


.exit:
    ret











