import processing.serial.*;

int candy_forceSensor = 255;
int elbow_bendSensor  = 255;
int neck_bendSensor   = 255;
int head_accSensor_x  = 255;
int head_accSensor_y  = 255;

void setup()
{
  size(400, 400);
  translate(20, 40);
  strokeWeight(4);
  scale(4);
  stroke(0, 0, 0);
  line(50, 35, 50, 50);
}

void draw()
{
  translate(20, 40);
  scale(4);
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
  stroke(elbow_bendSensor, 0, 0);
  // Left Arm (only arm with candy)
  line(50, 35, 25, 60);
  // Legs
  stroke(0,0,0);
  line(50, 50, 35, 70);
  line(50, 50, 65, 70);
}


