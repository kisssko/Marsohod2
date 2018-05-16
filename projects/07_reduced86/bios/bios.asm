
; Особый BIOS, который имитирует крутой BIOS, но на самом деле это
; такой жесткий примитив, о котором вслух не говорят

        org     0xe000
        macro   brk { xchg bx, bx }
        
bios_entry:
        
        brk
        
        ; ax = 80*y + x
        mov     bx, 80*0 + 0
        call    cursor_set        
        
        ; 96 байт доступно для стека
        mov     sp, $c000
        mov     di, $b000
        mov     ax, $1700
        mov     cx, 2000
@@:     mov     [di], ax    
        add     di, 2
        loop    @b        
        jmp     $

; --------------------
; Установка курсора
; bx = X + Y*80
; --------------------

cursor_set:

        mov     dx, $3d4
        mov     al, $0f
        out     dx, al      ; outb(0x3D4, 0x0F)
        inc     dx
        mov     al, bl
        out     dx, al      ; outb(0x3D5, pos[7:0])
        dec     dx
        mov     al, $0e
        out     dx, al      ; outb(0x3D4, 0x0E)
        inc     dx
        mov     al, bh
        out     dx, al      ; outb(0x3D5, pos[15:8])
        ret
        
; ----------------------------------------------------------------------       
        db      (0xFFF0 - $) dup 0x00       ; Unused
; ----------------------------------------------------------------------

F000_entry:

		mov		[$b000], word $0741
		jmp		$
    
        ;jmp     bios_entry        
        db      (0x10000 - $) dup 0x00
        
