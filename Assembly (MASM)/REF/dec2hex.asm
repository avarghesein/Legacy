
mprint macro msg
        mov dx,offset msg
        mov ah,09h
        int 21h
endm


cnvrt macro var
local l1,l2

	mov bl,10
	mov var,0
	l1:
        mov ah,01h
        int 21h
        mov ah,0
        cmp ax,'0'
	jl  l2
        cmp ax,'9'
	ja  l2
	sub ax,30h
        mov dx,ax
	mov ax,var
        mul bl
        add ax,dx
	mov var,ax
	jmp l1
	l2:
endm


tohex macro var,arr
local l1,l2,l3,loop1,l4

	mov cx,0
        mov ax,var
        mov si,offset arr
        mov bl,16
	l1:
        div bl
        cmp ah,0
	jl  l2
        cmp ah,9
	ja  l2
        add ah,30h
        mov [si],ah
	jmp l3
	l2:
        add ah,55
        mov [si],ah
	l3:
        mov ah,0
        inc si
        inc cx
        cmp ax,0
	ja  l1
        mov bx,cx
        dec bx
        mov si,offset arr
        add si,bx
	loop1:
        mov ah,02h
        mov dl,[si]
        int 21h
        dec si
	loop loop1
	l4:
endm


assume cs:code,ds:data

data segment
n1 db 10,13,"Enter the number:$"
n2 db 10,13,"corresponding hex no=$"
x1  dw 0
y1  db 15 dup(?)
data ends

code segment
start:
        mov ax,data
        mov ds,ax

        mprint n1
        cnvrt  x1
        mprint n2
        tohex x1,y1

        mov ah,4ch
        int 21h
code ends
end start
