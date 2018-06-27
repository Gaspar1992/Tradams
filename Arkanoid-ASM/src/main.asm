;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of ################ 
;;  Copyright (C) 2017 
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

.area _DATA
;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

border_colour  = #0x1410  ;; 0x10 (Border ID), 0x14 (Colour to set: Black).
number_actions = #4		  ;; Number of Used Keys

key_A = #0x2008
key_D = #0x2007
key_W = #0x0807
key_S = #0x1007

string_1: .asciz "Welcome to Arkanoid in ASM!"
string_2: .asciz "Menu de Prueba"

;;===============================================================================
;; DEFINED KEYS
;;===============================================================================

keys: 
	.dw #0x0807 ;; KEY_W
	.dw #0x1007 ;; KEY_S
	.dw #0x2008 ;; KEY_A
	.dw #0x2007 ;; KEY_D
    
    
	
actual_action:
	.db #0
interruption:
	.db #6


;;===============================================================================
;; CODE SECTION
;;===============================================================================

.area _CODE 

;; Symbols with the names of the CPCtelera functions we want to use
;; must be declared globl to be recognized by the compiler. Later on,
;; linker will do its job and make the calls go to function code.
.globl cpct_isKeyPressed_asm  
.globl cpct_scanKeyboard_asm
.globl cpct_setInterruptHandler_asm
.globl cpct_disableFirmware_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPALColour_asm
.globl cpct_waitVSYNC_asm
.globl cpct_drawStringM1_f_asm

.globl player_draw
.globl player_update
.globl player

.globl collision_entities_asm
.globl render_box_entity_asm

.globl ball
.globl ball_draw_asm
.globl ball_update_asm
.globl change_speed_y
;;-----------------------------------------------
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;-----------------------------------------------




_main::
	call init
   	call loop
ret


loop::

	
	ld hl , #actual_action	;; Actual_action = KeyBoard Value
	ld a , (hl)				;; Prepare PLAYER_UPDATE FUNCTION
	call player_update		;; Update Player Action
	call ball_update_asm
	call collisions
	call cpct_waitVSYNC_asm ;; VSYNC  UPDATE
	;; TRAS EL VSYNC SE DIBUJA TODO
	call ball_draw_asm  ;; BALL DRAW
	call player_draw    ;; PLAYER DRAW

	
	jr loop




collisions:
	ld ix , #player
	ld iy , #ball
	call collision_entities_asm
	or a
	call nz , change_speed_y
	
ret

init:
	;; Initialize CPC
   	call cpct_disableFirmware_asm ;; Disable Firmware
   	ld  c, #1                     ;; C = 1 (Mode 1)
   	call cpct_setVideoMode_asm    ;; Set Mode 1

   	;; Change border colour
   	ld    hl, #border_colour         ;; L=Border colour value, H=Palette Colour to be set (Border=16)
   	call  cpct_setPALColour_asm      ;; Set the border (colour 16)
	ld hl , #interruption_function	 ;; Set Interruption Function
	call cpct_setInterruptHandler_asm;; |

ret

interruption_function::
	ld hl , #interruption 		;; Asign Interruption Value
	dec (hl)					;; Decement (HL)
	ld a , (hl)					;; A = Updated Interruption Value
	or a						;; Active Flags
	ret nz						;; RETURN IF A != 0 
	ld (hl) , #6				;; UPDATE interruption value
	call keyboard_function		;; KEYBOARD UPDATE
ret

;;===============================================================================
;; FUNCTION KEYBOARD_FUNCTION
;;
;; Input parameters :   B => Iterator
;;                     HL => Pointer to Keys
;;===============================================================================
keyboard_function::
	call cpct_scanKeyboard_asm  ;; Read KeyBoard
	
	ld hl , #keys			    ;; Keys
	ld b , #number_actions		;; Prepare to KeyBoard Function
	call key_check				;; Check Keys
	ld hl , #actual_action		;; Actual_ACtion
	ld (hl) , b					;; Give value
ret

key_check:
	ld e , (hl)					;; First Part of Key (16 bit)
	inc hl						;; Increment to Next Part of Key
	ld d , (hl)					;; Second Part of key 
	inc hl 						;; Increment to Next Key
	ex de , hl					;; ExChange DE <=> HL
	push de						;; Save DE (KEY VALUES)
	push bc						;; Save BC (B = Action)
	call cpct_isKeyPressed_asm	;; Check Key hl
	pop bc						;; Recover (B = Action)
	pop hl						;; Recover (KEY VALUES)
	or a						;; Active Flags
	ret nz						;; IF A != 0 KEY ACTIVE
	djnz key_check
	ret

