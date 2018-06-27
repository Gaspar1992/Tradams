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
   44CF 57 65 6C 63 6F 6D    32 string_1: .asciz "Welcome to Arkanoid in ASM!"
        65 20 74 6F 20 41
        72 6B 61 6E 6F 69
        64 20 69 6E 20 41
        53 4D 21 00
   44EB 4D 65 6E 75 20 64    33 string_2: .asciz "Menu de Prueba"
        65 20 50 72 75 65
        62 61 00
   44FA 4F 70 63 69 6F 6E    34 string_3: .asciz "Opcion 1"
        20 31 00
   4503 4F 70 63 69 6F 6E    35 string_4: .asciz "Opcion 2"
        20 32 00
   450C 53 61 6C 69 72 00    36 string_5: .asciz "Salir"
                             37 ;;===============================================================================
                             38 ;; DEFINED KEYS
                             39 ;;===============================================================================
                             40 
                             41 
                             42 
                             43 
                             44 ;;===============================================================================
                             45 ;; CODE SECTION
                             46 ;;===============================================================================
                             47 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             48 .area _CODE 
