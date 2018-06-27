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

Min_screen_W       = #0       ;; Min Width of the screen (bytes)
Max_screen_W       = #80      ;; Max Width of the screen (bytes)
Min_screen_H       = #0       ;; Min Height of the screen (pixels)
Max_screen_H       = #200     ;; Max Height of the screen (pixels)

pvideomem          = #0xC000  ;; First byte of video memory
background_color   = #0x00    ;; BackGround Colour Pattern (0x00 = 0, 0, 0, 0) BLUE

.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm

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
    call _Movement_ASM      ;; Calculate X Movement
    inc hl                  ;; Next Position HL (Width)
    inc hl                  ;; Next Position HL (X Last Position)
    inc hl                  ;; Next Position HL (Y Position)
    ld d , #Max_screen_H    ;; D = MAX Screen Height
    ld e , #Min_screen_H    ;; E = MIN Screen Height
    ld b , c                ;; B = C | TO PREPARE _Movement_ASM
    call _Movement_ASM      ;; Calculate X Movement
ret
;;===============================================================================
;; FUNCTION MOVE_ENTITY_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                      B => Force Movement
;;                      D => Max Limit
;;                      E => Min Limit
;;===============================================================================
_Movement_ASM:
    ld a , b                ;; A = Mov(B)
    or a                    ;; Active de Flags
    ret z                   ;; IF A = 0
    jp p , limit_max        ;; IF A < 0
    neg                     ;; Negate A
    ld b , a                ;; B = -A
    jr limit_min            ;; IF A > 0
ret

limit_min:
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
limit_max_bucle:
    ret z                   ;; IF A = 0
    inc (hl)                ;; (HL)Pos = (HL)Pos++
    dec a                   ;; A = A--
    djnz limit_max_bucle    ;; IF B !=0
ret

;;===============================================================================
;;      TEntity      B1 X Position                  B2 Width
;;                   B3 X Last Position             
;;                   B4 Y Position                  B5 Height
;;                   B6 Y Last Position
;;===============================================================================
;;===============================================================================
;; FUNCTION RENDER_BOX_ENTITY_ASM
;;
;; Input parameters :  HL => Pointer to TEntity
;;                      A => Colour Pattern
;;===============================================================================
render_box_entity_asm::
    push af                     ;; Save Colour Pattern
    
    call clean_box_entity       ;; Clean Last Box Position
    call position_entity        ;; Position Entity
    pop bc                      ;; Recover Colour Pattern
    ld   a , b                  ;; A = Color Pattern
    inc hl                      ;; Previous Position HL (Width)  
   	call draw_box_entity        ;; Draw Box Entity

ret
;;===============================================================================
;; FUNCTION DRAW_BOX_ASM
;;
;; Input parameters :  HL => Pointer to TEntity (First Position = Width)
;;                     DE => Position Value (X , Y)
;;                      A => Color Pattern 
;;===============================================================================
draw_box_entity:
    push hl                         ;; Save Entity Pointer
    ld   c , (hl)                   ;; C = Entity Width (bytes)

    inc hl                          ;; Next Position HL (X LPos)
    inc hl                          ;; Next Position HL (Y Pos)
    inc hl                          ;; Next Position HL (Height)
   	ld   b , (hl)                   ;; B = Entity Height (pixels)
       
   	call cpct_drawSolidBox_asm      ;; Draw Solid Box 
    pop  hl
    dec hl                          ;; Previous Position HL (X Pos)  
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
;;===============================================================================
;; FUNCTION CLEAN_ENTITY
;;
;; Input parameters :  HL => Pointer to TEntity            
;;===============================================================================
clean_box_entity:

    ;; Calculate Box Last Position
    inc hl                      ;; Next Position HL (Width)
    inc hl                      ;; Next Position HL (X LPos)
   	call position_entity        ;; Calculate Position of Entity
    ;; HL => Same Position than before the function


    ;; Draw Clean Box
    ld   a , #background_color  ;; A = Color Pattern

    dec hl                      ;; Previous Position HL (Width)   
   	call draw_box_entity        ;; Draw Box Entity
    
    ;; Update Last Position to Actual Position
    call update_entity_position
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
;; Return parameters:   A => A = 0 (No Colision) || A != 0 (Colision)            
;;===============================================================================
collision_entities_asm::
    call axis_collision
    inc ix  ;; Next Position IX (Width)
    inc iy  ;; Next Position IY (Width)
    inc ix  ;; Next Position IX (X LPos)
    inc iy  ;; Next Position IY (X LPos)
    inc ix  ;; Next Position IX (Y Pos)
    inc iy  ;; Next Position IY (Y Pos)
    or a    ;; Active Flags
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