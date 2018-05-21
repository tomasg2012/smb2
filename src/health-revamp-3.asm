
StoreMushroomState:
    TXA
    PHA
    LDA     CurrentLevel
    RSL
    ADC     EnemyVariable
    TAX
    INC     $7800,X
    PLA
    TAX
    RTS

NewHealthRender:
    TYA
    PHA
DrawHealthPip:
    LDA #$BA
    STA SpriteDMAArea+1,Y
    LDA #$10
    STA SpriteDMAArea+3,Y
    LDA #3
    STA SpriteDMAArea+2,Y
    LDA byte_RAM_0
    STA SpriteDMAArea,Y
    CLC
    ADC #$10
    STA byte_RAM_0
    INX
    INY
    INY
    INY
    INY
    INC byte_RAM_3
    INC byte_RAM_3
    LDA byte_RAM_3
    CMP #8
    BCC DrawHealthPip
    PLA
    CMP PlayerMaxHealth
    BCC DrawHealthPip
    PLA
    TAX
    LDA PlayerHealth
    BEQ EndDrawHealth
FillHealthPip:
    DEC SpriteDMAArea+2,X
    SBC #$10
    BCC EndFillHealth
    TAY
    LDA #$B8
    STA SpriteDMAArea+1,X
    DEC SpriteDMAArea+2,X
    TYA
    SBC #$10
    BCC EndFillHealth
    ;DEC SpriteDMAArea+2,X
    ;SBC #$10
    ;BCC EndFillHealth
    INX
    INX
    INX
    INX
    JMP FillHealthPip
EndFillHealth:
EndDrawHealth:
    RTS
