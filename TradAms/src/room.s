.area _DATA

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

TRADAMS_TILE_SET::
    .dw TRADAMS_TILE_1  ,   TRADAMS_TILE_2
    .dw TRADAMS_TILE_3  ,   TRADAMS_TILE_4 
    .dw TRADAMS_TILE_5  ,   TRADAMS_TILE_6 
    .dw TRADAMS_TILE_7  ,   TRADAMS_TILE_8 
	.dw TRADAMS_TILE_9  ,   TRADAMS_TILE_10 
	.dw TRADAMS_TILE_11
TRADAMS_TILE_1:    
    .db #0x0f, #0x0f, #0x0f, #0x0f
	.db #0x01, #0x01, #0x01, #0x01
	.db #0x0d, #0x0d, #0x0d, #0x0d
	.db #0x02, #0x02, #0x02, #0x02
	.db #0x0b, #0x0b, #0x0b, #0x0b
	.db #0x04, #0x04, #0x04, #0x04
	.db #0x04, #0x04, #0x04, #0x04
	.db #0x0f, #0x0f, #0x0f, #0x0f
	.db #0x08, #0x08, #0x08, #0x08
	.db #0x08, #0x08, #0x08, #0x08
	.db #0x07, #0x07, #0x07, #0x07
	.db #0x01, #0x01, #0x01, #0x01
	.db #0x0e, #0x0e, #0x0e, #0x0e
	.db #0x02, #0x02, #0x02, #0x02
	.db #0x02, #0x02, #0x02, #0x02
	.db #0x0f, #0x0f, #0x0f, #0x0f

TRADAMS_TILE_2:
    .db #0x0f, #0x0f, #0x0f, #0x0f
	.db #0x01, #0x01, #0x01, #0x01
	.db #0x0d, #0x0d, #0x0d, #0x0d
	.db #0x02, #0x02, #0x02, #0x02
	.db #0x0a, #0x02, #0x03, #0x0b
	.db #0x05, #0x0c, #0x04, #0x04
	.db #0x04, #0x04, #0x04, #0x04
	.db #0x0f, #0x0f, #0x0f, #0x0f
	.db #0x08, #0x08, #0x08, #0x08
	.db #0x08, #0x08, #0x08, #0x08
	.db #0x07, #0x07, #0x07, #0x07
	.db #0x01, #0x01, #0x01, #0x01
	.db #0x02, #0x0e, #0x0e, #0x02
	.db #0x02, #0x02, #0x02, #0x02
	.db #0x02, #0x02, #0x02, #0x02
	.db #0x0f, #0x0f, #0x0f, #0x0f

TRADAMS_TILE_3:
    .db #0x08, #0x08, #0x08, #0x08
	.db #0x07, #0x07, #0x07, #0x07
	.db #0x04, #0x04, #0x04, #0x04
	.db #0x0b, #0x0b, #0x0b, #0x0b
	.db #0x02, #0x02, #0x02, #0x02
	.db #0x01, #0x01, #0x01, #0x01
	.db #0x0f, #0x0f, #0x0f, #0x0f
	.db #0x08, #0x08, #0x08, #0x08
	.db #0x0b, #0x0b, #0x0b, #0x0b
	.db #0x04, #0x04, #0x04, #0x04
	.db #0x05, #0x0d, #0x0d, #0x0d
	.db #0x02, #0x02, #0x02, #0x02
	.db #0x0e, #0x0e, #0x0e, #0x0e
	.db #0x01, #0x01, #0x01, #0x01
	.db #0x01, #0x01, #0x01, #0x01
	.db #0x0f, #0x0f, #0x0f, #0x0f

TRADAMS_TILE_4:
    .db #0x0a, #0x05, #0x02, #0x09
	.db #0x0a, #0x07, #0x02, #0x0f
	.db #0x09, #0x09, #0x03, #0x01
	.db #0x0e, #0x05, #0x0c, #0x09
	.db #0x0a, #0x05, #0x02, #0x09
	.db #0x0a, #0x07, #0x02, #0x0f
	.db #0x09, #0x09, #0x03, #0x01
	.db #0x0e, #0x05, #0x0c, #0x09
	.db #0x0a, #0x05, #0x02, #0x09
	.db #0x0a, #0x07, #0x02, #0x0f
	.db #0x09, #0x09, #0x03, #0x01
	.db #0x0e, #0x05, #0x0c, #0x09
	.db #0x0a, #0x05, #0x02, #0x09
	.db #0x0a, #0x07, #0x02, #0x0f
	.db #0x09, #0x09, #0x03, #0x01
	.db #0x0e, #0x05, #0x0c, #0x09

TRADAMS_TILE_5:
    .db #0x0a, #0x05, #0x02, #0x09
	.db #0x0a, #0x07, #0x02, #0x0f
	.db #0x09, #0x09, #0x03, #0x01
	.db #0x0e, #0x01, #0x0c, #0x09
	.db #0x0a, #0x01, #0x02, #0x09
	.db #0x0a, #0x07, #0x02, #0x0f
	.db #0x09, #0x09, #0x03, #0x01
	.db #0x0e, #0x05, #0x0c, #0x09
	.db #0x0a, #0x05, #0x00, #0x09
	.db #0x0a, #0x07, #0x00, #0x0f
	.db #0x09, #0x09, #0x03, #0x01
	.db #0x0e, #0x05, #0x0c, #0x01
	.db #0x0a, #0x05, #0x02, #0x01
	.db #0x0a, #0x07, #0x02, #0x0f
	.db #0x09, #0x09, #0x03, #0x01
	.db #0x0e, #0x05, #0x0c, #0x09

