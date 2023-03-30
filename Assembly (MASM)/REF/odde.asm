
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
        msg1 db "Enter number of numbers:$"
        msg2 db 10,13,"Enter numbers",10,13,"$"
        msg3 db 10,13,"Even numbers=$"
        msg4 db 10,13,"Odd  numbers=$"
        cnt  db ?
        var  db ?
        tmp  db 20 dup(?)
        odd  db 0
        ev db 0
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
    set si,cnt
    call readnumberbyte

    mov cx,0
    mov cl,cnt
    set si,var
    l1:
        provideline
        call readnumberbyte

        mov bl,2
        mov ah,0
        mov al,var
        div bl
        cmp ah,0
        ja  l2
        inc ev
        jmp l3
        l2:
        inc odd
        l3:
     loop l1


     dispmsg msg3
     set si,ev
     set di,tmp
     call dispnumberbyte
     dispmsg msg4
     set si,odd
     set di,tmp
     call dispnumberbyte

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

