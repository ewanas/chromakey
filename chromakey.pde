int greenDistance = 200;

void key (PImage src, PImage result) {
  src.loadPixels ();
  result.loadPixels ();
  int pixelLocation;

  PVector currentPixel = new PVector (0, 0, 0);
  PVector greenPixel = new PVector (0, 255, 0);

  for (int originalY = 0; originalY < src.height; originalY++) {
    for (int originalX = 0; originalX < src.width; originalX++) {
      pixelLocation = originalX + originalY * src.width;

      color c = src.pixels [pixelLocation];
      currentPixel.x = red (c); currentPixel.y = green (c); currentPixel.z = blue (c);

      if (PVector.dist (greenPixel, currentPixel) <= greenDistance) {
        result.pixels [pixelLocation] = color (0, 0, 0, 0);
        // result.pixels [pixelLocation] = src.pixels [pixelLocation];
      } else {
        result.pixels [pixelLocation] = src.pixels [pixelLocation];
      }
    }
  }

  result.updatePixels ();
}

PImage src;
PImage result;

void keyPressed () {
  switch (key) {
    case '+':
      greenDistance++;
      key (src, result);
      break;
    case '-':
      greenDistance--;
      key (src, result);
      break;
    case 'n':
      imgIndex++;
      imgIndex %= images.length;
      setupImages ();
      break;
  }

  key (src, result);
}

String [] images;

void setup () {
  size (800, 600);
  imgIndex = 0;

  images = new File ("data/pics").list ();
  setupImages ();
}

int imgIndex;
void setupImages () {
  src = loadImage ("pics/" + images [imgIndex]);
  src.resize (300, 0);

  result = createImage (src.width, src.height, ARGB);
  key (src, result);

  src.updatePixels ();
  result.updatePixels ();

  textFont (loadFont ("fonts/archer.vlw"), 15);
}

void draw () {
  background (255, map (sin ((float)millis () / 200.0), -1, 1, 128, 255), map (cos ((float)millis () / 200.0), -1, 1, 128, 255));
  translate ((width - src.width * 2) / 2, (height - (src.height)) / 2);

  image (src, 0, 0, src.width, src.height);

  translate (src.width + 10, 0);

  image (result, 0, 0, result.width, result.height);

  translate (0, result.height + 10);

  fill (0);
  text ("Current distance is: " + greenDistance, 0, 0);

  text ("Currently viewing image: " + imgIndex, 0, 20);

  // greenDistance = ceil (map (sin ((float)millis () / 500.0), -1, 1, 100, 250));
  // key (src, result);
}
