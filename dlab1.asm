.model small
.data
	msg db 'str: $'
	size1 dw 20
	size2 dw 20
	str1 db 20 dup (' ')
	str2 db 20 dup (' ')
.stack 200h
.code
main:
	mov si, 0
	mov di, 0
    	mov bx, 0
	mov ax, @data
	mov ds, ax
	lea dx, msg
	
	mov ah, 09h
	int 21h

read:
	mov ah, 00h
    	int 16h
    
	cmp al, 13
	je display
    	
	cmp al, 32
	jb read
	
	cmp si, 39
	ja read

	test si, 1
	jnz ev
	jz odd

next:
	mov dl, al
	mov ah, 02h
	int 21h
	
	inc si
		
	jmp read

odd:
	mov str1[di], al
	inc di
	jmp next
ev:
	
	mov str2[bx], al
	inc bx
	jmp next
	
display:
	mov dh, 0
		
	mov size1, di
	mov size2, bx

	mov ah, 0fh
	int 10h
	
	mov ah, 00h
	int 10h

newstr:
	mov dl, 0
	mov di, 0

	mov ah, 02h
	int 10h

	cmp dh, 4
	je string2
	
string1:
	mov al, str1[di]
	mov cx, 1

	mov ah, 0ah
	int 10h

	inc dl
	mov ah, 02h
	int 10h	

	inc di
	cmp di, size1
	jb string1
	mov dh, 4
 	jmp newstr

string2:
	mov al, str2[di]
	mov cx, 1

	mov ah, 0ah
	int 10h

	inc dl
	mov ah, 02h
	int 10h	

	inc di
	cmp di, size2
	jb string2

quit:
	mov ah, 4ch
	int 21h
end main