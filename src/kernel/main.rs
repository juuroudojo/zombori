// main.rs

#![no_std]
#![no_main]

use core::panic::PanicInfo;

/// This function is called on panic.
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

/// Entry point for the kernel.
#[no_mangle]
pub extern "C" fn kernel_main() -> ! {
    // Main kernel code goes here

    // Example: Output "Hello, OS!" to the screen
    let vga_buffer = 0xb8000 as *mut u8;
    for (i, &byte) in b"Hello, OS!".iter().enumerate() {
        unsafe {
            *vga_buffer.offset(i as isize * 2) = byte;
            *vga_buffer.offset(i as isize * 2 + 1) = 0x0F; // White on black
        }
    }

    loop {}
}
