# 15 puzzle game for Apple 1<br>
<br>
Thanks for coming here!<br>
This is a clone of the famous game 15 puzzlefor the Apple 1 computer.<br>
To run the program, use the command: <br>
280R<br>
<br>
Files content:<br>
15puzzle.asm - program source code. I wrote it in online assembler https://www.masswerk.at/6502/assembler.html<br>
15puzzle.bin - the binary code of the game, it can be used in emulators, and I also created a sound file from it, using the c2t utility https://github.com/datajerk/c2t<br>
15puzzle.hex - hexadecimal game codes, for oldschools, who like to manually enter dumps into the computer.<br>
15puzzle.wav - game sound file that can be downloaded to a computer via a tape adapter.<br>
To load wav file, use commands<br>
C100R<br>
280.5FFR<br>
280R<br>
<br>
To run, you can also use the online emulator https://www.scullinsteel.com/apple1/<br>
Just press Reset, copy the contents of the 15puzzle.hex file to the clipboard, paste it into the emulator screen, and after entering the code, type the commands<br>
280<br>
R<br>
<br>
Here is a little story about how I built this computer. Google translate will help translate into any language. https://habr.com/en/post/431270/<br>
**Have a good time!**
