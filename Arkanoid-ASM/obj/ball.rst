ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 ;;===============================================================================
                              4 ;; DEFINED CONSTANTS
                              5 ;;===============================================================================
                              6 
                     0000     7 Min_screen_W       = #0       ;; Min Width of the screen (bytes)
                     0050     8 Max_screen_W       = #80      ;; Max Width of the screen (bytes)
                     0000     9 Min_screen_H       = #0       ;; Min Height of the screen (pixels)
                     00C8    10 Max_screen_H       = #200     ;; Max Height of the screen (pixels)
                             11 
                     000F    12 ball_color     = #0x0F   ;; A = Colour Pattern (0x0F = 1, 1, 1, 1)
                             13 
   4492                      14 ball::
   4492 28                   15 	.db 40	;; Initial X Position
   4493 02                   16 	.db 2	;; Initial Width
   4494 28                   17 	.db 40	;; Initial Last X Position
   4495 82                   18 	.db 130	;; Initial Y Position
   4496 08                   19 	.db 8	;; Initial Height
   4497 82                   20 	.db 130	;; Initial Last Y Position
                             21 
   4498                      22 ball_speed::
   4498 FF                   23     .db -1  ;; Initial X Speed
   4499 FF                   24     .db -1  ;; Initial Y Speed
                             25 
                             26 
                             27 
                             28 .globl move_entity_asm
                             29 .globl render_box_entity_asm
                             30 
                             31 .area _CODE 
                             32 
   4000                      33 ball_draw_asm::
   4000 21 92 44      [10]   34     ld hl , #ball				;; Player Pointer to HL
   4003 3E 0F         [ 7]   35 	ld a , #ball_color		    ;; Color Pattern to A = Colour Pattern (0xFF = 3, 3, 3, 3) 
   4005 CD F2 40      [17]   36 	call render_box_entity_asm	;; Draw Player Box
   4008 C9            [10]   37 ret
                             38 
   4009                      39 ball_update_asm::
   4009 21 98 44      [10]   40     ld hl , #ball_speed       ;; Pointer to PlayerSpeed
   400C 46            [ 7]   41     ld b , (hl)                 ;; B = X Speed(HL)
   400D 23            [ 6]   42     inc hl                      ;; Next Position (Y Speed)
   400E 4E            [ 7]   43     ld c , (hl)                 ;; C = Y Speed(HL)
   400F 21 92 44      [10]   44     ld hl , #ball               ;; HL = Entity Ball
   4012 CD C0 40      [17]   45     call move_entity_asm        ;; Move Entity
   4015 21 92 44      [10]   46     ld hl , #ball               ;; HL = Entity Ball
   4018 7E            [ 7]   47     ld a , (hl)                 ;; A = X Pos(HL)
   4019 FE 00         [ 7]   48     cp #Min_screen_W            ;; A = X Pos(A) - Min Screen Width
   401B CC 35 40      [17]   49     call z , change_speed_x     ;; Change X Speed
   401E 23            [ 6]   50     inc hl                      ;; Next Position HL (Width)
   401F 86            [ 7]   51     add (hl)                    ;; A = X Pos(A) + Width(HL)
   4020 FE 50         [ 7]   52     cp #Max_screen_W            ;; A = [ X Pos(A) + Width(A) ] - Max Screen Width
   4022 CC 35 40      [17]   53     call z , change_speed_x     ;; Change X Speed
   4025 23            [ 6]   54     inc hl                      ;; Next Position HL (X LPos)
   4026 23            [ 6]   55     inc hl                      ;; Next Position HL (Y Pos)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4027 7E            [ 7]   56     ld a , (hl)                 ;; A = Y Pos(HL)
   4028 FE 00         [ 7]   57     cp #Min_screen_H            ;; A = Y Pos(A) - Min Screen Height
   402A CC 41 40      [17]   58     call z , change_speed_y     ;; Change Y Speed
   402D 23            [ 6]   59     inc hl                      ;; Next Position HL (Height)
   402E 86            [ 7]   60     add (hl)                    ;; A = Y Pos(A) + Height(HL)
   402F FE C8         [ 7]   61     cp #Max_screen_H            ;; A = [Y Pos(A) + Height(A)]
   4031 CC 41 40      [17]   62     call z , change_speed_y     ;; Change Y Speed
   4034 C9            [10]   63 ret
                             64 
   4035                      65 change_speed_x:
   4035 F5            [11]   66     push af
   4036 E5            [11]   67     push hl
   4037 21 98 44      [10]   68     ld hl , #ball_speed
   403A 7E            [ 7]   69     ld a , (hl)
   403B ED 44         [ 8]   70     neg
   403D 77            [ 7]   71     ld (hl) , a
   403E E1            [10]   72     pop hl
   403F F1            [10]   73     pop af 
   4040 C9            [10]   74 ret
   4041                      75 change_speed_y::
   4041 F5            [11]   76     push af
   4042 E5            [11]   77     push hl
   4043 21 98 44      [10]   78     ld hl , #ball_speed
   4046 23            [ 6]   79     inc hl
   4047 7E            [ 7]   80     ld a , (hl)
   4048 ED 44         [ 8]   81     neg
   404A 77            [ 7]   82     ld (hl) , a
   404B E1            [10]   83     pop hl
   404C F1            [10]   84     pop af 
   404D C9            [10]   85 ret
                             86 ;;===============================================================================
                             87 ;; FUNCTION MOVE_ENTITY_ASM
                             88 ;;
                             89 ;; Input parameters :  HL => Pointer to TEntity
                             90 ;;                      B => X Movement
                             91 ;;                      C => Y Movement
                             92 ;;===============================================================================
