import processing.serial.*;

final int NUMBER_OF_VALUES = 5;
// Initialize sensor values
int candy_forceSensor  = 255;
int tongue_forceSensor = 255;
int neck_bendSensor    = 255;
int body_accSensor_x   = 255;
int body_accSensor_y   = 255;

Serial serialPort;

void setup()
{
  // Print for debugging purposes
  println(Serial.list());
  // Change this to the right value!
  serialPort = new Serial(this, Serial.list()[1], 9600);
  // Only send out event when a line break is reached.
  serialPort.bufferUntil('\n');

  size(800, 800);

  // Basic background drawing
  translate(20, 40);
  strokeWeight(4);
  scale(8);
  stroke(0, 0, 0);
  line(50, 35, 50, 50);
}

void draw()
{
  translate(20, 40);
  scale(8);

  // Body Accelerometer
  fill(body_accSensor_x, body_accSensor_y, 0);
  // Body
  ellipse(50, 60, 50, 50);

  // Tongue Force sensor
  fill(tongue_forceSensor, 0, 0);
  // Neck and Head outlines show the neck bend sensor
  stroke(0, 0, neck_bendSensor);

  // Head
  ellipse(50, 10, 20, 20);
  // Neck
  line(50, 20, 50, 35);

  // Candy
  fill(0, candy_forceSensor, 0);
  stroke(0, candy_forceSensor, 0);
  ellipse(20, 20, 20, 20);
  line(20, 30, 25, 60);
  stroke(0, 0, 0);
}

void serialEvent(Serial myPort)
{
  // Read till line break and store in the variable
  String inString = myPort.readStringUntil('\n');
  // Convert the values into floats from strings after splitting the string
  float[] vals = float(split(inString, ","));
  // Make sure all the values are available
  if (vals.length >= NUMBER_OF_VALUES) {
    // Adjust these later to make them have a larger range
    tongue_forceSensor = int(map(vals[0], 0, 1023, 0, 255));
    candy_forceSensor  = int(map(vals[1], 0, 1023, 0, 255));
    neck_bendSensor    = int(map(vals[2], 500, 300, 0, 255));
    body_accSensor_x   = int(map(vals[3], 0, 1023, 0, 255));
    body_accSensor_y   = int(map(vals[4], 0, 1023, 0, 255));
  }
}
