.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

player_life_1::
	.db #0x06, #0x06
	.db #0x09, #0x09
	.db #0x08, #0x01
	.db #0x04, #0x02
	.db #0x04, #0x02
	.db #0x02, #0x04
	.db #0x02, #0x04
	.db #0x01, #0x08

player_life_2::
	.db #0x66, #0x06
	.db #0x9f, #0x09
	.db #0x8f, #0x01
	.db #0x46, #0x02
	.db #0x47, #0x02
	.db #0x23, #0x04
	.db #0x23, #0x04
	.db #0x11, #0x08

player_life_3::
	.db #0x66, #0x66
	.db #0x9f, #0x9f
	.db #0x8f, #0x1f
	.db #0x47, #0x2e
	.db #0x47, #0x2e
	.db #0x23, #0x4c
	.db #0x23, #0x4c
	.db #0x11, #0x88

player_lifes_sprites:
	.dw player_life_1 , player_life_2
	.dw player_life_3

player_life_size   = #0x0802
player_life_width  = #2

bit_coin::
	.db #0xff, #0xff, #0xff
	.db #0x8f, #0x00, #0x1f
	.db #0x8c, #0x0a, #0x15
	.db #0x8f, #0x00, #0x15
	.db #0x8d, #0x02, #0x15
	.db #0x8c, #0x0a, #0x15
	.db #0x8f, #0x03, #0x15
	.db #0xff, #0xff, #0xff

bit_coin_size = #0x0803
bit_coin_pos  = #10 * player_life_width

TradamsKeys::
	.db #0x11, #0x00
	.db #0x32, #0x88
	.db #0x65, #0xc4
	.db #0xf8, #0x6a
	.db #0xf8, #0xb5
	.db #0x74, #0xe2
	.db #0x32, #0xc4
	.db #0x11, #0x88

keys_size = #0x0802
keys_position = bit_coin_pos + string_separator*2

TradamsMines: .dw TradamsMina_0 , TradamsMina_1

TradamsMina_0::
	.db #0x00, #0x00
	.db #0x11, #0x88
	.db #0x23, #0x4c
	.db #0x57, #0x26
	.db #0x57, #0xae
	.db #0x23, #0x4c
	.db #0x11, #0x88
	.db #0x00, #0x00

TradamsMina_1:
	.db #0x00, #0x00
	.db #0x11, #0x88
	.db #0x23, #0x4c
	.db #0x57, #0xa6
	.db #0x57, #0xae ;; change
	.db #0x23, #0x4c
	.db #0x11, #0x88
	.db #0x00, #0x00

mina_size = keys_size
mina_position = keys_position + string_separator*2

TradamsDMG::
	.db #0x00, #0x33
	.db #0x00, #0x57
	.db #0x00, #0xae
	.db #0x11, #0x4c
	.db #0xab, #0x88
	.db #0xd7, #0x00
	.db #0xe6, #0x00
	.db #0xf9, #0x00

damage_size = mina_size
damage_position = mina_position + string_separator*6

TradamsFireRate::
	.db #0x00, #0x20
	.db #0x50, #0x72
	.db #0xf5, #0xd7
	.db #0xaf, #0xdf
	.db #0xaf, #0xdf
	.db #0xaf, #0xdf
	.db #0xaf, #0xff
	.db #0xff, #0xf8

rate_size = damage_size
rate_position = damage_position + string_separator*2

string_separator = #3
player_bag_it: .db #0
player_bag_value: .db #0
player_skills_it: .db #0
player_skills_value: .db #0
X_hud_position: .db 0

hud_changes::.db #1	;; Life Change
			 .db #1 ;; Bits
			 .db #1 ;; Keys
			 .db #1 ;; Bombs
			 .db #1 ;; Skills Damage
			 .db #1 ;; Skills Fire Rate

number_of_hud_flags = #6

number_consumable_obj = #3

