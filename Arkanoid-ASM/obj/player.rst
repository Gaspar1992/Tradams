ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 ;;===============================================================================
                              3 ;; DEFINED CONSTANTS
                              4 ;;===============================================================================
                              5 
                     00FF     6 player_color 		= #0xFF ;; Colour Pattern (0xFF = 3, 3, 3, 3) ##RED##
                              7 
                              8 ;;===============================================================================
                              9 ;;      PlayerE      B1 X Position                  B2 Width
                             10 ;;                   B3 X Last Position             B4 Y Position
                             11 ;;                   B5 Height                      B6 Y Last Position
                             12 ;;                   B7 X Speed                     B8 Y Speed
                             13 ;;===============================================================================
   4512                      14 player::
   4512 28                   15 	.db 40	;; Initial X Position
   4513 0A                   16 	.db 10	;; Initial Width
   4514 28                   17 	.db 40	;; Initial Last X Position
   4515 96                   18 	.db 150	;; Initial Y Position
   4516 0A                   19 	.db 10	;; Initial Height
   4517 96                   20 	.db 150	;; Initial Last Y Position
   4518                      21 player_speed::
   4518 01                   22 	.db 1 	;; Initial Speed
                             23 
                             24 
                             25 
                             26 .globl cpct_getScreenPtr_asm
                             27 .globl cpct_drawSolidBox_asm
                             28 
                             29 .globl move_entity_asm
                             30 .globl render_box_entity_asm
                             31 ;;===============================================================================
                             32 ;; CODE SECTION
                             33 ;;===============================================================================
                             34 
                             35 .area _CODE 
                             36 
                             37 
                             38 ;;===============================================================================
                             39 ;; FUNCTION DRAW_ENTITY_ASM
                             40 ;;
                             41 ;; Input parameters :  HL => Pointer to TEntity
                             42 ;;                     BC => Pointer to Colour Pattern
                             43 ;;===============================================================================
                             44 
   4169                      45 player_draw::
   4169 21 12 45      [10]   46 	ld hl , #player				;; Player Pointer to HL
   416C 3E FF         [ 7]   47 	ld a , #player_color		;; Color Pattern to A = Colour Pattern (0xFF = 3, 3, 3, 3) 
   416E CD F2 40      [17]   48 	call render_box_entity_asm	;; Draw Player Box
   4171 C9            [10]   49 ret
                             50 ;;===============================================================================
                             51 ;; FUNCTION PLAYER_UPDATE
                             52 ;;
                             53 ;; Input parameters :  A => ACTION
                             54 ;; A = 0 => No Action  || A = 1 => Move Right || A = 2 => Move Left
                             55 ;; A = 3 => Move Down  || A = 4 => Move Up 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 ;;===============================================================================
   4172                      57 player_update::
                             58 	
   4172 B7            [ 4]   59 	or a         				;; Active Flags
   4173 C8            [11]   60 	ret z		 				;; Return IF A = 0
   4174 21 18 45      [10]   61 	ld hl , #player_speed       ;; Pointer to PlayerSpeed
   4177 FE 04         [ 7]   62 	cp #4						;; A == 4 (Move UP)
   4179 CA 92 41      [10]   63 	jp z , move_player_up     	;; Move UP
   417C FE 03         [ 7]   64 	cp #3						;; A == 3 (Move Down)
   417E CA 9A 41      [10]   65 	jp z , move_player_down   	;; Move Down
   4181 FE 02         [ 7]   66 	cp #2						;; A == 2 (Move Left)
   4183 CA 9F 41      [10]   67 	jp z , move_player_left   	;; Move Left
   4186 FE 01         [ 7]   68 	cp #1						;; A == 1 (Move Right)
   4188 CA A7 41      [10]   69 	jp z , move_player_right  	;; Move Right
   418B                      70 move_player:
   418B 21 12 45      [10]   71 	ld hl , #player				;; HL = Pointer to Player Entity
   418E CD C0 40      [17]   72 	call move_entity_asm		;; Move Entity
   4191 C9            [10]   73 ret
                             74 
   4192                      75 move_player_up:
   4192 7E            [ 7]   76 	ld a  , (hl)
   4193 ED 44         [ 8]   77 	neg
   4195 4F            [ 4]   78 	ld c , a 		;; C = Player Speed Y(HL)
   4196 06 00         [ 7]   79 	ld b , #0		;; B = PLayer Speed X(HL)
   4198 18 F1         [12]   80 	jr move_player	;; Move Player
   419A                      81 move_player_down:
   419A 4E            [ 7]   82 	ld c , (hl)		;; C = Player Speed Y(HL)
   419B 06 00         [ 7]   83 	ld b , #0		;; B = PLayer Speed X(HL)
   419D 18 EC         [12]   84 	jr move_player	;; Move Player
                             85 
   419F                      86 move_player_left:
   419F 7E            [ 7]   87 	ld a  , (hl)
   41A0 ED 44         [ 8]   88 	neg
   41A2 47            [ 4]   89 	ld b , a 		;; B = PLayer Speed Y(HL)
   41A3 0E 00         [ 7]   90 	ld c , #0		;; C = Player Speed X(HL)
   41A5 18 E4         [12]   91 	jr move_player	;; Move Player
                             92 
   41A7                      93 move_player_right:
   41A7 46            [ 7]   94 	ld b , (hl)		;; B = PLayer Speed Y(HL)
   41A8 0E 00         [ 7]   95 	ld c , #0		;; C = Player Speed X(HL)
   41AA 18 DF         [12]   96 	jr move_player  ;; Move Player
                             97 
                             98 ;;===============================================================================
                             99 ;; FUNCTION MOVE_ENTITY_ASM
                            100 ;;
                            101 ;; Input parameters :  HL => Pointer to TEntity
                            102 ;;                      B => X Movement
                            103 ;;                      C => Y Movement
                            104 ;;===============================================================================
                            105 
