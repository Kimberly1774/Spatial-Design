import controlP5.*;
import java.util.*;
import toxi.color.*;
import toxi.math.*;
import processing.video.*;
float tolerance=0.33;

PImage img, workImg;
Capture cam;


ControlP5 cp5;

tree myTree, myTree1, myTree2;
tree[] myTrees = new tree[3];


PVector startPoint, startPoint1, startPoint2;
PVector drection;
int count, count1, count2;

float isBloomingPro = 0.8, isInBloomPro = 0.6, isInDecayPro = 0.4, isFalling = 0.2;

//controlP5
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
float windAmplitude   = 0.01;
float windAmplitudeVar= 0.005;

boolean wasIn = false;
//particleSystem
ArrayList<ParticleSystem> systems;
ArrayList<ParticleSystem> systems1;
ArrayList<ParticleSystem> systems2;
float fixPersonalLifespan;
float colorStrength;
float flowerSize = 0;
color[] myColors = {color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0) };

void setup() 
{

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    cam = new Capture(this, cameras[0]);
    cam.start();
  }

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

  /*  cp5.addSlider("windAmplitudeVar").setColorCaptionLabel(50)
   .setPosition(sliderX, sliderY + sliderXSpace*3)
   .setSize(500, 10)
   .setRange(0, 0.1);  
   */
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

  size(1500, 900);
  ellipseMode(CENTER);
  fill(40, 90, 220, 120);
  ellipseMode(CENTER);
  smooth();
  startPoint = new PVector(width/2, height);
  startPoint1 = new PVector(width*.2, height);
  startPoint2 = new PVector(width*.8, height);
  drection = new PVector(0, -height);

  myTree = new tree(startPoint, drection, count);
  myTree1 = new tree(startPoint1, drection, count1);
  myTree2 = new tree(startPoint2, drection, count2);


  myTrees[0] = myTree;
  myTrees[1] = myTree1;
  myTrees[2] = myTree2;  


  count = myTrees[0].treeSize;
  count1 = myTrees[1].treeSize;
  count2 = myTrees[2].treeSize;
  systems = new ArrayList<ParticleSystem>();
  systems1 = new ArrayList<ParticleSystem>();
  systems2 = new ArrayList<ParticleSystem>();
}
boolean mayIFlower = true;

void draw() 
{
  if (cam.available() == true && wasIn == false) {
    cam.read();
    image(cam, 0, 0, 500, 500);
    PImage partialSave = get(0, 0, 500, 500);
    partialSave.save("data/partialSave.jpg");
    getTheColors();
    wasIn = true;
  } 

  background(255, 100);

  myTrees[0].swing();
  myTrees[1].swing();
  myTrees[2].swing();


  stroke(90, 30, 40, 230);
  int tempIndex;

  myTrees[0].display();
  myTrees[1].display();
  myTrees[2].display();    
  myTrees[0].createParticleSystem(0);
  myTrees[1].createParticleSystem(1);
  myTrees[2].createParticleSystem(2);

  noStroke(); 

  //    for (int i = particles.size()-1; i >= 0; i--) {


  for (int i = systems.size()-1; i >= 0; i--) {
    ParticleSystem sys = systems.get(i);
    sys.run(0);
    if (sys.particles.size() == 0) {
      systems.remove(i);
    }
  }

  for (int i = systems1.size()-1; i >= 0; i--) {
    ParticleSystem sys1 = systems1.get(i);
    sys1.run(1);
    if (sys1.particles.size() == 0) {
      systems1.remove(i);
    }
  }  

  for (int i = systems2.size()-1; i >= 0; i--) {
    ParticleSystem sys2 = systems2.get(i);
    sys2.run(2);
    if (sys2.particles.size() == 0) {
      systems2.remove(i);
    }
  }
}

void mouseMoved() {
  mayIFlower = true;
}
