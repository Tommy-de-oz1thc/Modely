global Save_Letters
global lessen_a_correct 
global lessen_a_wrong 
global lessen_b_correct
global lessen_b_wrong 
global lessen_c_correct
global lessen_c_wrong 
global lessen_d_correct
global lessen_d_wrong 
global lessen_e_correct
global lessen_e_wrong 
global lessen_f_correct
global lessen_f_wrong 
global lessen_g_correct
global lessen_g_wrong 
global lessen_h_correct
global lessen_h_wrong 
global lessen_i_correct
global lessen_i_wrong 
global lessen_j_correct
global lessen_j_wrong 
global lessen_k_correct
global lessen_k_wrong 
global lessen_l_correct
global lessen_l_wrong 
global lessen_m_correct
global lessen_m_wrong 
global lessen_n_correct
global lessen_n_wrong 
global lessen_o_correct
global lessen_o_wrong 

global retur_value_letters


extern _printf, _fopen, _fprintf, _fclose
extern CW_Modely_Start

section .data
filename            db "save/save_letters.txt", 0
save_mode           db "w", 0
formatstr           db "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 0
save_ok_msg         db "Skrevet til fil", 10, 0
save_fail_msg       db "FEJL: fopen returnerede NULL", 10, 0
    
	lessen_a_correct dd 0
    lessen_a_wrong dd 0
	lessen_b_correct dd 1
	lessen_b_wrong dd 1
	lessen_c_correct dd 1
	lessen_c_wrong dd 1
	lessen_d_correct dd 1
	lessen_d_wrong dd 1
	lessen_e_correct dd 1
	lessen_e_wrong dd 1
	lessen_f_correct dd 1
	lessen_f_wrong dd 1
	lessen_g_correct dd 1
	lessen_g_wrong dd 1
	lessen_h_correct dd 1
	lessen_h_wrong dd 1
	lessen_i_correct dd 1
	lessen_i_wrong dd 1
	lessen_j_correct dd 1
	lessen_j_wrong dd 1
	lessen_k_correct dd 1
	lessen_k_wrong dd 1
	lessen_l_correct dd 1
	lessen_l_wrong dd 1
	lessen_m_correct dd 1
	lessen_m_wrong dd 1
	lessen_n_correct dd 1
	lessen_n_wrong dd 1
	lessen_o_correct dd 1
	lessen_o_wrong dd 1
	
    retur_value_letters dd 0
	
section .bss
    

section .text

Save_Letters:
    ; Dummydata til test (kan slettes og erstattes med rigtig data fra dit spil)
    ;mov dword [lessen_a_wrong],  1
   ; mov dword [lessen_a_correct],  2
    mov dword [lessen_b_wrong],  30
    mov dword [lessen_b_correct],  4
    mov dword [lessen_c_wrong],  5
    mov dword [lessen_c_correct],  6
    mov dword [lessen_d_wrong],  7
    mov dword [lessen_d_correct],  28
    mov dword [lessen_e_wrong],  9
    mov dword [lessen_e_correct], 10
    mov dword [lessen_f_wrong], 11
    mov dword [lessen_f_correct], 12
    mov dword [lessen_g_wrong], 13
    mov dword [lessen_g_correct], 14
    mov dword [lessen_h_wrong], 15
    mov dword [lessen_h_correct], 1
    mov dword [lessen_i_wrong], 17
    mov dword [lessen_i_correct], 8
    mov dword [lessen_j_wrong], 19
    mov dword [lessen_j_correct], 20
    mov dword [lessen_k_wrong], 21
    mov dword [lessen_k_correct], 22
    mov dword [lessen_l_wrong], 23
    mov dword [lessen_l_correct], 24
    mov dword [lessen_m_wrong], 25
    mov dword [lessen_m_correct], 26
    mov dword [lessen_n_wrong], 27
    mov dword [lessen_n_correct], 28
    mov dword [lessen_o_wrong], 29
    mov dword [lessen_o_correct], 30

    ; Åbn fil til skrivning
    push save_mode
    push filename
    call _fopen
    add esp, 8
    test eax, eax
    jz .write_failed

    mov ebx, eax  ; FILE*

    ; Push 30 værdier i omvendt rækkefølge (pga. stack)
    ; (alternativt kunne man loope, men her gør vi det manuelt for klarhed)


    push dword [lessen_o_correct]
    push dword [lessen_o_wrong]
    push dword [lessen_n_correct]
    push dword [lessen_n_wrong]
    push dword [lessen_m_correct]
    push dword [lessen_m_wrong]
    push dword [lessen_l_correct]
    push dword [lessen_l_wrong]
    push dword [lessen_k_correct]
    push dword [lessen_k_wrong]
    push dword [lessen_j_correct]
    push dword [lessen_j_wrong]
    push dword [lessen_i_correct]
    push dword [lessen_i_wrong]
    push dword [lessen_h_correct]
    push dword [lessen_h_wrong]
    push dword [lessen_g_correct]
    push dword [lessen_g_wrong]
    push dword [lessen_f_correct]
    push dword [lessen_f_wrong]
    push dword [lessen_e_correct]
    push dword [lessen_e_wrong]
    push dword [lessen_d_correct]
    push dword [lessen_d_wrong]
    push dword [lessen_c_correct]
    push dword [lessen_c_wrong]
    push dword [lessen_b_correct]
    push dword [lessen_b_wrong]
    push dword [lessen_a_correct]
    push dword [lessen_a_wrong]
    push formatstr
    push ebx
    call _fprintf
    add esp, 124

    ; Luk fil
    push ebx
    call _fclose
    add esp, 4

    ; Bekræftelse
    push save_ok_msg
    call _printf
    add esp, 4
    jmp .finish

.write_failed:
    push save_fail_msg
    call _printf
    add esp, 4
    

.finish:
    mov eax, [retur_value_letters]
    cmp eax, 1
    je ret_to_CW_Modely
	
ret_to_CW_Modely:
    mov dword [retur_value_letters], 0
    jmp CW_Modely_Start
