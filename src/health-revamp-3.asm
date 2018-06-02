
ResetMushroomState:
    LDX #20
ResetMushroomState_Loop
    EOR $7950,X
    DEX
    BPL ResetMushroomState_Loop
    RTS
    
StoreMushroomState:
    LDA EnemyVariable
    CMP #$FF
    BEQ StoreMushroomState_End
    TXA
    PHA
    LDA CurrentLevel
    ASL
    ADC EnemyVariable
    TAX
    INC $7950,X
    PLA
    TAX
StoreMushroomState_End:
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
    INC byte_RAM_3
    INC byte_RAM_3
    LDA byte_RAM_3
    CMP #6
    BCS +
    CMP PlayerMaxHealth
    BCS +
    INY
    INY
    INY
    INY
    JMP DrawHealthPip
+   PLA
    TAX
    TYA
    STA byte_RAM_3
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
    CPX byte_RAM_3
    BCS EndFillHealth
    INX
    INX
    INX
    JMP FillHealthPip
EndFillHealth:
EndDrawHealth:
    RTS
