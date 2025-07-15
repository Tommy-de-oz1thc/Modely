section .data
extern _system

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
wav_pause_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\pause.wav").PlaySync()', 0
wav_comma_cmd  db 'powershell -c (New-Object Media.SoundPlayer "cw\\comma.wav").PlaySync()', 0
wav_dot_cmd    db 'powershell -c (New-Object Media.SoundPlayer "cw\\dot.wav").PlaySync()', 0
wav_question_cmd    db 'powershell -c (New-Object Media.SoundPlayer "cw\\question.wav").PlaySync()', 0
wav_slash_cmd    db 'powershell -c (New-Object Media.SoundPlayer "cw\\slash.wav").PlaySync()', 0
wav_equals_cmd    db 'powershell -c (New-Object Media.SoundPlayer "cw\\equals.wav").PlaySync()', 0
wav_0_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\0.wav").PlaySync()', 0
wav_1_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\1.wav").PlaySync()', 0
wav_2_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\2.wav").PlaySync()', 0
wav_3_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\3.wav").PlaySync()', 0
wav_4_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\4.wav").PlaySync()', 0
wav_5_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\5.wav").PlaySync()', 0
wav_6_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\6.wav").PlaySync()', 0
wav_7_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\7.wav").PlaySync()', 0
wav_8_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\8.wav").PlaySync()', 0
wav_9_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\9.wav").PlaySync()', 0

wav_cmd_ptrs:
    dd wav_a_cmd, wav_b_cmd, wav_c_cmd, wav_d_cmd, wav_e_cmd
    dd wav_f_cmd, wav_g_cmd, wav_h_cmd, wav_i_cmd, wav_j_cmd
    dd wav_k_cmd, wav_l_cmd, wav_m_cmd, wav_n_cmd, wav_o_cmd
    dd wav_p_cmd, wav_q_cmd, wav_r_cmd, wav_s_cmd, wav_t_cmd
    dd wav_u_cmd, wav_v_cmd, wav_w_cmd, wav_x_cmd, wav_y_cmd 
	dd wav_z_cmd, wav_pause_cmd, wav_comma_cmd, wav_dot_cmd 
	dd wav_question_cmd, wav_slash_cmd, wav_equals_cmd
wav_digit_ptrs:
    dd wav_0_cmd, wav_1_cmd, wav_2_cmd, wav_3_cmd, wav_4_cmd
	dd wav_5_cmd, wav_6_cmd, wav_7_cmd, wav_8_cmd, wav_9_cmd




