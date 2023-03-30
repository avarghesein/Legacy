

provideline macro
        mov ah,02h
        mov dl,13
        int 21h
        mov  ah,02h
        mov dl,10
        int 21h
endm


dispmsg macro  msg
        lea  dx,msg
        mov ah,09h
        int 21h
endm


data segment
 n   db   0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
 m   db 0h,1h,2h,3h,4h,5h,6h,7h,8h,9h,10h,11h,12h,13h,14h,15h,16h,17h,18h,19h,20h,21h
 cnt dw 22
 msg db 10,13,"Cubes of bcd digits(up to 21):$"
 tmp db ?
 tmp1 db ?
data ends

stack1 segment
 dw 50 dup(0)
 stop label word
stack1 ends

assume cs:code,ds:data,ss:stack1
code segment
start:
        mov ax,data
        mov ds,ax
        mov ax,stack1
        mov ss,ax
        lea sp,stop

        dispmsg msg
        mov cx,cnt
        lea di,n
        lea si,m
        l1:
        push cx
        provideline
        call sqre
        call cube

                mov tmp,bh

        call display

                mov tmp,bl

        call display
        inc si
        inc di
        pop cx
        loop l1

        mov ah,4ch
        int 21h


sqre proc near
        mov ah,0
        mov bl,[di]
        mov al,[di]
        mul bl
        mov cx,ax
        ret
sqre endp

cube proc near
        mov dx,0000h
        mov bl,[si]
        cub:
          mov al,dl
          add al,bl
          daa
          mov dl,al
          jnc cubsub
          mov al,dh
          add al,1
          daa
          mov dh,al
          cubsub:
        loop cub
        mov bx,dx
        ret
cube endp


display proc near
        mov dl,tmp
        and dl,0f0h
        mov cl,04h
        ror dl,cl
        add dl,30h
        mov ah,02h
        int 21h
        mov dl,tmp
        and dl,0fh
        add dl,30h
        mov ah,02h
        int 21h
        ret
display endp

code ends
end start
