==radare2 stuff==

~/arduino-1.0.6/hardware/tools/avr/bin/avr-objdump -d AnalogInput.cpp.elf > AnalogInput.cpp.elf.objdump

Take a look at known arduino and search for main in our unknown arduino

We know it outputs SOS  a lot


objcopy -Isrec -Obinary arduino.cpp.hex arduino.bin
radare2 -aavr arduino.bin


pD 4  # note same addr
s $j
pd   <-- compare to known objdump
<-- we observe the boot code is more or less the same, and guess that main() is 0x7a8
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


s fcn.0000034a
afn loop

Observe four ldi r22..r25  00 00 01 f4, 00 00 03 20

/s SOS

0x1140 Happy New Year
0x1150 !@#...
0x1165 SOS

Cant see 1165 but perhaps these are offset

we guess this first one prints 

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

0x0125, 0x0100 are also 0x25 apart
0x0110 same spacing

0x1150 - 0x110 = 0x1040

0x1040 + 0x0100 = 0x1150
0x1040 + 0x0110 = 0x1150
0x1040 + 0x0125 = 0x1165

So we take apunt and overwrite 0x3b2 with NOP instructions

Note aradre2 doesnt yet support _assembly_ for AVR so we need to patch the hexfile directly