objects: .dw #bit_coin , #TradamsKeys , #TradamsMina_0 
objects_size	: .dw #bit_coin_size , #keys_size , #mina_size
objects_position: .db #bit_coin_pos , #keys_position , #mina_position

number_skills = #2

skills: .dw #TradamsDMG , #TradamsFireRate
skills_size: .dw #damage_size , #rate_size
skills_position: .db #damage_position , #rate_position

.globl cpct_drawSprite_asm
.globl cpct_getScreenPtr_asm

.globl player_skills
.globl player_bag

.globl int_to_string_asm
.globl draw_sentence
.globl Sentences_values
.globl StringBuffer

.globl simple_loop_inc_hl

global_score_1:: .db #0
global_score_2:: .db #0

.area _CODE 

;;===============================================================================
;; FUNCTION INITIALIZE_PLAYER_HUD_ASM
;;===============================================================================
initialize_player_hud_asm::
	ld hl , #hud_changes
	ld b  , #number_of_hud_flags
_init_hud_loop:
	ld (hl) , #1
	inc hl
	djnz _init_hud_loop
ret
;;===============================================================================
;; FUNCTION DRAW_PLAYER_HUD
;;===============================================================================
draw_player_hud_asm::
	ld hl , #hud_changes			;; HL = Pointer to HUD Changes
	push hl 						;; Save Pointer to HUD Changes
	call draw_player_life_hud
	ld de , #player_bag				;; Get Player Bag Pointer
	ld  a , (de)					;; A = Player bag First Value
	ld bc , #player_bag_value		;; BC = Pointer a Aux Player Bag Value
	ld (bc) , a 					;; BC = A
	pop  hl 						;; Recover Pointer to HUD Changes
	xor a 							;; A = 0
	ld (hl) , a						;; HUD LIFE CHANGES = 0
	inc hl 							;; Next Pointer Position (Bit Change)
	ld ix , #objects				;; Pointer to Objects Sprite
	ld iy , #objects_size			;; Pointer to Objects Size
	ld de , #objects_position		;; Pointer to Objects Position
	ld b , #number_consumable_obj	;; B = Number of Consumbles Objects
	call consumable_objects_hud
	;;ld de , #player_skills			;; DE = Player Skills
	;;inc de 							;; Next Pointer Position (Speed Y)
	;;inc de 							;; Next Pointer Position (Life)
	;;inc de 							;; Next Pointer Position (MXlife)
	;;inc de 							;; Next Pointer Position (Damage)
	;;ld  a , (de)					;; A = Player Skills Damage Value
	;;ld bc , #player_skills_value	;; Player Skills Value
	;;ld (bc) , a 					;; BC = A
	;;ld ix , #skills					;; Pointer to Skills Sprite
	;;ld iy , #skills_size			;; Pointer to Skills Size
	;;ld de , #skills_position		;; Pointer to Skills Position
	;;ld b  , #number_skills			;; B = Number of Skills
	;;call player_skills_hud
	ld hl , #X_hud_position			;; HL = Pointer to X Hud Position
	ld (hl) , #0					;; (HL) = 0
ret
;;===============================================================================
;; FUNCTION GET_SCREEN_HUD_POINTER
;;===============================================================================
get_screen_hud_pointer:
	ld hl , #X_hud_position				;; HL = Pointer to X HUD Position
	ld c , (hl)							;; C = Initial X
	ld b , #0							;; B = Initial Y
	ld de , #0xC000						;; Memory Screen Pointer
	call cpct_getScreenPtr_asm
ret
;;===============================================================================
;; FUNCTION DRAW_PLAYER_LIFES_HUD
;; 	Input Parameters HL = HUD Changes
;;===============================================================================
draw_player_life_hud:
	ld  a , (hl)						;; A = Hud Changes(1 - Life)
	or a 								;; Active Flags
	ret z 								;; Return IF A == 0
	ld hl , #player_skills				;; Pointer to Player Skills
	inc hl 								;; Next Pointer Position Speed Y
	inc hl 								;; Next Pointer Position Life
	ld c , (hl) 						;; C = Actual Player Life
	inc hl 								;; Next Pointer Position MaxLife
	ld b , (hl)							;; B = Max Life Value