TRADAMS_TILE_6:
    .db #0x0f, #0x0f, #0x0f, #0x0f
	.db #0x08, #0x08, #0x08, #0x08
	.db #0x0d, #0x08, #0x08, #0x08
	.db #0x0e, #0x0b, #0x0b, #0x0b
	.db #0x0a, #0x04, #0x04, #0x04
	.db #0x0a, #0x04, #0x04, #0x04
	.db #0x09, #0x04, #0x04, #0x04
	.db #0x0f, #0x04, #0x04, #0x04
	.db #0x09, #0x0b, #0x0b, #0x0b
	.db #0x08, #0x0a, #0x02, #0x02
	.db #0x08, #0x06, #0x02, #0x02
	.db #0x0e, #0x06, #0x02, #0x02
	.db #0x09, #0x0b, #0x0d, #0x0d
	.db #0x08, #0x07, #0x01, #0x01
	.db #0x08, #0x01, #0x01, #0x01
	.db #0x0e, #0x01, #0x0f, #0x0f

TRADAMS_TILE_7:
    .db #0x09, #0x09, #0x08, #0x08
	.db #0x08, #0x07, #0x08, #0x08
	.db #0x08, #0x01, #0x07, #0x0b
	.db #0x0e, #0x01, #0x04, #0x04
	.db #0x09, #0x09, #0x02, #0x04
	.db #0x08, #0x07, #0x0e, #0x04
	.db #0x08, #0x01, #0x01, #0x05
	.db #0x0e, #0x01, #0x01, #0x0a
	.db #0x09, #0x09, #0x00, #0x0a
	.db #0x08, #0x07, #0x0c, #0x0a
	.db #0x08, #0x01, #0x03, #0x06
	.db #0x0e, #0x01, #0x00, #0x0d
	.db #0x09, #0x09, #0x00, #0x03
	.db #0x08, #0x07, #0x0c, #0x03
	.db #0x08, #0x01, #0x03, #0x01
	.db #0x0e, #0x01, #0x00, #0x0f

TRADAMS_TILE_8:
    .db #0x0a, #0x07, #0x02, #0x05
	.db #0x09, #0x09, #0x02, #0x0e
	.db #0x0e, #0x05, #0x03, #0x07
	.db #0x0a, #0x05, #0x0c, #0x0a
	.db #0x0a, #0x07, #0x01, #0x04
	.db #0x09, #0x09, #0x02, #0x07
	.db #0x0e, #0x05, #0x04, #0x08
	.db #0x0a, #0x05, #0x08, #0x08
	.db #0x0a, #0x07, #0x0f, #0x0f
	.db #0x09, #0x0b, #0x01, #0x01
	.db #0x0e, #0x05, #0x0d, #0x0d
	.db #0x0a, #0x0a, #0x02, #0x02
	.db #0x09, #0x02, #0x02, #0x02
	.db #0x0a, #0x0d, #0x0d, #0x0d
	.db #0x0c, #0x04, #0x04, #0x04
	.db #0x0f, #0x0f, #0x0f, #0x0f

TRADAMS_TILE_9:
	.db #0x0f, #0x0f, #0x0f, #0x0f
	.db #0x01, #0x01, #0x01, #0x01
	.db #0x01, #0x01, #0x01, #0x0b
	.db #0x0d, #0x0d, #0x0d, #0x07
	.db #0x02, #0x02, #0x02, #0x05
	.db #0x02, #0x02, #0x02, #0x05
	.db #0x02, #0x02, #0x02, #0x09
	.db #0x02, #0x02, #0x02, #0x0f
	.db #0x0d, #0x0d, #0x0d, #0x09
	.db #0x04, #0x04, #0x05, #0x01
	.db #0x04, #0x04, #0x06, #0x01
	.db #0x04, #0x04, #0x06, #0x07
	.db #0x0b, #0x0b, #0x0d, #0x09
	.db #0x08, #0x08, #0x0e, #0x01
	.db #0x08, #0x08, #0x08, #0x01
	.db #0x0f, #0x0f, #0x08, #0x07

TRADAMS_TILE_10:
	.db #0x01, #0x01, #0x09, #0x09
	.db #0x01, #0x01, #0x0e, #0x01
	.db #0x0d, #0x0e, #0x08, #0x01
	.db #0x02, #0x02, #0x08, #0x07
	.db #0x02, #0x04, #0x09, #0x09
	.db #0x02, #0x07, #0x0e, #0x01
	.db #0x0a, #0x08, #0x08, #0x01
	.db #0x05, #0x08, #0x08, #0x07
	.db #0x05, #0x00, #0x09, #0x09
	.db #0x05, #0x03, #0x0e, #0x01
	.db #0x06, #0x0c, #0x08, #0x01
	.db #0x0b, #0x00, #0x08, #0x07
	.db #0x0c, #0x00, #0x09, #0x09
	.db #0x0c, #0x03, #0x0e, #0x01
	.db #0x08, #0x0c, #0x08, #0x01
	.db #0x0f, #0x00, #0x08, #0x07

