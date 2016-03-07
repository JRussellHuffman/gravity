PImage planet;
PImage planetInvert;
short mass;
byte h;
PFont font;
boolean release = false;
boolean isOver = false;

Planet earth;
Planet mars;

float spring = 0.01;

ArrayList<Body> toDestroy = new ArrayList();

ArrayList<Comet> allComets = new ArrayList();
ArrayList<Planet> allPlanets = new ArrayList();
ArrayList<Grid> grid = new ArrayList();

//grid stuff
int gap = 30;
int dotSize = 1;
int roundedx;
int roundedy;
  
void setup(){
  size(1280, 720);
  frameRate(60);
  planet = loadImage("earth.png");
  planetInvert = loadImage("earthInv.png");
  allComets = new ArrayList();
  earth = new Planet(new PVector(600, 350), planet.width, 2000);
  //mars = new Planet(new PVector(900, 400), planet.width, 2000);
  h = 80;
  font = createFont("Onyx", 12);
  
  gridSize(gap);
  
  for (int i = 0; i < roundedx+1; i++) {
    for (int j = 0; j < roundedy+1; j++) {
      grid.add(new Grid(gap*i, gap*j, dotSize));
      grid.add(new Grid(gap*i + (gap/4), gap * j, dotSize));
      grid.add(new Grid(gap*i, gap * j + (gap/4), dotSize));
      grid.add(new Grid(gap*i + (gap/2), gap * j, dotSize));
      grid.add(new Grid(gap*i, gap * j + (gap/2), dotSize));
      grid.add(new Grid(gap*i + (gap/4*3), gap * j, dotSize));
      grid.add(new Grid(gap*i, gap * j + (gap/4*3), dotSize));
    }
  }
  
}


void draw(){
  background(0);
  //checkhover();
  //movePlanet();
  text("w - initial height up", 10, 10);
  text("s - initial hieght down", 10, 20);
  text("c - clear", 10, 30);
  float ds = dist(mouseX, mouseY, width/2, height/2 - 60);
  stroke(200*(ds/250), 100, 50);
  strokeWeight(4);
  //line(width/2, height/2 - h, mouseX, mouseY);
  fill(150);
  noStroke();
  
  for(Comet com : allComets){
    com.Update();
  }
  
  for(Planet plan : allPlanets){
    plan.Update();
  }
  
  for(Body damned : toDestroy){
    damned.Die();
  }
  
  for (Grid gridItem : grid) {
    gridItem.applyGravity();
    gridItem.display();
  }
  
  earth.checkhover();
  //mars.checkhover();
}

void movePlanet () {
  //if (release && isOver) {
  //  int formerX = centerX;
  //  int formerY = centerY;
  //  int newX;
  //  int newY;
  //  if (formerX > mouseX) {
  //    newX = formerX - mouseX;
  //  } else if (formerX < mouseX) {
  //    newX = mouseX - formerX;
  //  } else {
  //    newX = mouseX;
  //  }
  //  if (formerY > mouseY) {
  //    newY = formerY - mouseY;
  //  } else if (formerY < mouseY) {
  //    newY = mouseY - formerY;
  //  } else {
  //    newY = mouseY;
  //  } 
  //}
  
}

void mousePressed(){
 spawnComet(mouseX, mouseY);
  release = true;
}

void mouseReleased() {
  release = false;
}

void keyPressed(){
  if (key == 'w' && h < 121){
    h++;
  }else if (key == 's' && h > 61){
    h--;
  }else if (key == 'c'){
    allComets.clear();
  }
}

void spawnComet(int x, int y) {
    int startX = x;
    int startY = y;
    
    int intensityX = 5;
    int intensityY = 5;
    
    float randomX = random(startX-5,startX+5);
    float randomY = random(startY-5,startY+5);
    float randomVelocityX = random (intensityX*-1, intensityX);
    float randomVelocityY = random (intensityY*-1, intensityY);
    
    Comet newComet = new Comet(new PVector(randomX, randomY), new PVector(randomVelocityX, randomVelocityY), 5);
}

void gridSize(int e) {
  float xCount = width/e;
  roundedx = Math.round(xCount);
  float yCount = height/e;
  roundedy = Math.round(yCount);
}
