.area _DATA

;;===============================================================================
;; LEVEL MATRIX ( 8 x 8 x 8 ) = 512 Bytes
;;===============================================================================
;; WIDTH x HEIGHT ( 8 x  8)
LEVEL_MATRIX::  ;;  0   1   2   3   4   5   6   7
                .db 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;; 0
                .db 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;; 1
                .db 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;; 2
                .db 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;; 3
                .db 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;; 4
                .db 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;; 5
                .db 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;; 6
                .db 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;; 7

.macro ConstructValues firstRoom , lvl_width , seed
    FIRST_ROOM_POSITION = firstRoom
    INDEX::        .db firstRoom
    LAST_INDEX::   .db #-10
    AUX_INDEX::    .db #-10
    ;;              UP  RGT DWN LFT
    INDEX_HOLES::.db -1, -1, -1, -1
    ROOM_HOLES:: .db 0 , 0 , 0 , 0
    
    PPOSITIONS      = #4
    LEVEL_WIDTH     = lvl_width
    MAX_POSITION    = #LEVEL_WIDTH - 1
    LEVEL_SIZE      = #LEVEL_WIDTH * #LEVEL_WIDTH - 1

    SEED:: .db seed
.endm

ConstructValues #0 8 #0x08


;;===============================================================================
;; DEFINED LEVEL ROOMS VALUES
;;===============================================================================
                ;; 3 = 00000111 => 8 POSIBILITIES
SEC_ROOM_FILTER     = #7       ;; FILTER TO SELECT
SEC_POSI_FILTER     = #3       ;; FULTER TO Positions
;; SPC ROOMS
FIRST_ROOM_ID        = #2

NUMBER_PUZZLE_ROOM  = #0       ;; ID 2 
NUMBER_TEMPLE_ROOM  = #0       ;; ID 3 
NUMBER_SURVIVE_ROOM = #2       ;; ID 4
NUMBER_HIDDEN_ROOM  = #1       ;; ID 5
NUMBER_STORE_ROOM   = #1       ;; ID 6
NUMBER_BET_ROOM     = #0       ;; ID 7
NUMBER_OBJECT_ROOM  = #2       ;; ID 8
NUMBER_BOSSES_ROOM  = #1       ;; ID 9 

NUMBER_OF_TYPE_ROOMS  = #8
NUMBER_OF_ROOMS::   .db NUMBER_PUZZLE_ROOM + NUMBER_TEMPLE_ROOM + NUMBER_SURVIVE_ROOM + NUMBER_HIDDEN_ROOM + NUMBER_STORE_ROOM + NUMBER_BET_ROOM + NUMBER_OBJECT_ROOM + NUMBER_BOSSES_ROOM

;;VOID_SPACE_ID   = #0           ID OF VOID ROOMS
CONNECTOR_ROOM_ID = #1        ;; ID OF NEUTRAL ROOMS
INITIAL_ROOM_ID   = #10       ;; ID OF INITIAL ROOM

LEVEL_ROOMS::   .db NUMBER_PUZZLE_ROOM , NUMBER_TEMPLE_ROOM , NUMBER_SURVIVE_ROOM , NUMBER_HIDDEN_ROOM
                .db NUMBER_STORE_ROOM  , NUMBER_BET_ROOM    , NUMBER_OBJECT_ROOM  , NUMBER_BOSSES_ROOM



;;===============================================================================
;; FUNCTIONS
;;===============================================================================
;; CPCTELERA
.globl cpct_getRandom_lcg_u8_asm
.globl cpct_setSeed_lcg_u8_asm
;; TOOLS
.globl simple_loop_inc_hl
;; ROOMS
.globl reset_generated_rooms_asm
.globl generate_new_room
.globl generate_new_connector_room
.globl set_initial_room

.area _CODE 

;;===============================================================================
;; FUNCTION GENERATE_NEW_LEVEL_ASM
;;===============================================================================
generate_new_level_asm::
    ;; STEP 1
    call init_construct_generator_values
    ;; STEP 2
    call select_initial_position_and_include_initial_room
    ;; STEP 3
