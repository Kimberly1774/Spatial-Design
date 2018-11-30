class tree 
{
  PVector[] map;
  branch[] twig;
  int treeSize;
  float BranchLengthFactor = thinning;
  float BranchLocationFactor = 0.3;

  float dt = windStrength;
  float time = 0;
  float[] dtheta;

  int candNum = 3;
  int[] candidateIndex = new int[candNum];
  float[] amplitude = new float[candNum];
  float[] phaseFactor = new float[candNum];
  float freq;
  float period;

  tree(PVector startPoint, PVector direction)
  { 
    int id = 0;
    boolean growth = false;

    frontier[] fr = new frontier[1];
    fr[id] = new frontier(startPoint, direction);

    twig = new branch[1];    
    twig[id] = new branch(fr[id].location, fr[id].thickness, id, 0);

    map = new PVector[1];
    map[0] = new PVector(id, twig[id].location.length - 1);

    while (!growth)
    {
      int growthSum = 0;
      for (id = 0; id < fr.length; id++)
      {
        fr[id].update(BranchLocationFactor);
        if (!fr[id].finished)
        {
          twig[id].location = (PVector[]) append(twig[id].location, new PVector(fr[id].location.x, fr[id].location.y)); 
          twig[id].thickness = (float[]) append(twig[id].thickness, fr[id].thickness);
          map = (PVector[]) append(map, new PVector(id, twig[id].location.length - 1));

          if (random(0, 1) < BranchLengthFactor)  // control length of one branch  
          { 

            fr[id].thickness *= 0.65;
            twig[id].thickness[twig[id].thickness.length - 1] = fr[id].thickness;
            if ( fr[id].thickness > BranchLocationFactor)  // control the number of the locations on all branches, i.e., treeSize.
            {
              fr = (frontier[]) append(fr, new frontier(fr[id]));           
              twig = (branch[]) append(twig, new branch(fr[id].location, fr[id].thickness, id, twig[id].location.length - 1));
              int _id = id;
              if (_id != 0)  for (int _i = 0; _i < 2; _i++)  twig[twig.length - 1].baseIndex[_i] = concat(twig[twig.length - 1].baseIndex[_i], twig[_id].baseIndex[_i]);
            }
          } // if (random(0, 1) < 0.2)
        } else  growthSum += 1;
      }
      if (growthSum == fr.length) 
      {
        dtheta = new float[twig.length];
        treeSize = map.length;
        growth = true;
      }
    } // while(!growth)

    ArrayList<Float> _candList = new ArrayList<Float>();
    float[] _candfloat = new float[twig.length];
    for (int i = 0; i < twig.length; i++)
    {
      _candfloat[i] = (float)twig[i].location.length;
      _candList.add(_candfloat[i]);
    }
    candidateIndex[0] = 0;
    twig[0].isCandidate = true;
    twig[0].dTheta = new float[twig[0].location.length];
    _candfloat[0] = -1.0;
    _candList.set(0, -1.0);
    for (int i = 1; i < candNum; i++) 
    {
      float _temp = max(_candfloat);
      candidateIndex[i] = _candList.indexOf(_temp);
      twig[candidateIndex[i]].isCandidate = true;
      twig[candidateIndex[i]].dTheta = new float[twig[candidateIndex[i]].location.length];
      _candfloat[candidateIndex[i]] = -1.0;
      _candList.set(candidateIndex[i], -1.0);
    }
    //    println(candidateIndex);
    
    amplitude[0] = random(windAmplitude*windAmplitudeVar*-0.5, windAmplitude+windAmplitudeVar*0.5);
    phaseFactor[0] = random(0.6, 1.2);
    freq = random(0.5, 0.8);
    period = 1 / freq;
    for (int i = 1; i < candNum; i++)
    {
      amplitude[i] = amplitude[i-1] * random(0.9, 1.4);
      phaseFactor[i] = phaseFactor[i-1] * random(0.9, 1.4);
    }
  }

  void swing()
  {
    for (int i = 0; i < candNum; i++)
    {
      int _num = twig[candidateIndex[i]].location.length;
      for (int j = 0; j < _num; j++) twig[candidateIndex[i]].dTheta[j] = amplitude[i] * dt * TWO_PI * freq * cos(TWO_PI * freq * time - phaseFactor[i] * PI * (float)j / (float)_num);
    }
    for (int id = 0; id < twig.length; id++)
    {
      if (twig[id].isCandidate)  for (int _id = 1; _id < twig[id].location.length; _id++)  twig[id].branchRotate(_id, twig[id].dTheta[_id], twig[id].location[0]);

      for (int j = 0; j < twig[id].baseIndex[0].length; j++)
      {
        if (!twig[twig[id].baseIndex[0][j]].isCandidate | id == 0) continue;
        else
        {
          for (int k = (id == 0) ? 1 : 0; k < twig[id].location.length; k++)
          {
            twig[id].branchRotate(k, twig[twig[id].baseIndex[0][j]].dTheta[twig[id].baseIndex[1][j]], twig[twig[id].baseIndex[0][j]].location[0]);
          }
        }
      }
    } // for(int id = 0; id < twig.length; id++)
    time += dt;
    if (time >= period) time -= period;
  }
}
