	
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

BugFixDoor: ;???
		PHA
        TXA
        PHA
        TYA
        PHA
StartChkDoor:
        DEY
        CPY #3
        BEQ DefaultNoSkip
        DEY
        DEY
        LDA (byte_RAM_5),Y
        CMP #$F5
        BEQ DefaultNoSkip
        INY
        LDA (byte_RAM_5),Y
        AND #$F0
        CMP #$F0
        BEQ DefaultNoSkip
        INY
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
        RTS
SkipDoorRead:
        PLA
        TAY
        PLA
        TAX
        PLA
        PLA
        PLA
        JMP     loc_BANK6_976F
