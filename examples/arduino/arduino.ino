#include "leotone.h"
 
int led = 13;
int buzzer = 11;
int DASH = 700;
int DOT = 200;

void setup() {
  pinMode(led, OUTPUT);     
  pinMode(buzzer, OUTPUT);
  Serial.begin(9600); 
}


void dash() {
  digitalWrite(led, HIGH);
  delay(DASH);
  digitalWrite(led, LOW);
  delay(DASH);
}

void dot() {
  digitalWrite(led, HIGH);
  delay(DOT);
  digitalWrite(led, LOW);
  delay(DOT);
}

int N=0;

// the loop routine runs over and over again forever:
void loop() {
  dash();
  dash();
  dash();
  delay(500);
  dot();
  dot();
  dot();
  delay(500);
  dash();
  dash();
  dash();
  delay(800);
  
  N++;

  if (N % 6 == 0) {
    Serial.println("Happy New Year!");
    Tone(buzzer, 440, 120); delay(100);
    Tone(buzzer, 660, 120); delay(100);
    Tone(buzzer, 880, 120); delay(100);
  } else  if (N % 3 == 0) {
    Serial.println("!@#$%^&*()0123456789");
  } else {
    Serial.println("SOS!");
  }
}
