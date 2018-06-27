.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

number_of_position_parameters:: .db #6
number_of_skill_parameters::    .db #8
number_of_bag_parameters::      .db #3

.macro defineEntityPosition name , x , y , x_last , y_last , width , height
    name'_position::
        name'_position_x:   .db x           ;; Entity X Pos
        name'_width:        .db width       ;; Entity Width
        name'_last_x:       .db x_last      ;; Entity X Last Position
        name'_position_y:   .db y           ;; Entity Y Pos
        name'_height:       .db height      ;; Entity Height
        name'_last_y:       .db y_last      ;; Entity Y Last Position
.endm

.macro defineEntitySkills name , spX , spY , life , MXlife , Damage , Speed , Range , Fire_rate
    name'_skills::
    name'_x_speed:  .db spX         ;; Entity X Movement Speed
    name'_y_speed:  .db spY         ;; Entity Y Movement Speed
    name'_life::    .db life        ;; Entity Life
    name'_MXlife:   .db MXlife      ;; Entity Max Life
    name'_damage:   .db Damage      ;; Entity Attack Damage
    name'_fire_rate:.db Fire_rate   ;; Entity Attack Fire Rate
    name'_bullet_sp:.db Speed       ;; Entity Attack Speed
    name'_bullet_rg:.db Range       ;; Entity Attack Range
.endm

.macro defineEntityVision name
    name'_vision::
    name'_actual_vision: .db #0     ;; Vision ( 0 = DOWN , 1 = UP , 2 = RIGHT , 3 = LEFT)****
    name'_last_vision: .db #0       ;; Last Vision
.endm

.macro defineEntityAttack name , Active, Direction  Speed , life , Damage
    attack_'name':: 
    attack_'name'_active:       .db Active           ;; Active = 1 , Not Active = 0
    attack_'name'_speed:        .db Speed            ;; Bullet Speed
    attack_'name'_life:         .db life             ;; life
    attack_'name'_direction:    .db Direction        ;; Direction Like Vision****
    attack_'name'_damge:        .db Damage           ;; Damage
.endm

.macro defineEntityBag name , bits , keys , bombs
    name'_bag::
    name'_bits: .db bits        ;; Entity Bits
    name'_bombs:.db keys        ;; Entity KEYS
    name'_keys: .db bombs       ;; Entity BOMBS
.endm


.area _CODE 

;;===============================================================================
;; MENUS ENTITIES
;; defineEntityPosition name , x , y , x_last , y_last , width , height
;;===============================================================================
Title_width  = #16
Title_height = #32
PlayerHQ_width  = #13
PlayerHQ_height = #41
defineEntityPosition     title_0 , Title_width , 0 , 0 , 0  , Title_width , Title_height
defineEntityPosition     title_1 , Title_width*2 , 0 , Title_width*2 , 0  , Title_width , Title_height
defineEntityPosition     PlayerHQ_0 , Title_width*3 , 0 , Title_width*3 , 0  , PlayerHQ_width , PlayerHQ_height
defineEntityPosition     PlayerHQ_1 , Title_width*3 , PlayerHQ_height , Title_width*3 , PlayerHQ_height  , PlayerHQ_width , PlayerHQ_height
;;===============================================================================
;;  PLAYER DEFINITIONS
;; defineEntityPosition name , x , y , x_last , y_last , width , height
;; defineEntitySkills name , spX , spY , life , MXlife , Damage , Speed , Range , Fire_rate
;; defineEntityBag name , bits , keys , bombs
;; defineEntityAttack name , Active, Direction  Speed , life , Damage
;;===============================================================================
defineEntityPosition     player , 0 , 0 , 0 , 0  , 0 , 0
defineEntityPosition     player_ini , 40 , 100 , 39 , 100  , 4 , 16
defineEntitySkills       player , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
defineEntitySkills       player_ini , 1 , 3 , 10 , 10 , 3 , 2 , 20 , 10
defineEntitySkills       player_limit , 4 , 6 , 20 , 20 , 99 , 1 , 99 , 10
defineEntityBag          player , 0 , 0 , 0
defineEntityBag          player_ini , 0 , 0 , 0
defineEntityBag          player_limit , 99 , 99 , 99