TRADAMS_TILE_11:
	.db #0x0a, #0x04, #0x0e, #0x05
	.db #0x07, #0x04, #0x09, #0x09
	.db #0x0e, #0x0c, #0x0a, #0x07
	.db #0x05, #0x03, #0x0a, #0x05
	.db #0x02, #0x08, #0x0e, #0x05
	.db #0x0e, #0x04, #0x09, #0x09
	.db #0x01, #0x02, #0x0a, #0x07
	.db #0x01, #0x01, #0x0a, #0x05
	.db #0x0f, #0x0f, #0x0e, #0x05
	.db #0x08, #0x08, #0x0d, #0x09
	.db #0x0b, #0x0b, #0x0a, #0x07
	.db #0x04, #0x04, #0x05, #0x05
	.db #0x04, #0x04, #0x04, #0x09
	.db #0x0b, #0x0b, #0x0b, #0x05
	.db #0x02, #0x02, #0x02, #0x03
	.db #0x0f, #0x0f, #0x0f, #0x0f

Horizontal_Construction_1:	.db #6 , #2 , #1 , #1 , #2 
							.db #2 , #2 , #2 , #1 , #1
							.db #1 , #2 , #1 , #2 , #1 
							.db #2 , #2 , #1 , #1 , #9

Horizontal_Construction_2:	.db #7 , #3 , #1 , #2 , #1 
							.db #1 , #3 , #2 , #1 , #1
							.db #1 , #1 , #3 , #1 , #2 
							.db #1 , #1 , #2 , #3 , #10

Horizontal_Construction_3:	.db #8 , #1 , #1 , #2 , #2 
							.db #1 , #1 , #1 , #1 , #2
							.db #1 , #1 , #1 , #2 , #1 
							.db #1 , #2 , #2 , #1 , #11

Vertical_Construction_1: 	.db #4 , #5 , #4 , #4
							.db #4 , #4 , #4 , #5 , #4

Vertical_Construction_2: 	.db #5 , #4 , #5 , #5
							.db #4 , #4 , #4 , #4 , #5

Tile_Width      = #4       ;; TileSet Width
Tile_Height     = #16      ;; TileSet Height
Screen_Start    = #0xC000  ;; Screen Start
N_Tile_WIDTH    = #20	   ;; Number of Tiles (Width Screen)
N_Tile_HEIGHT   = #12	   ;; Number of Tiles (Height Screen)

;; INITIAL CONSTRUCTION POS (YX)
C_H_1 = #0x0800
C_H_2 = #0x1800
C_H_3 = #0xB800
C_V_1 = #0x2800
C_V_2 = #0x284C
N_Tile_Vertical = #9

N_ROOMS_PARAMETERS = #4
.macro definedRoom name
	name'_room::
	name'_room_index:		.db #0xFF		;; INDEX ROOM
	name'_room_connect:		.db #0x00		;; CONNECTION VALUES
	name'_room_id:			.db #0x00		;; ID ROOM P1
	name'_room_second_prt:	.db #0x00		;; ID ROOM P2
.endm

generated_rooms::	
definedRoom a 
definedRoom b 
definedRoom c 
definedRoom d 
definedRoom e 
definedRoom f 
definedRoom g 
definedRoom h 
definedRoom i 
definedRoom j 
definedRoom k 
definedRoom l 
definedRoom m 
definedRoom n 
definedRoom o 
definedRoom p 
definedRoom q 
definedRoom r 
definedRoom s 
definedRoom t 
definedRoom u 
definedRoom v 
definedRoom w 
definedRoom x 
definedRoom y
definedRoom z 

definedRoom actual

definedRoom initValues

MAX_NUMBER_GENERATED_ROOMS  = #25
NUMBER_OF_GENERATED_ROOMS: .db #0

;; CONNECTIONS 

.macro defineConnectComparators name , position , roomConnect , checkOpen
	CONNECT_'name' = position
	CONNECTION_'name' = roomConnect
	CONNECTION_'name'_OPEN = checkOpen
.endm
					;;	X	 	Y
left_initial_pos:	.db #0x08 , #0x58
right_initial_pos:	.db #0x44 , #0x58
up_initial_pos:		.db #0x24 , #0x2F
down_initial_pos:	.db #0x24 , #0xA0

defineConnectComparators DOWN 	, 8 	, 128 	, 8
defineConnectComparators UP 	, -8 	, 64 	, 4
defineConnectComparators RIGHT 	, 1 	, 32 	, 2
defineConnectComparators LEFT 	, -1 	, 16 	, 1
NUMBER_CONNECTIONS = #4

CONNECTS_COMPARATOR::.db CONNECT_DOWN , CONNECT_UP , CONNECT_RIGHT , CONNECT_LEFT
CONNECTION_VALUES::  .db CONNECTION_DOWN , CONNECTION_UP , CONNECTION_RIGHT , CONNECTION_LEFT
CONNECTIONS_OPENED:: .db CONNECTION_DOWN_OPEN , CONNECTION_UP_OPEN
					 .db CONNECTION_RIGHT_OPEN , CONNECTION_LEFT_OPEN

