// Input pin ports for each sensor
const int body_acc_zPin   = A0;
const int body_acc_yPin   = A1;
const int body_acc_xPin   = A2;
const int neck_bendPin    = A3;
const int tongue_forcePin = A4;
const int candy_forcePin  = A5;

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
  Serial.print(analogRead(body_acc_yPin));
  Serial.print(",");
  // Remember to print a line break at the end
  Serial.println(analogRead(body_acc_zPin));
}
