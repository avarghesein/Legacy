
extrn readword:proc,displayword:proc,readnumber:proc,dispnumber:proc

dispmsg macro  msg
        lea  dx,msg
        mov ah,09h
        int 21h
endm


stack1 segment stack
        dw 100 dup(0)
        sttop label word
stack1 ends

data segment
        n1 dw ?
        n2 dw ?
        m1 db 10,13,"Enter the 1st word:$"
        m2 db 10,13,"Entered the 2nd word:$"
        m3 db 10,13,"Resut of multiplication is=$"
data ends

assume cs:code,ds:data,ss:stack1
code segment
start:
        mov ax,data
        mov ds,ax
        mov ax,stack1
        mov ss,ax
        lea sp,sttop

        dispmsg m1
        lea si,n1
        call far ptr readnumber
        dispmsg m2
        lea si,n2
        call far ptr readnumber

        mov dx,0
        mov ax,n1
        mov bx,n2
        imul bx
        mov n1,ax

        dispmsg m3
        lea si,n1
        call far ptr dispnumber

        mov ah,4ch
        int 21h

code ends
end start
        