.globl reset_objects_asm
.globl change_room
.globl LAST_INDEX
.globl AUX_INDEX
.globl EXISTING_DOORS

.globl cpct_setSeed_lcg_u8_asm
.globl cpct_getRandom_lcg_u8_asm
.globl cpct_drawSprite_asm
.globl cpct_getScreenPtr_asm

.globl draw_door_room
.globl simple_loop_inc_hl
.globl reset_objects_asm

.globl cpct_getRandom_xsp40_u8_asm

.globl palette_GREEN
.globl palette_WHITE
.globl palette_RED
.globl palette_YELLOW
.globl palette_BLUEP
.globl palette_ORANGE
.globl palette_BLACK
.globl palette_MAUVE
.globl cpct_setPalette_asm

.globl select_room_asm
.globl set_object_screen_asm

.globl reset_enemies_room_asm

.globl set_enemies_room_asm

.globl player_position

.globl draw_stairs_asm
.globl unset_stairs_asm
.globl set_stairs_asm

palette_size 	= #4		  ;; Number of Colors


.area _CODE 
;;===============================================================================
;; FUNCTION SET_INITIAL_ROOM:
;;===============================================================================
set_initial_room::
	ld de , #generated_rooms	;; pointer to generated rooms
	ld hl , #actual_room		;; pointer to Actual Room
	ld a , (de)					;; A = First Room Index Value
	ld (hl) , a					;; (HL)Actual Index value = First Room Index Value
	inc de 						;; Pointer to First Connection Value
	inc hl 						;; Pointer to Actual Connection Value
	ld a , (de)					;; A = First Room Connection Value
	ld (hl) , a					;; (HL)Actual Connection value = First Room Connection Value
	inc de 						;; Pointer to First Room ID Value
	inc hl 						;; Pointer to Actual Room ID Value
	ld a , (de)					;; A = First Room ID Value
	ld (hl) , a					;; (HL)Actual ID value = First Room ID Value
ret
;;===============================================================================
;; FUNCTION SET_ACTUAL_ROOM:
;;
;; Input parameters :  B  = Number of Door (0 = DOWN | 1 = LEFT | 2 = RIGHT | 3 = UP )
;;					   C  = Open Value (0 = Close | 1 = Open) 
;;===============================================================================
;;===============================================================================
;; FUNCTION ROOM_LOOP_HL:
;;
;; 	Input parameters :  A = NUMBER OF ROOM                
;; Output parameters :	HL= Pointer to Generated Rooms
;;===============================================================================
room_loop_hl:
	or a 							;; Active Flags
	ld hl , #generated_rooms		;; HL = Pointer to Generated Rooms
	ret z 							;; IF A == 0 THEN RET
	ld b , a 						;; B = A
_loop_room_loop_hl:
	inc hl 
	inc hl 							;; Next Position (CONNECT && DOOP)
	inc hl							;; Next Position (ID_ROOM)
	inc hl							;; Next Position (INDEX)
	djnz _loop_room_loop_hl
ret 
;;===============================================================================
;; FUNCTION GENERATE_NEW_ROOM:
;;
;; Input parameters :  A = INDEX
;;					   B = TYPE ROOM
;;===============================================================================
generate_new_room::
	push bc 							;; Save BC Values
	call set_index_room					;; Set Index Room
	inc hl 								;; Next Position (CONNECT && DOOP)
	call connection_room				;; Connection Room
	pop  bc 							;; Recover BC Values
	call all_door_opened
	inc hl 								;; Next Position (ID_ROOM)
	call room_id_generator				;; Generate ROOM ID
ret
;;===============================================================================
;; FUNCTION SET_INDEX_ROOM:
;;  Input parameters : A = Index
;; Output parameters : HL = Pointer to New Index Room   
;;===============================================================================
set_index_room:
	push af 							;; Save Index(A)
	ld hl , #NUMBER_OF_GENERATED_ROOMS	;; HL = Pointer to Number of Generated Rooms
	ld  a , (hl)						;; A = Number of GR Value
	inc (hl)							;; Increment HL Value
	call room_loop_hl					;; ROOM LOOP
	pop af 								;; Recover Index(A)
	ld (hl) , a 						;; (HL) Index Room = Index(A)
ret
;;===============================================================================
;; FUNCTION ROOM_ID_GENERATOR:
;; Input parameters : HL = Pointer to Room ID   
;; 					   B = Type Room
;;===============================================================================
room_id_generator:
	ld (hl) , b						;; HL = Type Room
	call select_room_asm
