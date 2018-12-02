void keyPressed() {
  if (keyCode == ' ' ) {
    background(230, 250, 220, 250);
    stroke(90, 30, 40, 230);
    
    myTrees[0] = new tree(startPoint, drection, count);
    myTrees[1] = new tree(startPoint1, drection, count);
    myTrees[2] = new tree(startPoint2, drection, count);
    
    count = myTree.treeSize;
    frameCount = 0;
  }
}

void mousePressed() {
  //systems.add(new ParticleSystem(1, new PVector(mouseX, mouseY)));
}
