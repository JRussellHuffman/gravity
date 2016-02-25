PImage planet;
PImage planetInvert;
ArrayList Balls;
short mass;
byte h;
PFont font;
boolean release = false;
boolean isOver = false;

int centerX = 620;
int centerY = 320;

void setup(){
  size(1280, 720);
  frameRate(60);
  planet = loadImage("earth.png");
  planetInvert = loadImage("earthInv.png");
  Balls = new ArrayList();
  mass = 800;
  h = 80;
  font = createFont("Onyx", 12);
  //ps = new ParticleSystem(new PVector(width/2,50));
}

float distance(PVector pos, PVector pos2){
  return sqrt(((pos.x-pos2.x)*(pos.x-pos2.x))+((pos.y-pos2.y)*(pos.y-pos2.y)));
}

PVector grav(PVector pos){
  PVector direction = new PVector(centerX - pos.x, centerY - pos.y); // is this the center of gravity?
  direction.normalize();
  float d = distance(pos, new PVector(centerX, centerY));
  direction.mult(mass/(d*d));
  return direction;
}
  

class Ball{
  PVector position;
  PVector velocity;
  
  Ball(float px, float py, float vx, float vy){
    position = new PVector(px, py);
    velocity = new PVector(vx/100, vy/100);
  }
  void drawball(){
    PVector gravity = grav(position);
    PVector velgrav = velocity;
    velgrav.add(gravity);
    position.add(velgrav);
    ellipse(position.x, position.y, 10, 10);
  }
}

void draw(){
  background(0);
  spew(mouseX, mouseY);
  checkhover();
  movePlanet();
  text("w - initial height up", 10, 10);
  text("s - initial hieght down", 10, 20);
  text("c - clear", 10, 30);
  float ds = distance(new PVector(mouseX, mouseY), new PVector(width/2, height/2 - 60));
  stroke(200*(ds/250), 100, 50);
  strokeWeight(4);
  //line(width/2, height/2 - h, mouseX, mouseY);
  fill(150);
  noStroke();
  if (isOver) {
    image(planetInvert, centerX-60, centerY-60);
  } else {
    image(planet, centerX-60, centerY-60); 
  }
  for (int i = Balls.size()-1; i >= 0; i--){
    Ball a = (Ball) Balls.get(i);
    a.drawball();
    float dis = distance(a.position, new PVector(centerX, centerY));
    if ( dis < 60 || dis > 2000){
      Balls.remove(i);
    }
  }
}

void checkhover () {
  PVector position = new PVector(mouseX, mouseY);
  float dis = distance(position, new PVector(centerX, centerY));
    if ( dis < 60 || dis > 2000){
      isOver = true;
    } else {
      isOver = false;
    }
    
    if (release && isOver) {
      centerX = mouseX;
      centerY = mouseY;
    }
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
  //Balls.add(new Ball(width/2, height/2 - h, mouseX - width/2, mouseY - (height/2 - h)));
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
    for (int i = Balls.size()-1; i >= 0; i--){
      Balls.remove(i);
    }
  }
}

void spew(int x, int y) {
  
  if (release && !isOver) {
    
    int startX = x;
    int startY = y;
    
    int intensityX = 250;
    int intensityY = 250;
    
    float randomX = random(startX-5,startX+5);
    float randomY = random(startY-5,startY+5);
    float randomVelocityX = random (intensityX*-1, intensityX);
    float randomVelocityY = random (intensityY*-1, intensityY);
    
    Balls.add(new Ball(randomX, randomY, randomVelocityX, randomVelocityY));
  }
  
}