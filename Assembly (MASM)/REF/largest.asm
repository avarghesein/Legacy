providetab macro
        mov ah,02h
        mov dl,09h
        int 21h
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




readarray macro msg,cnt
local l1,l2
    dispmsg msg
    set si,cnt
    call readnumberbyte
    mov cx,0
    mov cl,cnt
    set si,msg
    l1:
        provideline
        call readnumberbyte
        inc si 
    loop l1
    l2:
endm


disparray macro msg,cnt,tmp
local l1,l2
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
        

stack1 segment
    dw 50 dup(0)
    stacktop label word
stack1 ends


data segment
        tmp   db 20 dup(?)
        msg1  db "Enter number of numbers:$"
        msg2  db 10,13,"Entered array=>$"
        msg3  db 10,13,"LARGEST=>$"
        msg4  db 10,13,"SMALLEST=>$"
        cnt1  db ?
data ends
        


assume cs:code,ds:data,ss:stack1
code segment
start:

    mov ax,data
    mov ds,ax
    mov ax,stack1
    mov ss,ax
    lea sp,stacktop

    readarray msg1,cnt1
    dispmsg   msg2
    disparray msg1,cnt1,tmp

    mov ah,msg1
    mov al,msg1
    lea si,[msg1+1]
    mov cx,0
    mov cl,cnt1
    dec cx
    l1:
        cmp al,[si]
        jb  l2
        mov al,[si]
        l2:
        cmp ah,[si]
        ja  l3
        mov ah,[si]
        l3:
        inc si
        loop l1

    mov msg1,ah
    mov msg2,al

    dispmsg msg3
    set si,msg1
    set di,tmp
    call dispnumberbyte

    dispmsg msg4
    set si,msg2
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
                and al,0fh
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