ret
;;===============================================================================
;; FUNCTION CONNECTION_ROOM:
;;
;; Input parameters :  A = Index 
;;					   HL = Pointer to Room Generated Connect 
;;					   DE = Index to Comparate                    
;;===============================================================================
connection_room::
	neg 								;; A = -A
	push af 							;; Save Negate Index(A)
	ld  a , (de)						;; A = Last Index Value
	pop de 								;; Recover Negate Index(D)
	add d 								;; A = Connector Room Index(A) - Room Index(D)
	push hl 							;; Save Pointer to Room Generated Connect
	ld hl , #CONNECTS_COMPARATOR		;; HL = Pointer to Connects Comparator
	ld de , #CONNECTION_VALUES			;; DE = Pointer to Connection Values
	ld  b , #NUMBER_CONNECTIONS			;; B  = NUMBER OF CONNECTIONS
_loop_connection_room:
	cp (hl)								;; COMPARE HL WITH A
	jr nz , _next_loop_iteration		;; IF CP != 0 THEN JUMP
	pop hl 								;; Recover Pointer to Room Generated Connect
	ld  b  , (hl)						;; B = Room Connect Value(HL)
	ld  a , (de)						;; A = Connection Value(DE)
	add b 								;; A = Connection Value(A) + Room Connect Value(B)
	ld (hl) , a 						;; (HL) Room Connect = Connection Value(A)
	ret					
_next_loop_iteration:
	inc de 								;; Next Pointer Position
	inc hl 								;; Next Pointer Position
	djnz _loop_connection_room
	pop hl 								;; Recover Pointer to Room Generated Connect 
ret

all_door_opened::
	ld a , (hl)
	add  #0x0F
	ld (hl) , a 
ret
;;===============================================================================
;; FUNCTION GENERATE_NEW_CONNECTOR_ROOM:
;;
;; Input parameters :  A = INDEX
;;					   B = TYPE ROOM                     
;;					   DE= INDEX HOLE
;;					   IX= ROOM HOLE
;;===============================================================================
generate_new_connector_room::
	push bc 							;; Save Type Room(B)
	call set_index_room					;; Set Index Room
	inc hl 								;; Next Position (CONNECT && DOOP)
	call all_door_opened
	call set_connector_connections		;; Set Connections
	pop  bc 							;; Recover Type Room(B)
	inc hl 								;; Next Position (ID_ROOM)
	call room_id_generator				;; Generate ROOM ID
ret
;;===============================================================================
;; FUNCTION SET_CONNECTOR_CONNECTIONS:
;;
;; Input parameters :  HL = Pointer to Room Connections  
;;					   DE = INDEX HOLE
;;					   IX = ROOM HOLE
;;===============================================================================
set_connector_connections::
	push hl 											;; Save Pointer to Room Generated Connect 
	ld hl , #CONNECTION_VALUES							;; DE = Pointer to Connection Values
	ld iy , #CONNECTIONS_OPENED
	ld  b , #NUMBER_CONNECTIONS							;; B  = NUMBER OF CONNECTIONS
	ld  c , #0											;; C = 0
_loop_set_connector_connections:				
	ld a , (de)											;; A = Index Hole Value
	or a 												;; Active Flags
	jp m , _next_iteration_connector_connections		;; IF A < 0 THEN JUMP
	ld a , c 											;; A = C 
	add (hl)											;; A = Connection Value(HL)
	ld c , a 											;; C = Connection Value(A)
	ld a , (ix)											;; A = Room Hole
	cp #CONNECTOR_ROOM									;; Compare with connector room
	jr z , _next_iteration_connector_connections
	cp #INITIAL_ROOM
	jr z , _next_iteration_connector_connections
	cp #BOSSES_ROOM
	jr z , _next_iteration_connector_connections
	cp #OBJECT_ROOM
	jr z , _next_iteration_connector_connections
_close_door_connect:
	ld a , (iy)
	neg
	add c
	ld c , a 
_next_iteration_connector_connections:
	inc hl 												;; Increment HL
	inc ix 												;; Increment IX
	inc iy 												;; Increment IY
	inc de 												;; Increment DE
	djnz _loop_set_connector_connections				;; JUMP
	ld  de , #LAST_INDEX								;; DE = Last Index
	ld  hl , #AUX_INDEX									;; HL = Aux Index Pointer
	ld   a , (hl) 										;;  A = Aux Index Value
	pop hl 												;; Recover Pointer to Room Connect
	call connection_room

	ld  a   ,(hl)										;; A = Room Connect(HL)
	add c												;; A = Room Connect(A) + Connection Value(C)
	ld  (hl) , a 										;; HL = Room Connect(A) + Connection Value(C)
ret
;;===============================================================================
;; FUNCTION DRAW_ROOM_TILE:
;;
;; Input parameters :  B  = Y Position
;;					   C  = X Position
;;					   HL = TILE  
;;===============================================================================
draw_room_tile:

	push hl 						;; Save Pointer to Tile
	ld de , #Screen_Start			;; Pointer to Screen
	call cpct_getScreenPtr_asm		;; Get Screen Pointer
	ex    de, hl                    ;; DE = pointer to video memory location to draw the sprite


	ld c , #Tile_Width				;; Constant Tile Width
	ld b , #Tile_Height				;; Constant Tile Height
	pop hl 							;; Recover Pointer to Tile
	call cpct_drawSprite_asm		;; Draw Sprite
