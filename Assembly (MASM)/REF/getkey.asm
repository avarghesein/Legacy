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

; GET A KEY FROM THE USER (DOES NOT ECHO)
; RESULT IS LEFT IN AL REGISTER

mov     ah,08h       ; DOS function 08h, get a key from user
int     21h          ; tell DOS to do the command

; ECHO (SHOW) WHAT KEY THE USER PRESSED

mov      dl, al    ; copy the user keypress from AL into DL
mov     ah,06h      ; DOS function 06h, print character in DL to screen
int     21h         ; tell DOS to do the command

; JUST FOR FUN WE GO BEEP

mov      dl, 07h     ; copy the BEEP code into DL
mov     ah,06h    ; DOS function 06h, print one character to the screen
int     21h        ; tell DOS to do the command (which will make a BEEP)

;---------------

mov al, 0h                  ; return code (0 = no error)
mov ah,4ch                  ; quit to DOS
int 21h

end     start