_loop_draw_player_hud:
	push bc 							;; Save Iterator Value(B) and Actual Player Life (C)
	call get_screen_hud_pointer
	pop bc 								;; Recover Iterator Value(B) and Actual Player Life (C)
	ld a  , c 							;; A = Actual Player Life(C)
	ld hl , #player_lifes_sprites		;; HL = Player Life Sprites Pointer
	or a 								;; Active Flags
	jr z , _draw_life_sprite			;; IF A == 0 THEN JUMP
	inc hl 								;; Next Pointer Position
	inc hl 								;; Next Pointer Position
	dec a 								;; A--
	jr z , _draw_life_sprite			;; IF A == 0 THEN JUMP
	inc hl 								;; Next Pointer Position
	inc hl 								;; Next Pointer Position
	dec a 								;; A--	
_draw_life_sprite:
	ld c , a 							;; C = A
	push de 							;; Save DE Values
	ld e , (hl)							;; First Part of Sprite Pointer
	inc hl 								;; Next Pointer Position
	ld d , (hl)							;; Second Part of Sprite Pointer
	ex de , hl							;; Exchange DE<->HL
	pop de 								;; Recover DE Values
	push bc 							;; Save BC
	ld bc , #player_life_size			;; Player Life Size
	call cpct_drawSprite_asm			;; Draw Sprite
	ld hl , #X_hud_position				;; HL = Pointer to X Hud Position
	ld  a , (hl)						;; A  = X Hud Position
	add #player_life_width				;; A  = X HUD Position + Player Life Width
	ld (hl) , a 						;; (HL) = X HUD Position + Player Life Width
	pop bc 								;; Recover BC
	ld a , c 							;; A = C
	dec b 								;; Decrement B
	djnz _loop_draw_player_hud
ret


;;===============================================================================
;; FUNCTION CONSUMABLE_OBJECTS_HUD
;;
;;	Input Parameters : HL = HUD changes
;;					   IX = Pointer to Skills Array
;;					   IY = Pointer to Skills Size Array
;;					   DE = Pointer to Skills Position Array
;;						B = Number of Skills
;;===============================================================================
consumable_objects_hud:
	push bc								;; Save Iterator B
	push hl 							;; Save Pointer to HUD Changes
	push ix 							;; Save Pointer to Objects Array
	push iy 							;; Save Pointer to Objects Size Array
	push de 							;; Save Pointer to Objects Position Array
	ld  a , (hl)						;; A = Hud Changes(2 - Bit)
	or a 								;; Active Flags
	jr z , _next_iteration_1			;; Jump IF A == 0
	ld hl , #X_hud_position				;; HUD Position
	ld a , (de)							;; A = Actual Object X Position
	ld (hl) , a							;; New HUD Position
	call get_screen_hud_pointer			
	ex de , hl 							;; Exchange DE<->HL
	ld  l , 0(ix)						;; First Part of Object Pointer
	ld  h , 1(ix)						;; Second Part of Object Pointer
	ld  c , 0(iy) 						;; First Part of Size Pointer
	ld  b , 1(iy) 						;; Second Part of Size Pointer
	call cpct_drawSprite_asm			;; Draw Sprite
	pop de 								;; Recover DE
	push de 							;; Save Pointer to Objects Position Array
	ld a , (de)							;; A = Actual Object X Position
	add #string_separator				;; String Separator
	ld hl , #X_hud_position				;; Get HUD Pos
	ld (hl) , a							;; Update HUD Position
	ld hl , #Sentences_values			;; Sentence Value
	ld (hl) , a							;; Update Sentence Position
	ld hl , #player_bag_value			;; Pointer to Player Bag
	call int_to_string_asm				;; Int to String
	call draw_sentence
