
assume cs:code,ds:data

data segment
n1 db 10,13,"Enter the number:$"
data ends

code segment
start:
        mov ax,data
        mov ds,ax

        stc
        mov al,99h
        adc al,99h
        daa

        mov ah,4ch
        int 21h
code ends
end start

