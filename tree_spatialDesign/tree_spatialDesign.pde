import controlP5.*;
import java.util.*;
ControlP5 cp5;

tree myTree;
PVector startPoint;
PVector drection;
int count;
float uncertainX, uncertainY;
Slider thicknessSlider, uncertainXSlider, uncertainYSlider, windStrengthSlider;

int   sliderX         = 50;
int   sliderY         = 50;
int   sliderXSpace    = 15;
float myThickness     = 10;
float growthSpeed     = 50;
float thinning        = 0.3;
float spreadToSides   = 1;
float windStrength    = 0.0125;
float windAmplitude   = 0.0012;
float windAmplitudeVar= 0.00125;

void setup() 
{

  cp5 = new ControlP5(this);

  cp5.addSlider("myThickness").setColorCaptionLabel(50)
    .setPosition(sliderX, sliderY + sliderXSpace*0)
    .setSize(500, 10)
    .setRange(0, 30);

  cp5.addSlider("windStrength").setColorCaptionLabel(50)
    .setPosition(sliderX, sliderY + sliderXSpace*1)
    .setSize(500, 10)
    .setRange(0, 0.05);    

  cp5.addSlider("windAmplitude").setColorCaptionLabel(50)
    .setPosition(sliderX, sliderY + sliderXSpace*2)
    .setSize(500, 10)
    .setRange(0, 0.1);    
    
  cp5.addSlider("windAmplitudeVar").setColorCaptionLabel(50)
    .setPosition(sliderX, sliderY + sliderXSpace*3)
    .setSize(500, 10)
    .setRange(0, 0.1);  

  cp5.addSlider("growthSpeed").setColorCaptionLabel(50)
    .setPosition(sliderX, sliderY + sliderXSpace*4)
    .setSize(500, 10)
    .setRange(0, 50);  

  cp5.addSlider("thinning").setColorCaptionLabel(50)
    .setPosition(sliderX, sliderY + sliderXSpace*5)
    .setSize(500, 10)
    .setRange(0.1, 0.75);   

  cp5.addSlider("spreadToSides").setColorCaptionLabel(50)
    .setPosition(sliderX, sliderY + sliderXSpace*6)
    .setSize(500, 10)
    .setRange(0, 150); 

  size(800, 700);
  ellipseMode(CENTER);
  fill(40, 90, 220, 120);
  ellipseMode(CENTER);
  smooth();
  startPoint = new PVector(width/2, height);
  drection = new PVector(0, -height);
  myTree = new tree(startPoint, drection);
  count = myTree.treeSize;
}

void draw() 
{
  background(255, 100);
  myTree.swing();

  stroke(90, 30, 40, 230);
  int tempIndex;
  for (int i = 1; i < constrain(frameCount*growthSpeed, 0, count); i ++)
  {
    strokeWeight(myTree.twig[(int)myTree.map[i].x].thickness[(int)myTree.map[i].y]);
    line(myTree.twig[(int)myTree.map[i].x].location[(int)myTree.map[i].y - 1].x, myTree.twig[(int)myTree.map[i].x].location[(int)myTree.map[i].y - 1].y, 
      myTree.twig[(int)myTree.map[i].x].location[(int)myTree.map[i].y].x, myTree.twig[(int)myTree.map[i].x].location[(int)myTree.map[i].y].y);
  }

  noStroke(); 
  for (int i = 0; i < myTree.twig.length; i++)
  {
    int num = myTree.twig[i].location.length - 1;
    if (dist(myTree.twig[i].location[num].x, myTree.twig[i].location[num].y, mouseX, mouseY) < 300) {
      ellipse(myTree.twig[i].location[num].x, myTree.twig[i].location[num].y, 10, 10);
    }
    println(treeSize);
  }
}
