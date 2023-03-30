
extrn readword:proc,displayword:proc,readnumber:proc,dispnumber:proc

dispmsg macro  msg                              ;in inc1
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
        m3 db 10,13,"Quotient=$"
        m4 db 10,13,"Remainder=$"
        n3 dw 0
        n4 dw 0
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

        mov ax,n1
        cwd
        mov  bx,n2
        idiv bx
        mov n3,dx
        mov n4,ax
        

        dispmsg m3
        lea si,n4
        call far ptr dispnumber
        dispmsg m4
        lea si,n3
        call far ptr dispnumber

        mov ah,4ch
        int 21h

code ends
end start
        
