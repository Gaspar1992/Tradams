.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

sprite_player_1:
    .db #0x00, #0x77, #0xee, #0x00
	.db #0x00, #0xaa, #0x55, #0x00
	.db #0x11, #0x55, #0xaa, #0x88
	.db #0x33, #0xff, #0xff, #0xcc
	.db #0x32, #0xf0, #0xf0, #0xc4
	.db #0x32, #0xb4, #0xd2, #0xc4
	.db #0x32, #0x5a, #0xa5, #0xc4
	.db #0x32, #0xf0, #0xf0, #0xc4
	.db #0x32, #0xf0, #0xf0, #0xc4
	.db #0x33, #0xff, #0xff, #0xcc
	.db #0x00, #0xfc, #0xf3, #0x00
	.db #0x00, #0x77, #0xee, #0x00
	.db #0x00, #0x23, #0xc4, #0x00
	.db #0x00, #0x22, #0xc4, #0x00
	.db #0x00, #0x23, #0xc4, #0x00
	.db #0x00, #0x11, #0x88, #0x00

sprite_player_2:
    .db #0x11, #0xff, #0xff, #0x88
	.db #0x33, #0x55, #0xaa, #0xcc
	.db #0x22, #0xaa, #0x55, #0x44
	.db #0x22, #0x44, #0x22, #0x44
	.db #0x22, #0x33, #0xcc, #0x44
	.db #0x22, #0x22, #0x44, #0x44
	.db #0x22, #0x77, #0xee, #0x44
	.db #0x22, #0x88, #0x11, #0x44
	.db #0x33, #0x00, #0x00, #0xcc
	.db #0x11, #0xff, #0xff, #0x88
	.db #0x00, #0xff, #0xff, #0x00
	.db #0x00, #0x77, #0xee, #0x00
	.db #0x00, #0x32, #0x4c, #0x00
	.db #0x00, #0x32, #0x44, #0x00
	.db #0x00, #0x32, #0x4c, #0x00
	.db #0x00, #0x11, #0x88, #0x00

sprite_player_3:
    .db #0x00, #0x00, #0xff, #0xcc
	.db #0x00, #0x11, #0x22, #0xcc
	.db #0x00, #0x22, #0x55, #0xc4
	.db #0x00, #0x77, #0xfe, #0xc4
	.db #0x00, #0x88, #0x76, #0x4c
	.db #0x11, #0x11, #0xab, #0x4c
	.db #0x22, #0xee, #0x23, #0xc4
	.db #0x33, #0x11, #0xfe, #0xc4
	.db #0x22, #0xee, #0x32, #0xc4
	.db #0x11, #0x11, #0xba, #0x88
	.db #0x00, #0xcc, #0x77, #0x00
	.db #0x00, #0x77, #0xee, #0x00
	.db #0x00, #0x23, #0xe6, #0x00
	.db #0x00, #0x22, #0xe6, #0x00
	.db #0x00, #0x23, #0xc4, #0x00
	.db #0x00, #0x11, #0x88, #0x00

sprite_player_4:
	.db #0x33, #0xff, #0x00, #0x00
	.db #0x33, #0x44, #0x88, #0x00
	.db #0x32, #0xaa, #0x44, #0x00
	.db #0x32, #0xf7, #0xee, #0x00
	.db #0x23, #0xe6, #0x11, #0x00
	.db #0x23, #0x5d, #0x88, #0x88
	.db #0x32, #0x4c, #0x77, #0x44
	.db #0x32, #0xf7, #0x88, #0xcc
	.db #0x32, #0xc4, #0x77, #0x44
	.db #0x11, #0xd5, #0x88, #0x88
	.db #0x00, #0xee, #0x33, #0x00
	.db #0x00, #0x77, #0xee, #0x00
	.db #0x00, #0x76, #0x4c, #0x00
	.db #0x00, #0x76, #0x44, #0x00
	.db #0x00, #0x32, #0x4c, #0x00
	.db #0x00, #0x11, #0x88, #0x00


