class branch 
{
  PVector[] location;
  float[] thickness;
  int[][] baseIndex = new int[2][];
//  float[] baseDtheta;
  boolean isCandidate = false;
  float[] dTheta;
  
  branch(PVector loc, float thic, int id, int branchIndex)
  {
    location = new PVector[1];
    thickness = new float[1];
    location[0] = new PVector(loc.x, loc.y);
    thickness[0] = thic;
    
    baseIndex[0] = new int[1];
    baseIndex[1] = new int[1];
    baseIndex[0][0] = id;
    baseIndex[1][0] = branchIndex;
    
  }
  void branchRotate(int index, float theta, PVector reference)
  {
      location[index].sub(reference);
      rotate2D(location[index], theta);
      location[index].add(reference);
  }
  
  void rotate2D(PVector v, float theta)
  {
    float xTemp = v.x;
    v.x = v.x * cos(theta) - v.y * sin(theta);
    v.y = xTemp * sin(theta) + v.y * cos(theta);
  }
}