_bucle_generate_new_level_asm:
    call look_for_posibles_positions
    ;; STEP 4
    call include_new_rooms_into_room_holes
    ;; STEP 5
    call add_connector_rooms
    ;; STEP 6
    call insert_rooms_into_matrix
    ;; STEP 7
    call generate_actual_level_rooms
    ;; STEP 8
    call reset_constr_values
    ;; STEP 9 - CHECK AVAIBLES ROOMS
    ld hl , #NUMBER_OF_ROOMS                                    ;; HL = Pointer to NUMBER_OF_ROOMS
    ld a  , (hl)                                                ;; A = SPC_ROOMS Value(DE)
    or a
    jr nz , _bucle_generate_new_level_asm                       ;; IF A != 0 THEN JUMP
    ;; STEP 9
    call finalize_matrix_construct
ret
;;===============================================================================
;; FUNCTION INIT_NUMBER_OF_ROOMS
;;===============================================================================
init_number_of_rooms:
    ld hl , #NUMBER_OF_ROOMS
    ld  a , #0
    add #NUMBER_PUZZLE_ROOM
    add #NUMBER_TEMPLE_ROOM
    add #NUMBER_SURVIVE_ROOM
    add #NUMBER_HIDDEN_ROOM
    add #NUMBER_STORE_ROOM
    add #NUMBER_BET_ROOM
    add #NUMBER_OBJECT_ROOM
    add #NUMBER_BOSSES_ROOM
    ld (hl) , a
    ld hl , #LEVEL_ROOMS
    ld (hl) , #NUMBER_PUZZLE_ROOM
    inc hl
    ld (hl) , #NUMBER_TEMPLE_ROOM
    inc hl
    ld (hl) , #NUMBER_SURVIVE_ROOM
    inc hl
    ld (hl) , #NUMBER_HIDDEN_ROOM
    inc hl
    ld (hl) , #NUMBER_STORE_ROOM
    inc hl
    ld (hl) , #NUMBER_BET_ROOM
    inc hl
    ld (hl) , #NUMBER_OBJECT_ROOM
    inc hl
    ld (hl) , #NUMBER_BOSSES_ROOM
ret
;;===============================================================================
;; FUNCTION INIT_CONSTRUCT_GENERATOR_VALUES
;;===============================================================================
init_construct_generator_values:
    ld hl , #INDEX
    ld (hl) , #FIRST_ROOM_POSITION
    call init_number_of_rooms
    call reset_matrix_value
    call reset_generated_rooms_asm
    call init_random_number_generator
ret
;;===============================================================================
;; FUNCTION INIT_RANDOM_NUMBER_GENERATOR
;;===============================================================================
init_random_number_generator:
    ld hl , #SEED                   ;; HL = Pointer to Seed
    ld a  , (hl)                    ;; A  = Seed
    push hl                         ;; Save Pointer to Seed
    ld l  , a                       ;; L  = Seed(A)
    call cpct_setSeed_lcg_u8_asm    ;; Set Seed
    call cpct_getRandom_lcg_u8_asm  ;; A = Random Number
    pop  hl                         ;; Recover Pointer to Seed
    ld (hl) , a                     ;; (HL)Seed = Random Number(A)
ret
;;===============================================================================
;; FUNCTION SELECT_INITIAL_POSITION_AND_INCLUDE_INITIAL_ROOM
;;===============================================================================
select_initial_position_and_include_initial_room:
    call cpct_getRandom_lcg_u8_asm  ;; A = Random Number
    and #LEVEL_SIZE                 ;; A = Random Number(A) and Level Size
    ld hl , #INDEX                  ;; HL = Pointer to Index
    ;ld (hl) , a                     ;; (HL)Index = Random Number(A) and Level Size(A)
    ld a , (hl)
    ld hl   , #LEVEL_MATRIX         ;; HL = Pointer to Level Matrix
    call simple_loop_inc_hl         ;; GOTO SPECIF MATRIX POS
    ;; Return parameters:  HL => Specific position into Array
    ld (hl) , #INITIAL_ROOM_ID      ;; (HL) Matrix Pos = Initial Room ID
