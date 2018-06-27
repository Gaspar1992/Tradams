.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

Chars_Width  = #1   ;; Charset Width (Bytes)
Chars_Height = #6   ;; Charset height (Pixels)

pvideomem    = #0xC000  ;; First byte of video memory

Sentences_values::
    .db initial_main_text_pos_x;; X Pos
    .db initial_main_text_pos_y;; Y Pos
    .db 0                      ;; Num Setence

First_sentence_x_pos: .db #0

initial_main_text_pos_x = #34
initial_main_text_pos_y = #100

game_instruction_text_pos_x = #10
game_instruction_text_pos_y = #120

Sentence_selected: .db 0      ;; Actual Sentence
Sentence_Tremble:  .db 4      ;; Tremble Loop



CharSet::
        Char_A:     .db #0x06,#0x09,#0x09,#0x0f,#0x09,#0x09 ;; 1
        Char_B:     .db #0x0e,#0x09,#0x0a,#0x09,#0x09,#0x0e ;; 2
        Char_C:     .db #0x07,#0x08,#0x08,#0x08,#0x08,#0x07 ;; 3
        Char_D:     .db #0x0e,#0x09,#0x09,#0x09,#0x09,#0x0e ;; 4
        Char_E:     .db #0x0f,#0x08,#0x0e,#0x08,#0x08,#0x0f ;; 5
        Char_F:     .db #0x0f,#0x08,#0x0e,#0x08,#0x08,#0x08 ;; 6
        Char_G:     .db #0x07,#0x08,#0x0a,#0x09,#0x09,#0x06 ;; 7
        Char_H:     .db #0x09,#0x09,#0x0f,#0x09,#0x09,#0x09 ;; 8
        Char_I:     .db #0x0f,#0x0f,#0x06,#0x06,#0x0f,#0x0f ;; 9
        Char_J:     .db #0x0f,#0x02,#0x02,#0x02,#0x0a,#0x06 ;; 10
        Char_K:     .db #0x09,#0x0a,#0x0e,#0x0c,#0x0a,#0x09 ;; 11
        Char_L:     .db #0x08,#0x08,#0x08,#0x08,#0x08,#0x0f ;; 12
        Char_M:     .db #0x09,#0x0f,#0x09,#0x09,#0x09,#0x09 ;; 13
        Char_N:     .db #0x09,#0x0d,#0x0d,#0x0b,#0x0b,#0x09 ;; 14
        Char_O:     .db #0x06,#0x09,#0x09,#0x09,#0x09,#0x06 ;; 15
        Char_P:     .db #0x0e,#0x09,#0x09,#0x0e,#0x08,#0x08 ;; 16
        Char_Q:     .db #0x06,#0x09,#0x09,#0x09,#0x0a,#0x05 ;; 17
        Char_R:     .db #0x0e,#0x09,#0x09,#0x0e,#0x0a,#0x09 ;; 18
        Char_S:     .db #0x07,#0x08,#0x08,#0x06,#0x01,#0x0e ;; 19
        Char_T:     .db #0x0f,#0x0f,#0x06,#0x06,#0x06,#0x06 ;; 20
        Char_U:     .db #0x09,#0x09,#0x09,#0x09,#0x09,#0x06 ;; 21
        Char_V:     .db #0x09,#0x09,#0x06,#0x06,#0x02,#0x02 ;; 22
        Char_W:     .db #0x09,#0x09,#0x09,#0x0b,#0x0b,#0x06 ;; 23
        Char_X:     .db #0x09,#0x0f,#0x06,#0x06,#0x0f,#0x09 ;; 24
        Char_Y:     .db #0x09,#0x09,#0x06,#0x06,#0x06,#0x06 ;; 25
        Char_Z:     .db #0x0f,#0x01,#0x02,#0x04,#0x08,#0x0f ;; 26
        Char_0:     .db #0x06,#0x09,#0x09,#0x09,#0x09,#0x06 ;; 27
        Char_1:     .db #0x02,#0x06,#0x0e,#0x02,#0x02,#0x0f ;; 28
        Char_2:     .db #0x06,#0x09,#0x01,#0x02,#0x04,#0x0f ;; 29
        Char_3:     .db #0x0e,#0x01,#0x0e,#0x01,#0x01,#0x0e ;; 30
        Char_4:     .db #0x09,#0x09,#0x0f,#0x01,#0x01,#0x01 ;; 31
        Char_5:     .db #0x07,#0x08,#0x08,#0x0e,#0x01,#0x0f ;; 32
        Char_6:     .db #0x07,#0x08,#0x08,#0x0f,#0x09,#0x0f ;; 33
        Char_7:     .db #0x0f,#0x01,#0x01,#0x01,#0x01,#0x01 ;; 34
        Char_8:     .db #0x0f,#0x09,#0x0f,#0x09,#0x09,#0x0f ;; 35
        Char_9:     .db #0x0f,#0x09,#0x0f,#0x01,#0x01,#0x01 ;; 36
        Char_Point: .db #0x00,#0x00,#0x00,#0x00,#0x06,#0x06 ;; 37
        Char_EX:    .db #0x06,#0x06,#0x06,#0x06,#0x00,#0x06 ;; 38
        Char_QU:    .db #0x06,#0x09,#0x02,#0x02,#0x00,#0x02 ;; 39


                ;;   N    E   W    _   G   A   M    E   FN
    New_Game:    .db 14 , 5 , 23 , 0 , 7 , 1 , 13 , 5 , 99
                ;;   G   A   M    E   _   P    A   U    S    E   D   FN
    Game_Paused: .db 7 , 1 , 13 , 5 , 0 , 16 , 1 , 21 , 19 , 5 , 4 , 99
                ;;   C   O    N    T    I   N    U    E   FN
    Continue:    .db 3 , 15 , 14 , 20 , 9 , 14 , 21 , 5 , 99 
                ;;   C   O    D   E   S
    Codes:       .db 3 , 15 , 4 , 5 , 19 , 99
                ;;   M    U    S    I   C   _   O    N    FN
    Music_ON:    .db 13 , 21 , 19 , 9 , 3 , 0 , 15 , 14 , 99
                ;;   M    U    S    I   C   _   O    F   F   FN
    Music_OFF:   .db 13 , 21 , 19 , 9 , 3 , 0 , 15 , 6 , 6 , 99
                ;;   W    .    U    P    _   _   S    .    D    O   W    N    _     
    Controlls:   .db 16 , 38 , 21 , 16 , 0 , 0 , 19 , 38 , 4 , 15 , 23 , 14 , 0
                ;;   _   A    .    L    E    F   T    _   _   D   .    R    I   G   H   T     
                 .db 0 , 1 , 37 , 12 ,  5 ,  6 , 20 , 0 , 0 , 4 , 39 , 18 , 9 , 7 , 8 , 20
                ;;   _   _    S    P    A    C   E    .   A   T    T    A   C   K    FN        
                 .db 0 , 0 , 19 , 16 ,  1 ,  3 , 5 , 39 , 1 , 20 , 20 , 1 , 3 , 11 , 99 
                ;;   P    R    E    S   S    _   A   N    Y    _   K    E   Y    FN
    Press_any:   .db 16 , 18 , 5 , 19 , 19 , 0 , 1 , 14 , 25 , 0 , 11 , 5 , 25 , 99

    ;; BUFFER TO FUNCTION INT TO STRING
                        ;;   0    0    FN
    StringBuffer::      .db 27 , 27  , 99

