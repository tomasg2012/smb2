	
TableDoorTypes:
	  .BYTE $09
      .BYTE $0A
      .BYTE $0B
      .BYTE $13
      .BYTE $14
      .BYTE $15
      .BYTE $1C
      .BYTE $1D
      .BYTE $1E
      .BYTE $FF

BugFixDoor: ;???
		PHA
        TXA
        PHA
        TYA
        PHA
        LDA (byte_RAM_5),Y
        LDY #0
FindOurDoor:
        CMP TableDoorTypes,Y
        BEQ SkipDoorRead
        INY
		CPY #9
        BNE FindOurDoor 
DefaultNoSkip:
        PLA
        TAY
        PLA
        TAX
        PLA
        CLC
        ADC $9
        BCC +
        ADC #$0F
        JMP ++
+       CMP #$F0
        BNE +++
        LDA #00
++      INC $540
+++     STA $09
        RTS
SkipDoorRead:
        PLA
        TAY
        PLA
        TAX
        PLA
        RTS
