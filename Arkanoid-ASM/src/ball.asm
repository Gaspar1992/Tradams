.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

Min_screen_W       = #0       ;; Min Width of the screen (bytes)
Max_screen_W       = #80      ;; Max Width of the screen (bytes)
Min_screen_H       = #0       ;; Min Height of the screen (pixels)
Max_screen_H       = #200     ;; Max Height of the screen (pixels)

ball_color     = #0x0F   ;; A = Colour Pattern (0x0F = 1, 1, 1, 1)

ball::
	.db 40	;; Initial X Position
	.db 2	;; Initial Width
	.db 40	;; Initial Last X Position
	.db 130	;; Initial Y Position
	.db 8	;; Initial Height
	.db 130	;; Initial Last Y Position

ball_speed::
    .db -1  ;; Initial X Speed
    .db -1  ;; Initial Y Speed



.globl move_entity_asm
.globl render_box_entity_asm

.area _CODE 

ball_draw_asm::
    ld hl , #ball				;; Player Pointer to HL
	ld a , #ball_color		    ;; Color Pattern to A = Colour Pattern (0xFF = 3, 3, 3, 3) 
	call render_box_entity_asm	;; Draw Player Box
ret

ball_update_asm::
    ld hl , #ball_speed       ;; Pointer to PlayerSpeed
    ld b , (hl)                 ;; B = X Speed(HL)
    inc hl                      ;; Next Position (Y Speed)
    ld c , (hl)                 ;; C = Y Speed(HL)
    ld hl , #ball               ;; HL = Entity Ball
    call move_entity_asm        ;; Move Entity
    ld hl , #ball               ;; HL = Entity Ball
    ld a , (hl)                 ;; A = X Pos(HL)
    cp #Min_screen_W            ;; A = X Pos(A) - Min Screen Width
    call z , change_speed_x     ;; Change X Speed
    inc hl                      ;; Next Position HL (Width)
    add (hl)                    ;; A = X Pos(A) + Width(HL)
    cp #Max_screen_W            ;; A = [ X Pos(A) + Width(A) ] - Max Screen Width
    call z , change_speed_x     ;; Change X Speed
    inc hl                      ;; Next Position HL (X LPos)
    inc hl                      ;; Next Position HL (Y Pos)
    ld a , (hl)                 ;; A = Y Pos(HL)
    cp #Min_screen_H            ;; A = Y Pos(A) - Min Screen Height
    call z , change_speed_y     ;; Change Y Speed
    inc hl                      ;; Next Position HL (Height)
    add (hl)                    ;; A = Y Pos(A) + Height(HL)
    cp #Max_screen_H            ;; A = [Y Pos(A) + Height(A)]
    call z , change_speed_y     ;; Change Y Speed
ret

change_speed_x:
    push af
    push hl
    ld hl , #ball_speed
    ld a , (hl)
    neg
    ld (hl) , a
    pop hl
    pop af 
ret
change_speed_y::
    push af
    push hl
    ld hl , #ball_speed
    inc hl
    ld a , (hl)
    neg
    ld (hl) , a
    pop hl
    pop af 
ret
;;===============================================================================
;; FUNCTION MOVE_ENTITY_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                      B => X Movement
;;                      C => Y Movement
;;===============================================================================