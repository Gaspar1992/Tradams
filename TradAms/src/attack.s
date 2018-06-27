

.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================


.globl simple_loop_inc_hl
.globl draw_entity_asm
.globl clean_last_position_entity
.globl collision_entities_asm
.globl move_entity_asm
.globl all_attack_position
.globl number_of_position_parameters

Min_screen_W       = #4                     ;; Min Width of the screen (bytes)
Max_screen_W       = #80 - Min_screen_W     ;; Max Width of the screen (bytes)
Min_screen_H       = #32 + #8               ;; Min Height of the screen (pixels)
Max_screen_H       = #200 - #16             ;; Max Height of the screen (pixels)


bullet_sprite: .db #0x46, #0x26

bullet_width = #1
bullet_height = #2

;; Vision ( 0 = DOWN , 1 = UP , 2 = RIGHT , 3 = LEFT)****
.macro defineEntityAttack name , Active,  Speed , life , Direction , Damage
    attack_'name':: 
    attack_'name'_active:       .db Active           ;; Active = 1 , Not Active = 0
    attack_'name'_speed:        .db Speed            ;; Bullet Speed
    attack_'name'_life:         .db life             ;; life
    attack_'name'_direction:    .db Direction        ;; Direction Like Vision****
    attack_'name'_damge:        .db Damage           ;; Damage
.endm

entity_attack_parameters = 5
entity_attack_param_asm:: .db #entity_attack_parameters

all_attacks::
defineEntityAttack a , 0 , 0 , 0 , 0 , 0   ;; 1
defineEntityAttack b , 0 , 0 , 0 , 0 , 0   ;; 2
defineEntityAttack c , 0 , 0 , 0 , 0 , 0   ;; 3
defineEntityAttack d , 0 , 0 , 0 , 0 , 0   ;; 4
defineEntityAttack e , 0 , 0 , 0 , 0 , 0   ;; 5
defineEntityAttack f , 0 , 0 , 0 , 0 , 0   ;; 6
defineEntityAttack g , 0 , 0 , 0 , 0 , 0   ;; 7
defineEntityAttack h , 0 , 0 , 0 , 0 , 0   ;; 8
defineEntityAttack i , 0 , 0 , 0 , 0 , 0   ;; 9
defineEntityAttack j , 0 , 0 , 0 , 0 , 0   ;; 10
defineEntityAttack k , 0 , 0 , 0 , 0 , 0   ;; 11
defineEntityAttack l , 0 , 0 , 0 , 0 , 0   ;; 12
defineEntityAttack m , 0 , 0 , 0 , 0 , 0   ;; 13
defineEntityAttack n , 0 , 0 , 0 , 0 , 0   ;; 14
defineEntityAttack o , 0 , 0 , 0 , 0 , 0   ;; 15
defineEntityAttack p , 0 , 0 , 0 , 0 , 0   ;; 16
defineEntityAttack q , 0 , 0 , 0 , 0 , 0   ;; 17
defineEntityAttack r , 0 , 0 , 0 , 0 , 0   ;; 18
defineEntityAttack s , 0 , 0 , 0 , 0 , 0   ;; 19
defineEntityAttack t , 0 , 0 , 0 , 0 , 0   ;; 20
defineEntityAttack u , 0 , 0 , 0 , 0 , 0   ;; 21
defineEntityAttack v , 0 , 0 , 0 , 0 , 0   ;; 22
defineEntityAttack w , 0 , 0 , 0 , 0 , 0   ;; 23
defineEntityAttack x , 0 , 0 , 0 , 0 , 0   ;; 24
defineEntityAttack y , 0 , 0 , 0 , 0 , 0   ;; 25
defineEntityAttack z , 0 , 0 , 0 , 0 , 0   ;; 26
defineEntityAttack aa , 0 , 0 , 0 , 0 , 0  ;; 27
defineEntityAttack ab , 0 , 0 , 0 , 0 , 0  ;; 28
defineEntityAttack ac , 0 , 0 , 0 , 0 , 0  ;; 29
defineEntityAttack ad , 0 , 0 , 0 , 0 , 0  ;; 30