Main_Menu:
    .db #2                                  ;; Num of Sentences
    .dw New_Game , Codes                    ;; Sentences

Pause_Menu:
    .db #2                                  ;; Num of Sentences
    .dw Game_Paused , Continue              ;; Sentences

Music:
    .dw Music_OFF , Music_ON

.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl Music_option
.globl cpct_drawSolidBox_asm

;;===============================================================================
;; CODE SECTION
;;===============================================================================

.area _CODE 

;;================================================================
;; DRAW_SENTENCE
;; INPUT : HL = SENTENCE
;; ==============================================================
draw_sentence::
    ld ix , #First_sentence_x_pos    ;; First Sentence X Pos
    ld iy , #Sentences_values        ;; Sentence Values
    ld a , (iy)
    ld (ix) , a
_draw_sentence_loop:         
    ld a , (hl)                     ;; B = Number of Letter
    cp #99                          ;; IF A = 99
    ret z                           ;; FINISH SENTENCE
    push hl                         ;; SAVE HL POINTER
    or a                            ;; Active Flags
    jp z , space_char               ;; IF Char is a Space
    dec a                           ;; Decrement a
    jr z , next_action              ;; IF A = 0
    ld b , a                        ;; B = A
    xor a 
calculate_pos:
    add #Chars_Height   ;; A = A + Char Height
    djnz calculate_pos  ;; IF B = 0
