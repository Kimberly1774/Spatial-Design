class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  int myFlowerSizeP;
  float actualFlowerSizeP = 0;
  float fixPersonalLifespanP;
  float mycolorStrength;
  color[] theColor;

  Particle(PVector l, int myFlowerSize, float fixPersonalLifespan, color[] uppp) {
    acceleration = new PVector(random(0.1, 0.05), random(0.2, 0.3));
    velocity = new PVector(0, 0);
    position = l.copy();
    lifespan = fixPersonalLifespan;
    myFlowerSizeP = myFlowerSize;
    fixPersonalLifespanP = fixPersonalLifespan;
    mycolorStrength = random(200, 255);
    theColor = uppp;
  }

  void run() {
    ageing();
    display();
  }

  void falling() {
    velocity.add(acceleration);
    if (position.y < height - 10) {
      position.add(velocity);
    }
  }

  void ageing() {
    fixPersonalLifespanP -= 0.25;
  }

  void display() {    
    fill(theColor[int(map(position.y, 0, height, 0, 10))], mycolorStrength);
    for (int i = 0; i < myTree.twig.length; i++) {
      int num = myTree.twig[i].location.length - 1;
      if (dist(position.x, position.y, myTree.twig[i].location[num].x, myTree.twig[i].location[num].y) < 1) {
        position.x = myTree.twig[i].location[num].x;
        position.y = myTree.twig[i].location[num].y;
      }
    }
    ellipse(position.x, position.y, actualFlowerSizeP, actualFlowerSizeP);
  }
  boolean isBlooming() {
    return (fixPersonalLifespanP > lifespan*isBloomingPro && fixPersonalLifespanP < lifespan*1);
  }

  boolean isInBloom() {    
    return (fixPersonalLifespanP > lifespan*isInBloomPro && fixPersonalLifespanP < lifespan*isBloomingPro);
  }

  boolean isInDecay() {    
    return (fixPersonalLifespanP > lifespan*isInDecayPro && fixPersonalLifespanP < lifespan*isInBloomPro);
  }

  boolean isFalling() {
    return (fixPersonalLifespanP < lifespan*isInDecayPro);
  }

  boolean isDead() {
    return (fixPersonalLifespanP < 0.0);
  }
}
