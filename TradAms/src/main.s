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

border_colour  	= #0x1410  	  ;; 0x10 (Border ID), 0x14 (Colour to set: Black).
palette_size 	= #4		  ;; Number of Colors


;;===============================================================================
;; CODE SECTION
;;===============================================================================

.area _CODE 

.globl cpct_disableFirmware_asm
.globl cpct_setPalette_asm
.globl cpct_setPALColour_asm
.globl cpct_setVideoMode_asm

.globl main_game_bucle

.globl palette_GREEN

initialize:
	call cpct_disableFirmware_asm	;; Disable Firmware
	ld c , #1						;; C = 1 (VIDEO MODE)
	call cpct_setVideoMode_asm		;; Set Video Mode
	ld hl , #palette_GREEN			;; HL = Palette Pointer
	ld de , #palette_size			;; DE = Palette Size
	call cpct_setPalette_asm		;; Set Palette
	ld hl , #border_colour			;; HL = Border Color
	call cpct_setPALColour_asm		;; Set Border Color
ret

_main::
	call initialize
	call main_game_bucle	
ret
