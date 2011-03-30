// Input pin ports for each sensor
const int candy_forcePin  = A0;
const int tongue_forcePin = A1;
const int neck_bendPin    = A2;
const int body_acc_zPin   = A3;
const int body_acc_yPin   = A4;
const int body_acc_xPin   = A5;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  // Print each analog input
  Serial.print(analogRead(tongue_forcePin));
  Serial.print(",");
  Serial.print(analogRead(candy_forcePin));
  Serial.print(",");
  Serial.print(analogRead(neck_bendPin));
  Serial.print(",");
  Serial.print(analogRead(body_acc_xPin));
  Serial.print(",");
  // Remember to print a line break at the end
  Serial.println(analogRead(body_acc_yPin));
}
