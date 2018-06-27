.area _DATA
;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

keys:
    .dw #0x0408 ;; KEY_ESC	| 6
    .dw #0x8005 ;; KEY_SPACE| 5
	.dw #0x2008 ;; KEY_A	| 4
	.dw #0x2007 ;; KEY_D	| 3
    .dw #0x0807 ;; KEY_W	| 2
    .dw #0x1007 ;; KEY_S	| 1

number_actions 	= #6		  ;; Number of Used Keys



;;===============================================================================
;; CODE SECTION
;;===============================================================================

.area _CODE 

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

.globl actual_action



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
	ld hl , #actual_action		;; Actual_Action
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
