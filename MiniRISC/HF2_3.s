DEF LD  0x80                ; LED Datenregister

DATA
DIGIT_CODE:
    DB 0x35, 0x27, 0x56, 0x17, 0x6A, 0x4B, 0x70
    
CODE
    MOV r0, #DIGIT_CODE     ; Einladen des Vektorzeigers
    MOV r1, #7              ; Anzahl von Datenvektorbytes
    XOR r2, r2              ; Vorbereitung des Bitzaehlers

loop:
    MOV r8, (r0)            ; Wir laden das aktuelles Element ein
    MOV r9, r8              ; Wir machen eine Kopie (fuer die ungerade Bits)
    
    AND r8, #0x55           ; Wir maskieren die gerade Bits
    AND r9, #0xAA           ; Wir maskieren die ungerade Bits
    
    SR0 r9                  ; Wir verschieben die ungerade Bits nach rechts
    
    ADD r8, r9              ; Wir addieren die gerade und ungerade Bits
    MOV r9, r8              ; Wir machen eine Kopie
    
    AND r8, #0x33           ; Wir maskieren die gerade 2-Bit Teilsummen
    AND r9, #0xCC           ; Wir maskieren die ungerade 2-Bit Teilsummen
    
    SR0 r9                  ; Wir verschieben die Bits nach rechts (zweimal)
    SR0 r9
    
    ADD r8, r9              ; Wir addieren die gerade und ungerade 2-Bit Teilsummen
    MOV r9, r8              ; Wir machen eine Kopie
    
    AND r8, #0x07           ; Wir maskieren die untere 4-Bits
    AND r9, #0x70           ; Wir maskieren die obere 4-Bits
    
    SWP r9                  ; Wir vertauschen die obere und untere 4-Bits
   
    ADD r8, r9              ; Wir addieren die maskierete Zahlen
    ADD r2, r8              ; Wir addieren das Teilergebnis zu dem Bitzaehler
  
    ADD r0, #1              ; Wir inkrementieren den Vektorzeiger
    SUB r1, #1              ; Wir erfrischen die Anzahl von uebrigen Vektorelementen
    JNZ loop                ; Wenn es noch unbearbeitete Vektorelementen gibt, treten wir zu loop zurueck
    
    MOV LD, r2              ; Wir erfrischen die Anzeige
    