.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

Min_screen_W       = #4                     ;; Min Width of the screen (bytes)
Max_screen_W       = #80 - Min_screen_W     ;; Max Width of the screen (bytes)
Min_screen_H       = #32 + #8               ;; Min Height of the screen (pixels)
Max_screen_H       = #200 - #17             ;; Max Height of the screen (pixels)

SCREEN_W = #80
SCREEN_H = #200

SCREEN_W_IT = SCREEN_W / #10
SCREEN_H_IT = SCREEN_H / #10

pvideomem          = #0xC000  ;; First byte of video memory

.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl cpct_drawSolidBox_asm
.globl StringBuffer

.globl clear_entity_position

.area _CODE 

;;===============================================================================
;;      TEntity      B1 X Position                  B2 Width
;;                   B3 X Last Position             
;;                   B4 Y Position                  B5 Height
;;                   B6 Y Last Position
;;===============================================================================
;;===============================================================================
;; FUNCTION MOVE_ENTITY_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                      B => X Movement
;;                      C => Y Movement
;;===============================================================================
move_entity_asm::
    ld d , #Max_screen_W    ;; D = MAX Screen Width
    ld e , #Min_screen_W    ;; E = MIN Screen Width
    call movement           ;; Calculate X Movement
    inc hl                  ;; Next Position HL (Width)
    inc hl                  ;; Next Position HL (X Last Position)
    inc hl                  ;; Next Position HL (Y Position)
    ld d , #Max_screen_H    ;; D = MAX Screen Height
    ld e , #Min_screen_H    ;; E = MIN Screen Height
    ld b , c                ;; B = C | TO PREPARE _Movement_ASM
    call movement           ;; Calculate Y Movement
ret
;;===============================================================================
;; FUNCTION MOVE_ENTITY_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                      B => Force Movement
;;                      D => Max Limit
;;                      E => Min Limit
;;===============================================================================
movement:
    ld a , b                ;; A = Mov(B)
    or a                    ;; Active de Flags
    ret z                   ;; IF A = 0
    jp p , limit_max        ;; IF A < 0
    neg                     ;; Negate A
    ld b , a                ;; B = -A
    ld a , (hl)             ;; A = Pos(HL)
    sub e                   ;; A = Pos(HL) - Min_Limit(E)
limit_min_bucle:
    ret z                   ;; IF A = 0
    dec (hl)                ;; (HL)Pos = (HL)Pos--
    dec a                   ;; A = A--
    djnz limit_min_bucle    ;; IF B !=0
ret

limit_max:
    ld a , (hl)             ;; A = Pos(HL)
    inc hl                  ;; Next Position HL (Width | Height)
    add (hl)                ;; A = Pos(A) + (Width | Height)(HL)
    dec hl                  ;; Previous Position HL (Pos X | Pos Y)
    sub d                   ;; A = Pos(A) + (Width | Height)(HL) - Limit Max(D)
    jp p , limit_change_position
limit_max_bucle:
    ret z                   ;; IF A = 0
    inc (hl)                ;; (HL)Pos = (HL)Pos++
    dec a                   ;; A = A--
    djnz limit_max_bucle    ;; IF B !=0
ret
limit_change_position:
    ld a , d                ;; A = Limit Max
    inc hl                  ;; Next Position HL (Width | Height)
    sub (hl)                ;; A = Limit Max - (Width | Height)
    dec hl                  ;; Previous Position HL (Pos X | Pos Y)
ret

;;===============================================================================
;; FUNCTION DRAW_ENTITY_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                     DE => Sprite Memory Pointer
;;===============================================================================
draw_entity_asm::
    push de                             ;; Save Memory Sprite Pointer
    push hl                             ;; Save pointer to Entity
    call clean_last_position_entity
    pop  hl                             ;; Recover Pointer to Entity
    call update_entity_position
    call position_entity                ;; Calculate Video Memory Position
    inc hl                              ;; Next Position Width
    ld c , (hl)                         ;; C = Width (HL)
    inc hl                              ;; Next Position X Last Position
    inc hl                              ;; Next Position Y 
    inc hl                              ;; Next Position Height
    ld b , (hl)                         ;; B = Height (HL)
    pop hl                              ;; Recover Memory Sprite Pointer
    call cpct_drawSprite_asm            ;; Draw Sprite            
ret
;;===============================================================================
;; FUNCTION CLEAN_LAST_POSITION_ENTITY
;;
;; Input parameters :  HL => Pointer to TEntity 
;;===============================================================================
clean_last_position_entity::
    inc hl              ;; Next Position Width
    ld c , (hl)         ;; C = Entity Width
    inc hl              ;; Next Position Last X Pos
    push bc             ;; Save BC
    call position_entity
    pop bc              ;; Recover BC
    inc hl              ;; Next Position X Pos
    inc hl              ;; next Position height
    ld b , (hl)         ;; B = Height Value
    ld a , #0x00        ;; A = Black Pixel
    call cpct_drawSolidBox_asm
