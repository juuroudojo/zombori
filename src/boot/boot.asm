; boot.asm

section .text
global _start

_start:
    ; Set up the stack
    mov ax, 0x9000
    mov ss, ax
    mov sp, 0xFFFF

    ; Set video mode (80x25 text mode)
    mov ah, 0x00 ; Set video mode function
    mov al, 0x03 ; 80x25 text mode
    int 0x10     ; Call BIOS video interrupt

    ; Display "Hello, OS!" on the screen
    mov si, hello_message
    call print_message

    ; Infinite loop to halt execution (optional)
    cli
    hlt

print_message:
    ; Print a null-terminated string from the si register to the screen
    print_loop:
        lodsb     ; Load the next character from si into al
        test al, al
        jz print_done ; If it's the null terminator, we're done
        mov ah, 0x0E ; Teletype function (write character with attribute)
        mov bh, 0x00 ; Page number (usually 0)
        int 0x10    ; Call BIOS video interrupt
        jmp print_loop ; Repeat for the next character

    print_done:
        ret

hello_message db "Hello, OS!", 0

times 510 - ($ - $$) db 0
dw 0
