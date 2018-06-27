
.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================
;;Tile id_Tradams_miner: 8x8 pixels, 2x8 bytes.

MINER_WIDTH = #2
MINER_HEIGHT = #8

Tradams_miner_0::
	.db #0x11, #0x88
	.db #0x33, #0xcc
	.db #0x67, #0x6e
	.db #0xfd, #0xfb
	.db #0x77, #0xee
	.db #0x22, #0x44
	.db #0x55, #0xaa
	.db #0x88, #0x11


Tradams_miner_1::
	.db #0x11, #0x88
	.db #0x33, #0xcc
	.db #0x67, #0x6e
	.db #0xfd, #0xfb
	.db #0x77, #0xee
	.db #0x32, #0xc4
	.db #0x11, #0x88
	.db #0x00, #0x00

;; Tile id_Tradams_Robot_0: 16x16 pixels, 4x16 bytes.

ROBOT_WIDTH = #4
ROBOT_HEIGHT = #16

Tradams_Robot_0::
	.db #0x11, #0x00, #0x00, #0x88
	.db #0x00, #0x88, #0x11, #0x00
	.db #0x00, #0x44, #0x22, #0x00
	.db #0x11, #0xff, #0xff, #0x88
	.db #0x22, #0x77, #0xee, #0x44
	.db #0x44, #0xff, #0xff, #0x22
	.db #0x55, #0xe2, #0x74, #0xaa
	.db #0x76, #0xf1, #0xf8, #0xe6
	.db #0x55, #0xf2, #0xf4, #0xaa
	.db #0x44, #0xef, #0x7f, #0x22
	.db #0x55, #0xdd, #0xbb, #0xaa
	.db #0x55, #0xee, #0x77, #0xaa
	.db #0x55, #0x33, #0xcc, #0xaa
	.db #0x00, #0x88, #0x11, #0x00
	.db #0x00, #0x66, #0x66, #0x00
	.db #0x00, #0x77, #0xee, #0x00

Tradams_Robot_1::
	.db #0x11,#0x00,#0x00,#0x88
	.db #0x00,#0x88,#0x11,#0x00
	.db #0x00,#0x44,#0x22,#0x00
	.db #0x11,#0xff,#0xff,#0x88
	.db #0x22,#0x77,#0xee,#0x44
	.db #0x44,#0xcc,#0x33,#0x22
	.db #0x55,#0xee,#0x77,#0xaa
	.db #0x77,#0xff,#0xff,#0xee
	.db #0x55,#0xee,#0x77,#0xaa
	.db #0x44,#0xdd,#0xbb,#0x22
	.db #0x55,#0x22,#0x44,#0xaa
	.db #0x55,#0xdd,#0xbb,#0xaa
	.db #0x00,#0xbb,#0xdd,#0x00
	.db #0x00,#0x44,#0x22,#0x00
	.db #0x00,#0x66,#0x66,#0x00
	.db #0x00,#0x77,#0xee,#0x00


Tradams_Robot_2::
	.db #0x00,#0x44,#0x00,#0x00
	.db #0x00,#0x22,#0x00,#0x00
	.db #0x00,#0x11,#0x00,#0x00
	.db #0x00,#0xff,#0xcc,#0x00
	.db #0x11,#0x22,#0xaa,#0x00
	.db #0x30,#0xcc,#0x33,#0xcc
	.db #0x30,#0x99,#0xbb,#0x22
	.db #0x30,#0x99,#0xbb,#0xaa
	.db #0x10,#0x99,#0xbb,#0x66
	.db #0x01,#0x99,#0xbb,#0xaa
	.db #0x77,#0x99,#0x99,#0x22
	.db #0x77,#0x44,#0x11,#0xcc
	.db #0x77,#0xaa,#0x66,#0x00
	.db #0x33,#0x66,#0xcc,#0x00
	.db #0x00,#0x22,#0x88,#0x00
	.db #0x00,#0x33,#0x88,#0x00