;;===============================================================================
;;      Vision       B1 Actual Vision           B2 Last Vision
;;===============================================================================
player_sprites:
    .dw sprite_player_1 , sprite_player_2 , sprite_player_3 , sprite_player_4
actual_sprite: .dw sprite_player_1

SPACE_BUTTON 	= #5
LEFT_BUTTON 	= #4	
RIGHT_BUTTON 	= #3						
UP_BUTTON 		= #2					
DOWN_BUTTON 	= #1						

player_cooldown: .db #0
player_damage_cooldown:: .db #0

.globl cpct_drawSprite_asm
.globl cpct_getScreenPtr_asm

;; ENTITIES
.globl player_position
.globl player_ini_position
.globl player_skills
.globl player_ini_skills
.globl player_bag
.globl player_ini_bag
.globl player_limit_skills
.globl player_limit_bag
.globl player_vision

;; TOOLS
.globl draw_entity_asm
.globl move_entity_asm
.globl check_sprite_draw
.globl simple_loop_inc_hl
.globl clean_last_position_entity

;; OTHERS
.globl hud_changes
.globl set_attack_into_screen
.globl actual_action

.globl number_of_bag_parameters
.globl number_of_position_parameters
.globl number_of_skill_parameters

.area _CODE 

;;===============================================================================
;; FUNCTION INITIALIZE_PLAYER_ASM
;;===============================================================================
initialize_player_asm::
	ld ix , #player_ini_skills
	ld iy , #player_skills
	ld hl , #number_of_skill_parameters
	ld  b , (hl)
_first_init_loop:
	ld a , (ix)
	ld (iy) , a 
	inc ix 
	inc iy
	djnz _first_init_loop
	ld ix , #player_ini_position
	ld iy , #player_position
	ld hl , #number_of_position_parameters
	ld  b , (hl)
_second_init_loop:
	ld a , (ix)
	ld (iy) , a 
	inc ix 
	inc iy
	djnz _second_init_loop
	ld ix , #player_ini_bag
	ld iy , #player_bag
	ld hl , #number_of_bag_parameters
	ld  b , (hl)
_third_init_loop:
	ld a , (ix)
	ld (iy) , a 
	inc ix 
	inc iy
	djnz _third_init_loop
ret
;;===============================================================================
;; FUNCTION PLAYER_ADD_SKILLS_VALUES_ASM
;;	Input Parameters : A = Position
;; 					   E = Value
;;===============================================================================
player_add_skills_values_asm::
	ld d  , a 							;; D = A 
	ld hl , #player_skills				;; Pointer to Player Skills
	call simple_loop_inc_hl				;; Loop HL
	push hl 							;; Save HL
	pop  ix 							;; Recover HL into IX
	ld a  , d 							;; A = D
	ld hl , #player_limit_skills		;; Pointer to Player Limit Skills
	call simple_loop_inc_hl				;; Simple Loop
	push hl 							;; Save HL
	pop iy 								;; Recover HL into IY
	ld a , (ix)							;; A = IX
	add e 								;; A = A + E
	cp (iy)								;; Compare With Limit Skills
	jp p , _limit_skill_exceeded
	ld (ix) , a 						;; IX = New Skill Value
	ld a , d 							;; A = Position
	cp #2 								;; Life Compare
	jr nz , _extend_life_skill			;; Check Max Life
	ld hl , #hud_changes				;; Hud Changes
	inc (hl)							;; Increment HL
	ld a , (ix) 						;; A = IX
	cp 1(ix)							;; Compare
	ret z 								;; Return CP = 0
	ret m 								;; Return CP < 0
_max_life_exceeded:
	ld a , 1(ix)						;; A = Max Life
	ld (ix) , a 						;; IX = Max Life
	ret
_limit_skill_exceeded:
	ld a , (iy)							;; A = Limit Skill
	ld (ix) , a 						;; IX = Skill Limit
