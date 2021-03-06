data segment
    a   DW  1D41H, 1FC8H, 2546H, 5D8CH, 980FH, 7F57H, 0B31H, 741CH, 3D8DH, 9A6CH, 163EH, 820AH, 2DDCH, 6A65H, 66D6H, 2904H, 2971H, 7DB4H, 52B3H, 46BAH, 1D99H, 76A1H, 49B1H, 9981H, 883DH, 0109H, 12C9H, 6B95H, 6337H, 6432H, 03A0H, 94D5H, 8148H, 33FEH, 23D9H, 9E1CH, 4B79H, 0616H, 6C85H, 8AEDH, 5B1DH, 2C23H, 213BH, 568FH, 1767H, 1868H, 648AH, 346BH, 5D56H, 9276H
    ;9900H,0890H,0880H,9600H,0860H,0850H,0840H,0830H,0820H,0810H,0800H,0790H,6780H,0770H,0760H,7750H,0740H,0730H,4720H,0710H,0700H,0690H,0680H,0670H,0660H,0650H,0640H,0630H,0620H,0610H,0600H,05B0H,05A0H,0570H,3560H,4550H,0540H,0530H,2520H,0510H,6500H,0490H,3480H,0470H,3460H,0450H,0440H,0430H,0420H,0410H
ends

stack segment stack
    ST  DB  100 DUP(0)  
    TOP EQU 700
ends

code segment   
    assume cs:code, ds:data, ss:stack
start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, TOP
    
	mov si, offset a
	mov di, 98
    call quicksort
mov ax, 4c00h
int 21h   
    
quicksort proc near
	;partition ==> q
	cmp si, di
	jnb end_quicksort
	push di
	call partition
	pop di
	 
	cmp bx, 0
	je quick2
	push di
	push bx
	push si
	mov di, bx
	sub di, 2
	call quicksort
	pop si
	pop bx
	pop di
	
  quick2:
	push si
	push bx
	push di
	mov si, bx
	add si, 2
	call quicksort
	pop di
	pop bx
	pop si
	
	end_quicksort:
		RET
quicksort endp

partition proc near
	; a, si, di
	push ax
	push si
	
	
	mov bx, si
	mov cx, di
	sub cx, si
	SHR cx, 1
  s:	
    mov ax, [di]
	cmp ax, [bx]
	jb exchange
	mov ax, [bx]
	push [si]
	pop [bx]
	mov [si], ax
	add si, 2
	;change [bx] with [si]
  exchange:	
	add bx, 2 
	loop s 
	;exchange [si] with [di]
	mov ax, [di]
	push [si]
	pop [di]
	mov [si], ax	;now si is the place of the partition place
	mov bx, si
	
	
	pop si
	pop ax
	ret
partition endp

ends

end start
