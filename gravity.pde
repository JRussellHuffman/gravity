PImage planet;
PImage star;
PImage redGiant;
PImage orangeGiant;
PImage redDwarf;
PImage blueStar;
PImage nebulaBlue;
PImage nebulaPurple;
PImage nebulaYellow;
PImage neutronStar;
PImage whiteDwarf;
PImage planetaryNebulaeOne;
PImage planetaryNebulaeTwo;
PImage planetaryNebulaeThree;

PImage blackHole;
PImage rock;
short mass;
byte h;
PFont font;
boolean release = false;
boolean isOver = false;


Star sun; // Creation of the star object. INITIALIZING THE STAR OBJECT CALLED SUN
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


//boolean sketchFullScreen() {
//  return (true);
//}

void setup(){
  size(displayWidth, displayHeight);
  SetupStarMap();
  SetupCursorMap();
  SetupIdToType();
  tuioClient  = new TuioProcessing(this);

  frameRate(60);
  planet = loadImage("planet.png");
  star = loadImage("star.png");
  redGiant = loadImage("redGiant.png");
  orangeGiant = loadImage("orangeGiant.png");
  blueStar = loadImage("blueStar.png");
  redDwarf = loadImage("redDwarf.png");
  nebulaBlue = loadImage("nebulaBlue.png");
  nebulaYellow = loadImage("nebulaYellow.png");
  nebulaPurple = loadImage("nebulaPurple.png");
  blackHole = loadImage("blackHole.png");
  neutronStar = loadImage("neutronStar.png");
  whiteDwarf = loadImage("whiteDwarf.png");
  planetaryNebulaeOne = loadImage("planetaryNebulaeOne.png");
  planetaryNebulaeTwo = loadImage("planetaryNebulaeTwo.png");
  planetaryNebulaeThree = loadImage("planetaryNebulaeThree.png");
  allComets = new ArrayList();
  allBodies = new ArrayList();

  sun = new Star(new PVector(600, 350), star.width-15, 5000, star); // Star.width is the width of the star image!!!!!!!!!! DAMMIT!!!!!!

//  deathStar = new Star(new PVector(800, 350), star.width-15, 5000, star); //CREATING THE OBJECT IN THE SKETCH!!!
  rock = loadImage("rock.png");
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
    hotBod.Update(); // Updating all of the tuio objects on the sketch
  }
  
  for(Body damned : toDestroy){
    damned.Die(); // Destroys the objects that are set to destroy (Comets that go away from the sketch for instance)
  }
  
  //Popup(new PVector(mouseX, mouseY), new String[]{"DERP_1", "DERP_2", "DERP_3"});
  
  learningPanel();
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
    for(Body hotBod : allBodies){
      hotBod.Destroy(); 
    }
  } else if (key == 'l') {
    if (open == false){
      open = true;
    } else {
      open = false;
    }
  }
}