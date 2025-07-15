global main
global selected_file

extern _system, _printf, _getch
extern Letters, Words, Sentences, Info

section .data
	cls_cmd db "cls", 0       ; define the clear screan
	choose_format db "%d", 0  ; define the choose value
	intro_line1 db "+------------------------------------------+", 10, 0
	intro_line2 db "|  WELCOME TO CW Modely morsecode program  |", 10, 0
	intro_line3 db "|  Made by Tommy Clemmensen *OZ1THC* 2025  |", 10, 0
	intro_line4 db "|  coded in NASM Assembly - Version 1.0    |", 10, 0
	intro_line5 db "+------------------------------------------+", 10, 0
	press_key_txt db "Exit (Esc), Letters(l), Words(w), Sentences(s), Info(i)", 0
	
	say_cmd db "Say\\say_text.exe Welcome to CW Modely. Press w for words or s for sentences to start.", 0
	say_exit db "Say\\say_text.exe You have exit the program.", 0
	
section .bss
    choose resd 1
	selected_file resd 1
		
section .text

show_intro_box:
    push intro_line1
    call _printf
    add esp, 4

    push intro_line2
    call _printf
    add esp, 4

    push intro_line3
    call _printf
    add esp, 4

    push intro_line4
    call _printf
    add esp, 4

    push intro_line5
    call _printf
    add esp, 4  

    ret

main:
    push cls_cmd
    call _system

    call show_intro_box
     
    push say_cmd
    call _system

start:
    
	push press_key_txt
	call _printf
	add esp, 4

    call _getch
    movzx eax, al
	cmp eax, 27
	je exit
	cmp eax, 'l'
    je Letters
    cmp eax, 'w'
    je Words
    cmp eax, 's'
    je Sentences
    cmp eax, 'i'
    je Info
	
	push cls_cmd
    call _system
	
	call show_intro_box
	
    jmp start



slut:
    push cls_cmd            ; clear screan
    call _system
    jmp start
	
exit:
    push say_exit
    call _system
	ret