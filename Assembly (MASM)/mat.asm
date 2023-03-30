
provideline macro
        mov ah,02h
        mov dl,10
        int 21h
        mov  ah,02h
        mov dl,13
        int 21h
endm

providetab macro
        mov ah,02h
        mov dl,09h
        int 21h
endm


disparray macro msg,cnt,tmp
local l1,l2
        provideline
        set di,tmp
        set si,msg
        mov cx,0
        mov cl,cnt
        l1:
        providetab
        call dispnumberbyte
        inc si
        loop l1
        l2:

endm
        



readrc macro msg1,r1
    dispmsg msg1
    set si,r1
    call readnumberbyte
endm



readmatrix macro tmp,msg1,r1,c1
local l1,l2
    dispmsg tmp
    set si,msg1
    mov ax,0
    mov al,r1
    mul c1
    mov cx,0
    mov cl,al
    l1:
        call readnumberbyte
        inc si
        provideline

    loop l1
    l2:
endm


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


set macro reg,var
        lea reg,var
endm



stack1 segment
    dw 50 dup(0)
    stacktop label word
stack1 ends


data segment
   
        msg1 db "Enter number of rows for 1st matrix:$"
        msg2 db 10,13,"Enter number of columns for 1st matrix:$"
        msg3 db 10,13,"Enter number of columns for 2nd matrix:$"
        n1   db 10,13,"Enter elemets of 1st matrix",10,13,"$"
        n2   db 10,13,"Enter elements of 2nd matrix",10,13,"$"
        msg4 db 10,13,"Resultant matrix:$"
        k    dw ?
        r1   db ?
        c1   db ?
        c2   db ?
data ends
        


assume cs:code,ds:data,ss:stack1
code segment
start:

    mov ax,data
    mov ds,ax
    mov ax,stack1
    mov ss,ax
    lea sp,stacktop

    readrc msg1,r1
    readrc msg2,c1
    readrc msg3,c2
    provideline
    readmatrix n1,msg1,r1,c1
    readmatrix n2,msg2,c1,c2

    mov cx,0
    dispmsg msg4

    mov k,0
    mov cl,r1
    set bx,msg1
    outer:
        push cx
        mov si,bx
        set dx,msg2
        mov cx,0
        mov cl,c2
        inner:
                push cx
                mov di,dx
                mov si,bx
                mov cx,0
                mov cl,c1

                 push si       ;putting value at [msg3+k]=0
                 set  si,msg3  ;using  push & pops
                 add  si,k     ;for free registers
                 mov  [si],0   ;for temporary use
                 pop si
                inner1:
                        push cx
                        mov ax,0
                        mov al,[si]
                        mov cl,[di]
                        mul cl

                        push si         ;putting value at
                        set  si,msg3    ;[msg3+k]=[msg3+k]+prsent value in AL
                        add  si,k       ;using push & pops for
                        add  al,[si]    ;freeing some registers
                        mov  [si],al    ;using temporarly to find
                        pop  si         ;the exact location of array mag3

                        mov ax,0
                        mov al,c2
                        add di,ax
                        inc si
                        pop cx
                loop inner1
                inc k
                inc dx
                pop cx
        loop inner
        mov ax,0
        mov al,c1
        add bx,ax
        pop cx
    loop outer

     mov ax,0
     mov al,r1
     mov bl,c2
     mul bl
     mov r1,al
     disparray msg3,r1,n1

        

mov ah,4ch
int 21h


readnumberbyte proc near
        mov [si],0
        mov dl,10
        read:
                mov ah,01h
                int 21h

                cmp al,'0'
                jl  endread
                cmp al,'9'
                ja  endread
                sub al,30h
                mov dh,al
                mov al,[si]
                mul dl
                add al,dh
                mov [si],al
                jmp read

        endread:ret

readnumberbyte endp



dispnumberbyte proc near
        mov ax,0
        mov al,[si]
        mov dl,10
        mov dh,0
        findremainder:
                div dl
                add ah,30h
                mov [di],ah
                inc di
                inc dh
                mov ah,0
                cmp al,0
                jg  findremainder
        dec di
        print:
                mov ah,02h
                mov dl,[di]
                int 21h
                dec di
                dec dh
                cmp dh,0
                jg  print
                ret
dispnumberbyte endp
        

code ends
end start