max_attack_into_screen = 30

max_attack_into_screen_asm:: .db #max_attack_into_screen
defineEntityAttack aux , 0 , 0 , 0 , 0 , 0   ;; AUXILIAR
.area _CODE 

;;===============================================================================
;; DEFINED FUNCTIONS
;;===============================================================================
;;===============================================================================
;; FUNCTION DRAW_ATTACK_ASM
;;===============================================================================
draw_attack_asm::
    ld b , #max_attack_into_screen          ;; B = Max Number of Iterations
    ld c , #0                               ;; C = Array Pos
    ld hl , #all_attacks                    ;; HL = Pointer to All Attacks
_loop_draw_attacks:
    push bc                                 ;; Save BC Values
    ld a , (hl)                             ;; A = Active Value (0 = Disabled)
    or a                                    ;; Active Flags
    push hl                                 ;; Save HL Value
    call nz , draw_attack                   ;; IF Attack Enabled Call
    pop hl                                  ;; Recover HL
    ld a , #entity_attack_parameters        ;; A = entity_attack_parameters
    call simple_loop_inc_hl                 ;; HL Loop
    pop  bc                                 ;; Recover BC Values
    inc c                                   ;; increment C
    djnz _loop_draw_attacks
ret

draw_attack:
    call get_attack_position
    ld de , #bullet_sprite
    call draw_entity_asm
ret
;;===============================================================================
;; defineEntityAttack name , Active,  Speed , life , Direction , Damage
;;===============================================================================
;; FUNCTION SET_ATTACK_INTO_SCREEN
;; Input Parameters: HL = Entity Vision Pointer
;;                   IX = Entity Skills Pointer
;;                   DE = Entity Position Pointer
;;===============================================================================
set_attack_into_screen::
    ld iy , #attack_aux                 ;; IY = Pointer to Attack Aux
    ld a , 6(ix)                        ;; A = Entity Attack Speed
    ld 1(iy) , a                        ;; Attack Aux Speed = A
    ld a , 7(ix)                        ;; A = Entity Attack Range
    ld 2(iy) , a                        ;; Attack Aux Life = A
    ld a , (hl)                         ;; A = Entity Last Vision
    ld 3(iy) , a                        ;; Attack Aux Direction = A
    ld a , 4(ix)                        ;; A = Entity Attack Damage
    ld 4(iy) , a                        ;; Attack Aux Damage = A
    call get_disabled_attack            ;; HL = GET DISABLED ATTACK
    ld a , h                            ;;  A = H
    cp #not_found_disabled              ;; COMPARE WITH NOT FOUND
    ret z                               ;; IF COMPARE == TRUE RETURN
    push hl                             ;; Save HL Values
    pop ix                              ;; Recover HL into IX
    ld 0(ix) , #1                       ;; Attack Active
    ld a , 1(iy)                        ;; A = Aux Speed
    ld 1(ix) , a                        ;; Attack Speed = A
    ld a , 2(iy)                        ;; A = Aux Life
    ld 2(ix) , a                        ;; Attack Life = A
    ld a , 3(iy)                        ;; A = Aux Direction
    ld 3(ix) , a                        ;; Attack Direction = A
    ld a , 4(iy)                        ;; A = Aux Damage
    ld 4(ix) , a                        ;; Attack Damage = A
    push ix                             ;; Save IX ---------------(1)
    call get_attack_position            ;; HL = Get Attack Pos
    push de                             ;; Save DE Value
    pop  iy                             ;; Recover DE Value into IY
    push hl                             ;; Save HL Values
    pop  ix                             ;; Recover HL Values into IX
    pop  de                             ;; Recover IX into DE ----(1)
    ld a , 0(iy)                        ;; A = Entity X Pos
    ld 0(ix) , a                        ;; Attack X pos = A
    ld 1(ix) , #bullet_width            ;; Attack Width = Bullet Width
    ld 2(ix) , a                        ;; Attack X last pos = A
    ld a , 3(iy)                        ;; A = Entity Y Pos
    ld 3(ix) , a                        ;; Attack Y pos = A
    ld 4(ix) , #bullet_height           ;; Attack Height = Bullet Height
    ld 5(ix) , a                        ;; Attack Y last pos = A
    ld hl , #attack_aux                 ;; Attack Aux
    ld a , #3                           ;; A = 3
    call simple_loop_inc_hl             ;; HL Loop
