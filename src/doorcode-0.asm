
EnterDoor_Custom:
    LDA #1
    STA TransitionType
    LDA #0
    STA PlayerState
    STA PlayerXLo
    STA byte_RAM_E5  
    LDA #E0
    STA PlayerYLo
    STA byte_RAM_E6
    LDA CurrentLevelPage
    STA byte_RAM_E8
    LDA #DF
    STA byte_RAM_3
EnterDoor_J1:
    JSR sub_BANK1_BA4E
    LDY byte_RAM_E7
    LDA (byte_RAM_1),Y
    LDY #5
EnterDoor_J2:
    CMP     loc_BANK0_9247+2,Y
    BEQ


    RTS
