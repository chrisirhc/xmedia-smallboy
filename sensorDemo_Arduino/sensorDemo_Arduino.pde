#include "./SoftwareSerial.h"

// Input pin ports for each sensor
const int body_acc_zPin   = A0;
const int body_acc_yPin   = A1;
const int body_acc_xPin   = A2;
const int neck_bendPin    = A3;
const int tongue_forcePin = A4;
const int candy_forcePin  = A5;

// Setup SoftwareSerial for XBee component
#define rxPin 3
#define txPin 2
SoftwareSerial xbeeSerial(rxPin, txPin);

void setup()
{
  // Pin modes for digital pins (from SoftwareSerialExample)
  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);

  // Setup baud rates
  Serial.begin(9600);
  xbeeSerial.begin(9600);
}

char addressChar;
bool sendNow;

void loop()
{
  // Flag to indicate whether to send the sensor data
  sendNow = false;
  if (xbeeSerial.available() > 0) {
    while(xbeeSerial.available() > 0) {
      // Search for the B character
      addressChar = char(xbeeSerial.read());
      if (addressChar == 'B') {
        sendNow = true;
        // Break when it's found
        break;
      }
    }
  }
  if (!sendNow && Serial.available() > 0) {
    while(Serial.available() > 0) {
      // Search for the B character
      addressChar = char(Serial.read());
      if (addressChar == 'B') {
        sendNow = true;
        // Break when it's found
        break;
      }
    }
  }
    if (sendNow) {
      // Print each analog input
      Serial.print(analogRead(tongue_forcePin));
      Serial.print(",");
      Serial.print(analogRead(candy_forcePin));
      Serial.print(",");
      Serial.print(analogRead(neck_bendPin));
      Serial.print(",");
      Serial.print(analogRead(body_acc_xPin));
      Serial.print(",");
      Serial.print(analogRead(body_acc_yPin));
      Serial.print(",");
      // Remember to print a line break at the end
      Serial.println(analogRead(body_acc_zPin));

      // Same thing for the XBee
      xbeeSerial.print(analogRead(tongue_forcePin));
      xbeeSerial.print(",");
      xbeeSerial.print(analogRead(candy_forcePin));
      xbeeSerial.print(",");
      xbeeSerial.print(analogRead(neck_bendPin));
      xbeeSerial.print(",");
      xbeeSerial.print(analogRead(body_acc_xPin));
      xbeeSerial.print(",");
      xbeeSerial.print(analogRead(body_acc_yPin));
      xbeeSerial.print(",");
      xbeeSerial.println(analogRead(body_acc_zPin));
    }
}
