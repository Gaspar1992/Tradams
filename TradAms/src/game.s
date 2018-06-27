.area _DATA
;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

;; CPCTELERA
.globl cpct_isAnyKeyPressed_asm
.globl cpct_scanKeyboard_asm
.globl cpct_setInterruptHandler_asm
.globl cpct_waitVSYNC_asm
;; GENERAL
.globl interruption_function
.globl actual_action
.globl clear_screen_asm
.globl change_level
.globl stairs_collision_asm
.globl unset_stairs_asm
.globl actual_level
;; MAIN MENU
.globl draw_main_menu
.globl clear_main_menu
;; ATTACK
.globl update_attacks_asm
.globl draw_attack_asm
;; OBJECTS
.globl draw_objects_asm
.globl set_object_screen_asm
.globl objects_collision_asm
;; PLAYER
.globl player_life
.globl initialize_player_asm
.globl initialize_player_hud_asm
.globl player_update_asm
.globl draw_player_asm
.globl draw_player_hud_asm
.globl clear_player_asm
;; ENEMIES
.globl enemies_update_asm
.globl enemies_bullet_collision_asm
.globl draw_all_enemies_asm
.globl reset_enemies_room_asm
.globl player_enemies_collision_asm
;;LEVEL && ROOMS
.globl change_room
.globl change_room_asm
.globl generate_new_level_asm
.globl draw_room_asm
.globl doors_collision_asm
.globl actual_action
;;===============================================================================
;; CODE SECTION
;;===============================================================================

.area _CODE 

main_game_bucle::
    ld hl , #interruption_function	 ;; Set Interruption Function
	call cpct_setInterruptHandler_asm;; |
come_back:
    call main_menu
    call game_bucle
    jp come_back
ret

;;=============================================================
;; FUNCTION SET OBJECT SCREEN ASM
;; 
;;  Input Parameters :  D = id
;;                     BC = Screen Position (B = Y , C = X)
;;=============================================================


main_menu::
    call cpct_waitVSYNC_asm
    call draw_main_menu
menu_bucle:
    call cpct_waitVSYNC_asm
    call cpct_scanKeyboard_asm
    call cpct_isAnyKeyPressed_asm
    jp z , menu_bucle
    call cpct_waitVSYNC_asm
    call clear_main_menu
    call initialize_player_asm
ret

    
game_bucle:
    ld hl , #actual_level
    inc (hl)
    ld hl , #change_level
    ld (hl) , #0
    call initialize_player_hud_asm
    call generate_new_level_asm
_change_actual_room:
    call cpct_waitVSYNC_asm
    call draw_room_asm
_loop_game_bucle:
    ld hl , #player_life
    ld  a , (hl)
    or  a
    jr z , _game_over
    jp m , _game_over
    ld hl , #change_level
    ld  a , (hl)
    or  a 
    jr z , continue_game_bucle
    call clear_player_asm
    call unset_stairs_asm
    jr game_bucle
continue_game_bucle:
    ;; Updates
    call update_attacks_asm
    call enemies_update_asm
    call player_update_asm
    ;; Collisions
    call stairs_collision_asm
    call enemies_bullet_collision_asm
    call doors_collision_asm
    call objects_collision_asm
    call player_enemies_collision_asm
    
    ;; Room Changer
    call change_room_asm
    jr nz , _change_actual_room
    ;; Wait VSYNC
    call cpct_waitVSYNC_asm
    ;; DRAW
    call draw_all_enemies_asm
    call draw_player_asm
    
    call draw_objects_asm
    call draw_attack_asm
    call draw_player_hud_asm
    jr _loop_game_bucle
_game_over:
    ld hl , #actual_level
    ld (hl) , #0
    ;; Wait VSYNC
    call cpct_waitVSYNC_asm
    call reset_enemies_room_asm
    call clear_screen_asm
ret

pause_bucle:
    call cpct_waitVSYNC_asm
    ;; DRAW

    ;; ACTIONS
    ld hl , #actual_action  ;; Actual Action Pointer
    ld a  , (hl)            ;; Actual Action Value       
    cp #6
    jp nz , pause_bucle
ret
game_over_bucle:
ret

