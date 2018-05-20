; Модуль преобразования чисел в различные форматы

; ----------------------------------------------------------------------
; Функция: ПРЕОБРАЗОВАНИЕ ДЕСЯТИЧНОГО ПРЕДСТАВЛЕНИЯ В ДВОИЧНОЕ
; На вход: SI - указатель на число в десятичном формате (ASCIIZ): меняются
;          CX - максимальная разрядность (8/16/32 и т.д.)
;          DI - выходное значение
; ----------------------------------------------------------------------

ATOI:   mov     bx, cx      ; Копия CX
        push    cx

.loopc: mov     ah, 0       ; Перебрать все CX бит
        push    si
        
        ; Последовательно разделить все цифры на 2 с переносом
        ; ------------------
.loopz: mov     al, [si]    ; Получить новое значение
        and     al, al      ; Проверить на знак 0
        je      short .binsh 
        sub     al, '0'       
        add     ah, al      ; Добавить перенос от предыдущего разряда
        shr     ah, 1       ; Выполнить деление на 2
        mov     al, ah
        mov     ah, 0       ; Расчет нового переноса
        jnb     short @f
        mov     ah, 10
@@:     add     al, '0'
        mov     [si], al    ; Запись нового значения    
        inc     si
        jmp     .loopz
        ; ------------------

.binsh: pop     si          ; Дошло до последней цифры
        push    bx di ax    ; Сдвиг на 1 бит направо для освобожения нового бита
        xor     ax, ax      ; Сброс CF
@@:     sahf
        rcr     byte [di], 1
        lahf
        inc     di
        sub     bx, 8
        jnbe    short @b
        pop     ax di bx
        
        and     ah, ah      ; Если есть перенос, поставить старший бит
        je      @f
        or      [di], byte 80h
@@:     loop    short .loopc
        
        ; BigEndian -> LittleEndian
        shr     bx, 1
        shr     bx, 1
        shr     bx, 1
        dec     bx        
        mov     si, di
        add     si, bx        
@@:     mov     al, [si]
        xchg    al, [di]
        mov     [si], al
        dec     si
        inc     di
        cmp     di, si
        jb      @b
        ret
        
