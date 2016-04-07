PImage planet;
PImage star;
PImage blackHole;
PImage redDwarf;
PImage rock;
short mass;
byte h;
PFont font;
boolean release = false;
boolean isOver = false;

Star sun;
Star secondSun;

float spring = 0.01;

ArrayList<Body> toDestroy = new ArrayList();

ArrayList<Comet> allComets = new ArrayList();
ArrayList<Planet> allPlanets = new ArrayList();
ArrayList<Star> allStars = new ArrayList();
ArrayList<Body> allBodies = new ArrayList();
ArrayList<Grid> grid = new ArrayList();
ArrayList<Cursor> cursors = new ArrayList();
ArrayList<Pullout> allPullout = new ArrayList();

Cursor mouseCursor;


  
void setup(){
  //size(displayWidth, displayHeight);
  size(1280, 720);
  SetupStarMap();
  SetupCursorMap();
  SetupIdToType();
  tuioClient  = new TuioProcessing(this);

  frameRate(60);
  planet = loadImage("planet.png");
  star = loadImage("star.png");
  redDwarf = loadImage("redDwarf.png");
  blackHole = loadImage("blackHole.png");
  rock = loadImage("rock.png");
  allComets = new ArrayList();
  allBodies = new ArrayList();
  //sun = new Star(redDwarf, new PVector(800, 550), 100, 5000); //15 pixel padding for sun "fuzzyness"
  secondSun = new Star(star, new PVector(300, 150), 150, 5000); //15 pixel padding for sun "fuzzyness"
  h = 80;
  font = createFont("Onyx", 12);
  
  initializeGrid();
  
}


void draw(){
  TuioUpdate();
  background(0);
  float ds = dist(mouseX, mouseY, width/2, height/2 - 60);
  drawGrid ();
  stroke(200*(ds/250), 100, 50);
  strokeWeight(4);
  //line(width/2, height/2 - h, mouseX, mouseY);
  fill(150);
  noStroke();
  
//  rect(tuioX,tuioY,100,100);
 for(Cursor cur : cursors){
    cur.Update();
  }
  
  for(Body hotBod : allBodies){
    hotBod.Update();
  }
  
  for(Body damned : toDestroy){
    damned.Die();
  }
  
  //Popup(new PVector(mouseX, mouseY), new String[]{"DERP_1", "DERP_2", "DERP_3"});
  
  
}

void mousePressed(){
  mouseCursor = new Cursor();
  release = true;
}

void mouseReleased() {
  mouseCursor.OnRemove();
  release = false;
  
}

void keyPressed(){
  if (key == 'c'){
    allComets.clear();
  }
}