ret
;;===============================================================================
;; FUNCTION DRAW_ROOM:
;;===============================================================================
draw_room_asm::
	ld hl , #Horizontal_Construction_1
	ld de , #C_H_1
	ld  b , #N_Tile_WIDTH
	ld  c , #0
	call draw_room_construction
	ld hl , #Horizontal_Construction_2
	ld de , #C_H_2
	ld  b , #N_Tile_WIDTH
	ld  c , #0
	call draw_room_construction
	ld hl , #Horizontal_Construction_3
	ld de , #C_H_3
	ld  b , #N_Tile_WIDTH
	ld  c , #0
	call draw_room_construction
	ld hl , #Vertical_Construction_1
	ld de , #C_V_1
	ld  b , #N_Tile_Vertical
	ld  c , #1
	call draw_room_construction
	ld hl , #Vertical_Construction_2
	ld de , #C_V_2
	ld  b , #N_Tile_Vertical
	ld  c , #1
	call draw_room_construction
	call draw_connection_room
ret
;;===============================================================================
;; FUNCTION DRAW_CONNECTION_ROOM:
;;
;; 	Input parameters :  
;;===============================================================================
draw_connection_room::
	ld ix , #EXISTING_DOORS
	ld 0(ix) , #-1									;; IX = -1
	ld 1(ix) , #-1									;; IX = -1
	ld 2(ix) , #-1									;; IX = -1
	ld 3(ix) , #-1									;; IX = -1
	ld de , #actual_room						    ;; Actual Room
	inc de 											;; CONNECTION VALUES
	ld a , #NUMBER_CONNECTIONS						;; A = ITERATOR
	dec a 											;; DECREMENT A
	ld hl , #CONNECTION_VALUES						;; VALUES TO COMPARATE
	call simple_loop_inc_hl							;; HL LOOP
	ld b , #NUMBER_CONNECTIONS						;; B = ITERATOR
_loop_draw_connection_room:			
	ld a , (de)										;; A = Room Connection Values
	and (hl)										;; A = Room Connection Values(A) and Especific Connection(HL)
	cp (hl)											;; Compare
	jr nz , _next_draw_connection_room_iterator		;; IF A !=0 THEN JUMP
	push hl											;; Save Connection Values
	push bc											;; Save Iterator
	ld a , b										;; A = Iterator
	dec a 											;; Decrement A
	ld hl , #CONNECTIONS_OPENED						;; HL = Pointer to Connections Open
	call simple_loop_inc_hl							;; HL LOOP
	ld a , (de)										;; A = Room Connection Values
	and (hl)										;; A = Room Connection Values(A) and Especific Door State(HL)
	cp (hl)											;; Compare
	pop bc 											;; Recover Iterator
	jr nz , _draw_closed_door						;; IF Door is closed
_draw_opened_door:									;; DOOR OPENED
	ld (ix) , #1									;; IX = 1
	ld c , #1										;; C = 1 (OPEN)
	jr _draw_door									;; DRAW DOOR
_draw_closed_door:									;; DOOR CLOSED
	ld c , #0										;; C = 0 (CLOSE)
	ld (ix) , #0
_draw_door:
	push bc 										;; Save Iterator
	push de 										;; Save Coonector Room Pointer
	dec b											;; Decrement B
	call draw_door_room								;; Draw Door
	pop de											;; Recover Connector Room Pointer
	pop bc											;; Recover Iterator
	pop hl 											;; Recover Connection Value
_next_draw_connection_room_iterator:
	inc ix 											;; Next Door
	dec hl 											;; Decrement Pointer to Connection Values
	djnz _loop_draw_connection_room
ret
;;===============================================================================
;; FUNCTION DRAW_ROOM_CONSTRUCTION:
;;
;; 	Input parameters :  B = Number of Tile
;;  					C = Value for Coordinate
;;					   DE = Initial Position  
;; 					   HL = Pointer to Construction
;;===============================================================================
draw_room_construction:
	push bc 								;; Save Iterator(B)
	ld a ,(hl)								;; A = Number Tile(HL)
	or a 									;; Active Flags
	jr z , _next_draw_hor_const_iteration	;; IF A == 0 THEN JUMP
	ld b ,(hl)								;; B = Number Tile(HL)
	push hl 								;; Save Pointer to Construction
	push de 								;; Save Coordinates
	call tile_selector						;; Tile Selector
	pop  de 								;; Recover Coordinates
	ld b , d 								;; B = Coordinate Y (D)
	ld c , e 								;; C = Coordinate X (E)
	push de 								;; Save Coordinates
	call draw_room_tile						;; Draw Room Tile
	pop  de 								;; Recover Coordinates
	pop hl 									;; Recover Pointer to Construction
_next_draw_hor_const_iteration:
	pop bc 									;; Recover Iterator (B)
	ld a  , c 								;; A = C
	or a 									;; Active Flags
	jr z , _width_selection_value
_heigth_selection_value:
	ld a  , d 								;; A = Coordinate X (E)
	add #Tile_Height						;; A = Coordinate X (E) + Tile_Value
	ld d  , a 								;; D = A
_next_draw_hor_const_iteration_2:	
	inc hl									;; Increment
	djnz draw_room_construction
ret
_width_selection_value:
	ld a  , e 								;; A = Coordinate X (E)
	add #Tile_Width							;; A = Coordinate X (E) + Tile_Value
	ld e  , a 								;; E = A
	jr _next_draw_hor_const_iteration_2

