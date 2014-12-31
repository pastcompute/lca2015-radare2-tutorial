#ifndef H_A
#define H_A

#include <Arduino.h> //needed for Serial.println

void Tone(int buzzer, int Freq, int duration){ 
  int uSdelay = 1000000 / (Freq * 2);
  unsigned long ending = millis() + duration;
  while(millis() < ending){
    digitalWrite(buzzer, HIGH);
    delayMicroseconds(uSdelay);
    digitalWrite(buzzer, LOW);
    delayMicroseconds(uSdelay);
  }
} 


#endif