defineEntityVision       player

defineEntityPosition     clear_entity , 0 , 0 , 0 , 0  , 20 , 20
;;===============================================================================
;;  DOORS DEFINITIONS
;; defineEntityPosition name , x , y , x_last , y_last , width , height
;;===============================================================================
defineEntityPosition     left_door , 01 , 88  , 0 , 0  , 4 , 32
defineEntityPosition     right_door, 75 , 88  , 0 , 0  , 4 , 32
defineEntityPosition     up_door   , 36 , 9  , 0 , 0  , 8 , 32
defineEntityPosition     down_door , 36 , 182 , 0 , 0  , 8 , 16
;;Doors (0 = DOWN | 1 = LEFT | 2 = RIGHT | 3 = UP ) 
entity_doors_asm::  .dw  left_door_position , right_door_position ,up_door_position  , down_door_position  

;;===============================================================================
;;  OBJECTS DEFINITIONS
;; defineEntityPosition name , x , y , x_last , y_last , width , height
;;===============================================================================

all_position_objects::
defineEntityPosition object_a , 0 , 0 , 0 , 0 , 0 , 0 ;; 1
defineEntityPosition object_b , 0 , 0 , 0 , 0 , 0 , 0 ;; 2
defineEntityPosition object_c , 0 , 0 , 0 , 0 , 0 , 0 ;; 3
defineEntityPosition object_d , 0 , 0 , 0 , 0 , 0 , 0 ;; 4
defineEntityPosition object_e , 0 , 0 , 0 , 0 , 0 , 0 ;; 5
defineEntityPosition object_f , 0 , 0 , 0 , 0 , 0 , 0 ;; 6
defineEntityPosition object_g , 0 , 0 , 0 , 0 , 0 , 0 ;; 7
defineEntityPosition object_h , 0 , 0 , 0 , 0 , 0 , 0 ;; 8
defineEntityPosition object_i , 0 , 0 , 0 , 0 , 0 , 0 ;; 9
defineEntityPosition object_j , 0 , 0 , 0 , 0 , 0 , 0 ;; 10

;;===============================================================================
;;  ENEMIES DEFINITIONS
;; defineEntityPosition name , x , y , x_last , y_last , width , height
;; defineEntitySkills name , spX , spY , life , MXlife , Damage , Speed , Range , Fire_rate
;; defineEntityBag name , bits , bombs , keys
;;===============================================================================
all_enemy_position::
defineEntityPosition        enemy_1 , 0 , 0 , 0 , 0 , 0 , 0 ;; 
defineEntityPosition        enemy_2 , 0 , 0 , 0 , 0 , 0 , 0 ;; 
defineEntityPosition        enemy_3 , 0 , 0 , 0 , 0 , 0 , 0 ;; 
defineEntityPosition        enemy_4 , 0 , 0 , 0 , 0 , 0 , 0 ;; 

all_enemy_vision::
defineEntityVision          enemy_1
defineEntityVision          enemy_2
defineEntityVision          enemy_3
defineEntityVision          enemy_4

enemy_skills::
defineEntitySkills          enemy_T1 , 1 , 2 , 8 , 8 , 1 , 0 , 10 , 6   ;; Bomberman
defineEntitySkills          enemy_T2 , 1 , 1 , 8 , 8 , 1 , 00 , 0 , 0   ;; Robot
defineEntitySkills          enemy_T3 , 0 , 0 , 8 , 8 , 1 , 1 , 10 , 6   ;; Turret

