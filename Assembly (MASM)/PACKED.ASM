read macro var
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

	       display macro msg
		    mov dx,offset msg
		    mov ah,09h
		    int 21h
		endm

		toasciih macro reg
		    mov dl,reg
		    and dl,0f0h
		    mov cl,04h
		    ror dl,cl
		    add dl,30h
		    mov ah,02h
		    int 21h
		endm

		toasciil macro reg
		    mov dl,reg
		    and dl,0fh
		    add dl,30h
		    mov ah,02h
		    int 21h
		endm


stack1 segment
    dw 50 dup(0)
    stacktop label word
stack1 ends


data segment

    x  dw ?
    t1 dw ?
    t2 dw ?
    msg  db 10,13,"$"
    f	db 10,13,"Enter the count:$"
    msg2 db 10,13,"The sum is = $"
data ends

assume cs:code,ds:data,ss:stack1
code segment
start:

    mov ax,data
    mov ds,ax
    mov ax,stack1
    mov ss,ax
    lea sp,stacktop

    display f
    read x

    mov dx,0000h
    mov cx,x
    l1:
    mov t1,cx;push cx
    mov t2,dx;push dx
    call pack
    mov cx,t1;pop dx
    mov dx,t2;pop cx

    mov f,0
    mov al,dl
    add al,bl
    daa
    mov dl,al
    adc f,0


    cmp f,1
    je	l2
    loop l1

    jmp l3

    l2:
    mov al,dh
    add al,1
    daa
    mov dh,al
    loop l1

    l3:
    mov bx,dx
    display msg2


    toasciih bh
    toasciil bh
    toasciih bl
    toasciil bl

    mov ah,4ch
    int 21h



		    pack proc near
			display msg
			mov ah,01h
			int 21h
			mov bl,al
			mov ah,01h
			int 21h

			mov cl,al
			mov al,bl
			mov bl,cl

			and al,0fh
			and bl,0fh
			mov cl,04h
			rol al,cl
			add al,bl

			mov bl,al

			ret
		    pack endp


code ends
end start
