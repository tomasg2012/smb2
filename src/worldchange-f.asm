WorldChangeF:
    PHA ;; after this, reload character tables
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

