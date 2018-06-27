.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

width_stairs = #4
height_stairs = #16

Stairs:
	.db #0x1f, #0x0f, #0x0f, #0x8f
	.db #0x19, #0x00, #0x00, #0x89
	.db #0x19, #0xff, #0xff, #0x89
	.db #0x19, #0x00, #0x00, #0x89
	.db #0x19, #0x00, #0x00, #0x89
	.db #0x19, #0xff, #0xff, #0x89
	.db #0x19, #0x00, #0x00, #0x89
	.db #0x19, #0x00, #0x00, #0x89
	.db #0x19, #0xff, #0xff, #0x89
	.db #0x19, #0x00, #0x00, #0x89
	.db #0x19, #0x00, #0x00, #0x89
	.db #0x19, #0xff, #0xff, #0x89
	.db #0x19, #0x00, #0x00, #0x89
	.db #0x08, #0x00, #0x00, #0x01
	.db #0x08, #0x00, #0x00, #0x01
	.db #0x0f, #0x0f, #0x0f, #0x0f

set_stairs:: .db #0

.globl exit_position
.globl collision_entities_asm
.globl draw_entity_asm
.globl change_level
.globl clean_last_position_entity
.globl player_position

.area _CODE 

;;===============================================================================
;; FUNCTION DRAW_STAIRS_ASM
;;===============================================================================
draw_stairs_asm::
    ld hl , #set_stairs
    ld  a , (hl)
    or  a 
    ret z
    ld de , #Stairs
    ld hl , #exit_position
    call draw_entity_asm
ret
;;===============================================================================
;; FUNCTION UNSET_STAIRS_ASM
;;===============================================================================
unset_stairs_asm::
    ld hl , #set_stairs
    ld (hl) , #0
    ld hl , #exit_position
    call clean_last_position_entity
ret
;;===============================================================================
;; FUNCTION SET_STAIRS_ASM
;;===============================================================================
set_stairs_asm::
    ld hl , #set_stairs
    ld (hl) , #1
ret
;;===============================================================================
;; FUNCTION STAIRS_COLLISION_ASM
;;===============================================================================
stairs_collision_asm::
    ld hl , #set_stairs
    ld  a , (hl)
    or  a 
    ret z
    ld ix , #player_position
    ld iy , #exit_position
    call collision_entities_asm
    or a 
    ret z
    ld hl , #change_level
    inc (hl) 
ret