Tradams_Robot_3::
	.db #0x00,#0x00,#0x22,#0x00
	.db #0x00,#0x00,#0x44,#0x00
	.db #0x00,#0x00,#0x88,#0x00
	.db #0x00,#0x33,#0xff,#0x00
	.db #0x00,#0x55,#0x44,#0x88
	.db #0x33,#0xcc,#0x33,#0xc0
	.db #0x44,#0xdd,#0x99,#0xc0
	.db #0x55,#0xdd,#0x99,#0xc0
	.db #0x66,#0xdd,#0x99,#0x80
	.db #0x55,#0xdd,#0x99,#0x08
	.db #0x44,#0x99,#0x99,#0xee
	.db #0x33,#0x88,#0x22,#0xee
	.db #0x00,#0x66,#0x55,#0xee
	.db #0x00,#0x33,#0x66,#0xcc
	.db #0x00,#0x11,#0x44,#0x00
	.db #0x00,#0x11,#0xcc,#0x00

.globl player_position
.globl player_add_skills_values_asm

.globl all_enemy_position
.globl all_enemy_vision
.globl all_enemy_skills
.globl enemy_skills

.globl simple_loop_inc_hl
.globl draw_entity_asm
.globl clean_last_position_entity
.globl collision_entities_asm
.globl move_entity_asm
.globl number_of_position_parameters
.globl number_of_skill_parameters

.globl all_attacks
.globl all_attack_position
.globl get_attack_position

.globl actual_level
.globl check_sprite_draw

.globl set_damage_cooldown
.globl player_damage_cooldown
.globl player_position

.globl set_object_screen_asm
.globl cpct_getRandom_xsp40_u8_asm


.globl max_attack_into_screen_asm
.globl entity_attack_param_asm

.globl cpct_getRandom_lcg_u8_asm
;;===============================================================================
;; ENEMIES VALUES
;;===============================================================================
ENEMY_BOMBER = #0
ENEMY_ROBOT  = #1
ENEMY_TURRET = #2

ROBOT_DOWN_STATE = #0
ROBOT_LEFT_STATE = #1
ROBOT_UP_STATE = #2
ROBOT_RIGHT_STATE = #3

ROBOT_STATES = #4

X_ENEMIES_POS = #0x3C
X_MIN_ENEMY_POS = #4

Y_MIN_ENEMY_POS = #40
Y_MAX_ENEMY_POS = #88

ACTUAL_DEFINED_ENEMY = #2

;; 					Vision ( 0 = DOWN , 1 = UP , 2 = RIGHT , 3 = LEFT)****
ENEMY_BOMBER_SPRITE: 
	.dw Tradams_miner_0 , Tradams_miner_1 , Tradams_miner_1 , Tradams_miner_0
ENEMY_ROBOT_SPRITE: 
	.dw Tradams_Robot_0 , Tradams_Robot_1 , Tradams_Robot_3 , Tradams_Robot_2

;;ENEMY_TURRET_SPRITE: 
;;	.db ENEMY_BOMBER
;;	.dw Tradams_miner_0 , Tradams_miner_1 , Tradams_miner_1 , Tradams_miner_0

ALL_ENEMY_SIZE:: .db #MINER_WIDTH , MINER_HEIGHT , ROBOT_WIDTH , ROBOT_HEIGHT

ALL_ENEMY_SPRITES::
	.dw ENEMY_BOMBER_SPRITE , ENEMY_ROBOT_SPRITE

.macro defineEnemy name
    name'_enemy::
	name'_active: .db #0		;;(1)
    name'_sprite: .dw #0x0000	;;(2-3)
	name'_type:	  .db #0     	;;(4)
	name'_state:  .db #0		;;(5)
.endm

states_filter = #0x03

defined_enemy_params = #5

all_defined_enemies::
defineEnemy a
defineEnemy b
defineEnemy c
defineEnemy d

max_enemies_by_room = #3

enemy_movement_turn: .db #0

