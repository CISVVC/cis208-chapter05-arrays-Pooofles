;
; file: asm_main.asm
; author: Jessica Sandoval

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
        syswrite: equ 4
        stdout: equ 1
        exit: equ 1
        SUCCESS: equ 0
        kernelcall: equ 80h
	array dd 6,8,10,5
	length dd 4
	number dd 2
	prompt db "please enter a number to multiply by:", 0
	input dd 0 

; uninitialized data is put in the .bss segment
;
segment .bss

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; *********** Start  Assignment Code *******************
	mov eax, array
	push eax
	mov eax,[length]
	push eax
	mov eax, prompt
	call print_string
	call read_int
	push eax
	call multiply

	pop eax
	pop eax
	pop eax
	mov ecx, [length]
	mov edx, 0
loop2:
	mov eax, [array+edx]
	call print_int
	call print_nl
	add edx, 4
	loop loop2
; *********** End Assignment Code **********************

        popa
        mov     eax, SUCCESS       ; return back to the C program
        leave                     
        ret

multiply: 
	push ebp
	mov 	ebp, esp
	mov     ebx, [ebp+16]
	mov 	ecx, [ebp+12]
	mov     edx, 0
loop1:
	mov eax, [ebx + edx]
	imul eax, [ebp+8]
	mov [ebx + edx], eax
	add edx, 4
	loop loop1
	
	pop ebp
	ret