_next_iteration_1:
	ld hl , #player_bag_it				;; Player Bag Iterator
	inc (hl)							;; Player Bag Iterator++
	ld a , (hl)							;; A = PB Iterator
	ld hl , #player_bag					;; Player Bag Value
	call simple_loop_inc_hl
	ld  a , (hl)				
	ld bc , #player_bag_value	
	ld (bc) , a 		
	pop de 								;; Recover DE
	pop iy 								;; Recover IY
	pop ix 								;; Recover IX
	pop hl 								;; Recover HL
	pop bc								;; Recover Iterator
	inc de 								;; Next DE Value
	inc ix								;; -
	inc ix								;; -
	inc iy								;; -
	inc iy								;; Next Position in IX , IY
	xor a 								;; A = 0
	ld (hl) , a							;; HUD CHANGES = 0
	inc hl								;; Next Pointer Position (Next Change)
	djnz consumable_objects_hud
	ld ix , #player_bag_it
	ld (ix) , #0
	ld ix , #player_bag_value
	ld (ix) , #0
ret
;;===============================================================================
;; FUNCTION PLAYER_SKILLS_HUD
;;
;;	Input Parameters : HL = HUD changes
;;					   IX = Pointer to Objects Array
;;					   IY = Pointer to Objects Size Array
;;					   DE = Pointer to Objects Position Array
;;						B = Number of Consumble Objects
;;===============================================================================
player_skills_hud:
	push bc								;; Save Iterator B
	push hl 							;; Save Pointer to HUD Changes
	push ix 							;; Save Pointer to Objects Array
	push iy 							;; Save Pointer to Objects Size Array
	push de 							;; Save Pointer to Objects Position Array
	ld  a , (hl)						;; A = Hud Changes(2 - Bit)
	or a 								;; Active Flags
	jr z , _next_iteration_2				;; Jump IF A == 0
	ld hl , #X_hud_position				;; HUD Position
	ld a , (de)							;; A = Actual Object X Position
	ld (hl) , a							;; New HUD Position
	call get_screen_hud_pointer			
	ex de , hl 							;; Exchange DE<->HL
	ld  l , 0(ix)						;; First Part of Object Pointer
	ld  h , 1(ix)						;; Second Part of Object Pointer
	ld  c , 0(iy) 						;; First Part of Size Pointer
	ld  b , 1(iy) 						;; Second Part of Size Pointer
	call cpct_drawSprite_asm			;; Draw Sprite
	pop de 								;; Recover DE
	push de 							;; Save Pointer to Objects Position Array
	ld a , (de)							;; A = Actual Object X Position
	add #string_separator				;; String Separator
	ld hl , #X_hud_position				;; Get HUD Pos
	ld (hl) , a							;; Update HUD Position
	ld hl , #Sentences_values			;; Sentence Value
	ld (hl) , a							;; Update Sentence Position
	ld hl , #player_skills_value		;; Pointer to Player Bag
	call int_to_string_asm				;; Int to String
	call draw_sentence
_next_iteration_2:
	ld hl , #player_bag_it				;; Player Bag Iterator
	inc (hl)							;; Player Bag Iterator++
	ld a , (hl)							;; A = PB Iterator
	ld hl , #player_skills				;; Player Bag Value
	call simple_loop_inc_hl
	ld  a , (hl)				
	ld bc , #player_skills_value	
	ld (bc) , a 		
	pop de 								;; Recover DE
	pop iy 								;; Recover IY
	pop ix 								;; Recover IX
	pop hl 								;; Recover HL
	pop bc								;; Recover Iterator
	inc de 								;; Next DE Value
	inc ix								;; -
	inc ix								;; -
	inc iy								;; -
	inc iy								;; Next Position in IX , IY
	xor a 								;; A = 0
	ld (hl) , a							;; HUD CHANGES = 0
	inc hl								;; Next Pointer Position (Next Change)
	djnz player_skills_hud
ret