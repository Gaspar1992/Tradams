ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of ################ 
                              3 ;;  Copyright (C) 2017 
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 .area _DATA
                             20 ;;===============================================================================
                             21 ;; DEFINED CONSTANTS
                             22 ;;===============================================================================
                             23 
                     1410    24 border_colour  = #0x1410  ;; 0x10 (Border ID), 0x14 (Colour to set: Black).
                     0004    25 number_actions = #4		  ;; Number of Used Keys
                             26 
                     2008    27 key_A = #0x2008
                     2007    28 key_D = #0x2007
                     0807    29 key_W = #0x0807
                     1007    30 key_S = #0x1007
                             31 
   449A 57 65 6C 63 6F 6D    32 string_1: .asciz "Welcome to Arkanoid in ASM!"
        65 20 74 6F 20 41
        72 6B 61 6E 6F 69
        64 20 69 6E 20 41
        53 4D 21 00
   44B6 4D 65 6E 75 20 64    33 string_2: .asciz "Menu de Prueba"
        65 20 50 72 75 65
        62 61 00
                             34 
                             35 ;;===============================================================================
                             36 ;; DEFINED KEYS
                             37 ;;===============================================================================
                             38 
   44C5                      39 keys: 
   44C5 07 08                40 	.dw #0x0807 ;; KEY_W
   44C7 07 10                41 	.dw #0x1007 ;; KEY_S
   44C9 08 20                42 	.dw #0x2008 ;; KEY_A
   44CB 07 20                43 	.dw #0x2007 ;; KEY_D
                             44     
                             45     
                             46 	
   44CD                      47 actual_action:
   44CD 00                   48 	.db #0
   44CE                      49 interruption:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   44CE 06                   50 	.db #6
                             51 
                             52 
                             53 ;;===============================================================================
                             54 ;; CODE SECTION
                             55 ;;===============================================================================
                             56 
                             57 .area _CODE 
                             58 
                             59 ;; Symbols with the names of the CPCtelera functions we want to use
                             60 ;; must be declared globl to be recognized by the compiler. Later on,
                             61 ;; linker will do its job and make the calls go to function code.
                             62 .globl cpct_isKeyPressed_asm  
                             63 .globl cpct_scanKeyboard_asm
                             64 .globl cpct_setInterruptHandler_asm
                             65 .globl cpct_disableFirmware_asm
                             66 .globl cpct_setVideoMode_asm
                             67 .globl cpct_setPALColour_asm
                             68 .globl cpct_waitVSYNC_asm
                             69 .globl cpct_drawStringM1_f_asm
                             70 
                             71 .globl player_draw
                             72 .globl player_update
                             73 .globl player
                             74 
                             75 .globl collision_entities_asm
                             76 .globl render_box_entity_asm
                             77 
                             78 .globl ball
                             79 .globl ball_draw_asm
                             80 .globl ball_update_asm
                             81 .globl change_speed_y
                             82 ;;-----------------------------------------------
                             83 ;; MAIN function. This is the entry point of the application.
                             84 ;;    _main:: global symbol is required for correctly compiling and linking
                             85 ;;-----------------------------------------------
                             86 
                             87 
                             88 
                             89 
   404E                      90 _main::
   404E CD 7D 40      [17]   91 	call init
   4051 CD 55 40      [17]   92    	call loop
   4054 C9            [10]   93 ret
                             94 
                             95 
   4055                      96 loop::
                             97 
                             98 	
   4055 21 CD 44      [10]   99 	ld hl , #actual_action	;; Actual_action = KeyBoard Value
   4058 7E            [ 7]  100 	ld a , (hl)				;; Prepare PLAYER_UPDATE FUNCTION
   4059 CD 72 41      [17]  101 	call player_update		;; Update Player Action
   405C CD 09 40      [17]  102 	call ball_update_asm
   405F CD 6D 40      [17]  103 	call collisions
   4062 CD 80 43      [17]  104 	call cpct_waitVSYNC_asm ;; VSYNC  UPDATE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                            105 	;; TRAS EL VSYNC SE DIBUJA TODO
   4065 CD 00 40      [17]  106 	call ball_draw_asm  ;; BALL DRAW
   4068 CD 69 41      [17]  107 	call player_draw    ;; PLAYER DRAW
                            108 
                            109 	
   406B 18 E8         [12]  110 	jr loop
                            111 
                            112 
                            113 
                            114 
   406D                     115 collisions:
   406D DD 21 12 45   [14]  116 	ld ix , #player
   4071 FD 21 92 44   [14]  117 	ld iy , #ball
   4075 CD 36 41      [17]  118 	call collision_entities_asm
   4078 B7            [ 4]  119 	or a
   4079 C4 41 40      [17]  120 	call nz , change_speed_y
                            121 	
   407C C9            [10]  122 ret
                            123 
   407D                     124 init:
                            125 	;; Initialize CPC
   407D CD 88 43      [17]  126    	call cpct_disableFirmware_asm ;; Disable Firmware
   4080 0E 01         [ 7]  127    	ld  c, #1                     ;; C = 1 (Mode 1)
   4082 CD 73 43      [17]  128    	call cpct_setVideoMode_asm    ;; Set Mode 1
                            129 
                            130    	;; Change border colour
   4085 21 10 14      [10]  131    	ld    hl, #border_colour         ;; L=Border colour value, H=Palette Colour to be set (Border=16)
   4088 CD E0 41      [17]  132    	call  cpct_setPALColour_asm      ;; Set the border (colour 16)
   408B 21 92 40      [10]  133 	ld hl , #interruption_function	 ;; Set Interruption Function
   408E CD AC 41      [17]  134 	call cpct_setInterruptHandler_asm;; |
                            135 
   4091 C9            [10]  136 ret
                            137 
   4092                     138 interruption_function::
   4092 21 CE 44      [10]  139 	ld hl , #interruption 		;; Asign Interruption Value
   4095 35            [11]  140 	dec (hl)					;; Decement (HL)
   4096 7E            [ 7]  141 	ld a , (hl)					;; A = Updated Interruption Value
   4097 B7            [ 4]  142 	or a						;; Active Flags
   4098 C0            [11]  143 	ret nz						;; RETURN IF A != 0 
   4099 36 06         [10]  144 	ld (hl) , #6				;; UPDATE interruption value
   409B CD 9F 40      [17]  145 	call keyboard_function		;; KEYBOARD UPDATE
   409E C9            [10]  146 ret
                            147 
                            148 ;;===============================================================================
                            149 ;; FUNCTION KEYBOARD_FUNCTION
                            150 ;;
                            151 ;; Input parameters :   B => Iterator
                            152 ;;                     HL => Pointer to Keys
                            153 ;;===============================================================================
   409F                     154 keyboard_function::
   409F CD 61 44      [17]  155 	call cpct_scanKeyboard_asm  ;; Read KeyBoard
                            156 	
   40A2 21 C5 44      [10]  157 	ld hl , #keys			    ;; Keys
   40A5 06 04         [ 7]  158 	ld b , #number_actions		;; Prepare to KeyBoard Function
   40A7 CD AF 40      [17]  159 	call key_check				;; Check Keys
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



   40AA 21 CD 44      [10]  160 	ld hl , #actual_action		;; Actual_ACtion
   40AD 70            [ 7]  161 	ld (hl) , b					;; Give value
   40AE C9            [10]  162 ret
                            163 
   40AF                     164 key_check:
   40AF 5E            [ 7]  165 	ld e , (hl)					;; First Part of Key (16 bit)
   40B0 23            [ 6]  166 	inc hl						;; Increment to Next Part of Key
   40B1 56            [ 7]  167 	ld d , (hl)					;; Second Part of key 
   40B2 23            [ 6]  168 	inc hl 						;; Increment to Next Key
   40B3 EB            [ 4]  169 	ex de , hl					;; ExChange DE <=> HL
   40B4 D5            [11]  170 	push de						;; Save DE (KEY VALUES)
   40B5 C5            [11]  171 	push bc						;; Save BC (B = Action)
   40B6 CD D4 41      [17]  172 	call cpct_isKeyPressed_asm	;; Check Key hl
   40B9 C1            [10]  173 	pop bc						;; Recover (B = Action)
   40BA E1            [10]  174 	pop hl						;; Recover (KEY VALUES)
   40BB B7            [ 4]  175 	or a						;; Active Flags
   40BC C0            [11]  176 	ret nz						;; IF A != 0 KEY ACTIVE
   40BD 10 F0         [13]  177 	djnz key_check
   40BF C9            [10]  178 	ret
                            179 