;;===============================================================================
;; FUNCTION TILE_SELECTOR:
;;
;; 	Input parameters :  B = Number of Tile  
;; Output parameters : HL = Tile Memory Pos
;;===============================================================================
tile_selector:
	ld hl , #TRADAMS_TILE_SET		;; Pointer to Tile Set
	dec b 							;; Decrement Iterator
	ld a , b 						;; A = B
	or a 							;; Active Flags
	jr z , _get_tile_value
_loop_tile_selector:	
	inc hl 							;; Second Part of Pointer
	inc hl							;; Next Tile Pointer
	djnz _loop_tile_selector		;; 
_get_tile_value:
	ld e , (hl)                     ;; E = First Middle Tile Part
    inc hl                          ;; Next Position Array TileSet
    ld d , (hl)                     ;; D = Second Middle Tile Part
	ex de , hl 						;; Exchange DE <-> HL
ret
;;===============================================================================
;; FUNCTION CHANGE_ROOM_ASM:
;;===============================================================================
CONNECTOR_ROOM      = #1       ;; ID 1
PUZZLE_ROOM         = #2       ;; ID 2 
TEMPLE_ROOM         = #3       ;; ID 3 
SURVIVE_ROOM        = #4       ;; ID 4
HIDDEN_ROOM         = #5       ;; ID 5
STORE_ROOM          = #6       ;; ID 6
BET_ROOM            = #7       ;; ID 7
OBJECT_ROOM         = #8       ;; ID 8
BOSSES_ROOM         = #9       ;; ID 9 
INITIAL_ROOM        = #10      ;; ID 10

change_room_asm::
	ld hl , #change_room			;; HL = Change Room Flag Pointer
    ld a , (hl)         			;; A = Flag Value
    or a 							;; Active CPU Flags
    ret z 							;; RETURN if A == 0
	call reset_objects_asm
	ld ix , #actual_room			;; Pointer to Actual Room
	ld  a , 0(ix)					;; A = Index Room
	call find_room_by_id
	push hl 						;; Save HL Values
	pop iy 							;; Recover HL into IY
	ld a , 1(ix)					;; Connection Value
	ld 1(iy) , a 					;; HL = New Connection Value
	ld 3(iy) , #1					;; Finished Room
	ld a , 0(ix)					;; A = ID Room
	ld hl , #change_room			;; HL = Change Room 
	add (hl)						;;  A = ID Room + Change Room
	call find_room_by_id			;; Find New Room
update_actual_room::
	push hl 						;; Save HL Values
	pop iy 							;; Recover HL Values into IY
	ld a , 0(iy)					;; A = New Room Value (Index)
	ld 0(ix) , a 					;; Actual Room New Value
	ld a , 1(iy)					;; A = New Room Value (Connection)
	ld 1(ix) , a 					;; Actual Room New Value
	ld a , 2(iy)					;; A = New Room Value (Type Room)
	ld 2(ix) , a 					;; Actual Room New Value
	ld a , 3(iy)					;; A = New Room Value (Finished Room)
	ld 3(ix) , a 					;; Actual Room New Value
	call select_palette_colour
	call set_next_initial_pos
	call set_specific_setting_room
	ld a , #1
	or a 
ret
;;===============================================================================
;; FUNCTION SET_NEXT_INITIAL_POS
;;===============================================================================
set_next_initial_pos:
	ld hl , #change_room			;; HL = Change Room
	ld a , (hl)						;; A = (HL)
	cp #CONNECT_DOWN
	jr z , up_initial_pos_update
	cp #CONNECT_UP
	jr z , down_initial_pos_update
	cp #CONNECT_LEFT
	jr z , right_initial_pos_update
	ld iy , #left_initial_pos
	jr set_new_initial_pos
right_initial_pos_update:
	ld iy , #right_initial_pos
	jr set_new_initial_pos
up_initial_pos_update:
	ld iy , #up_initial_pos
	jr set_new_initial_pos
down_initial_pos_update:
	ld iy , #down_initial_pos
set_new_initial_pos:
	ld (hl) ,#0						;; Reset Flag
	ld ix , #player_position 
	ld a , 0(iy)
	ld 0(ix) , a
	ld a , 1(iy)
	ld 3(ix) , a
ret
;;===============================================================================
;; FUNCTION SELECT_PALETTE_COLOUR
;;===============================================================================
ALL_ID_ROOMS: 	.db CONNECTOR_ROOM , PUZZLE_ROOM , TEMPLE_ROOM , SURVIVE_ROOM
				.db HIDDEN_ROOM	   , STORE_ROOM  , BET_ROOM  , OBJECT_ROOM
				.db BOSSES_ROOM    , INITIAL_ROOM

ALL_PALETTES:	.dw palette_GREEN  , palette_MAUVE , palette_WHITE , palette_BLUEP
				.dw palette_BLACK  , palette_ORANGE, palette_GREEN , palette_YELLOW
				.dw palette_RED	   , palette_GREEN

