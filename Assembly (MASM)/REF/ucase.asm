dispmsg macro  msg
        lea  dx,msg
        mov ah,09h
        int 21h
endm


assume cs:code,ds:data

data segment
 msg1 db "Enter the STRING:$"
 msg2 db 10,13,"FORMATTED STRING:$"
 plist label byte
        max   db    30
        len   db    ?
        str   db    30 dup(?)
data ends


code segment
start:
        mov ax,data
        mov ds,ax

        dispmsg msg1
        mov ah,0AH
        lea dx,plist
        int 21h
           
        lea si,str
        mov cx,0
        mov cl,len
        l1:
                mov dl,[si]
                cmp dl,61H
                jb  l2
                cmp dl,7aH
                jg  l2
                xor dl,32
                mov [si],dl
                l2:
                inc si
        loop l1
        mov [si],'$'


        dispmsg msg2
        dispmsg str

        mov ah,4ch
        int 21h
code ends
end start


