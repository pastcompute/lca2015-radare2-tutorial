## Intro

* Our known arduino file is data/AnalogueInput.cpp.elf
* This was bulk-disassembled using the Arduino toolkit:

    ~/arduino-1.0.6/hardware/tools/avr/bin/avr-objdump -d AnalogInput.cpp.elf > AnalogInput.cpp.elf.objdump

* Our unknown Arduino program prints out SOS a lot, and some other text occasionally, and Happy New Year rarely, when it plays the tune
* We take a look at known arduino and use it to search for main by looking for similarities in our unknown arduino
* Arduino programs have a main() that calls setup() then calls loop() forever

## Conversion

Convert hex file to binary we can look at using radare2:

    objcopy -Isrec -Obinary arduino.cpp.hex arduino.bin
    radare2 -aavr arduino.bin

## Orientation

Using radare2

    pD 4          # Examine start of program. Arduino has a jump table note same addr
    s $j          # Seek to where the first instruction jumps to
    pd            # < now examine the code and compare to known objdump
                  # <-- we observe the boot code is more or less the same, and guess that main() is 0x7a8
    af
    afl

Rename the funcion @ 0x7a8

    afn main

Arduino has a setup() and a loop()
And we notice our known main() is again very similar

    |      .-> 0x000007c0    0e94a501     call fcn.0000034a
    |      . >    fcn.0000034a()
    |      |   0x000007c4    2097         sbiw r28, 0x00
    |      |   0x000007c6    e1f3         breq 0x7c0

Seek to what we think is loop and name it

    s fcn.0000034a
    afn loop

Observe four ldi r22..r25  00 00 01 f4, 00 00 03 20, this equates to numbers 500 and 800 which could be sleeps between characters in morse code?

Search for the strings we already know, where are they?

    / Happy
    /px SOS
    px 64 @ 0x1140

    - offset -   0 1  2 3  4 5  6 7  8 9  A B  C D  E F  0123456789ABCDEF
    0x00001140  4861 7070 7920 4e65 7720 5965 6172 2100  Happy New Year!.
    0x00001150  2140 2324 255e 262a 2829 3031 3233 3435  !@#$%^&*()012345
    0x00001160  3637 3839 0053 4f53 2100 0d00 0b00 bc02  6789.SOS!.......

We cant see 1165 in the disassembly anywhere, but perhaps these are offset somehow?

We notice these three with pairs of registers 0x100, 0x0125 0x0110 with a common function call to 0x1042

    |          0x000003b0    892b         or r24, r25
    |          0x000003b2    b9f5         brne fcn.00000422
    |          0x000003b4    80e6         ldi r24, 0x60
    |          0x000003b6    91e0         ldi r25, 0x01
    |          0x000003b8    60e0         ldi r22, 0x00
    |          0x000003ba    71e0         ldi r23, 0x01
    |          0x000003bc    0e942108     call 0x1042

    |      |   0x0000043a    80e6         ldi r24, 0x60
    |      |   0x0000043c    91e0         ldi r25, 0x01
    |      |   0x0000043e    65e2         ldi r22, 0x25
    |      |   0x00000440    71e0         ldi r23, 0x01
    |      |   ; JMP XREF from 0x00000438 (fcn.00000422)
    |      `-> 0x00000442    0e942108     call fcn.00001042

              0x00000430    80e6         ldi r24, 0x60
    |          0x00000432    91e0         ldi r25, 0x01
    |          0x00000434    60e1         ldi r22, 0x10
    |          0x00000436    71e0         ldi r23, 0x01
    |      ,=< 0x00000438    04c0         rjmp 0x442                        ; (fcn.00000422)


We observe similar spacing of 16-bit numbers referenced by the calls to 0x1042:

0x0100, 0x0110, 0x0125 have same spacing as our strings

    0x1040 + 0x0100 = 0x1140
    0x1040 + 0x0110 = 0x1150
    0x1040 + 0x0125 = 0x1165

We deduce that 0x1042 is equivalent to puts or printf, and that the code in the prelude tom main copying data to 0x0100 fro 0x1140 is setting up static data in RAM from the EEPROM.

So we take a punt and we want to overwrite 0x3b2 `brne` with NOP instructions

Note aradre2 doesnt yet support _assembly_ for AVR so we need to patch the hexfile directly

    oo+                  # reopen in read write
    wx @ 0x03b2 00 00

## Reverse conversion

This is not completely trivial, radare2 can only save binary and objcopy wont do what we need
The srecord package can do it for us.

    srec_cat patched.bin -binary -o patched.hex -intel -obs=16 -address-length=2  -disable=data-count 
    unix2dos patched.hex

To see the impact
:
    diff arduino.cpp.hex patched.hex

