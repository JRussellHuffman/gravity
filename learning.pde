//nottechnically a class because don't need it.

boolean open = false;
int panelWidth = 300;
int panelSpeed = 30;
int fromRight = 1920; //why doesn't just saying "width" work??
int imageWidth = 75;
String[] bodyText = new String[7];
PImage[] popImages = new PImage[7];


void populateBodyText() {
  bodyText[0] = "Black Hole: Black holes are really crazy space things. Like whoa....";
  bodyText[1] ="Red Giant: Red Giants are Giant and Red, duh";
  bodyText[2] ="Blue Star: These stars are kinda blue, actually very blue";
  bodyText[3] ="planet: We are currently on one. It's called earth. But this isn't about Earth";
  bodyText[4] ="Planetary Nebula: It's most gas from a star that exploded. It may be just gas, but I don't know...";
  bodyText[5] ="Asteroid: Asteroid are small rocks typically in orbit, but here some of them are just flying around";
  bodyText[6] ="Neutron Star: This star is super tiny, like the size of a city, but super dense and has a lot of gravity.";
}

void populateImages() {
  popImages[0] = blackHole;
  popImages[1] = redGiant;
  popImages[2] = blueStar;
  popImages[3] = planet;
  popImages[4] = planetaryNebulaeTwo;
  popImages[5] = rock;
  popImages[6] = neutronStar;
}

void learningPanel () {
  populateBodyText();
  populateImages();
  openClose();
  drawPanel();
  for (int i = 0; i <= 6; i = i+1) {
    eachBody(i, popImages[i], bodyText[i]);
  }
}

void drawPanel() {
  fill(255);
  rect(fromRight, 0, panelWidth, height);
  pushStyle();
  fill(0);
  strokeWeight(1);
  stroke(255);
  rect(fromRight, 0, panelWidth, height);
  popStyle();
}

void openClose() {
  if (open == false) {
    if (fromRight < width) {
      fromRight += panelSpeed;
    }
  } else {
    if (fromRight > width-panelWidth){
      fromRight -= panelSpeed;
    }
  }
}

void eachBody(int fromTop, PImage image, String text) {
  fromTop *= 120;
  imageMode(CORNER);
  image(image, fromRight + 10, fromTop + 20, imageWidth, imageWidth);
  imageMode(CENTER);
  fill(0);
  textAlign(LEFT);
  pushStyle();
  fill(255);
  text(text, fromRight + imageWidth + 20, fromTop + 30, panelWidth - imageWidth - 40, 100);
  popStyle();
}