.area _CODE 

;;===============================================================================
;; DEFINED FUNCTIONS
;;===============================================================================
;; Vision ( 0 = DOWN , 1 = UP , 2 = RIGHT , 3 = LEFT)****
;;===============================================================================
;; FUNCTION SET_ENEMIES_ROOM @TODO
;;===============================================================================
set_enemies_room_asm::
	ld hl , #actual_level
	ld a , (hl)
	cp #max_enemies_by_room
	jp p , _max_enemies_by_p
_enemies_by_level:
	ld b , (hl)							;; B = Actual Level
	jr _set_enemies_init
_max_enemies_by_p:
	ld  b , #max_enemies_by_room		;;  B = Number of enemies
_set_enemies_init:
	ld hl , #all_defined_enemies		;; HL = ALL DEFINED ENEMIES POINTER
	ld  c , #0							;;  C = Array Pos
_loop_enemies_room:
	push bc 							;; Save BC Values -------------------(0)
	push hl 							;; Save HL Values -------------------(1)
	ld ix , #ENEMY_ROBOT_SPRITE
	inc(hl)								;; Active Enemy
	inc hl 								;; Next Pointer Position (SpriteA)
	ld a , 1(ix)						;; A = First Part of Sprite Pointer
	ld (hl) , a							;; HL = A
	inc hl 								;; Next Pointer Position (SpriteB)
	ld a , 0(ix)						;; A = Second Part of Sprite Pointer
	ld (hl) , a							;; HL = A
	inc hl 								;; Next pointer Position (Type Enemy)
	ld (hl) , #ENEMY_ROBOT				;; HL = Enemy Robot
	inc hl  							;; Next Pointer Position (State Enemy)
	push bc 							;; Save BC Values -------------------(A)
	push hl 							;; Save HL Values -------------------(B)
	call cpct_getRandom_lcg_u8_asm 		;; A = Random Number
	pop hl 								;; Recover HL Values ----------------(B)
	and #states_filter 					;; A = A and states filter
	ld (hl) , a 						;; HL = New Enemy State
	pop bc 								;; Recover BC Values ----------------(A)
	call get_enemy_position				;; HL = Enemy Position
	push hl 							;; Save HL Values -------------------(2)
	pop iy 								;; Recover HL into IY ---------------(2)
	call cpct_getRandom_lcg_u8_asm		;; A = Random Number
	and #X_ENEMIES_POS					;; A = A and X_ENEMY_POS
	add #X_MIN_ENEMY_POS				;; A = A + X_MIN
	ld 0(iy) , a 						;; Enemy X Pos = A
	ld 2(iy) , a 						;; Enemy X Last Pos = A 
	call cpct_getRandom_lcg_u8_asm		;; A = Random Number
	or a 								;; Active Flags
	jp m , _max_y_pos					;; IF A > 127
	add #Y_MIN_ENEMY_POS				;; A = A + Y_MIN
	jr _next_enemy_setting
_max_y_pos:
	sub #Y_MAX_ENEMY_POS				;; A = A - Y_MAX
_next_enemy_setting:
	ld 3(iy) , a 						;; Enemy Y Pos = A
	ld 5(iy) , a 						;; Enemy Y Last Pos = A 
	dec 5(iy)							;; Enemy Y Last Pos--
	ld hl , #ALL_ENEMY_SIZE				;; HL = All Enemy Size
	pop ix 								;; Recover HL into IX Values --------(1)
	ld a , 3(ix)						;; A = Enemy Type
	add a 								;; A = A*2
	push ix 							;; Save IX Values -------------------(3)
	call simple_loop_inc_hl 			;; HL Loop
	ld a , (hl)							;; A = Enemy Width 
	inc hl 								;; Next Enemy Size Value
	ld 1(iy) , a 						;; Enemy Width = A
	ld a , (hl)							;; A = Enemy Height
	ld 4(iy) , a 						;; Enemy Height = A
	pop ix 								;; Recover HL Values INTO IX --------(3)
	pop bc 								;; Recover BC Values ----------------(0)
	push bc 							;; Save BC Values -------------------(4)
	push ix 							;; Save HL Values -------------------(5)
	call set_enemy_skills
	pop hl 								;; Recover HL Values ----------------(5)
	ld a,  #defined_enemy_params		;; A = Defined Enemy Params
	call simple_loop_inc_hl	
	pop bc 								;; Recover BC Values ----------------(4)
	inc c								;; Increment Array Pos
	djnz _loop_enemies_room
