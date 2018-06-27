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
                             20 
                             21 ;;===============================================================================
                             22 ;; DEFINED CONSTANTS
                             23 ;;===============================================================================
                             24 
                     0000    25 Min_screen_W       = #0       ;; Min Width of the screen (bytes)
                     0050    26 Max_screen_W       = #80      ;; Max Width of the screen (bytes)
                     0000    27 Min_screen_H       = #0       ;; Min Height of the screen (pixels)
                     00C8    28 Max_screen_H       = #200     ;; Max Height of the screen (pixels)
                             29 
                     C000    30 pvideomem          = #0xC000  ;; First byte of video memory
                     0000    31 background_color   = #0x00    ;; BackGround Colour Pattern (0x00 = 0, 0, 0, 0) BLUE
                             32 
                             33 .globl cpct_getScreenPtr_asm
                             34 .globl cpct_drawSolidBox_asm
                             35 
                             36 .area _CODE 
                             37 
                             38 ;;===============================================================================
                             39 ;;      TEntity      B1 X Position                  B2 Width
                             40 ;;                   B3 X Last Position             
                             41 ;;                   B4 Y Position                  B5 Height
                             42 ;;                   B6 Y Last Position
                             43 ;;===============================================================================
                             44 ;;===============================================================================
                             45 ;; FUNCTION MOVE_ENTITY_ASM
                             46 ;;
                             47 ;; Input parameters :  HL => Pointer to TEntity
                             48 ;;                      B => X Movement
                             49 ;;                      C => Y Movement
                             50 ;;===============================================================================
   40C0                      51 move_entity_asm::
   40C0 16 50         [ 7]   52     ld d , #Max_screen_W    ;; D = MAX Screen Width
   40C2 1E 00         [ 7]   53     ld e , #Min_screen_W    ;; E = MIN Screen Width
   40C4 CD D3 40      [17]   54     call _Movement_ASM      ;; Calculate X Movement
   40C7 23            [ 6]   55     inc hl                  ;; Next Position HL (Width)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   40C8 23            [ 6]   56     inc hl                  ;; Next Position HL (X Last Position)
   40C9 23            [ 6]   57     inc hl                  ;; Next Position HL (Y Position)
   40CA 16 C8         [ 7]   58     ld d , #Max_screen_H    ;; D = MAX Screen Height
   40CC 1E 00         [ 7]   59     ld e , #Min_screen_H    ;; E = MIN Screen Height
   40CE 41            [ 4]   60     ld b , c                ;; B = C | TO PREPARE _Movement_ASM
   40CF CD D3 40      [17]   61     call _Movement_ASM      ;; Calculate X Movement
   40D2 C9            [10]   62 ret
                             63 ;;===============================================================================
                             64 ;; FUNCTION MOVE_ENTITY_ASM
                             65 ;;
                             66 ;; Input parameters :  HL => Pointer to TEntity
                             67 ;;                      B => Force Movement
                             68 ;;                      D => Max Limit
                             69 ;;                      E => Min Limit
                             70 ;;===============================================================================
   40D3                      71 _Movement_ASM:
   40D3 78            [ 4]   72     ld a , b                ;; A = Mov(B)
   40D4 B7            [ 4]   73     or a                    ;; Active de Flags
   40D5 C8            [11]   74     ret z                   ;; IF A = 0
   40D6 F2 E7 40      [10]   75     jp p , limit_max        ;; IF A < 0
   40D9 ED 44         [ 8]   76     neg                     ;; Negate A
   40DB 47            [ 4]   77     ld b , a                ;; B = -A
   40DC 18 01         [12]   78     jr limit_min            ;; IF A > 0
   40DE C9            [10]   79 ret
                             80 
   40DF                      81 limit_min:
   40DF 7E            [ 7]   82     ld a , (hl)             ;; A = Pos(HL)
   40E0 93            [ 4]   83     sub e                   ;; A = Pos(HL) - Min_Limit(E)
   40E1                      84 limit_min_bucle:
   40E1 C8            [11]   85     ret z                   ;; IF A = 0
   40E2 35            [11]   86     dec (hl)                ;; (HL)Pos = (HL)Pos--
   40E3 3D            [ 4]   87     dec a                   ;; A = A--
   40E4 10 FB         [13]   88     djnz limit_min_bucle    ;; IF B !=0
   40E6 C9            [10]   89 ret
                             90 
   40E7                      91 limit_max:
   40E7 7E            [ 7]   92     ld a , (hl)             ;; A = Pos(HL)
   40E8 23            [ 6]   93     inc hl                  ;; Next Position HL (Width | Height)
   40E9 86            [ 7]   94     add (hl)                ;; A = Pos(A) + (Width | Height)(HL)
   40EA 2B            [ 6]   95     dec hl                  ;; Previous Position HL (Pos X | Pos Y)
   40EB 92            [ 4]   96     sub d                   ;; A = Pos(A) + (Width | Height)(HL) - Limit Max(D)
   40EC                      97 limit_max_bucle:
   40EC C8            [11]   98     ret z                   ;; IF A = 0
   40ED 34            [11]   99     inc (hl)                ;; (HL)Pos = (HL)Pos++
   40EE 3D            [ 4]  100     dec a                   ;; A = A--
   40EF 10 FB         [13]  101     djnz limit_max_bucle    ;; IF B !=0
   40F1 C9            [10]  102 ret
                            103 
                            104 ;;===============================================================================
                            105 ;;      TEntity      B1 X Position                  B2 Width
                            106 ;;                   B3 X Last Position             
                            107 ;;                   B4 Y Position                  B5 Height
                            108 ;;                   B6 Y Last Position
                            109 ;;===============================================================================
                            110 ;;===============================================================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                            111 ;; FUNCTION RENDER_BOX_ENTITY_ASM
                            112 ;;
                            113 ;; Input parameters :  HL => Pointer to TEntity
                            114 ;;                      A => Colour Pattern
                            115 ;;===============================================================================
   40F2                     116 render_box_entity_asm::
   40F2 F5            [11]  117     push af                     ;; Save Colour Pattern
                            118     
   40F3 CD 1B 41      [17]  119     call clean_box_entity       ;; Clean Last Box Position
   40F6 CD 0C 41      [17]  120     call position_entity        ;; Position Entity
   40F9 C1            [10]  121     pop bc                      ;; Recover Colour Pattern
   40FA 78            [ 4]  122     ld   a , b                  ;; A = Color Pattern
   40FB 23            [ 6]  123     inc hl                      ;; Previous Position HL (Width)  
   40FC CD 00 41      [17]  124    	call draw_box_entity        ;; Draw Box Entity
                            125 
   40FF C9            [10]  126 ret
                            127 ;;===============================================================================
                            128 ;; FUNCTION DRAW_BOX_ASM
                            129 ;;
                            130 ;; Input parameters :  HL => Pointer to TEntity (First Position = Width)
                            131 ;;                     DE => Position Value (X , Y)
                            132 ;;                      A => Color Pattern 
                            133 ;;===============================================================================
   4100                     134 draw_box_entity:
   4100 E5            [11]  135     push hl                         ;; Save Entity Pointer
   4101 4E            [ 7]  136     ld   c , (hl)                   ;; C = Entity Width (bytes)
                            137 
   4102 23            [ 6]  138     inc hl                          ;; Next Position HL (X LPos)
   4103 23            [ 6]  139     inc hl                          ;; Next Position HL (Y Pos)
   4104 23            [ 6]  140     inc hl                          ;; Next Position HL (Height)
   4105 46            [ 7]  141    	ld   b , (hl)                   ;; B = Entity Height (pixels)
                            142        
   4106 CD 98 43      [17]  143    	call cpct_drawSolidBox_asm      ;; Draw Solid Box 
   4109 E1            [10]  144     pop  hl
   410A 2B            [ 6]  145     dec hl                          ;; Previous Position HL (X Pos)  
   410B C9            [10]  146 ret
                            147 ;;===============================================================================
                            148 ;; FUNCTION POSITION_ENTITY
                            149 ;;
                            150 ;; Input parameters :  HL => Pointer to TEntity (Positions => X Pos OR X LPos)
                            151 ;; Return Values: DE => Position Value (X , Y)   
                            152 ;;===============================================================================
   410C                     153 position_entity:
   410C E5            [11]  154     push hl                         ;; Save Entity Pointer
   410D 4E            [ 7]  155     ld c , (hl)                     ;; C  = X Pos || X LPos
                            156 
   410E 23            [ 6]  157     inc hl                          ;; Next Position HL (Width || Y Pos)
   410F 23            [ 6]  158     inc hl                          ;; Next Position HL (X LPos || Height)
   4110 23            [ 6]  159     inc hl                          ;; Next Position HL (Y Pos || Y LPos)
                            160 
   4111 46            [ 7]  161     ld b , (hl)                     ;; B  = Y Pos || Y LPos
   4112 11 00 C0      [10]  162     ld  de , #pvideomem             ;; Video Memory Position
   4115 CD 45 44      [17]  163     call cpct_getScreenPtr_asm      ;; Get Screen Pointer
                            164     ;; Return value: HL = Screen Pointer to (X, Y) byte
                            165 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



   4118 EB            [ 4]  166     ex  de , hl                     ;; Exchange Values DE <-> HL
   4119 E1            [10]  167     pop hl                          ;; Recover Entity Pointer
                            168 
   411A C9            [10]  169 ret
                            170 ;;===============================================================================
                            171 ;; FUNCTION CLEAN_ENTITY
                            172 ;;
                            173 ;; Input parameters :  HL => Pointer to TEntity            
                            174 ;;===============================================================================
   411B                     175 clean_box_entity:
                            176 
                            177     ;; Calculate Box Last Position
   411B 23            [ 6]  178     inc hl                      ;; Next Position HL (Width)
   411C 23            [ 6]  179     inc hl                      ;; Next Position HL (X LPos)
   411D CD 0C 41      [17]  180    	call position_entity        ;; Calculate Position of Entity
                            181     ;; HL => Same Position than before the function
                            182 
                            183 
                            184     ;; Draw Clean Box
   4120 3E 00         [ 7]  185     ld   a , #background_color  ;; A = Color Pattern
                            186 
   4122 2B            [ 6]  187     dec hl                      ;; Previous Position HL (Width)   
   4123 CD 00 41      [17]  188    	call draw_box_entity        ;; Draw Box Entity
                            189     
                            190     ;; Update Last Position to Actual Position
   4126 CD 2A 41      [17]  191     call update_entity_position
   4129 C9            [10]  192 ret
                            193 ;;===============================================================================
                            194 ;; FUNCTION UPDATE_ENTITY_POSITION
                            195 ;;
                            196 ;; Input parameters :  HL => Pointer to TEntity            
                            197 ;;===============================================================================
   412A                     198 update_entity_position:
   412A E5            [11]  199     push hl                     ;; Save Entity Pointer
   412B 7E            [ 7]  200     ld a , (hl)                 ;; A = X Pos
   412C 23            [ 6]  201     inc hl                      ;; Next Position HL (Width)
   412D 23            [ 6]  202     inc hl                      ;; Next Position HL (X LPos)
   412E 77            [ 7]  203     ld (hl) , a                 ;; HL(X LPos) = X Pos
   412F 23            [ 6]  204     inc hl                      ;; Next Position HL (Y Pos)
   4130 7E            [ 7]  205     ld a , (hl)                 ;; A = Y Pos
   4131 23            [ 6]  206     inc hl                      ;; Next Position HL (Height)
   4132 23            [ 6]  207     inc hl                      ;; Next Position HL (Y LPos)
   4133 77            [ 7]  208     ld (hl) , a                 ;; HL(Y LPos) = Y Pos
   4134 E1            [10]  209     pop hl                      ;; Recover Entity Pointer
                            210     
   4135 C9            [10]  211 ret
                            212 ;;===============================================================================
                            213 ;;      TEntity      B1 X Position                  B2 Width
                            214 ;;                   B3 X Last Position             
                            215 ;;                   B4 Y Position                  B5 Height
                            216 ;;                   B6 Y Last Position
                            217 ;;===============================================================================
                            218 ;;===============================================================================
                            219 ;; FUNCTION COLLISION_ENTITIES_ASM
                            220 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                            221 ;; Input parameters :  IX => Pointer to First TEntity
                            222 ;;                     IY => Pointer to Second TEntity
                            223 ;; Return parameters:   A => A = 0 (No Colision) || A != 0 (Colision)            
                            224 ;;===============================================================================
   4136                     225 collision_entities_asm::
   4136 CD 49 41      [17]  226     call axis_collision
   4139 DD 23         [10]  227     inc ix  ;; Next Position IX (Width)
   413B FD 23         [10]  228     inc iy  ;; Next Position IY (Width)
   413D DD 23         [10]  229     inc ix  ;; Next Position IX (X LPos)
   413F FD 23         [10]  230     inc iy  ;; Next Position IY (X LPos)
   4141 DD 23         [10]  231     inc ix  ;; Next Position IX (Y Pos)
   4143 FD 23         [10]  232     inc iy  ;; Next Position IY (Y Pos)
   4145 B7            [ 4]  233     or a    ;; Active Flags
   4146 20 01         [12]  234     jr nz , axis_collision      ;; IF A != 0 CHECK COLLISION
   4148 C9            [10]  235 ret
                            236 
   4149                     237 axis_collision:
   4149 DD 7E 00      [19]  238     ld a , (ix)         ;; First Entity X/Y Pos
   414C DD 86 01      [19]  239     add 1(ix)           ;; A = X/Y Pos(A) + Width/Height(IX) 
   414F FD 96 00      [19]  240     sub (iy)            ;; A = [X/Y Pos(A) + Width/Height(A)] - Second Entity X/Y Pos(IY)
   4152 28 12         [12]  241     jr z , no_collision ;; No collision
   4154 FA 66 41      [10]  242     jp m , no_collision ;; No collision
                            243 
                            244     ;; Second Check
                            245 
   4157 FD 7E 00      [19]  246     ld a , (iy)         ;; Second Entity X/Y Pos 
   415A FD 86 01      [19]  247     add 1(iy)           ;; A = X/Y Pos(A) + Width/Height(IY)
   415D DD 96 00      [19]  248     sub (ix)            ;; A = [X/Y Pos(A) + Width/Height(A)] - Second Entity X/Y Pos(IX)
   4160 28 04         [12]  249     jr z , no_collision ;; No collision
   4162 FA 66 41      [10]  250     jp m , no_collision ;; No collision
   4165 C9            [10]  251 ret
                            252 
   4166                     253 no_collision:
   4166 3E 00         [ 7]  254     ld a , #0
   4168 C9            [10]  255 ret
