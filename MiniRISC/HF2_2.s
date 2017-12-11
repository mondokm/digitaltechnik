DEF LD  0x80                ; LED Datenregister

DATA
DIGIT_CODE:
    DB 0x35, 0x27, 0x56, 0x17, 0x6A, 0x4B, 0x70
    ORG 0x10;
SUM_LUT:
    DB 0x00, 0x01, 0x01, 0x02, 0x01, 0x02, 0x02, 0x03, 0x01, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04
    
CODE
    MOV r0, #DIGIT_CODE     ; Einladen des Vektorzeigers
    MOV r1, #7              ; Anzahl von Datenvektorbytes
    XOR r2, r2              ; Vorbereitung des Bitzaehlers
loop:
    MOV r8, (r0)            ; Wir laden das aktuelles Element ein
    
    MOV r9, r8              ; Wir machen eine Kopie von die eingelesenes Element (fuer die obere 4 Bits)
    SWP r9                  ; Wir tauschen die obere und untere 4 Bits
    
    AND r8, #0x0F           ; Wir maskieren die untere 4 Bits
    MOV r10, #SUM_LUT       ; Wir laden die Adresse von SUM_LUT ein
    ADD r10, r8             ; Wir addieren die untere 4 Bits zu die Adresse von SUM_LUT
    MOV r11, (r10)          ; Wir laden die Anzahl von 1-er bits in r8 ein
    ADD r2, r11             ; Wir inkrementieren den BitZaehler
    
    AND r9, #0x0F           ; Wir maskieren die untere 4 Bits
    MOV r10, #SUM_LUT       ; Wir laden die Adresse von SUM_LUT ein
    ADD r10, r9             ; Wir addieren die untere 4 Bits zu die Adresse von SUM_LUT
    MOV r11, (r10)          ; Wir laden die Anzahl von 1-er bits in r8 ein
    ADD r2, r11             ; Wir inkrementieren den BitZaehler
    
    ADD r0, #1              ; Wir inkrementieren den Vektorzeiger
    SUB r1, #1              ; Wir erfrischen die Anzahl von uebrigen Vektorelementen
    JNZ loop                ; Wenn es noch unbearbeitete Vektorelementen gibt, treten wir zu loop zurueck
    
    MOV LD, r2              ; Wir erfrischen die Anzeige