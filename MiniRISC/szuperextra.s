DEF TR   0x82                ; Timer kezdoállapot regiszter    
DEF TM   0x82                ; Timer számláló regiszter       
DEF TC   0x83                ; Timer parancs regiszter          
DEF TS   0x83                ; Timer státusz regiszter      
DEF SW   0x81
DEF COL0 0x94                ; Kijelzo COL0 adatregiszter     
DEF COL1 0x95                ; Kijelzo COL1 adatregiszter        
DEF COL2 0x96                ; Kijelzo COL2 adatregiszter      
DEF COL3 0x97                ; Kijelzo COL3 adatregiszter           
DEF COL4 0x98                ; Kijelzo COL4 adatregiszter         

CODE
    JMP start
    JMP tmr_irq

start:
    JSR clear_display
    MOV r9, #0x00  ;bal/jobb
    MOV r10,#0xFF  ;villogas flip-flop kezdoerteke
    MOV r11,#0     ;novo nyil kezdo hossza
    MOV r6, #0xFF  ;timer beallitasa
    MOV TM, r6
    MOV TC, r6
    MOV r6, TS
    STI
    JMP display_loop

display:
    TST r12, #0x2   ;bal/jobb
    JNZ to_left 
    MOV r9, #0xFF
    JMP end
to_left:
    MOV r9, #0x00
end:
    TST r12, #0x1   ;le/fel a ledeket
    JZ dont_blink
    XOR r10, #0xFF  
    JMP blink_end
dont_blink:
    MOV r10, #0xFF
blink_end:
    TST r12, #0x4   ;novekvo/statikus
    JZ full
    JMP growing
    
display_loop:    
    JMP display_loop

; r0: 0-5 (mennyire van kitoltve a nyil)
display_arrow_left:
    JSR clear_display
    MOV r2, #COL0   ;a kijelzo elso soranak cime
    MOV r3, #0x10   ;elso sor
    MOV r4, #0xE0   ;also sor
    SUB r0, #1
    JN last_left
loop_left:
    OR r3, #0x01    ;a vonal fuggoleges resze
    MOV (r2), r3    ;kijelezzuk
    ADD r2, #1      ;kijelzo kovetkezo sora
    SR0 r3          ;a kovekezo sorhoz egyel arrebb rakjuk a 
                    ;nyil diagonalis reszet
    SR1 r4          ;az also sort is csusztatjuk
    SUB r0, #1
    JN last_left
    JMP loop_left
last_left:
    AND r4, #0x1F   ;a nyilhoz nem tartozo utolso 2 led nem kell
    MOV COL4, r4
    RTS
    
display_arrow_right:
    JSR clear_display
    MOV r2, #COL0   ;a kijelzo elso soranak cime
    MOV r3, #0x04   ;elso sor
    MOV r4, #0x03   ;also sor
    SUB r0, #1
    JN last_right
loop_right:
    OR r3, #0x40    ;a vonal fuggoleges resze
    MOV (r2), r3    ;kijelezzuk
    ADD r2, #1      ;kijelzo kovetkezo sora
    SL0 r3          ;a kovekezo sorhoz egyel arrebb rakjuk a nyil 
                    ;diagonalis reszet
    SL1 r4          ;az also sort is csusztatjuk
    SUB r0, #1
    JN last_right
    JMP loop_right
last_right:
    AND r4, #0xFC   ;a nyilhoz nem tartozo elso 2 led nem kell
    MOV COL4, r4
    RTS

full:
    MOV r0, #5      ;nyil hossza 5 lesz
    CMP r10, #0
    JNZ full_display
    JSR clear_display
    RTS
full_display:
    CMP r9, #0      ;0:bal, 1:jobb
    JZ full_left
    JSR display_arrow_right
    RTS
full_left:
    JSR display_arrow_left
    RTS
    

growing:
    CMP r10, #0
    JNZ growing_display
    JSR clear_display
    RTS
growing_display:
    MOV r0, r11     ;betoltjuk az aktualis hosszt, majd noveljuk
    ADD r11, #1
    CMP r0, #6
    JZ growing_reset    ;ha teljes hosszusagu a nyil, akkor elorol indul
    CMP r9, #0          ;bal/jobb
    JZ growing_left
    JSR display_arrow_right
    RTS
growing_left:
    JSR display_arrow_left
    RTS
growing_reset:
    MOV r11, #0         ;0 hosszusagura allitjuk a nyilat, és lekapcsolunk 
                        ;minden ledet
    JSR clear_display
    RTS
    
    
clear_display:
    XOR r7, r7
    MOV COL0, r7
    MOV COL1, r7
    MOV COL2, r7
    MOV COL3, r7
    MOV COL4, r7
    RTS
    
tmr_irq:
    MOV r12, TS
    MOV r12, SW     ;beolvassuk a kapcsolok allasat
    JSR display
    RTI
    