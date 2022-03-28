* = $280

jmp start

logo 
;off:len(0h:30h)
  .ASCII "15 PUZZLE"
  .byte $8D
  .byte $8D
  .ASCII "W-UP"
  .byte $8D
  .ASCII "S-DOWN"
  .byte $8D
  .ASCII "A-LEFT"
  .byte $8D
  .ASCII "D-RIGHT"
  .byte $8D
  .byte $8D 
  .ASCII "CODE: DENIS PARYSHEV"
  .byte $8D
  .byte $8D
  .ASCII "PRESS ANY KEY"

horisontalline 
;off:len(4Ch:17h)
  .ASCII " +----+----+----+----+" 
  .byte $8D
verticalline 
;off:len(63h:3h)
  .ASCII " ! "

winmess 
;off:len(66h:Ah)
  .byte $8D
  .byte $8D
  .ASCII "YOU WIN!"

messlevel
;off:len(70h:7h)
  .ASCII "LEVEL: "

field
  .byte #$1
  .byte #$2
  .byte #$3
  .byte #$4
  .byte #$5
  .byte #$6
  .byte #$7
  .byte #$8
  .byte #$9
  .byte #$A
  .byte #$B
  .byte #$C
  .byte #$D
  .byte #$E
  .byte #$0
  .byte #$F

rnd 
  .byte #$E7
  .byte #$E8
  .byte #$E9
  .byte #$EA
  .byte #$EB
  .byte #$EC

index
  .byte #$0

level
  .byte #$41

freepos
  .byte #$0

printline
;y=start offset
;x=length
  lda logo,y
  jsr $FFEF  
  iny
  dex
  cpx #$0
  beq printdone
  jmp printline
printdone
rts

startscreen
  ldy #$0
  ldx #$4A
  jsr printline
rts

cls
  ldx #$0
  lda #$8D
clrnext
  jsr $FFEF 
  inx
  cpx #$18 
  beq donecls
  jmp clrnext
donecls
rts

getkey
  lda $D011        
  bpl getkey
  lda $D010
rts

printchar
  lda field,x
  ldx #$20
;null
  cmp #$0
  bne try1
  ldy #$20
  jmp found
;1
try1
  cmp #$1
  bne try2
  ldy #$31
  jmp found
;2
try2
  cmp #$2
  bne try3
  ldy #$32
  jmp found
;3
try3
  cmp #$3
  bne try4
  ldy #$33
  jmp found
;4
try4
  cmp #$4
  bne try5
  ldy #$34
  jmp found
;5
try5
  cmp #$5
  bne try6
  ldy #$35
  jmp found
;6
try6
  cmp #$6
  bne try7
  ldy #$36
  jmp found
;7
try7
  cmp #$7
  bne try8
  ldy #$37
  jmp found
;8
try8
  cmp #$8
  bne try9
  ldy #$38
  jmp found
;9
try9
  cmp #$9
  bne try10
  ldy #$39
  jmp found
;10
try10
  ldx #$31
  cmp #$A
  bne try11
  ldy #$30
  jmp found
;11
try11
  cmp #$B
  bne try12
  ldy #$31
  jmp found
;12
try12
  cmp #$C
  bne try13
  ldy #$32
  jmp found
;13
try13
  cmp #$D
  bne try14
  ldy #$33
  jmp found
;14
try14
  cmp #$E
  bne try15
  ldy #$34
  jmp found
;15
try15
  ldy #$35
found
  txa
  jsr $FFEF
  tya 
  jsr $FFEF
  jsr printV
rts

printH
  ldy #$4A
  ldx #$17
  jsr printline
rts

printV
  ldy #$61
  ldx #$3
  jsr printline
rts

print8D
  lda #$8D
  jsr $FFEF
rts 

showlevel
  ldy #$6E
  ldx #$7
  jsr printline
  lda level
  jsr $FFEF 
  jsr print8D
rts

print
  jsr showlevel
  ldx #$0
  stx index
printloop
  lda #$0
  cmp index
  beq prnH
  lda #$4
  cmp index
  beq prnH
  lda #$8
  cmp index
  beq prnH
  lda #$C
  cmp index
  beq prnH
  jmp noH
prnH
  jsr print8D
  jsr printH
  jsr printV