select_palette_colour:
	ld hl , #ALL_ID_ROOMS
	ld iy , #ALL_PALETTES
	dec iy 
	dec iy 
	ld a , 2(ix)					;; A = Type Room
_loop_palette_colour:
	inc iy 
	inc iy 
	cp (hl)							;; COMPARE
	inc hl 							;; Increment HL Pos
	jr nz , _loop_palette_colour
	ld h , 1(iy)					;; Set First Pointer Part
	ld l , 0(iy)					;; Set Second Pointer Part
_set_palette:
	ld de , #palette_size			;; DE = Palette Size
	call cpct_setPalette_asm		;; Set Palette
ret
;;===============================================================================
;; FUNCTION RESET_GENERATED_ROOMS_ASM
;;===============================================================================
reset_generated_rooms_asm::
	ld hl , #NUMBER_OF_GENERATED_ROOMS
	ld  a , (hl)
	or a 
	ret z
	ld  b , (hl)
	ld (hl) , #0
	ld  c , #N_ROOMS_PARAMETERS
	ld a , #0
_reset_generated_rooms_loop:
	add c
	djnz _reset_generated_rooms_loop
	ld b , a
	ld hl , #generated_rooms
_reset_generated_rooms_loop_2:
	ld (hl) , #0
	inc hl
	djnz _reset_generated_rooms_loop_2
ret
;;===============================================================================
;; FUNCTION FIND_ROOM_BY_ID
;;	Input Parameters:		A = ID ROOM
;;	Output Parameters:		HL = Pointer to Room
;;===============================================================================
find_room_by_id:
	ld hl , #generated_rooms				;; Generated Room Pointer
	ld  b , #NUMBER_OF_GENERATED_ROOMS		;; Number of Generated Rooms
	ld  c , a 								;; C = A(ID)
_loop_find_by_id:
	cp (hl)									;; Compare ID 
	ret z 									;; Return IF CP == 0
	push bc 								;; Save BC
	ld  a , #N_ROOMS_PARAMETERS				;; A = N_ROOM_PARAMETERS
	call simple_loop_inc_hl					;; Simple Loop
	pop bc 									;; Recover BC
	ld a , c 								;; A = C
	djnz _loop_find_by_id
ret
;;===============================================================================
;; FUNCTION set_specific_setting_room
;;===============================================================================


ALL_ROOM_SETTINGS:	.dw	connector_room_settings , puzzle_room_settings , temple_room_settings
					.dw survive_room_settings   , hidden_room_settings , store_room_settings
					.dw bet_room_settings		, object_room_settings , bosses_room_settings
					.dw initial_room_settings

set_specific_setting_room::
	call unset_stairs_asm
	call reset_enemies_room_asm
	ld b  , #INITIAL_ROOM
	ld hl , #actual_room			;; Actual Room
	inc hl							;; Next Pointer Position(Connect Values)
	inc hl							;; Next Pointer Position(ID ROOM)
	inc hl 							;; Next Pointer Position(FINISHED ROOM)
	ld a , (hl)						;; A = FINISHED ROOM
	or a 							;; Active Flags
	ret nz							;; Return IF A != 0
	dec hl 							;; Previous Pointer Position(ID ROOM)
	ld a , (hl)						;; A = ID ROOM
	ld hl , #ALL_ID_ROOMS			;; HL = ALL ID ROOMS Pointer
	ld ix , #ALL_ROOM_SETTINGS
_loop_set_setting:
	cp (hl)							;; COMPARE
	jr z , set_function_setting
	inc ix							;; Next Pointer Position
	inc ix							;; Next Pointer Position
	inc hl							;; Next Pointer Position
	djnz _loop_set_setting
ret

set_function_setting::	
	ld e , 0(ix)		;; First Part of Function Array Pointer
	ld d , 1(ix)		;; Secong Part of Function Array Pointer
	push de 			;; PUSH DE
	ret					;; RET DE
connector_room_settings::
	call set_enemies_room_asm
ret
puzzle_room_settings::
ret
temple_room_settings::
ret
survive_room_settings::
	call set_enemies_room_asm
	call cpct_getRandom_xsp40_u8_asm	;; A = Random Number
	and #15								;; AND #7 Number of Random Objects
	add #1								;; Exclude the first three objects
	ld d , a							;; D = Random ID Object
    ld bc , #0x4828						;; Object Position
    call set_object_screen_asm			;; Set Object
ret
hidden_room_settings::
	call cpct_getRandom_xsp40_u8_asm	;; A = Random Number
	and #7								;; AND #7 Number of Random Objects
	add #3								;; Exclude the first three objects
	ld d , a							;; D = Random ID Object
    ld bc , #0x4828						;; Object Position
    call set_object_screen_asm			;; Set Object
ret
store_room_settings::
ret
bet_room_settings::
ret
object_room_settings::
	call cpct_getRandom_xsp40_u8_asm	;; A = Random Number
	and #15								;; AND #7 Number of Random Objects
	add #1								;; Exclude the first three objects
	ld d , a							;; D = Random ID Object
    ld bc , #0x4828						;; Object Position
    call set_object_screen_asm			;; Set Object
ret
bosses_room_settings::
    call set_stairs_asm
	call draw_stairs_asm
ret
initial_room_settings::
ret

