void keyPressed() {
  if (keyCode == ' ' ) {
    background(230, 250, 220, 250);
    stroke(90, 30, 40, 230);
    myTree = new tree(startPoint, drection);
    count = myTree.treeSize;
    frameCount = 0;
  }
}