;; Vision ( 0 = DOWN , 1 = UP , 2 = RIGHT , 3 = LEFT)****
    ld a , (hl)                         ;; A = Aux Direction
    cp #1                               ;; UP
    jr z , _up_attack_direction
    cp #0                               ;; DOWN
    jr z , _down_attack_direction
    cp #3                               ;; LEFT
    jr z , _left_attack_direction
_right_attack_direction:
    ld a , 1(iy)                        ;; A = Entity Width
    add 0(ix)                           ;; A = A + Attack X Pos
    jr _x_axis_changes
_left_attack_direction:
    inc de                              ;; Next Position Speed Attack
    ld a , (de)                         ;; A = Speed Attack
    neg                                 ;; A = -A
    ld (de) , a                         ;; Update Speed Attack
    dec de                              ;; Previous Position Active Attack
    ld a , 1(ix)                        ;; A = Attack Width
    neg                                 ;; A = -A
    add 0(ix)                           ;; A = Attack X Pos - A
_x_axis_changes:
    ld 0(ix) , a                        ;; Attack X pos = A
    ld 2(ix) , a                        ;; Attack X Last pos = A
    cp #Min_screen_W                    ;; Compare with Min Screen W
    jp m , disabled_new_attack
    cp #Max_screen_W                    ;; Compare with Max Screen W
    jp p , disabled_new_attack
ret
_down_attack_direction:
    ld a , 4(iy)                        ;; A = Entity Height
    add 3(ix)                           ;; A = A + Attack Y Pos
    jr _y_axis_changes
_up_attack_direction:
    inc de                              ;; Next Position Speed Attack
    ld a , (de)                         ;; A = Speed Attack
    neg                                 ;; A = -A
    ld (de) , a                         ;; Update Speed Attack
    dec de                              ;; Previous Position Active Attack
    ld a , 4(ix)                        ;; A = Attack Height
    neg                                 ;; A = -A
    add 3(ix)                           ;; A = Attack Y Pos - A
_y_axis_changes:
    ld 3(ix) , a                        ;; Attack Y pos = A
    ld 5(ix) , a                        ;; Attack Y Last pos = A
    or a                                ;; Active Flags
    jp p , _min_y_axis                  ;; IF A >= 0
;;_max_y_axis:
    sub #127                            ;; A = A - 127
    ld b , a                            ;; B = A
    ld a , #Max_screen_H                ;; A = Max Screen
    sub #127                            ;; A = Max Screen - 127
    cp b
    jp m , disabled_new_attack
    jp z , disabled_new_attack
    ret                      
_min_y_axis:
    cp #Min_screen_H
    jp m , disabled_new_attack
ret
disabled_new_attack:
    ex de , hl
    ld (hl) , #0
ret
;;===============================================================================
;; FUNCTION GET_DISABLED_ATTACK
;; Output Parameters: HL = First Disabled Attack or not_found
;;                     C = Array Pos
not_found_disabled  = #0xFF
;;===============================================================================
get_disabled_attack::
    ld b , #max_attack_into_screen          ;; B = Max Number of Iterations
    ld c , #0                               ;; C = Array Pos
    ld hl , #all_attacks                    ;; HL = Pointer to All Attacks
