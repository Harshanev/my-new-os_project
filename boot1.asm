bits 16 ; tell NASM this is 16 bit code
org 0x7c00 ; tell NASM to start outputting stuff at offset 0x7c00
boot:
    
    call os_clear_screen
    call os_show_cursor
    mov si,hello ; point si register to hello label memory location
    mov ah,0x0e ; 0x0e means 'Write Character in TTY mode'
.loop:
    lodsb
    or al,al ; is al == 0 ?
    jz halt  ; if (al == 0) jump to halt label
    int 0x10 ; runs BIOS interrupt 0x10 - Video Services
    jmp .loop
halt:
    cli ; clear interrupt flag
    hlt ; halt execution
hello: db "Hello world!",0
os_clear_screen:
        pusha

        mov dx, 0                       ; Position cursor at top-left
        call os_move_cursor

        mov ah, 6                       ; Scroll full-screen
        mov al, 4                       ; Normal white on black
        mov bh, 0                       ;
        mov cx, 0                       ; Top-left
        mov dh, 24                      ; Bottom-right
        mov dl, 79
        int 10h

        popa
        ret
os_move_cursor:
        pusha

        mov bh, 1
        mov ah, 4
        int 10h                         ; BIOS interrupt to move cursor

        popa
        ret
os_show_cursor:
        pusha

        mov ch, 2
        mov cl, 2
        mov ah, 4
        mov al, 3
        mov dh, 0
        mov dl, 0
        int 10h
        popa
        ret
times 510 - ($-$$) db 0 ; pad remaining 510 bytes with zeroes
dw 0xaa55 ; magic bootloader magic - marks this 512 byte sector bootable!
