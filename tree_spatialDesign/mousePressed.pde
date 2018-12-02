void keyPressed() {
  if (keyCode == ' ' ) {
    background(230, 250, 220, 250);
    stroke(90, 30, 40, 230);
    myTree = new tree(startPoint, drection, count);
    count = myTree.treeSize;
    frameCount = 0;
  }
}

void mousePressed() {
  //systems.add(new ParticleSystem(1, new PVector(mouseX, mouseY)));
}