ret
;;===============================================================================
;; FUNCTION GET_ENEMY_SKILLS
;; Input Parameters : C = Array Pos
;; Output Parameters: HL = Array Pointer Position
;;===============================================================================
get_enemy_skills:
	ld hl , #number_of_skill_parameters
	ld  b , (hl)
	ld hl , #all_enemy_skills
	xor a
_loop_get_enemy_skills:
	add c
	ret z
	djnz _loop_get_enemy_skills
	call simple_loop_inc_hl
ret
;;===============================================================================
;; FUNCTION GET_ENEMY_DEFAULT_SKILLS
;; Input Parameters : C = Array Pos
;; Output Parameters: HL = Array Pointer Position
;;===============================================================================
get_enemy_default_skills:
	ld hl , #number_of_skill_parameters
	ld  b , (hl)
	ld hl , #enemy_skills
	xor a
_loop_get_enemy_default_skills:
	add c
	ret z
	djnz _loop_get_enemy_default_skills
	call simple_loop_inc_hl
ret
;;===============================================================================
;; FUNCTION SET_ENEMY_SKILLS
;; Input Parameters : C = Array Pos
;; 					  IX = Enemy Defined Pointer
;;===============================================================================
set_enemy_skills::
	push bc 							;; SAVE BC Values -------------------(0)
	ld c , 3(ix)						;; C = Type Enemy
	call get_enemy_default_skills		;; HL = Enemy Default Skills Pointer
	push hl 							;; Save HL Values -------------------(1)
	pop ix 								;; Recover IX Values ----------------(1)
	pop bc 								;; Recover BC Values ----------------(0)
	call get_enemy_skills				;; HL = Enemy Skills Pointer
	push hl 							;; Save HL Values -------------------(2)
	pop iy 								;; Recover HL Values ----------------(2)
	ld hl , #number_of_skill_parameters ;; HL = Pointer to Nº Skill Parameters
	ld b , (hl) 						;; B  = Number Skills Parameters
_setting_enemy_skills:
	ld a , (ix)							;; A = Skill Value
	ld (iy) , a 						;; IY = A
	inc ix 								;; Next Default Skills Position
	inc iy 								;; Next Enemy Skills Position
	djnz _setting_enemy_skills
ret
;;===============================================================================
;; FUNCTION GET_ENEMY_POSITION
;; Input Parameters : C = Array Pos
;; Output Parameters: HL = Array Pointer Position
;;===============================================================================
get_enemy_position:
	ld hl , #number_of_position_parameters
	ld b , (hl)
	ld hl , #all_enemy_position			;; HL = All enemy position array
	xor a 								;; A = 0
_loop_get_enemy_position:
	add c 								;; A = A + C
	ret z								;; IF A = 0 THEN RETURN
	djnz _loop_get_enemy_position
	call simple_loop_inc_hl
ret
;;===============================================================================
;; FUNCTION DRAW_ALL_ENEMIES_ASM
;;===============================================================================
draw_all_enemies_asm::
	ld ix , #all_defined_enemies		;; IX = Pointer to Defined Enemies
	ld  b , #max_enemies_by_room		;;  B = Max enemies like iterator
	ld  c , #0 							;;  C = Array Position
