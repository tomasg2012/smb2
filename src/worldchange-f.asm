WorldChangeF:
    PHA
    LSR CurrentWorld
    LSR CurrentWorld
    LSR CurrentWorld
-   CLC
    SBC #$02
    BCC + 
    INC CurrentWorld
    BNE -
+   PLA
    RTS