_loop_get_disabled_attack:
    ld a , (hl)                             ;; A = Active Value (0 = Disabled)
    or a                                    ;; Active Flags
    ret z                                   ;; IF Attack Disabled RETURN
    ld a , #entity_attack_parameters        ;; A = entity_attack_parameters
    push bc                                 ;; Save BC Values
    call simple_loop_inc_hl                 ;; HL Loop
    pop  bc                                 ;; Recover BC Values
    inc c                                   ;; increment C
    djnz _loop_get_disabled_attack
    ld h , #not_found_disabled
ret
;;===============================================================================
;; FUNCTION GET_ATTACK_POSITION
;; Input  Parameters   C = Array Pos
;; Output Parameters: HL = Attack Position by Array pos
;;===============================================================================
get_attack_position::
    ld hl , #number_of_position_parameters  ;; HL = Number Pos Params
    ld b , (hl)                             ;; B = Number of Position Parameters
    ld a , #0                               ;; A = 0
_loop_attack_pos:
    add c                                   ;; A = A + C
    jr z , _prepare_pointer
    djnz _loop_attack_pos
_prepare_pointer:
    ld hl , #all_attack_position
    call simple_loop_inc_hl
ret
;;===============================================================================
;; FUNCTION UPDATE_ATTACKS_ASM
;;===============================================================================
update_attacks_asm::
    ld b , #max_attack_into_screen          ;; B = Max Number of Iterations
    ld c , #0                               ;; C = Array Pos
    ld hl , #all_attacks                    ;; HL = Pointer to All Attacks
_loop_update_attacks:
    push bc                                 ;; Save BC Values
    ld a , (hl)                             ;; A = Active Value (0 = Disabled)
    or a                                    ;; Active Flags
    push hl                                 ;; Save HL Value
    call nz , update_attack                 ;; IF Attack Enabled Call
    pop hl                                  ;; Recover HL
    ld a , #entity_attack_parameters        ;; A = entity_attack_parameters
    call simple_loop_inc_hl                 ;; HL Loop
    pop  bc                                 ;; Recover BC Values
    inc c                                   ;; increment C
    djnz _loop_update_attacks
ret
;;===============================================================================
;; FUNCTION UPDATE_ATTACK
;; Input Parameters: C = Attack Array Pos
;;                  HL = Attack Atributes
;;===============================================================================
update_attack:
    push hl                                 ;; Save HL Values -----------(2)
    call get_attack_position                ;; HL = Attack Pos Pointer
    pop  ix                                 ;; Recover HL into IX -------(2)
    push hl                                 ;; Save HL Values -----------(4)
    pop iy                                  ;; Recover HL Values into IY (4)
    ld a , 2(ix)                            ;; A = Attack Life
    or a                                    ;;
    jr z , disabled_actual_attack
    dec 2(ix)                               ;; Decrement Attack Life
    ld a , 3(ix)                            ;; A = Attack Direction
    ld bc , #0                              ;; Reset BC Values
    cp #3                                   ;; Left
    jr z , _x_attack_movement
    cp #2                                   ;; Right
    jr z , _x_attack_movement
    ld a , 1(ix)
    add a
    ld c , a
    jr _attack_movement
_x_attack_movement:
    ld b , 1(ix)
_attack_movement:
    call move_entity_asm
    ld a , 3(ix)                            ;; A = Attack Direction
    cp #3                                   ;; Left
    jr z , _check_x_movement
    cp #2                                   ;; Right
    jr z , _check_x_movement
    ld a , 3(iy)                            ;; A = Attack Y Pos
    cp 5(iy)                                ;; COMPARE WITH LAST Y Pos
    jr z , disabled_actual_attack
ret
_check_x_movement:
    ld a , 0(iy)                            ;; A = Attack X Pos
    cp 2(iy)                                ;; COMPARE WITH LAST X Pos
    jr z , disabled_actual_attack
    cp #Max_screen_W
    jp p , disabled_actual_attack
ret

disabled_actual_attack::
    dec 0(ix)               ;; Disable Actual Attack
    push iy                 ;; Save IY
    pop hl                  ;; Recover IY into HL
    call clean_last_position_entity
ret