ret
;;===============================================================================
;; FUNCTION LOOK_FOR_POSIBLES_POSITIONS
;;===============================================================================
look_for_posibles_positions:
    ld de , #INDEX_HOLES                ;; DE = Pointer to Index holes
    ld hl , #INDEX                      ;; HL = Pointer to Index
    ld a  , (hl)                        ;; A  = Index(HL)
    ld l  , a                           ;; L  = Index(A)
;; LOOKING FOR DOWN INDEX POS       
    add #LEVEL_WIDTH                    ;; A  = Index(A) + Level Width
    cp #LEVEL_SIZE                      ;; CP => A  = Index(A) + Level Width - Level Size
    jp p , _look_for_up_index           ;; IF A > Level Size THEN JUMP
;; IS IT A EMPTY POS?
    call _empty_matrix_position         ;; Check Matrix Value
    jr nz , _look_for_up_index          ;; IF NZ(F) == 0
;; SET DOWN INDEX POS       
    ld (de) , a                         ;; (DE)Index Hole = Index(A) + Level Width(A)
_look_for_up_index:     
    inc de                              ;; Next Index Hole to Evaluate
    ld a , #LEVEL_WIDTH                 ;; A = Level Width
    neg                                 ;; A = -A
    add l                               ;; A = Index(B) - Level Width(A)
    jp m , _look_for_right_index        ;; IF A < 0 THEN JUMP
;; IS IT A EMPTY POS?             
    call _empty_matrix_position         ;; Check Matrix Value
    jr nz , _look_for_right_index       ;; IF NZ(F) == 0
;; SET UP INDEX POS       
    ld (de) , a                         ;; (DE)Index Hole = Index(A) - Level Width(A)
_look_for_right_index:      
    inc de                              ;; Next Index Hole to Evaluate
    ld a , l                            ;; A = Index(L)
    and #MAX_POSITION                   ;; A = (Index(A) + 1) and Max Position
    cp  #MAX_POSITION                   ;; CP => (Index + 1 and Max Position) - Max Position
    jp z , _look_for_left_index         ;; IF CP == 0  THEN JUMP
    ld a , l                            ;; A = Index(L)
    inc a                               ;; A = Index(A) + 1
;; IS IT A EMPTY POS?          
    call _empty_matrix_position         ;; Check Matrix Value
    jr nz , _look_for_left_index        ;; IF NZ(F) == 0
;; SET RIGHT INDEX POS       
    ld (de) , a                         ;; (DE)Index Hole = Index(A) + 1
_look_for_left_index:
    inc de                              ;; Next Index Hole to Evaluate
    ld a , #0                           ;; A = Pos
_loop_for_left_index:
    cp l                                ;; CP => A = A - L
    ret z                               ;; RETURN IF A - L == 0
    add #LEVEL_WIDTH                    ;; A = Value(A) + Level Width
    cp #LEVEL_SIZE                      ;; CP => A = A - Level Size
    jp m , _loop_for_left_index         ;; JP IF A < Level Size
    ld a , l                            ;; A = Index(L)
    dec a                               ;; A = Index(A) - 1
;; IS IT A EMPTY POS?         
    call _empty_matrix_position         ;; Check Matrix Value
    ret nz                              ;; IF NZ(F) == 0
;; SET LEFT INDEX POS       
    ld (de) , a                         ;; (DE)Index Hole = Index(A) - 1
ret 
;;===============================================================================
;; FUNCTION _EMPTY_MATRIX_POSITION
;;          Input Parameters : A = Matrix Pos
;;         Output Parameters : A = Matrix Pos (Input Value)
;;                             F = Active Flags
;;===============================================================================
_empty_matrix_position:
    push hl                             ;; Save HL Values
    ld hl , #LEVEL_MATRIX               ;; HL = Pointer to Level Matrix
    ld c , a                            ;; C = A
    call simple_loop_inc_hl             ;; Loop - Matrix Pos
    ld a , (hl)                         ;; A = Level Matrix Pos Value
    or a                                ;; Active Flags
    ld a , c                            ;; A = C
    pop  hl                             ;; Recover HL Values
