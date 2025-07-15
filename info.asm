global Bedroom
global Info
extern main
extern _printf, _scanf, _getch, _system
extern choose, map_found, map_tip
extern _fopen, _fprintf, _fclose, _fgets
extern retur_value, current_room

section .data
    text_bedroom db "You are now in the bedroom", 10, 0  
    cls_cmd db "cls", 0       ; define the clear screan
    choose_format db "%d", 0
	promptbedroom db "Menu(1), Read Info(2): ", 0
	filename db "txt\\info.txt", 0
	read_mode db "r", 0
	no_name db "No names yet", 10, 0
	nameheadline db "Names in the list:", 10, 0
	newline db 10, 0
	go_return db "Press any key to return.", 10, 0
	no_map_msg db "You don't have the map, press any key to go back.", 0
	map_tip db 'Press "1000" to view the map', 10, 0
	say_cmd db "Say\\say_text.exe Welcome to Infomation file", 0
	
section .bss
    file resd 1  
    read_buf resb 100	
    retur resd 1 
	
section .text
    
Info:
    push cls_cmd            ; clear screan
    call _system

    push say_cmd
    call _system
    
	
spring:   
    
	push cls_cmd            ; clear screan
    call _system
	
	push text_bedroom       ; set text to print out  
    call _printf
    add esp, 4
	
	push promptbedroom
	call _printf              
    add esp, 4
	
	call _getch
    movzx eax, al
	cmp eax, '1'
	je main
	cmp eax, '2'
    je Read
	jmp spring
	

	
Read:
    ; opon file in  read-mode
    push read_mode
    push filename
    call _fopen
    add esp, 8
    mov [file], eax

    ; if file == 0, show "no names yet"
    cmp eax, 0
    je no_names

    ; læs første linje
    push dword [file]
    push 100
    push read_buf
    call _fgets

    call _fgets
    add esp, 12
    mov [retur], eax
    cmp dword [retur], 0
    je close_and_end
    push cls_cmd
    call _system
   
    push nameheadline
    call _printf
    add esp, 4

.show_line:
    push read_buf
    call _printf              ;write to txt file
    add esp, 4

    ; read next line
    push dword [file]
    push 100
    push read_buf
    call _fgets
    add esp, 12
    mov [retur], eax
    cmp dword [retur], 0
    jne .show_line

.finish_with_reading:
    ; close file and go return
    push dword [file]
    call _fclose
    add esp, 4
    push go_return
    call _printf
    add esp, 4
    call _getch      
	jmp spring

no_names:
    push no_name               ;write a msg if no names in the txt file
    call _printf
    add esp, 4
    push go_return
    call _printf
    add esp, 4
    call _getch      
    jmp spring

close_and_end:
    push dword [file]
    call _fclose
    add esp, 4
    jmp no_names