next_action:
    ld bc , #0          ;; BC = 0
    ld c  , a           ;; C = A
    ld hl , #CharSet    ;; Pointer to Charset
    add hl , bc         ;; HL = Pos Pointer(HL) + Letter Pos(BC)
    call draw_letter    ;; Draw Letter
    pop hl              ;; Recover Sentence Pointer
    inc hl              ;; Next Char of Sentence
    jp _draw_sentence_loop    ;; Continue Loop to finish the Sentence

ret
;;================================================================
;; DRAW_LETTER
;; INPUT : HL = LETTER   
;; ==============================================================
draw_letter:
    push hl                     ;; Save Letter Pos
    ld de , #pvideomem          ;; Screen Start Position
    ld hl , #Sentences_values   ;; Pointer to Values
    ld c , (hl)                 ;; X Pos
    inc hl                      ;; Next Position (Y Pos)
    ld b , (hl)                 ;; Y Pos
    dec hl                      ;; Previous Position X Pos
    ld a , (hl)                 ;; A = Y Pos
    add #Chars_Width            ;; A = Y Pos + Char Width
    ;inc a                       ;; Give Space Between Chars
    ld (hl) , a                 ;; Update HL to next Position
    call cpct_getScreenPtr_asm  ;; Get Screen Position
    ;; Return Position in HL

    ex de , hl                  ;; Exchange DE<->HL
    pop hl                      ;; Recover Letter Sprite Pointer
    ld c , #Chars_Width         ;; Char Width
    ld b , #Chars_Height        ;; Char Height
    call cpct_drawSprite_asm    ;; Draw Char

ret
;;=====================================================
;; SPACE_BAR 
;;=====================================================
space_char:
    ld hl , #Sentences_values   ;; Pointer to Values
    ld a , (hl)                 ;; A = X Pos
    add #Chars_Width            ;; A = X Pos + Char Width
    ld (hl) , a                 ;; Update HL to next Position
    pop hl                      ;; Recover Sentence Pointer
    inc hl                      ;; Next Char
    jr draw_sentence            ;; Come back to Function

;;======================================================
;;  NEXT LINE
;;======================================================
next_line:
    ld hl , #Sentences_values   ;; Pointer to Sentences Values
    ld ix , #First_sentence_x_pos;; First Sentence X Pos
    ld a , (ix)                 ;; A = First..
    ld (hl) , a                 ;; HL (X Pos) = A
    inc hl                      ;; Next Position Y Pos
    ld a , (hl)                 ;; A = Y Pos
    add #Chars_Height           ;; A = Y Pos(A) + Chars_Height(HL)
    add #Chars_Height           ;; A = Y Pos(A) + 2*Chars_Height(HL|A)
    ld (hl) , a                 ;; HL(Y Pos) = A
    inc hl                      ;; Next Position Num Sentences
    inc (hl)                    ;; Num Sentences++
ret
;;======================================================
;;  RESET VALUES
;;======================================================
reset_values:
    ld hl , #Sentences_values   ;; Pointer to Sentences Values
    ld a , #0                   ;; Reset X Pos a initial
    ld (hl) , a                 ;; HL (X Pos) = A
    inc hl                      ;; Next Position Y Pos
    ld a , #0                   ;; A = Y Ini Pos
    ld (hl) , a                 ;; HL(Y Pos) = A
    inc hl                      ;; Next Position Num Sentences
    xor (hl)
