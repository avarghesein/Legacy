 .model small
            .code
            .386

            org     100h

start: 

           .data

            CopyMsg     db      'Copyright (c)1997 By Me!',0Dh,0Ah,'$'

           

          .code

           

            mov dx, offset CopyMsg      ; tell DOS where string is
            mov ah, 09h                 ; DOS command 9 = print string
            int 21h                     ; tell DOS to issue command

            

            mov al, 0h             ; return code (0 = no error)



            mov ah,4ch           ; quit to DOS
            int 21h

            end     start


