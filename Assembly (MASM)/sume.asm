
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


stack1 segment   stack
    dw 100 dup(0)
    stacktop label word
stack1 ends


data segment
    k    db 4 dup(?)
    tmp  db 10 dup(00h,00h,00h,00h,00h,00h,00h,00h,00h,00h)
    x	 dw ?
    msg	 db 10,13,"$"
    msg1 db 10,13,"Enter the count:$"
    msg2 db 10,13,"The sum is = $"
data ends

assume cs:code,ds:data,ss:stack1,es:data
code segment
start:

    mov ax,data
    mov ds,ax
    mov ds,ax
    mov ax,stack1
    mov ss,ax
    lea sp,stacktop

    display msg1
    read x

    
    mov cx,x
      
    l1:
    push cx

    push dx
    call pack
    pop dx
    
    mov cx,4
    lea si,tmp
    lea di,k

    l4:
    push si
    push cx
    clc
    mov al,[si]
    adc al,[di]
    daa
    mov [si],al
    jnc l6
    call addc

    l6:
    pop cx
    pop si
    inc si
    inc di
    loop l4

    l2:
    pop cx
    loop l1

    
    display msg2

    mov cx,4
    mov bx,3
    lea si,tmp
    add si,bx
    l5:
    push cx
    mov bh,[si]
    toasciih bh
    toasciil bh
    dec si
    pop cx
    loop l5
    mov ah,4ch
    int 21h


                    addc proc near
                        dec cx
                        inc si
                        h:
                          mov al,[si]
                          adc al,00h
                          daa
                          mov [si],al
                          inc si
                        loop h
                    ret
                    addc endp

		    pack proc near
			display msg

                        push cx
                        push di
                        mov cx,3
                        lea di,k
                        add di,cx
                        mov cx,4
                        l10:
                        push cx
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

                        mov [di],al
                        dec di
                        pop cx
                        loop l10

                        pop di
                        pop cx
			ret
		    pack endp


code ends
end start