ret
_extend_life_skill:
	cp #3								;; Check Max Life
	ret nz								;; Return if Not Change Mx Life
	ld hl , #hud_changes				;; Hud Changes
	inc (hl)							;; Increment HL
ret
;;===============================================================================
;; FUNCTION PLAYER_ADD_CONSUMABLES_VALUES_ASM
;;	Input Parameters : A = Position
;; 					   E = Value
;;===============================================================================
player_add_consumables_values_asm::
	ld d  , a 							;; D = A 
	ld hl , #player_bag					;; Pointer to Player Bag
	call simple_loop_inc_hl				;; Loop HL
	push hl 							;; Save HL
	pop  ix 							;; Recover HL into IX
	ld a  , d 							;; A = D
	ld hl , #player_limit_bag			;; Pointer to Player Limit Bag
	call simple_loop_inc_hl				;; Simple Loop
	push hl 							;; Save HL
	pop iy 								;; Recover HL into IY
	ld hl , #hud_changes				;; HL = Hud Changes
	ld a , d 							;; A = D
	inc a 								;; Increment A
	call simple_loop_inc_hl				;; Simple Loop
	inc (hl)							;; Increment HL
	ld a , (ix)							;; A = IX
	add e 								;; A = A + E
	cp (iy)								;; Compare With Limit Skills
	jp p , _limit_skill_exceeded
	ld (ix) , a 						;; IX = New Skill Value
	ret 
;;===============================================================================
;; PART UPDATE PLAYER FUNCTION
;;===============================================================================
player_update_asm::
	call cooldown_control
	call damage_cooldown_control
	ld hl , #actual_action		;; Actual Action Pointer
	ld a , (hl)					;; Action Value
	or a 						;; Active Flags
	ret z						;; Return IF A = 0
	cp #SPACE_BUTTON
	jp z , player_attack
	jr move_player_general
ret
cooldown_control::
	ld hl , #player_cooldown		;; HL = Pointer to CoolDown
	ld a , (hl)						;; A = CoolDown Value
	or a 							;; Active Flags
	ret z 							;; Return if cooldown == 0
	dec (hl)						;; Decrement CoolDown Value
ret
damage_cooldown_control::
	ld hl , #player_damage_cooldown	;; HL = Pointer to CoolDown
	ld a , (hl)						;; A = CoolDown Value
	or a 							;; Active Flags
	ret z 							;; Return if cooldown == 0
	dec (hl)						;; Decrement CoolDown Value
ret
;;===============================================================================
;; FUNCTION SELECT_PLAYER_SPRITE
;;===============================================================================
select_player_sprite:
	ld hl , #player_vision	;; Pointer to Player Vision
	ld  a , (hl)			;; A = Player Vision
	ld  b , a  				;; B = A
	inc (hl)				;; Next Position
	sub (hl)				;; A = A - (HL)
	ret z 					;; If A = 0 Return
	ld (hl) , b				;; (HL)last vision = B(New vision)
	ld    a , b 			;; A = B
	add   a 				;; A = A + A
	ld  hl , #player_sprites;; Pointer to Player Sprites
	call simple_loop_inc_hl ;; HL = Player Sprite Position
	ld   c , (hl)			;; First Part of Sprite
	inc hl 					;; Next Position
	ld   b , (hl)			;; Second Part of Pointer
	ld  hl , #actual_sprite ;; Pointer to Actual Sprite
	ld  (hl) , c 			;; First Part of Pointer
	inc hl 					;; Next Position
	ld  (hl) , b 			;; Second Part of Pointer 
ret
;;===============================================================================
;; FUNCTION DRAW_PLAYER
;;===============================================================================
draw_player_asm::
	ld  hl , #player_position	;; Pointer to Player Position
	call check_sprite_draw
	ret z                       ;; Return IF Z Flag is Active
	ld hl , #actual_sprite
	ld  e , (hl)				;; E = First Part of Sprite Pointer
	inc hl 						;; Increment HL Memory Pointer
	ld  d , (hl)				;; D = Second Part of Sprite Pointer
	ld hl , #player_position	;; Pointer to Player Position
	call draw_entity_asm		;; Draw Entities