ret
;;======================================================
;;  MUSIC SENTENCE
;;======================================================
draw_active_music_sentence:
ret
;;======================================================
;;  TREMBLE SENTENCE
;;======================================================
draw_tremble_sentence:
ret
;;======================================================
;;  DRAW MENU
;;  Input: HL = Menu Sentences
;;======================================================
draw_menu:
    ld b , (hl)         ;; B = Number of Sentences
draw_menu_loop:
    inc hl              ;; First Part
    ld e , (hl)         ;; First Part
    inc hl              ;; Second Part
    ld d , (hl)         ;; Second Part
    ex de , hl          ;; Exchange DE<->HL
    push de             ;; Push MENU Pointer
    call draw_sentence  ;; Draw Sentence
    call next_line      ;; Next Line
    pop hl              ;; Recover Menu Pointer
    djnz draw_menu_loop ;; IF B != 0 LOOP
    call reset_values   ;; RESET VALUES
ret
;;======================================================
;;  CLEAR SENTENCE
;; INPUT : HL = SENTENCE
;;======================================================
clear_sentence:
    ld ix , #First_sentence_x_pos    ;; First Sentence X Pos
    ld iy , #Sentences_values        ;; Sentence Values
    ld a , (iy)
    ld (ix) , a
_clear_sentence_loop:
    ld a , (hl)                     ;; A = No Letter
    cp #99                          ;; End of the line
    ret z                           ;; Return if CP is true
    inc hl                          ;; Next HL Value
    

    push hl                         ;; Save HL Values

    ld c , 0(iy)                    ;; C  = X Pos
    ld b , 1(iy)                    ;; B  = Y Pos
    ld  de , #pvideomem             ;; Video Memory Position
    call cpct_getScreenPtr_asm      ;; Get Screen Pointer

    ex  de , hl                     ;; Exchange Values DE <-> HL
    ld b , #Chars_Height
    ld c , #Chars_Width
    ld a , #0x00                    ;; A = Black Pixel
    call cpct_drawSolidBox_asm

    ld a , (iy)                     ;; A = X pos
    add #Chars_Width
    ld (iy) , a                     ;; Update X pos

    pop hl                          ;; Recover HL

    jp _clear_sentence_loop
;;======================================================
;;  CLEAR MAIN MENU
;;======================================================
clear_main_menu_sentences::
    ld hl , #Sentences_values
    ld (hl) , #initial_main_text_pos_x
    inc hl 
    ld (hl) , #initial_main_text_pos_y
    inc hl 
    ld (hl) , #0
    ld hl , #Press_any
    call clear_sentence
    call reset_values
ret
;;======================================================
;;  MAIN MENU
;;======================================================
draw_main_senteces_menu::
    ld hl , #Sentences_values
    ld (hl) , #initial_main_text_pos_x
    inc hl 
    ld (hl) , #initial_main_text_pos_y
    inc hl 
    ld (hl) , #0
    ld hl , #Press_any
    call draw_sentence          ;; Draw Sentences
ret

draw_real_main_senteces_menu::
    ld hl , #Sentences_values
    ld (hl) , #initial_main_text_pos_x
    inc hl 
    ld (hl) , #initial_main_text_pos_y
    inc hl 
    ld (hl) , #0
    ld hl , #New_Game
    call draw_sentence          ;; Draw Sentences
    call next_line
    ld hl , #Continue
    call draw_sentence          ;; Draw Sentences
    call next_line
    ld hl , #Codes
    call draw_sentence          ;; Draw Sentences

ret

;;======================================================
;;  CLEAR INITIAL ROOM
;;======================================================
clear_initial_sentences::
    ld ix , #Sentences_values
    ld 0(ix) , #game_instruction_text_pos_x
    ld 1(ix) , #game_instruction_text_pos_x
    ld 2(ix) , #0
    ld hl , #Controlls
    call clear_sentence
    call reset_values
ret
;;======================================================
;;  INITIAL ROOM
;;======================================================
draw_initial_senteces::
    ld ix , #Sentences_values
    ld 0(ix) , #game_instruction_text_pos_x
    ld 1(ix) , #game_instruction_text_pos_x
    ld 2(ix) , #0
    ld hl , #Controlls
    call draw_sentence          ;; Draw Sentences
    call reset_values
ret

