// Input pin ports for each sensor
const int candy_forcePin = A0;
const int elbow_bendPin  = A1;
const int neck_bendPin   = A2;
const int head_acc_xPin  = A3;
const int head_acc_yPin  = A4;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  // Print each analog input
  Serial.print(analogRead(candy_forcePin));
  Serial.print(",");
  Serial.print(analogRead(elbow_bendPin));
  Serial.print(",");
  Serial.print(analogRead(neck_bendPin));
  Serial.print(",");
  Serial.print(analogRead(head_acc_xPin));
  Serial.print(",");
  // Remember to print a line break at the end
  Serial.println(analogRead(head_acc_yPin));
}
