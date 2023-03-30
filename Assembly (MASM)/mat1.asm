
extrn readnumber:proc,dispnumber:proc



increment macro reg,cnt
        add reg,cnt
        add reg,cnt
endm


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



disparray macro msg,cnt
local l1,l2,l3
        provideline
        set si,msg
                mov bx,0
        mov cx,cnt
        l1:     
                cmp bx,c2
                jb  l3
                provideline
                mov bx,0
        l3:
                inc bx
        call far ptr dispnumber
        providetab
        increment si,1
        loop l1
        l2:
endm
        



readrc macro r1
    set si,r1
    call far ptr readnumber
endm



readmatrix macro msg1,r1,c1
local l1,l2
    set si,msg1
    mov ax,r1
    mov dx,0
    mul c1
    mov cx,ax
    l1:
        call far ptr readnumber
        increment si,1
        provideline
    loop l1
    l2:
endm


dispmsg macro  msg
        lea  dx,msg
        mov ah,09h
        int 21h
endm


set macro reg,var
        lea reg,var
endm



stack1 segment  stack
    dw 70 dup(0)
    stacktop label word
stack1 ends


data segment
   
        msg1 db "Enter number of rows for 1st matrix:$"
        msg2 db 10,13,"Enter number of columns for 1st matrix:$"
        msg3 db 10,13,"Enter number of columns for 2nd matrix:$"
        n1   db 10,13,"Enter elemets of 1st matrix",10,13,"$"
        n2   db 10,13,"Enter elements of 2nd matrix",10,13,"$"
        msg4 db 10,13,"Resultant matrix:$"
        a1   dw 50 dup(0)
        a2   dw 50 dup(0)
        a3   dw 50 dup(0)
        k    dw 0
        r1   dw ?
        c1   dw ?
        c2   dw ?
data ends
        


assume cs:code,ds:data,ss:stack1
code segment
start:

    mov ax,data
    mov ds,ax
    mov ax,stack1
    mov ss,ax
    lea sp,stacktop

    dispmsg msg1
    readrc r1
    dispmsg msg2
    readrc c1
    dispmsg msg3
    readrc c2
    provideline

    dispmsg n1
    readmatrix a1,r1,c1
    dispmsg n2
    readmatrix a2,c1,c2

    dispmsg msg4

    mov cx,r1
    set bx,a1
    outer:
        push cx
        mov si,bx
        set dx,a2
        mov cx,c2
        inner:
                push cx
                mov di,dx
                mov si,bx
                mov cx,c1

                 push si
                 set  si,a3 
                 increment si,k
                 mov  [si],0
                 pop si
                inner1:
                        push cx
                        push dx
                        mov  dx,0
                        mov ax,[si]
                        mov cx,[di]
                        imul cx

                        push si        
                        set  si,a3   
                        increment si,k
                        add  ax,[si]
                        mov  [si],ax  
                        pop  si      

                        increment di,c2
                        increment si,1
                        pop dx
                        pop cx
                loop inner1
                inc k
                increment dx,1
                pop cx
        loop inner
        increment bx,c1
        pop cx
    loop outer

     mov dx,0
     mov ax,r1
     mul c2
     mov r1,ax
     disparray a3,r1

        

mov ah,4ch
int 21h

code ends
end start

