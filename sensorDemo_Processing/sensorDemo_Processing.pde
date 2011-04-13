import processing.serial.*;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

final int NUMBER_OF_VALUES = 5;
// Initialize sensor values
int candy_forceSensor  = 360;
int tongue_forceSensor = 360;
int neck_bendSensor    = 360;
int body_accSensor_x   = 360;
int body_accSensor_y   = 360;
int body_accSensor_z   = 360;
int tongue_color = 255;
int candy_color = 255;
int neck_color  = 255;
int bodyx_color = 255;
int bodyy_color = 255;
int bodyz_color = 255;

Serial serialPort;

void setup()
{
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 32000);

  // Print for debugging purposes
  println(Serial.list());
  // Change this to the right value!
  serialPort = new Serial(this, Serial.list()[0], 9600);
  // Only send out event when a line break is reached.
  serialPort.bufferUntil('\n');

  size(800, 800);
  // size(800, 800);

  // Basic background drawing
  translate(20, 40);
  strokeWeight(4);
  scale(8);
  stroke(0, 0, 0);
  line(50, 35, 50, 50);
}

void draw()
{
  // Write to receive the updated data
  serialPort.write('B');
  translate(20, 40);
  scale(8);

  // Body Accelerometer
  fill(bodyx_color, bodyy_color, bodyz_color);
  // Body
  ellipse(50, 60, 50, 50);

  // Tongue Force sensor
  fill(tongue_color, 0, 0);
  // Neck and Head outlines show the neck bend sensor
  stroke(0, 0, neck_color);

  // Head
  ellipse(50, 10, 20, 20);
  // Neck
  line(50, 20, 50, 35);

  // Candy
  fill(0, candy_color, 0);
  stroke(0, candy_color, 0);
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
    OscMessage msg = new OscMessage("/boy");
    // Adjust these later to make them have a larger range
    tongue_forceSensor = int(map(vals[0], 0, 1023, 0, 360));
    candy_forceSensor  = int(map(vals[1], 0, 1023, 0, 360));
    neck_bendSensor    = int(map(vals[2], 250, 100, 0, 360));
    body_accSensor_x   = int(map(vals[3], 0, 1023, 0, 360));
    body_accSensor_y   = int(map(vals[4], 0, 1023, 0, 360));
    body_accSensor_z   = int(map(vals[5], 0, 1023, 0, 360));

    tongue_color  = int(map(vals[0], 0, 1023, 0, 255));
    candy_color   = int(map(vals[1], 0, 1023, 0, 255));
    neck_color    = int(map(vals[2], 250, 100, 0, 255));
    bodyx_color   = int(map(vals[3], 0, 1023, 0, 255));
    bodyy_color   = int(map(vals[4], 0, 1023, 0, 255));
    bodyz_color   = int(map(vals[5], 0, 1023, 0, 255));

    msg.add(tongue_forceSensor);
    msg.add(candy_forceSensor);
    msg.add(neck_bendSensor);
    msg.add(body_accSensor_x);
    msg.add(body_accSensor_y);
    msg.add(body_accSensor_z);
    oscP5.send(msg, myRemoteLocation);
  }
}
