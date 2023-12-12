ENTRY(Reset_Handler)

MEMORY
{
    FLASH(rx):ORIGIN =0x08000000, LENGTH = 1024K
    SRAM(rwx):ORIGIN =0x20000000, LENGTH = 128K
}

__max_heap_size = 0x400;
__max_stack_size = 0x200;

SECTIONS
{
    .text :
    {
        *(.isr_vector)
        *(.text)
        *(.text.*)
        *(.rodata)
        *(.rodata.*)
        . = ALIGN(4);
        _etext = .;
    }> FLASH

    _la_data = LOADADDR(.data);
    
    .data :
    {
        _sdata = .;
        *(.data)
        *(.data.*)
        _edata = .;
    }> SRAM AT> FLASH

    .bss :
    {
        _sbss = .;
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss.*)
        _ebss = .;
        __bss_end__ = _ebss;
        __end__ = __bss_end__;
        end = __end__;
    }> SRAM
}