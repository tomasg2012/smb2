

EnterDoor_Custom:
    LDA #1
    STA TransitionType
    LDA PlayerState_Normal
    STA PlayerState
    STA PlayerXLo
    STA byte_RAM_E5  
    LDA #$E0
    STA PlayerYLo
    STA byte_RAM_E6
    LDA CurrentLevelPage
    STA byte_RAM_E8
    LDA #$DF
    STA byte_RAM_3
EnterDoor_J1:
    JSR sub_BANK1_BA4E ;; get tiles something
    LDY byte_RAM_E7
    LDA (byte_RAM_1),Y
    LDY #5
EnterDoor_J2:
    CMP loc_BANK0_9247+2,Y ;; compare to doors
    BEQ EnterDoor_J4 ;; if tru end
    DEY
    BNE EnterDoor_J2 ;; else loop if y > 0
    DEC byte_RAM_3 
    BEQ EnterDoor_J3 ;; skip if tilepos aint done else
    JSR MoveByXThenY
    STA byte_RAM_E6
    JMP EnterDoor_J1
EnterDoor_J3:
    JMP FindVine_Custom
EnterDoor_J4:
    JSR sub_BANK0_950C
    LDA #00
    STA byte_RAM_41B
    RTS

MoveByXThenY:
    LDA byte_RAM_E5
    CLC
    ADC #1
    AND #$0F
    STA byte_RAM_E5
    ASL
    ASL
    ASL
    ASL
    STA PlayerXLo
    BNE +
    JSR sub_BANK0_950C
    RTS
+   LDA PlayerYLo
    RTS
    

FindVine_Custom:
    LDA #0
    STA PlayerXLo
    STA PlayerYLo
    STA byte_RAM_E5
    STA byte_RAM_E6
    JSR VineGetStartPos
FindVine_J0
    LDA #$F0
    CMP PlayerYLo
    BNE FindVine_J1
    JSR VineGetStartPos_Bottom
FindVine_J1:
    JSR sub_BANK1_BA4E
    LDY byte_RAM_E7
    LDA (byte_RAM_1),Y
    LDY #5
-   CMP byte_BANK0_8B2B-1,Y ;; compare to doors
    BEQ + ;; if tru end
    DEY
    BNE - ;; else loop if y > 0
    DEC byte_RAM_3 
    BEQ FindVine_J4 ;; skip if tilepos aint done else
    JSR MoveByXThenY
    STA byte_RAM_E6
    JMP FindVine_J0
+   JSR VineSetVelocity
    JMP FindVine_J5
FindVine_J4:
    JSR loc_BANK0_94DC
FindVine_J5:
    LDA #0
    STA byte_RAM_41B
    RTS

VineSetVelocity:
    LDA PlayerState_ClimbingAreaTransition
    STA PlayerState
    STA byte_RAM_4EA
    LDA SpriteAnimation_Climbing
    STA PlayerAnimationFrame
    LDA PlayerYLo
    BPL VineSetVelocity_Down
VineSetVelocity_Up:
    LDA #$F0
    STA PlayerYAccel
    RTS
VineSetVelocity_Down:
    LDA #$10
    STA PlayerYAccel
    RTS

VineGetStartPos:
    LDA RawLevelData
    ROL
    ROL
    AND #1
    CMP #1
    BEQ VineGetStartPos_Top
    LDA CurrentLevelPage
    CMP #0
    BEQ VineGetStartPos_Top
VineGetStartPos_Bottom:
    LDA #$E0
    STA PlayerYLo
    LDA #$10
    STA byte_RAM_3
    RTS
VineGetStartPos_Top:
    LDA #$20
    STA byte_RAM_3
    RTS

