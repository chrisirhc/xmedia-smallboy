import processing.serial.*;

final int NUMBER_OF_VALUES = 5;
// Initialize sensor values
int candy_forceSensor = 255;
int neck_bendSensor   = 255;
int head_accSensor_x  = 255;
int head_accSensor_y  = 255;

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
  // Head
  fill(head_accSensor_x, head_accSensor_y, 0);
  ellipse(50, 10, 20, 20);
  // Neck
  stroke(0, 0, neck_bendSensor);
  line(50, 20, 50, 35);
  // Candy
  stroke(0, candy_forceSensor, 0);
  fill(0, 0, 0);
  ellipse(20, 20, 20, 20);
  line(20, 30, 25, 60);
  stroke(0, 0, 0);
  // Left Arm (only arm with candy)
  line(50, 35, 25, 60);
  // Legs
  stroke(0,0,0);
  line(50, 50, 35, 70);
  line(50, 50, 65, 70);
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
    candy_forceSensor = int(map(vals[1], 0, 1023, 0, 255));
    neck_bendSensor   = int(map(vals[0], 500, 300, 0, 255));
    head_accSensor_x  = int(map(vals[3], 0, 1023, 0, 255));
    head_accSensor_y  = int(map(vals[4], 0, 1023, 0, 255));
  }
}
