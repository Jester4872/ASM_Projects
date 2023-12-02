.thumb

@called from 296CC
@r0=#0x0000002
@r1=#0x203A463
@r2=#0x0000024
@r3=#0x0000000
@r4=#0x203A470  defender struct
@r5=#0x0000000
@r6=#0x0000000
@r7=#0x203A3F0  attacker struct 
@r8=#0x0000000
@r9=#0x0000000
@r10=#0x0000000
@r11=#0x3007DFC
@r12=#0x000001D
@r13=#0x3007D30
@r14=#0x8000E0D
@r15=#0x80296C8

@the HP increase doesn't seem to be taking effect now that I have edited the attack increase

ldsb    r6,[r1,r6]
ldr     r0,[r7]                 @load the character's unit data in the ROM
ldrb    r0,[r0,#0x1D]           @load their Attack growth byte
b       CheckCharacter

CheckCharacter:
    ldr     r2,[r4,#0x0]        @load the character's unit data from RAM
    ldrb    r2,[r2,#0x4]        @load their character ID byte
    cmp     r2,#0x03            @check if it matches our chosen character ID
    beq     Aptitude_Attack     @branch and apply the growth boost if so
    ldr     r2,[r7,#0x0]        @otherwise check the other battle struct for the same data
    ldrb    r2,[r2,#0x4]
    cmp     r2,#0x03
    beq     Aptitude_Attack
    b       End                 @if the character we need is in neither, branch to the end

Aptitude_Attack:
    mov     r2,#0x96            @20% growth rate boost
    add     r0,r2               @add my boost to the Attack growth getter
    b       End

End:
    add     r0,#0x10            @vanilla opcode
    ldr     r2,=#0x80296D4|1    @hardcoded return address
    bx      r2                  @branch back to the vanilla function
