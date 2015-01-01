## arduino.cpp.hex

This program is obsrved to perform the following:

* print SOS several times, 
* at the same time flash SOS in morse code on the LED
* occasionally prints !@#$%^&*()0123456789
* rarely prints "Happy New Year" and plays a tune
* At a rate of approx 1 per second loop()

The challenge: modify the program to play tune and print "Happy New Year" each loop instead of SOS

Hints:

* Arduino entry is a jump to main() prelude
* Arduino programs main() calls setup() then calls loop() forever
* bintutils program objcopy can convert hex to raw binary
* arduino prelude to main() copies static data from somewhere after the code, to 0x100

