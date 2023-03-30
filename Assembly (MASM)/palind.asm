

provideline macro
        mov ah,02h
        mov dl,10
        int 21h
        mov  ah,02h
        mov dl,13
        int 21h
endm

dispmsg macro  msg
        lea  dx,msg
        mov ah,09h
        int 21h
endm



data segment
        msg0 db "Enter string:$"
        plist label byte
                max db 30
                len db ?
                str db 30 dup(?)
        rev  db 30 dup(?)
        msg1 db "String is PALINDROME$"
        msg2 db "String is NOT PALINDROME$"
data ends
assume cs:code,ds:data
code segment
start:
        mov ax,data
        mov ds,ax

        dispmsg msg0
        mov ah,0aH
        lea dx,plist
        int 21h


        lea di,rev
        lea si,str
        mov cx,0
        mov cl,len
        add si,cx
        dec si
        std
        l1:
                lodsb
                mov [di],al
                inc di
        loop l1

        mov [di],'$'
        lea si,str
        mov cx,0
        mov cl,len
        add si,cx
        mov [si],'$'
        provideline
        lea si,str
        lea di,rev
        l2:
                mov al,[si]
                cmp al,[di]
                jne l3
                inc si
                inc di
        loop l2
        lea dx,msg1
        jmp l4
        l3:
        lea dx,msg2
        l4:
        mov ah,09h
        int 21h

        mov ah,4ch
        int 21h
code ends
end start

