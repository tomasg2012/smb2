# Super Mario Bros. 2, The Disassembly
A disassembly of Super Mario Bros. 2, in progress.

This is built for use with ASM6 (https://github.com/freem/asm6f/).
For your convinience, a binary of that is included.

## Building
To build, run

    build

This will generate a few files:

* `smb2.nes`, your Rev A-based ROM
* `comparison.txt`, a byte comparison against the original ROM
* `smb2.lst`, the assembler listing
* `assembler.txt` and `assembler-err.txt`, logs from the assembler
* a bunch of assorted other files

This branch will build a revision A ROM. Revision A fixed a particularly nasty bug involving the split Fryguy enemy that could cause the player to get softlocked until they used the suicide cheat.

## Assembly
The "source" lives in the `asm` directory:

* `prg-x.asm` are the program banks.
* `defs.asm` are some definitions.
* `ram.asm` are definitions and labels for RAM addresses.

The `tools/Super Mario Bros. 2 (USA) 2.asm` file is an auto-generated disassembly
from a certain disassembly tool. If you modify it (for some reason),
you can use `php tools/asm.php` to re-split the disassembly and clean it up.
Note that doing so will *lose all changes* in the split disassembly!

In this branch, this will *remove the PRG A features*. So don't do that.

## Whoops
If you goof up and something breaks, `tools/offsetcompare.php` may help;
it uses labels like `unk_byte_ABCD` to check if the code has gotten
shifted or offset in some way (so you can go fix it).
