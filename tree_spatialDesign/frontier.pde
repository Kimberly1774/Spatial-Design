class frontier 
{
  PVector location;
  PVector velocity;
  float thickness;
  boolean finished;
  
  frontier(PVector startPoint, PVector direction)
  {
    location = new PVector(startPoint.x, startPoint.y);
    velocity = new PVector(direction.x, direction.y);
    thickness = myThickness;
    finished = false;
  }
  
  frontier(frontier parent) 
  {
    location = parent.location.get();
    velocity = parent.velocity.get();
    thickness = parent.thickness;
    parent.thickness = thickness;
    finished = parent.finished;
  }
  
  void update(float factor) 
  {  
    if(  location.x > -10 
       & location.y > -10
       & location.x < width + 10
       & location.y < height + 10 
       & thickness > factor)  
    {
      velocity.normalize();
      PVector uncertain = new PVector(random(-spreadToSides, spreadToSides), random(-1, .1));
      uncertain.normalize();
      uncertain.mult(0.2);
      velocity.mult(0.8);
      velocity.add(uncertain);
      velocity.mult(random(10, 20));
      location.add(velocity);
    }
    
    else
    {
      finished = true;
    }
    
  } // void update()
}