_draw_all_enemies:
	push bc 							;; Save BC Values -----------------(0)
	ld  a , 0(ix)						;; Active Enemy
	or a 								;; Active Flags
	jr z , _next_iteration_draw_enemies
	call get_enemy_position				;; HL = ENEMY Position
	push hl 							;; Save HL Values
	call check_sprite_draw
	pop hl 								;; Recover HL Values
	jr z , _next_iteration_draw_enemies
	ld d , 1(ix)						;;  D = First Part of Sprite Pointer
	ld e , 2(ix)						;;  C = Second Part of Sprite Pointer
	call draw_entity_asm
_next_iteration_draw_enemies:
	ld bc , #0							;; BC = 0
	ld  c , #defined_enemy_params		;; C = Defined Enemy Params
	add ix , bc 						;; Next Entity Position
	pop bc 								;; Recover BC Values --------------(0)
	inc c 								;; Increment C Value
	djnz _draw_all_enemies
ret
;;===============================================================================
;; FUNCTION ENEMIES_BULLET_COLLISION_ASM
;;===============================================================================
enemies_bullet_collision_asm::
	ld hl , #all_defined_enemies		;; HL = Pointer to All defined enemies
	ld  b , #max_enemies_by_room		;;  B = Max enemies by room Pointer
	ld  c , #0							;;  C = Array Position
_loop_enemies_bullet_collision:
	push bc 							;; Save BC Values -------------------(0)
	push hl 							;; Save HL Values -------------------(1)
	ld a , (hl)							;; A = Active Enemy
	or a 								;; Active Flags
	jp z , _next_enemy_to_evaluate
	call bullet_enemy_check_collision   ;; A = Collision && IY = Bullet Pointer
	jp z , _next_enemy_to_evaluate
	pop hl 								;; Recover HL -----------------------(1A)
	pop bc 								;; Recover BC Values ----------------(0A)
	push bc 							;; Save BC Values -------------------(2)
	push hl 							;; Save HL Values -------------------(3)
	call get_enemy_skills
	push hl 							;; Save HL Values -------------------(4)
	pop ix 								;; Recover HL Values into IX --------(4)
	ld a , 2(ix)						;; A = Enemy Life Points
	sub 4(iy)							;; A = A - IY
	ld 2(ix) , a						;; Decrement Life Points
_next_enemy_to_evaluate:
	ld a , #defined_enemy_params		;; Defined enemy params
	pop hl 								;; Recover HL Values ----------------(1B - 3)
	call simple_loop_inc_hl				;; Next HL Value
	pop bc 								;; Recover BC Values ----------------(0B - 2)
	inc c 								;; Increment C Value
	djnz _loop_enemies_bullet_collision
ret
;;===============================================================================
;; FUNCTION BULLET_ENEMY_CHECK_COLLISION
;; Input Parameters:	HL = Define Enemy Pointer
;; 						 C = Array Position
;; OutPut Parameters: A = (0 No Collision || != 0 Collision)
;; 					 IY = Bullet 
;;===============================================================================
bullet_enemy_check_collision:
	call get_enemy_position				;; HL = Enemy Position
	push hl 							;; Save HL Value ----------------------(0)
	pop ix 								;; Recover HL Value into IX -----------(0)
	ld hl , #max_attack_into_screen_asm
	ld  b , (hl)						;; B = Max Attacks into screen
	ld  c , #0							;; C = Array Position
	ld hl , #all_attacks				;; HL = Pointer to All Attacks
_loop_bullet_enemy_collision:
	push bc 							;; Save BC Values ---------------------(1)
	push hl 							;; Save HL Values ---------------------(2)
	ld a , (hl)							;; A = Active Bullet Value
	or a 								;; Active Flags
	jr z , _next_bullet_to_evaluate     
	call get_attack_position			;; HL = Attack Position
	push hl 							;; Save HL Values ---------------------(3)
	pop iy 								;; Recover HL Values into  IY ---------(3)
	call collision_entities_asm
	or a  								;; Active Flags
	jr z , _next_bullet_to_evaluate		;; JUMP If no exist Collision
	pop iy 								;; Recover IY Values ------------------(2A)
	pop bc 								;; Recover BC Values ------------------(1A)
	ld 2(iy) , #0						;; Bullet Life = 0
	ld a , #1 							;; A = 1
	or a 								;; Active Flags
