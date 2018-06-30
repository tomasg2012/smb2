MoveByXLo:
    LDA PlayerXLo
    SEC
    SBC #$10
    STA PlayerXLo
    RTS

MoveByYLo:
    LDA PlayerYLo
    SEC
    SBC #$10
    STA PlayerYLo
    RTS

EnterDefault_Custom:
    LDA #0
    STA PlayerState ;instead of setting sprite to default, set player state to default
    STA byte_RAM_41B ; restore state?
    LDA #$E0
    STA PlayerYLo
    JSR sub_BANK0_9561 ; put player in air
    LSR A
    LSR A
    LSR A
    LSR A
    STA byte_RAM_E5 ; get proper y tile for "check tile"
    LDA #$D0 
    STA PlayerYLo ; wait why do we set it up a bit, we just stored the y tile,
    STA byte_RAM_E6 ; this might be for X, but seems to still work
    LDA CurrentLevelPage
    STA byte_RAM_E8 ; level page for "check tile"
    LDA #$DF
    STA byte_RAM_3 ; counter
    JSR sub_BANK1_BA4E ;; maybe above has to do with check first tile before anything else
    JMP ++
EnterDefault_Reap: ; loop stuff
    DEC byte_RAM_3
    BEQ +
    JSR MoveByYThenX
-   JSR sub_BANK1_BA4E ;; check tile
++  LDY byte_RAM_E7
    LDA (byte_RAM_1),Y
    CMP #$40
    BEQ EnterDefault_Reap
    DEC byte_RAM_3
    BEQ +
    JSR MoveByYThenX
    JSR sub_BANK1_BA4E
    LDY byte_RAM_E7
    LDA (byte_RAM_1),Y
    CMP #$40
    BNE -
+   JSR MoveByYLo
    RTS 

EnterDoor_Custom: ; This is called first for every transition
    LDA #PlayerState_Normal 
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
    JSR MoveByYLo
    STA byte_RAM_E6
    RTS
+   LDA PlayerYLo
    STA byte_RAM_E6
    RTS

MoveByYThenX:
    LDA byte_RAM_E6
    SEC
    SBC #$10
    AND #$F0
    STA PlayerYLo
    STA byte_RAM_E6
    LDA PlayerYLo
    CMP #$00
    BNE +
    SEC
    SBC #$20
    AND #$F0
    STA PlayerYLo
    STA byte_RAM_E6
    JSR MoveByXLo
    CMP #$F0
    BNE ++
    JSR MoveByXLo
++  LSR
    LSR
    LSR
    LSR
    STA byte_RAM_E5
    RTS
+   LDA PlayerXLo
    LSR
    LSR
    LSR
    LSR
    STA byte_RAM_E5
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
    LDY #9
-   CMP byte_BANK0_8B2B-1,Y ;; compare to vines
    BEQ + ;; if tru end
    DEY
    BNE - ;; else loop if y > 0
    DEC byte_RAM_3 
    BEQ FindVine_J4 ;; skip if tilepos aint done else
    JSR MoveByXThenY
    JMP FindVine_J0
+   JSR VineSetVelocity
    JMP FindVine_J5
FindVine_J4:
    JMP loc_BANK0_94DC ;; go to default behavior
FindVine_J5:
    LDA #0
    STA byte_RAM_41B
    RTS

VineSetVelocity:
    LDA #PlayerState_ClimbingAreaTransition
    STA PlayerState
    STA byte_RAM_4EA
    LDA #SpriteAnimation_Climbing
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

