DEF LD  0x80                ; LED Datenregister
    
DATA
DIGIT_CODE:
    DB 0x35, 0x27, 0x56, 0x17, 0x6A, 0x4B, 0x70
    
CODE
start:
    MOV r0, #DIGIT_CODE     ; Einladen des Vektorzeigers
    MOV r1, #7              ; Anzahl von Datenvektorbytes
    XOR r2, r2              ; Vorbereitung des Bitzaehlers
read:
    MOV r8, (r0)            ; Wir einladen das aktuelles Element
    SR0 r8                  ; Wir verschieben r3 nach rechts
loop:
    ADC r2, #0              ; Wir addieren das Carry-Bit zu r2
    SR0 r8                  ; Wir verschieben r3 nach rechts
    JNZ loop                ; Wenn r3 noch 1-Bits hat, treten wir zur loop
    
    ADC r2, #0              ; Wir addieren das Carry-Bit zu r2
    ADD r0, #0x01           ; Treten wir zur naechste Element 
    SUB r1, #1              ; 
    JNZ read                ; Wenn es noch Zahlen gibt, dann treten wir zu read zurueck
    
    MOV LD, r2              ; Wir erfrischen die Anzeige