ret

;;===============================================================================
;; FUNCTION INCLUDE_NEW_ROOMS_INTO_MATRIX
;;===============================================================================
include_new_rooms_into_room_holes:
    ld hl , #INDEX_HOLES                        ;; HL = Pointer to Index Hole
    ld de , #ROOM_HOLES                         ;; DE = Pointer to Room Hole
    ld  b , #PPOSITIONS                         ;; B  = PPositions
_loop_include_new_rooms_into_holes:
    push hl                                     ;; Save Pointer to Index Hole
    ld hl , #NUMBER_OF_ROOMS                    ;; HL = Pointer to Number Of Rooms
    ld  a , (hl)                                ;; A = Number of Rooms Value(HL)
    pop hl                                      ;; Recover Pointer to Index Hole
    or a                                        ;; Active Flags
    ret z                                       ;; IF A == 0 THEN RETURN
    ld a , (hl)                                 ;; A = Index Hole Value(HL)
    or a                                        ;; Active Flags
    jp m , _next_iteration_1                    ;; IF A == 0 THEN JUMP
    push hl                                     ;; Save Pointer to Index Hole
    push bc                                     ;; Save Iterator (B)
    call p , get_level_room                     ;; IF A >= 0 THEN GET LEVEL ROOM
    pop  bc                                     ;; Recover Iterator(B)
    pop  hl                                     ;; Recover Pointer to Index Hole
    push hl                                     ;; Save Pointer to Index Hole
    ld hl , #NUMBER_OF_ROOMS                    ;; HL = Number of Rooms
    dec (hl)                                    ;; Number of Rooms Value --
    pop hl                                      ;; Recover Pointer to Index Hole
    ld (de) , a                                 ;; HL = ID ROOM(A)
_next_iteration_1:
    inc hl                                      ;; Next pointer position
    inc de                                      ;; Next pointer position
    djnz _loop_include_new_rooms_into_holes
ret 
;;===============================================================================
;; FUNCTION ADD_CONNECTOR_ROOM
;;===============================================================================
add_connector_rooms:
    ld hl , #NUMBER_OF_ROOMS                        ;; HL = Pointer to Number of Rooms
    ld  a , (hl)                                    ;;  A = Number of Rooms Value
    or  a                                           ;; Active Flags
    ret z                                           ;; RET IF A == 0
    call cpct_getRandom_lcg_u8_asm                  ;; A = Random Number
    and #SEC_POSI_FILTER                            ;; A = Random Number and SEC_POSI_FILTER
    ld b  , a                                       ;; B = A
    ld hl , #ROOM_HOLES                             ;; HL = Pointer to Room Holes
    push bc                                         ;; Save Iterator(B)
    call simple_loop_inc_hl                         ;; HL LOOP
    pop  bc                                         ;; Recover Iterator(B)
_loop_add_connector_rooms:          
    ld a , (hl)                                     ;; A = Room Hole Value
    or a                                            ;; Active Flags
    jr nz , add_connector_room_to_room_hole         ;; IF A != 0 THEN JUMP
    inc b                                           ;; B++
    inc hl                                          ;; HL++
    ld a , b                                        ;; A = B
    cp #PPOSITIONS                                  ;; A = A - PPositions
    jr nz , _loop_add_connector_rooms               ;; IF A != 0 THEN JUMP
    ld hl , #ROOM_HOLES                             ;; HL = Room Holes
    ld  b , #0                                      ;;  B = 0
    jr _loop_add_connector_rooms                    ;; JUMP