ret
;;===============================================================================
;; FUNCTION POSITION_ENTITY
;;
;; Input parameters :  HL => Pointer to TEntity (Positions => X Pos OR X LPos)
;; Return Values: DE => Position Value (X , Y)   
;;===============================================================================
position_entity:
    push hl                         ;; Save Entity Pointer
    ld c , (hl)                     ;; C  = X Pos || X LPos

    inc hl                          ;; Next Position HL (Width || Y Pos)
    inc hl                          ;; Next Position HL (X LPos || Height)
    inc hl                          ;; Next Position HL (Y Pos || Y LPos)

    ld b , (hl)                     ;; B  = Y Pos || Y LPos
    ld  de , #pvideomem             ;; Video Memory Position
    call cpct_getScreenPtr_asm      ;; Get Screen Pointer
    ;; Return value: HL = Screen Pointer to (X, Y) byte

    ex  de , hl                     ;; Exchange Values DE <-> HL
    pop hl                          ;; Recover Entity Pointer

ret
;;============================================================
;;  FUNCTION CHECK_SPRITE_DRAW
;;
;;  Input Parameters: HL = Position Entity
;; Output Parameters:  F = Active Flag Z
;;============================================================
check_sprite_draw::
	ld  a , (hl)				;; A = X Pos
	inc hl 						;; Next Position Width Value
	inc hl 						;; Next Position X Last Pos
	cp (hl)						;; Compare
	ret nz                      ;; Return IF A == 0
	inc hl 						;; Next Position Y Pos
	ld a , (hl)					;; A = Y Pos
	inc hl 						;; Next Position Height
	inc hl 						;; Next Position Y Last Pos
	cp (hl)						;; Compare
ret  						
;;===============================================================================
;; FUNCTION UPDATE_ENTITY_POSITION
;;
;; Input parameters :  HL => Pointer to TEntity            
;;===============================================================================
update_entity_position:
    push hl                     ;; Save Entity Pointer
    ld a , (hl)                 ;; A = X Pos
    inc hl                      ;; Next Position HL (Width)
    inc hl                      ;; Next Position HL (X LPos)
    ld (hl) , a                 ;; HL(X LPos) = X Pos
    inc hl                      ;; Next Position HL (Y Pos)
    ld a , (hl)                 ;; A = Y Pos
    inc hl                      ;; Next Position HL (Height)
    inc hl                      ;; Next Position HL (Y LPos)
    ld (hl) , a                 ;; HL(Y LPos) = Y Pos
    pop hl                      ;; Recover Entity Pointer
ret
;;===============================================================================
;;      TEntity      B1 X Position                  B2 Width
;;                   B3 X Last Position             
;;                   B4 Y Position                  B5 Height
;;                   B6 Y Last Position
;;===============================================================================
;;===============================================================================
;; FUNCTION COLLISION_ENTITIES_ASM
;;
;; Input parameters :  IX => Pointer to First TEntity
;;                     IY => Pointer to Second TEntity
;; Return parameters:   A => A = 0 (No Collision) || A != 0 (Collision)            
;;===============================================================================
collision_entities_asm::
    call axis_collision
    inc ix                      ;; Next Position IX (Width)
    inc iy                      ;; Next Position IY (Width)
    inc ix                      ;; Next Position IX (X LPos)
    inc iy                      ;; Next Position IY (X LPos)
    inc ix                      ;; Next Position IX (Y Pos)
    inc iy                      ;; Next Position IY (Y Pos)
    or a                        ;; Active Flags
    jr nz , axis_collision      ;; IF A != 0 CHECK COLLISION
ret

axis_collision:
    ld a , (ix)         ;; First Entity X/Y Pos
    add 1(ix)           ;; A = X/Y Pos(A) + Width/Height(IX) 
    sub (iy)            ;; A = [X/Y Pos(A) + Width/Height(A)] - Second Entity X/Y Pos(IY)
    jr z , no_collision ;; No collision
    jp m , no_collision ;; No collision

    ;; Second Check

    ld a , (iy)         ;; Second Entity X/Y Pos 
    add 1(iy)           ;; A = X/Y Pos(A) + Width/Height(IY)
    sub (ix)            ;; A = [X/Y Pos(A) + Width/Height(A)] - Second Entity X/Y Pos(IX)
    jr z , no_collision ;; No collision
    jp m , no_collision ;; No collision
ret

no_collision:
    ld a , #0
ret
;;===============================================================================
;; FUNCTION SIMPLE_LOOP_INC_HL
;;
;; Input parameters:   HL => Pointer to "Array"
;;                      A => Iterator
;; Return parameters:  HL => Specific position into Array
;;===============================================================================
simple_loop_inc_hl::
    ld  bc , #0             ;; BC = 0
    ld  c , a               ;; B = ITERATOR        
    add hl , bc             ;; HL = HL + BC
