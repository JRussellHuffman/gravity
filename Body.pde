abstract class Body {
  
// This is an abstract class, this class does not have a constructor but initializes the variables that will be used on other sub-classes like star.
  PVector position;
  PVector velocity;
  float diameter;
  float mass;
  
  abstract void Update();
  void Die(){
    allBodies.remove(this);
  }
  
  void BodyInit(){
    allBodies.add(this);
    position = new PVector();
    velocity = new PVector();
  }
  
  void Destroy(){
    toDestroy.add(this);
  }
  
  void applyForce(PVector force){
    
  }
  

  PVector gravityAt(PVector otherPos) {
    PVector direction = new PVector(position.x - otherPos.x, position.y - otherPos.y);
    direction.normalize();
    float d = dist(otherPos.x, otherPos.y, position.x, position.y);
    direction.mult(mass/(d*d));
    return direction;
  }
  
  PVector gridGrav(PVector otherPos) {
    PVector direction = new PVector(position.x - otherPos.x, position.y - otherPos.y);
    direction.normalize();
    float d = dist(otherPos.x, otherPos.y, position.x, position.y);
    direction.mult((mass*2)/(d*d)); //double mass to exaggerate effect on grid
    return direction;
  }
  
//this method does crazy things...  
//  PVector gridReturn(PVector otherPos) {
//    PVector direction = new PVector(position.x - otherPos.x, position.y - otherPos.y);
//    direction.normalize();
//    float d = dist(otherPos.x, otherPos.y, position.x, position.y);
//    direction.div(mass/(d*d));
//    return direction;
//  }
  
  abstract void draw();
}