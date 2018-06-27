.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

Music_option:: .db #0        ;; Music ON / OFF

actual_action:: .db #0      ;; Actual Action

change_room:: .db #0		;; Change Room Flag

change_level:: .db #0		;; Change Level Flag

actual_level:: .db #0		;; Actual Level

init_game_instructions: .db #1 ;; Initial Room

interruption:   .db interruption_value      ;; Wait interruptions

interruption_value = #12

.globl keyboard_function

palette_GREEN::
	.db #0x54	;; BLACK
	.db #0x44	;; BLUE
	.db #0x52	;; BRIGHT GREEN
	.db #0x40	;; GREY

palette_WHITE::
	.db #0x54	;; BLACK
	.db #0x44	;; BLUE
	.db #0x4B	;; WHITE
	.db #0x40	;; GREY

palette_RED::
	.db #0x54	;; BLACK
	.db #0x44	;; BLUE
	.db #0x4C	;; Bright Red
	.db #0x40	;; GREY

palette_YELLOW::
	.db #0x54	;; BLACK
	.db #0x44	;; BLUE
	.db #0x4A	;; Bright Yellow
	.db #0x40	;; GREY

palette_BLUEP::
	.db #0x54	;; BLACK
	.db #0x44	;; BLUE
	.db #0x5F	;; Pastel Blue
	.db #0x40	;; GREY

palette_ORANGE::
	.db #0x54	;; BLACK
	.db #0x44	;; BLUE
	.db #0x4E	;; Orange
	.db #0x40	;; GREY

palette_BLACK::
	.db #0x54	;; BLACK
	.db #0x44	;; BLUE
	.db #0x54	;; BLACK
	.db #0x40	;; GREY

palette_MAUVE::
	.db #0x54	;; BLACK
	.db #0x44	;; BLUE
	.db #0x5D	;; Mauve
	.db #0x40	;; GREY

.area _CODE 

;;===============================================================================
;; CODE SECTION
;;===============================================================================

interruption_function::
	ld hl , #interruption 			;; Asign Interruption Value
	dec (hl)						;; Decement (HL)
	ld a , (hl)						;; A = Updated Interruption Value
	or a							;; Active Flags
	ret nz							;; RETURN IF A != 0 
	ld (hl) , #interruption_value	;; UPDATE interruption value
	call keyboard_function			;; KEYBOARD UPDATE
	call nz , disable_initial_instructions
ret
disable_initial_instructions:
	ld ix , #init_game_instructions	;; IX = INIT Game Inst.. Pointer
	xor a 							;; XOR A
	cp (ix)							;; COMPARE IX WITH A
	ret p 							;; Return CP > 0
	dec (ix)
ret