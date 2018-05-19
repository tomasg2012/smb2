WorldChange:
    PHA
    LSR CurrentWorld
    LSR CurrentWorld
    LSR CurrentWorld
-   CLC
    SBC #$02
    BCC + 
    INC CurrentWorld
+   PLA
    RTS