;;===============================================================================
;; FUNCTION ADD_CONNECTOR_ROOM_TO_ROOM_HOLE
;;          Input Parameters: HL = Pointer to Room Hole 
;;                             A = Room Hole Value
;;===============================================================================
add_connector_room_to_room_hole:
    ld c , a                        ;; C = A
    ld a , #FIRST_ROOM_ID           ;; A = First Room ID
    neg                             ;; A = -A
    add c                           ;; A = Room Hole Value - First Room ID
    ld (hl) , #CONNECTOR_ROOM_ID    ;; (HL)Room Hole Value = Connector Room ID
    ld hl , #LEVEL_ROOMS            ;; DE = Pointer to Level Rooms
    call simple_loop_inc_hl         ;; HL LOOP
    inc (hl)                        ;; Increment Level Room Value
    ld hl , #NUMBER_OF_ROOMS        ;; HL = Pointer to Number of Room
    inc (hl)                        ;; Increment Number of Room Value
ret

;;===============================================================================
;; FUNCTION INSERT_ROOMS_INTO_MATRIX
;;===============================================================================
insert_rooms_into_matrix::
    ld hl , #INDEX_HOLES                    ;; HL = Pointer to Index Hole
    ld de , #ROOM_HOLES                     ;; DE = Pointer to Room Hole
    ld  b , #PPOSITIONS                     ;;  B = PPositions
_loop_rooms_into_matrix:        
    ld  a , (hl)                            ;;  A = Index Hole Value
    or  a                                   ;; Active Flags
    jp  m , _next_iteration_2               ;; IF A < 0 THEN JUMP
    ld  c , a                               ;; C = Index Hole Value(A)
    push hl                                 ;; Save Index Hole Pointer
    ld hl , #LEVEL_MATRIX                   ;; HL = Level Matrix Pointer
    push bc                                 ;; Save Iterator(B)
    call simple_loop_inc_hl                 ;; HL LOOP
    pop  bc                                 ;; Recover Iterator(B)
    ld  a , (de)                            ;; A = Room Hole Value
    ld (hl) , a                             ;; (HL)Level Matrix Value = Room Hole Value(A)
    pop hl                                  ;; Recover Pointer to Index Hole
_next_iteration_2:      
    inc hl                                  ;; Increment Pointer Position
    inc de                                  ;; Increment Pointer Position
    djnz _loop_rooms_into_matrix        
ret
;;===============================================================================
;; FUNCTION FINALIZE_MATRIX_CONSTRUCT
;;===============================================================================
finalize_matrix_construct::
    call set_initial_room
ret
;;===============================================================================
;; FUNCTION RESET_CONSTR_VALUES
;;===============================================================================
reset_constr_values::
    ld hl , #INDEX_HOLES
    ld de , #ROOM_HOLES
    ld b  , #PPOSITIONS 
_loop_reset_constr_values:
    ld (hl) , #-1
    ex  de  , hl 
    ld (hl) , #0
    ex  de  , hl
    inc hl
    inc de 
    djnz _loop_reset_constr_values
ret
;;===============================================================================
;; FUNCTION RESET_MATRIX_VALUES
;;===============================================================================
reset_matrix_value:
    ld hl , #LEVEL_MATRIX       ;; HL = Pointer to Level Matrix
    ld b  , #LEVEL_SIZE         ;; B  = Iterator
_loop_reset_matrix_value:
    ld (hl) , #0                ;; (HL)Level Matrix Value = 0
    inc hl                      ;; Next Level Matrix Position
    djnz _loop_reset_matrix_value
ret
;;===============================================================================
;; FUNCTION GET_LEVEL_ROOM
;;          Output Parameters : A = ID ROOM
;;===============================================================================
get_level_room::
    call cpct_getRandom_lcg_u8_asm  ;; A = Random Number
    and  #SEC_ROOM_FILTER           ;; A = Random Number(A) and Sec Room Filter
    ld  b , a                       ;; B = Random Number(A) and Sec Room Filter(A)
    ld hl , #LEVEL_ROOMS            ;; HL = Pointer to Level Rooms
    push bc                         ;; BC = Save Iterator
    call simple_loop_inc_hl         ;; HL LOOP
    pop  bc                         ;; BC = Iterator