ret
_next_bullet_to_evaluate:
	ld hl , #entity_attack_param_asm	;; Pointer of N Params Attack
	ld  a , (hl) 						;; A = N Params
	pop hl 								;; Recover HL Values ------------------(2B)
	call simple_loop_inc_hl
	pop bc 								;; Recover BC Values ------------------(1B)
	inc c 								;; Increment C Values
	djnz _loop_bullet_enemy_collision
	xor a 								;; A = 0
ret
;;===============================================================================
;; FUNCTION ENEMIES_UPDATE_ASM
;;===============================================================================
enemies_update_asm::
	ld hl , #all_defined_enemies		;; HL = Pointer to All defined enemies
	ld  b , #max_enemies_by_room		;;  B = Max enemies by room Pointer
	ld  c , #0							;;  C = Array Position
_loop_enemies_update:
	push bc 							;; Save BC Values -------------------(0)
	push hl 							;; Save HL Values -------------------(1)
	ld a , (hl)							;; A = Enemy Active
	or a 								;; Active Flags
	jr z , _check_next_enemy
	call get_enemy_skills
	push hl 							;; Save HL Values -------------------(2)
	pop ix 								;; Recover HL Values into IX --------(2)
	ld a , 2(ix)						;; A = Enemy Life
	or a 								;; Active Flags
	jr z , disable_enemy
	jp m , disable_enemy
_check_next_enemy_state:
	pop ix 								;; Recover IX Values ----------------(1)
	pop  bc 							;; Recover BC Values ----------------(0)
	push bc 							;; Save BC Values -------------------(A)
	push ix 							;; Save HL Values -------------------(3)
	call robot_state_machine
_check_next_enemy:
	ld a , #defined_enemy_params		;; Defined enemy params
	pop  hl 							;; Recover HL Values ----------------(B - 3)
	call simple_loop_inc_hl
	pop bc 								;; Recover BC Values ----------------(4)
	inc c 								;; Incremente Array Position
	djnz _loop_enemies_update
ret
;;===============================================================================
;; FUNCTION DISABLE_ENEMY
;; Input Parameters: 	HL = Defined Enemy Pointer
;; 						 C = Array Pointer
;;===============================================================================
disable_enemy:
	pop  hl 							;; Recover HL Values ----------------(1A)
	pop bc 								;; Recover BC Values ----------------(0A)
	push bc 							;; Save BC Values -------------------(3)
	push hl 							;; Save HL Values -------------------(4)
	ld (hl) , #0						;; HL = 0
	call get_enemy_position				;; HL = Get Enemy Position
	push hl 							;; Save HL Position
	pop ix 								;; Recover HL into IX
	call clean_last_position_entity

	call cpct_getRandom_xsp40_u8_asm	;; A = Random Number
	and #3								;; AND #7 Number of Random Objects
	ld d , a							;; D = Random ID Object
	ld b , 3(ix)						;; B = Enemy Y Position
    ld c , 0(ix)						;; C = Enemy X Position
    call set_object_screen_asm			;; Set Object

	jr _check_next_enemy
;;===============================================================================
;; FUNCTION ROBOT_PLAYER_CHECKER
;; Input Parameters: 	IY = ENEMY POSITION
;; OutPut Parameters: 	 B = New Enemy State (0-3 States | -1 fail)
ROBOT_DOWN_STATE = #0
ROBOT_LEFT_STATE = #1
ROBOT_UP_STATE = #2
ROBOT_RIGHT_STATE = #3
;;===============================================================================
robot_player_checker:
	ld hl , #player_position
	ld b , #-1
	ld a , 0(iy)				;; A = Enemy X Position
	cp  (hl)					;; Compare X Player Position
	jr z , _x_positions
	ld a , #3					;; A = 3
	call simple_loop_inc_hl     ;; HL = Loop
	ld b , #-1					;; B = 0
	ld a , 3(iy)				;; A = Enemy Y Position
	cp (hl)						;; Compare Y Player Position
	ret nz 						;; IF CP != 0 THEN RETURN
