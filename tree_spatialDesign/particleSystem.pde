class ParticleSystem {
  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                   // An origin point for where particles are birthed

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Particle>();   // Initialize the arraylist
    origin = v.copy();                        // Store the origin point
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, int(random(6, 12)), random(100, 200), uppp));    // Add "num" amount of particles to the arraylist
    }
  }

  void run(int t) {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run(t);
      if (p.isDead()) {
        particles.remove(i);
      }
      if (p.isBlooming()) {    
        if (p.actualFlowerSizeP < p.myFlowerSizeP)  p.actualFlowerSizeP = map(p.fixPersonalLifespanP, p.lifespan*isBloomingPro, p.lifespan*1, p.myFlowerSizeP, 0);
      }
      if (p.isInBloom()) {

    }
      if (p.isInDecay()) {
        p.mycolorStrength = map(p.fixPersonalLifespanP, p.lifespan*isInBloomPro, p.lifespan*isInDecayPro, 255, 100);
      }
      if (p.isFalling()) {
        p.mycolorStrength -= 0.125;
        p.falling();
      }
    }
  }

  void addParticle() {
    Particle p;
    p = new Particle(origin, int(random(10, 100)), random(100, 300), uppp);


    /*} 
     else {
     p = new CrazyParticle(origin);
     }*/
    //particles.add(p);
  }



  boolean dead() {
    return particles.isEmpty();
  }
}