all_enemy_skills::
defineEntitySkills          enemy_1 , 0 , 0 , 0 , 0 , 0 , 0 , 00 , 0   ;; 
defineEntitySkills          enemy_2 , 0 , 0 , 0 , 0 , 0 , 00 ,00 , 0   ;; 
defineEntitySkills          enemy_3 , 0 , 0 , 0 , 0 , 0 , 0 , 00 , 0   ;; 
defineEntitySkills          enemy_4 , 0 , 0 , 0 , 0 , 0 , 0 , 00 , 0   ;; 

;;===============================================================================
;;  ATTACK DEFINITIONS
;; defineEntityPosition name , x , y , x_last , y_last , width , height
;;===============================================================================


all_attack_position::
defineEntityPosition attack_a , 0 , 0 , 0 , 0 , 0 , 0 ;; 1
defineEntityPosition attack_b , 0 , 0 , 0 , 0 , 0 , 0 ;; 2
defineEntityPosition attack_c , 0 , 0 , 0 , 0 , 0 , 0 ;; 3
defineEntityPosition attack_d , 0 , 0 , 0 , 0 , 0 , 0 ;; 4
defineEntityPosition attack_e , 0 , 0 , 0 , 0 , 0 , 0 ;; 5
defineEntityPosition attack_f , 0 , 0 , 0 , 0 , 0 , 0 ;; 6
defineEntityPosition attack_g , 0 , 0 , 0 , 0 , 0 , 0 ;; 7
defineEntityPosition attack_h , 0 , 0 , 0 , 0 , 0 , 0 ;; 8
defineEntityPosition attack_i , 0 , 0 , 0 , 0 , 0 , 0 ;; 9
defineEntityPosition attack_j , 0 , 0 , 0 , 0 , 0 , 0 ;; 10
defineEntityPosition attack_k , 0 , 0 , 0 , 0 , 0 , 0 ;; 11
defineEntityPosition attack_l , 0 , 0 , 0 , 0 , 0 , 0 ;; 12
defineEntityPosition attack_m , 0 , 0 , 0 , 0 , 0 , 0 ;; 13
defineEntityPosition attack_n , 0 , 0 , 0 , 0 , 0 , 0 ;; 14
defineEntityPosition attack_o , 0 , 0 , 0 , 0 , 0 , 0 ;; 15
defineEntityPosition attack_p , 0 , 0 , 0 , 0 , 0 , 0 ;; 16
defineEntityPosition attack_q , 0 , 0 , 0 , 0 , 0 , 0 ;; 17
defineEntityPosition attack_r , 0 , 0 , 0 , 0 , 0 , 0 ;; 18
defineEntityPosition attack_s , 0 , 0 , 0 , 0 , 0 , 0 ;; 19
defineEntityPosition attack_t , 0 , 0 , 0 , 0 , 0 , 0 ;; 20
defineEntityPosition attack_u , 0 , 0 , 0 , 0 , 0 , 0 ;; 21
defineEntityPosition attack_v , 0 , 0 , 0 , 0 , 0 , 0 ;; 22
defineEntityPosition attack_w , 0 , 0 , 0 , 0 , 0 , 0 ;; 23
defineEntityPosition attack_x , 0 , 0 , 0 , 0 , 0 , 0 ;; 24
defineEntityPosition attack_y , 0 , 0 , 0 , 0 , 0 , 0 ;; 25
defineEntityPosition attack_z , 0 , 0 , 0 , 0 , 0 , 0 ;; 26
defineEntityPosition attack_aa , 0 , 0 , 0 , 0 , 0 , 0 ;; 27
defineEntityPosition attack_ab , 0 , 0 , 0 , 0 , 0 , 0 ;; 28
defineEntityPosition attack_ac , 0 , 0 , 0 , 0 , 0 , 0 ;; 29
defineEntityPosition attack_ad , 0 , 0 , 0 , 0 , 0 , 0 ;; 30

;;
defineEntityPosition exit , 40 , 72 , 40 , 72 , 4 , 16 ;; 1