ret

;;===============================================================================
;; FUNCTION MOVE_PLAYER_GENERAL
;;===============================================================================
move_player_general:
	ld bc , #0					;; BC = 0
	ld hl , #player_skills		;; HL = Pointer to Skills
	cp #UP_BUTTON				;; IF PRESS UP (W)
	jr z , move_player_up		;; IF A == 0 THEN JUMP
	cp #RIGHT_BUTTON			;; IF PRESS RIGHT (D)
	jr z , move_player_right	;; IF A == 0 THEN JUMP
	cp #LEFT_BUTTON				;; IF PRESS LEFT (A)
	jr z , move_player_left		;; IF A == 0 THEN JUMP
;;===============================================================================
;; FUNCTION MOVE_PLAYER_DOWN
;;===============================================================================
	ld a , #DOWN_BUTTON			;; A = DOWN_BUTTON
	dec a 						;; Decrement A Value
	ld de , #player_vision		;; DE = Pointer to player vision
	ld (de) , a 				;; (DE) Player Vision = A
	inc hl 						;; Next Position Speed Y
	ld c  , (hl)				;; C = Speed Value(HL)
	jr _move_player
;;===============================================================================
;; FUNCTION MOVE_PLAYER_UP
;;===============================================================================
move_player_up:
	ld a , #UP_BUTTON			;; A = UP_BUTTON
	dec a 						;; Decrement A Value
	ld de , #player_vision		;; DE = Pointer to player vision
	ld (de) , a 				;; (DE) Player Vision = A
	inc hl 						;; Next Position Speed Y
	ld a  , (hl)				;; A = Speed Value(HL)
	neg 						;; A = -A
	ld c  ,  a 					;; B = -A
	jr _move_player
;;===============================================================================
;; FUNCTION MOVE_PLAYER_RIGHT
;;===============================================================================
move_player_right:
	ld a , #RIGHT_BUTTON		;; A = UP_BUTTON
	dec a 						;; Decrement A Value
	ld de , #player_vision		;; DE = Pointer to player vision
	ld (de) , a 				;; (DE) Player Vision = A
	ld b  , (hl) 				;; B = Speed Value(HL)
	jr _move_player
;;===============================================================================
;; FUNCTION MOVE_PLAYER_LEFT
;;===============================================================================
move_player_left:
	ld a , #LEFT_BUTTON			;; A = UP_BUTTON
	dec a 						;; Decrement A Value
	ld de , #player_vision		;; DE = Pointer to player vision
	ld (de) , a 				;; (DE) Player Vision = A
	ld a  , (hl) 				;; A = Speed Value(HL)
	neg 						;; A = -A
	ld b  ,  a					;; B = -A
_move_player:
	ld hl , #player_position	;; HL = Player Position Pointer
	call move_entity_asm		;; Move Player
	call select_player_sprite	;; Select Next Player Sprite
ret
;;===============================================================================
;; FUNCTION PLAYER_ATTACK
;;===============================================================================
player_attack::
	ld ix , #player_skills			;; Player skills
	ld hl , #player_cooldown		;; HL = Player CoolDown
	ld a , (hl)						;;  A = ColdDown Value
	or a 							;; Active Flags
	ret nz 							;; Return IF CoolDown
	ld a , 5(ix)					;; A = Fire Rate
	ld (hl) , a 					;; Cooldown Value = A
	ld de , #player_position
	ld hl , #player_vision
	call set_attack_into_screen
ret
;;===============================================================================
;; FUNCTION SET_DAMAGE_COOLDOWN
;;===============================================================================
set_damage_cooldown::
	ld hl , #player_damage_cooldown
	ld (hl) , #100
ret
;;===============================================================================
;; FUNCTION CLEAR_PLAYER_ASM
;;===============================================================================
clear_player_asm::
	ld hl , #player_position
	call clean_last_position_entity
ret