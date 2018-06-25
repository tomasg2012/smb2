

CustomCopyChar:
      LDA     PlayerInAir
      BEQ     + 
      RTS

+     DEC     CurrentCharacter
      LDA     #SoundEffect1_CherryGet
      STA     SoundEffect1Queue
      ;LDA     #SpriteAnimation_Pulling
      ;STA     PlayerAnimationFrame
CharSel:
      LDA     CurrentCharacter
      AND     #3
      STA     CurrentCharacter
      TAX
      LDY     StatOffsets,X
      LDX     #0

RptStats:
      LDA     MarioStats,Y
      STA     PickupSpeedAnimation,X
      INY
      INX
      CPX     #$17
      BCC     RptStats
GetCharBit:
      LDA     CurrentCharacter
      ASL     A
      ASL     A
      TAX
      LDY     #0
RptPalette:
      LDA     MarioPalette,X
      STA     unk_RAM_637,Y
      INX
      INY
      CPY     #4
      BNE     RptPalette
      RTS
