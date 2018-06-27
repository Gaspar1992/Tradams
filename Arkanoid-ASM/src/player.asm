.area _DATA
;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

player_color 		= #0xFF ;; Colour Pattern (0xFF = 3, 3, 3, 3) ##RED##

;;===============================================================================
;;      PlayerE      B1 X Position                  B2 Width
;;                   B3 X Last Position             B4 Y Position
;;                   B5 Height                      B6 Y Last Position
;;                   B7 X Speed                     B8 Y Speed
;;===============================================================================
player::
	.db 40	;; Initial X Position
	.db 10	;; Initial Width
	.db 40	;; Initial Last X Position
	.db 150	;; Initial Y Position
	.db 10	;; Initial Height
	.db 150	;; Initial Last Y Position
player_speed::
	.db 1 	;; Initial Speed



.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm

.globl move_entity_asm
.globl render_box_entity_asm
;;===============================================================================
;; CODE SECTION
;;===============================================================================

.area _CODE 


;;===============================================================================
;; FUNCTION DRAW_ENTITY_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                     BC => Pointer to Colour Pattern
;;===============================================================================

player_draw::
	ld hl , #player				;; Player Pointer to HL
	ld a , #player_color		;; Color Pattern to A = Colour Pattern (0xFF = 3, 3, 3, 3) 
	call render_box_entity_asm	;; Draw Player Box
ret
;;===============================================================================
;; FUNCTION PLAYER_UPDATE
;;
;; Input parameters :  A => ACTION
;; A = 0 => No Action  || A = 1 => Move Right || A = 2 => Move Left
;; A = 3 => Move Down  || A = 4 => Move Up 
;;===============================================================================
player_update::
	
	or a         				;; Active Flags
	ret z		 				;; Return IF A = 0
	ld hl , #player_speed       ;; Pointer to PlayerSpeed
	cp #4						;; A == 4 (Move UP)
	jp z , move_player_up     	;; Move UP
	cp #3						;; A == 3 (Move Down)
	jp z , move_player_down   	;; Move Down
	cp #2						;; A == 2 (Move Left)
	jp z , move_player_left   	;; Move Left
	cp #1						;; A == 1 (Move Right)
	jp z , move_player_right  	;; Move Right
move_player:
	ld hl , #player				;; HL = Pointer to Player Entity
	call move_entity_asm		;; Move Entity
ret

move_player_up:
	ld a  , (hl)
	neg
	ld c , a 		;; C = Player Speed Y(HL)
	ld b , #0		;; B = PLayer Speed X(HL)
	jr move_player	;; Move Player
move_player_down:
	ld c , (hl)		;; C = Player Speed Y(HL)
	ld b , #0		;; B = PLayer Speed X(HL)
	jr move_player	;; Move Player

move_player_left:
	ld a  , (hl)
	neg
	ld b , a 		;; B = PLayer Speed Y(HL)
	ld c , #0		;; C = Player Speed X(HL)
	jr move_player	;; Move Player

move_player_right:
	ld b , (hl)		;; B = PLayer Speed Y(HL)
	ld c , #0		;; C = Player Speed X(HL)
	jr move_player  ;; Move Player

;;===============================================================================
;; FUNCTION MOVE_ENTITY_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                      B => X Movement
;;                      C => Y Movement
;;===============================================================================