_y_positions:
	dec hl						;; Last Pointer Position (X LAST)
	dec hl						;; Last Pointer Position (WIDTH)
	dec hl						;; Last Pointer Position (X POS)
	ld a , (hl)					;; A = X Player
	sub 0(iy)					;; A = X Player - X Enemy
	jp m , _y_left_positions
	ld b , #ROBOT_RIGHT_STATE
	ret
_y_left_positions:
	ld b , #ROBOT_LEFT_STATE
	ret
_x_positions:
	inc hl						;; Next Pointer Pos (WIDTH)
	inc hl						;; Next Pointer Pos (X LAST)
	inc hl						;; Next Pointer Pos (Y POS)
	ld a , (hl)					;; A = Y Player
	sub 3(iy)					;; A = Y Player - Y Enemy
	jp m , _x_up_positions
	ld b , #ROBOT_DOWN_STATE
	ret
_x_up_positions:
	ld b , #ROBOT_UP_STATE
ret

;;===============================================================================
;; FUNCTION ROBOT_STATE_MACHINE
;; Input Parameters: 	IX = Defined Enemy Pointer
;; 						 C = Array Pointer
;;===============================================================================
robot_state_machine:
	push bc 					;; Save BC Values ------------------(0)
	call get_enemy_skills		;; HL = Enemy Skills
	pop  bc 					;; Recover BC Values ---------------(0)
	push hl 					;; Save HL Values ------------------(1)
	pop iy 						;; Recover HL Values into IY -------(1)
	call get_enemy_position     ;; HL = Enemy Position
	ld a , 4(ix) 				;; A = Enemy State
	ld bc,#0					;; BC = 0
	cp #ROBOT_RIGHT_STATE		;; COMPARE WITH STATES
	jr z , _right_state			;; IF CP == 0
	cp #ROBOT_UP_STATE			;; COMPARE WITH STATES
	jr z , _up_state			;; IF CP == 0
	cp #ROBOT_LEFT_STATE		;; COMPARE WITH STATES
	jr z , _left_state			;; IF CP == 0
_down_state:
	ld c , 1(iy)				;; C = Enemy Y Speed
	jr _check_last_movement
_right_state:
	ld b , 0(iy)				;; C = Enemy X Speed
	jr _check_last_movement
_up_state:
	ld a , 1(iy)				;; A = Enemy Y Speed
	neg							;; A = -A
	ld c , a 					;; C = A
	jr _check_last_movement
_left_state:
	ld a , 0(iy)				;; A = Enemy X Speed
	neg							;; A = -A
	ld b , a 					;; B = A
_check_last_movement::
	push hl 					;; Save HL Values --------------(2)
	call move_entity_asm 		;; Move Entity
	pop  iy 					;; Recover HL Values into IY ---(2)
	call robot_player_checker
	ld a , b 					;; A = B
	or a 						;; Active Flags
	jp m , _next_state_enemy
	ld 4(ix) , a 				;; Change State
	jr update_sprite_value
_next_state_enemy:
	ld a , 0(iy) 				;; A = Entity X Pos
	cp 2(iy)					;; A CP Entity Last X Pos
	jr nz , update_sprite_value
	ld a , 3(iy) 				;; A = Entity Y Pos
	cp 5(iy)					;; A CP Entity Last Y Pos
	jr nz , update_sprite_value
	inc 4(ix)					;; Increment State Value
	ld a , 4(ix) 				;; A = New State
	cp #ROBOT_STATES			;; IF A > Number of States
	jr nz , update_sprite_value
	ld 4(ix) , #0
