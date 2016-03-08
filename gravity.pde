PImage planet;
PImage planetInvert;
PImage star;
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
  
void setup(){
  size(1280, 720);
  frameRate(60);
  planet = loadImage("earth.png");
  planetInvert = loadImage("earthInv.png");
  star = loadImage("star.png");
  allComets = new ArrayList();
  earth = new Planet(new PVector(600, 350), star.width-15, 5000); //15 pixel padding for sun "fuzzyness"
  mars = new Planet(new PVector(900, 400), star.width-15, 5000); //15 pixel padding for sun "fuzzyness"
  h = 80;
  font = createFont("Onyx", 12);
  
  initializeGrid();
  
}


void draw(){
  background(0);
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
  
  drawGrid ();
  
  earth.checkhover();
  mars.checkhover();
}

void mousePressed(){
 spawnComet(mouseX, mouseY);
  release = true;
}

void mouseReleased() {
  release = false;
}

void keyPressed(){
  if (key == 'c'){
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
