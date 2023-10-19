OUTPUT_FORMAT("elf64-x86-64")
ENTRY(start)

SECTIONS {
    /* The bootloader places us at 0x1000 (4KB) in memory, so we need to skip the first 4KB */
    . = 0x1000;

    /* The .text section contains the kernel code */
    .text : {
        *(.text.start)   /* Entry point code */
        *(.text*)        /* All other code */
    }

    /* The .rodata section contains read-only data, such as string literals */
    .rodata : {
        *(.rodata*)
    }

    /* The .data section contains initialized data */
    .data : {
        *(.data*)
    }

    /* The .bss section contains uninitialized data */
    .bss : {
        *(.bss*)
    }

    /* The .bootdata section contains data loaded by the bootloader */
    .bootdata : {
        *(.bootdata*)
    }

    /* The .bootbss section contains uninitialized data loaded by the bootloader */
    .bootbss : {
        *(.bootbss*)
    }

    /* The stack section (adjust size as needed) */
    .stack : {
        *(.stack)
    }

    /* The .note section contains debugging information */
    .note : {
        *(.note*)
    }

    /* The .comment section contains compiler comments */
    .comment : {
        *(.comment)
    }

    /* Alignment and padding */
    /DISCARD/ : {
        *(.eh_frame)
        *(.comment)
    }
}