_loop_get_level_room:
    ld a , (hl)                     ;; A = Level Room Value(HL)
    or a                            ;; Active Flags
    jr nz , selected_level_room     ;; SELECTED ROOM
    inc hl                          ;; Next Level Room
    inc b                           ;; B++
    ld a , b                        ;; A = B
    cp #NUMBER_OF_TYPE_ROOMS        ;; A = A - NUMBER OF TYPE ROOMS
    jr nz , _loop_get_level_room    ;; IF A != 0 THEN JUMP
    ld hl , #LEVEL_ROOMS            ;; HL = Pointer to Level Rooms
    ld b , #0                       ;; B  = 0
    jr _loop_get_level_room         ;; JUMP LOOP
;;===============================================================================
;; FUNCTION SELECTED_LEVEL_ROOM
;;           Input Parameters : B = ID RAW ROOM
;;                              HL= Pointer to Level Rooms
;;          Output Parameters : A = ID ROOM
;;===============================================================================
selected_level_room:
    dec (hl)                ;; Decrement Number of Level Type Room
    ld a , b                ;; A = ID RAW ROOM
    add #FIRST_ROOM_ID      ;; A = ID RAW ROOM + FIRST ROOM ID = NORMAL ROOM ID
ret
;;===============================================================================
;; FUNCTION GENERATE_ACTUAL_LEVEL_ROOMS:
;;===============================================================================
generate_actual_level_rooms:
    ld de , #INDEX                  ;; DE = Pointer to Index DE
    ld a , (de)                     ;;  A = Last Index Value
    ld hl , #AUX_INDEX              ;; HL = AUX Index Pointer
    ld (hl) , a                     ;; HL Value = Index Value(A)
    ld hl , #LEVEL_MATRIX           ;; HL = Pointer to Level Matrix
    call simple_loop_inc_hl         ;; HL LOOP
    ld b  , (hl)                    ;;  B = Room Value(HL)
    ld a , (de)                     ;;  A = Last Index Value
    ld de , #INDEX_HOLES            ;; DE = Pointer to Index Hole
    ld ix , #ROOM_HOLES
    call generate_new_connector_room
    ld  b , #PPOSITIONS             ;; B = PPositions - Iterator
    ld de , #INDEX_HOLES            ;; DE = Pointer to Index Hole
    ld hl , #ROOM_HOLES             ;; HL = Pointer to Room Holes
_loop_generate_actual_level_rooms:
    push hl                         ;; Save HL Pointer
    push de                         ;; Save DE Pointer
    push bc                         ;; Save Iterator (B)
    ld a , (hl)                     ;; A = Room Hole Value
    or a                            ;; Active Flags
    jr z , _next_loop_iteration     ;; JUMP IF A == 0
    cp #CONNECTOR_ROOM_ID           ;; COMPARE WITH CONNECTORS
    jr z , set_next_connection_room ;; JUMP IF A == 0
    ld b , a                        ;; B = Room Hole Value(A)
    ld a , (de)                     ;; A = Index Hole Value
    ld de , #AUX_INDEX              ;; DE = AUX Index Pointer
    call generate_new_room          ;; GENERATE NEW ROOM
_next_loop_iteration:   
    pop  bc                         ;; Recover Iterator(B)
    pop  de                         ;; Recover DE Pointer
    pop  hl                         ;; Recover HL Pointer
    inc de                          ;; Increment Pointer Position
    inc hl                          ;; Increment Pointer Position
    djnz _loop_generate_actual_level_rooms
ret
;;===============================================================================
;; FUNCTION SET_NEXT_CONNECTION_ROOM:
;;===============================================================================
set_next_connection_room:
    ld hl , #INDEX          ;; HL = Pointer to Index Value
    ld  a , (hl)            ;;  A = Index Value
    push hl                 ;; Save Index Pointer
    ld hl , #LAST_INDEX     ;; HL = Pointer to Last Index Value
    ld (hl) , a             ;; (HL)Last Index Value = Actual Index(A)
    pop hl                  ;; Recover Index Pointer
    ld a , (de)             ;; A = Index Hole Value(DE)
    ld (hl) , a             ;; (HL)Index Value = New Index(A)
    jr _next_loop_iteration