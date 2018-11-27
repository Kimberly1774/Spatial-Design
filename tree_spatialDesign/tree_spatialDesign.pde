tree myTree;
PVector startPoint;
PVector drection;
int count;

void setup() 
{
  size(800, 600);
  background(230, 250, 220, 250);
  ellipseMode(CENTER);
  stroke(80, 0, 50, 200);
  fill(250, 80, 120, 120);
  ellipseMode(CENTER);
  smooth();
  startPoint = new PVector(width/2, height);
  drection = new PVector(0, -height);
  myTree = new tree(startPoint, drection);
  count = myTree.treeSize;
}

void draw() 
{
  background(230, 250, 220, 250);
  myTree.swing();

  stroke(80, 0, 50, 200);
  int tempIndex;
  for (int i = 1; i < constrain(frameCount*5, 0, count); i ++)
  {
    strokeWeight(myTree.twig[(int)myTree.map[i].x].thickness[(int)myTree.map[i].y]);
    line(myTree.twig[(int)myTree.map[i].x].location[(int)myTree.map[i].y - 1].x, myTree.twig[(int)myTree.map[i].x].location[(int)myTree.map[i].y - 1].y, 
      myTree.twig[(int)myTree.map[i].x].location[(int)myTree.map[i].y].x, myTree.twig[(int)myTree.map[i].x].location[(int)myTree.map[i].y].y);
  }

  noStroke(); 
  for (int i = 0; i < myTree.twig.length; i++)
  {
    int num = myTree.twig[i].location.length - 1;
    if (dist(myTree.twig[i].location[num].x, myTree.twig[i].location[num].y, mouseX, mouseY) < 100) {
      ellipse(myTree.twig[i].location[num].x, myTree.twig[i].location[num].y, 12, 12);
    }
  }
}