update_sprite_value:
	ld a , 4(ix)				;; A = Enemy State
	cp #ROBOT_RIGHT_STATE		;; COMPARE WITH STATES
	jr z , _right_state_sprite	;; IF CP == 0
	cp #ROBOT_UP_STATE			;; COMPARE WITH STATES
	jr z , _up_state_sprite		;; IF CP == 0
	cp #ROBOT_LEFT_STATE		;; COMPARE WITH STATES
	jr z , _left_state_sprite	;; IF CP == 0
	ld hl , #Tradams_Robot_0
	jr _assign_new_sprite
_right_state_sprite:
	ld hl , #Tradams_Robot_3
	jr _assign_new_sprite
_up_state_sprite:
	ld hl , #Tradams_Robot_1
	jr _assign_new_sprite
_left_state_sprite:
	ld hl , #Tradams_Robot_2
_assign_new_sprite:
	ld 1(ix) , h
	ld 2(ix) , l
ret
;;===============================================================================
;; FUNCTION RESET_ENEMIES_ROOM
;;===============================================================================
reset_enemies_room_asm::
	ld hl , #all_defined_enemies		;; HL = Pointer to All defined enemies
	ld  b , #max_enemies_by_room		;;  B = Max enemies by room Pointer
	ld  c , #0							;;  C = Array Position
_loop_reset_enemies:
	push bc 							;; Save BC Values ---------------------(1)
	push hl 							;; Save HL Values ---------------------(2)
	ld a , (hl)							;; A = Active
	or a 								;; Active Flags
	jr z , _next_reset_enemies_iteration
	ld (hl) , #0 						;; HL = 0
	call get_enemy_position
	call clean_last_position_entity
_next_reset_enemies_iteration:
	ld a , #defined_enemy_params		;; Defined enemy params
	pop  hl 							;; Recover HL Values ------------------(2)
	call simple_loop_inc_hl
	pop bc 								;; Recover BC Values ------------------(1)
	inc c 								;; Incremente Array Position
	djnz _loop_reset_enemies
ret
;;===============================================================================
;; FUNCTION PLAYER_ENEMIES_COLLISION_ASM
;;===============================================================================
player_enemies_collision_asm::
	ld hl , #player_damage_cooldown		;; HL = Player Damage Cooldown
	ld a , (hl)							;;  A = Value
	or a 								;; Active Flags
	ret nz 								;; Return if Cooldown != 0
	ld hl , #all_defined_enemies		;; HL = Pointer to All defined enemies
	ld  b , #max_enemies_by_room		;;  B = Max enemies by room Pointer
	ld  c , #0							;;  C = Array Position
_loop_player_enemies_collision:
	push bc 							;; Save BC Values
	push hl 							;; Save HL Values
	ld a , (hl) 						;; A = Active Enemy
	or a 								;; Active Flags
	jr z , _next_PE_collision
	call get_enemy_position 			;; HL = Position Enemy Pointer
	push hl 							;; Save HL Values
	pop  ix 							;; Recover HL Values into IX
	ld iy , #player_position			;; IY = Player Position
	call collision_entities_asm 		;; Check Collision
	or a 								;; Active Flags
	jr z , _next_PE_collision 			;; Jump if no collision
	pop hl 								;; Recover HL Values
	pop bc 								;; Recover BC Values
	push bc 							;; Save BC Values
	push hl 							;; Save HL Values
	call get_enemy_skills
	push hl 							;; Save HL Values
	pop  ix 							;; Recover HL Values into IX
	ld a , 4(ix)						;; E = Enemy Player
	neg 								;; A = -A
	ld e , a  							;; E = A
	ld a , #2 						    ;; A = Skills Position
	call player_add_skills_values_asm
	call set_damage_cooldown
_next_PE_collision:
	ld a , #defined_enemy_params
	pop hl 								;; Recover HL Values
	call simple_loop_inc_hl
	pop bc 								;; Recover BC Values
	inc c
	djnz _loop_player_enemies_collision
ret