ret
;;===============================================================================
;; FUNCTION INT_TO_STRING_ASM
;;
;; Input parameters:   HL => Pointer to INT
;; Return parameters:  HL => Pointer to Generated String
;;===============================================================================
first_number = #27

int_to_string_asm::
    ld a , (hl)                     ;; E = INT(HL)
    ld hl , #0
    ld l , a                
    ld c , #0x0A                    ;; C = Division Value
    call Bit_division
    ld ix , #StringBuffer           ;; HL = Pointer to String Value
    ld a , l                        ;;  A = Result of Division
    add #first_number               ;;  A += First Number of Charset
    ld (ix) , a                     ;; First String Value
    ld a , h                        ;;  A = Division MOD
    add #first_number               ;;  A += First Number of Charset
    ld 1(ix) , a                     ;; Second String Value
    ld hl , #StringBuffer
ret
;;===============================================================================
;; FUNCTION Bit_division - (http://www.cpcwiki.eu/index.php/Programming:Integer_Division)
;;
;; Input parameters:   HL = Value 1 && C = Value 2
;; Return parameters:  H  = Value 1 MOD Value 2 && L = Value 1 / 2
;;===============================================================================
Bit_division:
        LD B , #8
Div_Next:
        ADD     HL,HL
        LD      A,H
        SUB     C
        JR      C,Div_NXTB
        LD      H,A
        INC     L
Div_NXTB:
        DJNZ    Div_Next
RET
;;=======================================================================================
;; FUNCTION CLEAR_SCREEN_ASM
;;=======================================================================================
clear_screen_asm::
    ld ix , #clear_entity_position
    ld 0(ix) , #0
    ld 2(ix) , #0
    ld 3(ix) , #0
    ld 5(ix) , #0
    ld c , #SCREEN_H_IT                 ;; Number of H iterations
_h_loop:
    ld b , #SCREEN_W_IT                 ;; Number of W iteratios
_w_loop:
    push bc                             ;; Save BC Values ---------(0)
    ld hl , #clear_entity_position      ;; HL = Clear Entity Pos
    call clean_last_position_entity     ;; 
    ld hl , #clear_entity_position
    ld  b , #20
    ld  c , #0
    call clear_entity_move_asm
    pop bc 
    djnz _w_loop
    push bc 
    ld hl , #clear_entity_position
    ld (hl), #0
    ld   c , #20
    ld   b , #0
    call clear_entity_move_asm
    pop bc 
    dec c 
    jr nz , _h_loop
ret
;;===============================================================================
;; FUNCTION CLEAR_ENTITY_MOVE_ASM
;;
;; Input parameters :  HL => Pointer to Clear TEntity
;;                      B => X Movement
;;                      C => Y Movement
;;===============================================================================
clear_entity_move_asm::
    push hl
    ld d , #SCREEN_W        ;; D = MAX Screen Width
    ld e , #0               ;; E = MIN Screen Width
    call movement_entity_clear           ;; Calculate X Movement
    inc hl                  ;; Next Position HL (Width)
    inc hl                  ;; Next Position HL (X Last Position)
    inc hl                  ;; Next Position HL (Y Position)
    ld d , #SCREEN_H        ;; D = MAX Screen Height
    ld e , #0               ;; E = MIN Screen Height
    ld b , c                ;; B = C | TO PREPARE _Movement_ASM
    call movement_entity_clear           ;; Calculate Y Movement
    pop hl 
    call update_entity_position
ret
;;===============================================================================
;; FUNCTION MOVE_ENTITY_CLEAR_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                      B => Force Movement
;;                      D => Max Limit
;;                      E => Min Limit
;;===============================================================================
movement_entity_clear:
    ld a , b                ;; A = Mov(B)
    or a                    ;; Active de Flags
    ret z                   ;; IF A = 0
    jp p , limit_clear_max  ;; IF A < 0
    neg                     ;; Negate A
    ld b , a                ;; B = -A
    ld a , (hl)             ;; A = Pos(HL)
    sub e                   ;; A = Pos(HL) - Min_Limit(E)
limit_min_clear_bucle:
    ret z                   ;; IF A = 0
    dec (hl)                ;; (HL)Pos = (HL)Pos--
    dec a                   ;; A = A--
    djnz limit_min_clear_bucle    ;; IF B !=0
ret

limit_clear_max:
    ld a , (hl)             ;; A = Pos(HL)
    inc hl                  ;; Next Position HL (Width | Height)
    add (hl)                ;; A = Pos(A) + (Width | Height)(HL)
    dec hl                  ;; Previous Position HL (Pos X | Pos Y)
    sub d                   ;; A = Pos(A) + (Width | Height)(HL) - Limit Max(D)
limit_clear_max_bucle:
    ret z                   ;; IF A = 0
    inc (hl)                ;; (HL)Pos = (HL)Pos++
    dec a                   ;; A = A--
    djnz limit_clear_max_bucle    ;; IF B !=0
ret
