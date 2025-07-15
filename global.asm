section .data
global show_text
show_text db 1    ; 1 = vis tekst, 0 = skjul

section .text
global toggle_show_text
toggle_show_text:
    mov al, [show_text]
    xor al, 1
    mov [show_text], al
    ret


