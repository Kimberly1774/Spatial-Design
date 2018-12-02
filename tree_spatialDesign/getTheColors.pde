color[] colors = {10};
color[] uppp = new color[1000];
int countMe = 0;

color[] getTheColors() {

  img=loadImage("partialSave.jpg");
  workImg=loadImage("partialSave.jpg");
  // create a color histogram of image, using only 10% of its pixels and the given tolerance
  Histogram hist=Histogram.newFromARGBArray(img.pixels, img.pixels.length/10, tolerance, true);
  // now snap the color of each pixel to the closest color of the histogram palette
  TColor col=TColor.BLACK.copy();
  for (int i=0; i<img.pixels.length; i++) {
    col.setARGB(img.pixels[i]);
    TColor closest=col;
    float minD=1;
    for (HistEntry e : hist) {
      float d=col.distanceToRGB(e.getColor());
      if (d<minD) {
        minD=d;
        closest=e.getColor();
      }
    }
    workImg.pixels[i]=closest.toARGB();
  }
  workImg.updatePixels();
  // display original and posterized images
  image(img, 0, 0);
  image(workImg, workImg.width, 0);
  // display power curve distribution of histogram colors as bar chart
  float x=0;
  int w=width/hist.getEntries().size();




  for (Iterator<HistEntry> i=hist.iterator(); i.hasNext() && x<width; ) {
    HistEntry e=i.next();


    if (x == w*countMe) {
      uppp[countMe] = color(e.getColor().toARGB());
    }


    for (int k = 0; k < colors.length; k++) {
      colors[k] = e.getColor().toARGB();
    }

    fill(e.getColor().toARGB());
    float h=e.getFrequency()*height;
    rect(x, height-h, w, h);
    x+=w;
    countMe++;
  }
  saveFrame("data/wholeSave.jpg");

  return colors;
}
