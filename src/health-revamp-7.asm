
GetMushroomState:
      BNE     GetMushroomState_AddOne
      LDA     CurrentLevel
      ASL
      TAX
      LDA     $7950,X
      STA     Mushroom1Pulled,Y
      JMP     GetMushroomState_End
GetMushroomState_AddOne:
      LDA     CurrentLevel
      ASL
      ADC     #1
      TAX
      LDA     $7950,X
      STA     Mushroom1Pulled,Y
GetMushroomState_End:
      RTS
