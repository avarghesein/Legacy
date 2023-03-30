
public readnumber,dispnumber

data segment public
        tmp db 50 dup(?)
data ends


funcode segment  common
s:
        readnumber proc far
                push ax
                push bx
                push cx
                push dx
                mov [si],0
                mov cx,0
                mov bx,00000h
                mov ah,01h
                int 21h
                cmp al,'-'
                jne positive
                mov cx,1
                mov bx,0ffffh
                jmp outer
                positive:
                cmp al,'+'
                je outer
                mov ah,0
                sub al,30h
                mov [si],ax
                outer:
                call far ptr readword
                mov ax,[si]
                xor ax,bx
                add ax,cx
                mov [si],ax
                pop dx
                pop cx
                pop bx
                pop ax
                ret
        readnumber endp        



        dispnumber proc far
                push ax
                push bx
                push cx
                push dx
                mov  ax,[si]
                and ah,128
                cmp ah,0
                je unsigned
                mov ah,02h
                mov dl,'-'
                int 21h
                mov ax,[si]
                xor ax,0ffffh
                add ax,1
                mov [si],ax
                unsigned:
                call far ptr displayword
                pop dx
                pop cx
                pop bx
                pop ax
                ret
        dispnumber endp


        readword proc far
                push ax
                push bx
                push cx
                push dx

                mov cx,10
                read:
                        mov ah,01h
                        int 21h
                        cmp al,'0'
                        jb endread
                        cmp al,'9'
                        ja endread
                        sub al,30h
                        mov bh,0
                        mov bl,al
                        mov ax,[si]
                        mul cx
                        add ax,bx
                        mov [si],ax
                        jmp read
                endread:
                pop dx
                pop cx
                pop bx
                pop ax
                ret
        readword endp

        displayword proc far
                push ax
                push bx
                push cx
                push dx
                push di

                lea di,tmp
                mov ax,[si]
                mov bx,10
                mov cx,0

                findremainder:
                    mov dx,0
                    div bx
                    add dl,30h
                    mov [di],dl
                    inc di
                    inc cx
                    cmp ax,0
                    ja findremainder
               
                dec di
                print:
                    mov ah,02h
                    mov dl,[di]
                    int 21h
                    dec di
                    loop print

                pop di
                pop dx
                pop cx
                pop bx
                pop ax
                ret
        displayword endp

funcode ends
end s
