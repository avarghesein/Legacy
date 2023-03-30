

      dispmsg macro  msg
				        lea  dx,msg
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


				assume cs:code,ds:data
				data segment
		        n1 db 10,13,"Enter   number=$"
		        n2 db 10,13,"Entered number=$"
                          data ends
				code segment
			start:
	        mov ax,data
			        mov ds,ax

				        dispmsg n1
			        mov ah,01h
		        int 21h
			        mov bl,al
			        mov ah,01h
			        int 21h

			        mov cl,al
		        mov al,bl
		        mov bl,cl

		        and al,0fH
		        and bl,0fH
		        mov cl,04H
			        rol al,cl
			        add al,bl
			        mov bl,al

                          dispmsg n2             
				        toasciih bl
				        toasciil bl

			mov ah,4ch
			int 21h

			code ends
				end start