noH
  ldx index
  jsr printchar
  inc index
  lda #$10
  cmp index
  beq endprint
  jmp printloop
endprint
  jsr print8D
  jsr printH
rts

checkout
  ldx #$1
  stx index
  ldx #$0
checkloop
  lda field,x
  cmp index
  bne continue
  inc index
  inx
  cpx #$F
  bne checkloop
; win
  jsr cls
  jsr print
  inc level
  lda #$5A
  cmp level
  beq clrlevel
  jmp nextround
clrlevel
  lda #$1
  sta level
nextround
  ldy #$64
  ldx #$A
  jsr printline 
  jmp again
continue
rts

findfreepos
  ldx #$0
nextfp
  lda field,x
  cmp #$0
  beq fpfound
  inx
  jmp nextfp
fpfound
  stx freepos
rts

upKey
  ldx freepos
  cpx #$4
  beq tozero
  cpx #$0
  beq upnotpos
  dex
  cpx #$0
  beq upnotpos
  dex
  cpx #$0
  beq upnotpos
  dex
  cpx #$0
  beq upnotpos
  dex
  cpx #$0
  beq upnotpos  
  jmp movenums
tozero
  ldx #$0
movenums
  ldy freepos
  lda field,x
  sta field,y
  stx freepos
  lda #$0
  sta field,x
  ldy #$0
  rts
upnotpos
  ldy #$1
rts

downKey
  ldx freepos
  inx
  cpx #$10
  beq downnotpos
  inx
  cpx #$10
  beq downnotpos
  inx
  cpx #$10
  beq downnotpos
  inx
  cpx #$10
  beq downnotpos  
  ldy freepos
  lda field,x
  sta field,y
  stx freepos
  lda #$0
  sta field,x
  ldy #$0
  rts
downnotpos
  ldy #$1
rts

rightKey
  ldx freepos
  inx
  cpx #$4
  beq rightnotpos
  cpx #$8
  beq rightnotpos
  cpx #$C
  beq rightnotpos
  cpx #$10
  beq rightnotpos  
  ldy freepos
  lda field,x
  sta field,y
  stx freepos
  lda #$0
  sta field,x
  ldy #$0
  rts
rightnotpos
  ldy #$1
rts

leftKey
  ldx freepos
  cpx #$0
  beq leftnotpos 
  dex
  cpx #$3
  beq leftnotpos
  cpx #$7
  beq leftnotpos
  cpx #$B
  beq leftnotpos 
  ldy freepos
  lda field,x
  sta field,y
  stx freepos
  lda #$0
  sta field,x
  ldy #$0
  rts
leftnotpos
  ldy #$1
rts

getmove
  jsr getkey
  cmp #$D7
  bne notUp
  jsr upKey
  cpy #$1
  beq getmove
  rts
notUp
  cmp #$D3
  bne notDown
  jsr downKey
  cpy #$1
  beq getmove
  rts
notDown
  cmp #$C1
  bne notLeft
  jsr leftKey
  cpy #$1
  beq getmove
  rts
notLeft
  cmp #$C4
  bne notRight
  jsr rightKey
  cpy #$1
  beq getmove
  rts
notRight
jmp getmove

rand
; First book of KIM-1 172p
  cld
  sec
  lda rnd+1
  adc rnd+4
  adc rnd+5
  sta rnd
  ldy #4 
rpl
  lda rnd,y
  sta rnd+1,y
  dey
  bpl rpl
  ldy rnd
  iny
  tya
  and #$F
  ldy #$0
checkdouble
  cmp field,y
  beq rand
  iny
  cpy #$F
  beq checkdone  
  jmp checkdouble
checkdone
rts

init
  ldx #$0
  lda #$0
clearfield
  sta field,x
  inx
  cpx #$10
  beq fillfield
  jmp clearfield
fillfield
  ldx #$0
fillrand
  jsr rand
  sta field,x
  inx
  cpx #$10
  beq initdone  
  jmp fillrand
initdone
rts

start
  jsr cls
  jsr startscreen
again
  jsr getkey
  sta rnd+1
  jsr init 
mainloop
  jsr cls
  jsr print
  jsr findfreepos
  jsr getmove
  jsr checkout
jmp mainloop 
