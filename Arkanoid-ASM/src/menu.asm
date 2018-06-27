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

border_colour  = #0x1410  ;; 0x10 (Border ID), 0x14 (Colour to set: Black).
number_actions = #4		  ;; Number of Used Keys

key_A = #0x2008
key_D = #0x2007
key_W = #0x0807
key_S = #0x1007

string_1: .asciz "Welcome to Arkanoid in ASM!"
string_2: .asciz "Menu de Prueba"
string_3: .asciz "Opcion 1"
string_4: .asciz "Opcion 2"
string_5: .asciz "Salir"
;;===============================================================================
;; DEFINED KEYS
;;===============================================================================




;;===============================================================================
;; CODE SECTION
;;===============================================================================

.area _CODE 