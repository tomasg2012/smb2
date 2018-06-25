	
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
        DEY
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
		JMP ResumeDoor
SkipDoorRead:
        PLA
        TAY
        PLA
        TAX
        PLA
		JMP SkipDoorReadMain

