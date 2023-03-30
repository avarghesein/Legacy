;**********************************************
;
; KEYPRESS.ASM
; Our First Interactive Program
;
; Compile with:
;
;      TASM KEYPRESS.ASM
;      TLINK /t KEYPRESS.OBJ
;
; +gthorne'97
;
;**********************************************

.model small
.code
.386

org     100h

start:  jmp     MAIN_PROGRAM

;----------------------
; Your Data Here
;----------------------

CopyMsg     db      'Copyright (c)1997 By Me!',0Dh,0Ah,'$'

PressEnter  db      0Dh,0Ah,'$'

;----------------------

MAIN_PROGRAM:

;---------------
; Your Code Here
;---------------

; DISPLAY OUR COPYRIGHT MESSAGE

            mov dx, offset CopyMsg      ; tell DOS where string is
            mov ah, 09h                 ; DOS command 9 = print string
            int 21h                     ; tell DOS to issue command

            ; Press ENTER for the heck of it

            mov dx, offset PressEnter   ; tell DOS where string is
            mov ah, 09h                 ; DOS command 9 = print string
            int 21h                     ; tell DOS to issue command

START_OF_ENDLESS_LOOP:

      ; GET A KEY FROM THE USER INTO AL (DOES NOT ECHO)

      mov     ah,8                ; DOS function 08h, get a key from user
      int     21h                 ; tell DOS to do the command

      mov      bl, al		; store key for later in BL register
			; so we don't lose it because AL
			; gets clobbered when a CMP is issued

      cmp       bl, 'Y'		; see if user pressed a 'Y'
      je           GO_ON_WITH_PROGRAM

      cmp       bl, 'N'		; see if user pressed a 'N'
      je           GO_ON_WITH_PROGRAM

      cmp       bl, 'y'		; see if user pressed a 'y'
      je           GO_ON_WITH_PROGRAM

      cmp       bl, 'n'		; see if user pressed a 'n'
      je           GO_ON_WITH_PROGRAM

      ; WE GO BEEP IF ANY OTHER KEY WAS PRESSED

       mov      dl, 07h           ; copy the BEEP code into DL
       mov     ah,6               ; DOS function 06h, print a character
       int     21h                ; tell DOS to do the command (make a BEEP)

       JMP START_OF_ENDLESS_LOOP

GO_ON_WITH_PROGRAM:

      ; ECHO (SHOW) WHAT KEY THE USER PRESSED

       mov      dl, bl            ; copy the user keypress from BL into DL
       mov     ah,6               ; DOS function 06h, print a character
       int     21h                ; tell DOS to do the command

      ;---------------

      mov al, bl                   ; put keypress into AL to be the exit code
				   ; from this program

      mov ah,4ch                   ; quit to DOS
      int 21h

      end     start


