

stack1 segment
    dw 50 dup(0)
    stacktop label word
stack1 ends


data segment
        msg db 13,"$"
        x   db 10 dup(?)
        y   db 20 dup(?)
        n1  db ?
        n2  db ?
        n3  db ?
data ends
        

assume cs:code,ds:data,ss:stack1
code segment
start:

    mov ax,data
    mov ds,ax
    mov ax,stack1
    mov ss,ax
    lea sp,stacktop

    mov cx,6000
    lll:
    push cx

    mov ah,2cH
    int 21h

    mov [x],ch
    mov [x+1],cl
    mov [x+2],dh
    mov [x+3],dl

    lea si,x
    lea di,y
    mov cx,4
    l1:
        push cx
    
        mov bl,[si]
        call extract

        call  cnvrttobcd

        mov bl,n3
        call extract

        mov ah,n1
        mov al,n2
        mov [di],ah
        mov [di+1],al
        add di,2
        inc si
        pop cx

     loop l1


     mov ah,09h
     lea dx,msg
     int 21h



     mov bx,0
     lea si,y
     mov cx,8
     l2:
        mov dl,[si]
        add dl,30h
        mov ah,02h
        int 21h
        inc si

        cmp bx,1
        jne  l3
        cmp cx,1
        je l5
        mov dl,':'
        mov ah,02h
        int 21h
        mov bx,0
        jmp l5
        l3:
        inc bx
        l5:
     loop l2


     pop cx
     loop lll

     mov ah,4ch
     int 21h

                cnvrttobcd proc near
                        mov ax,0
                        mov cx,16
                        l4:
                                add al,n1
                                daa
                        loop l4
                        add al,n2
                        daa
                        mov n3,al
                        ret
                cnvrttobcd endp


                extract proc near
                        mov dl,bl
                        and dl,0f0H
                        mov cl,04H
                        ror dl,cl
                        mov n1,dl
                        mov dl,bl
                        and dl,0fH
                        mov n2,dl
                        ret
                extract endp

code ends
end start


