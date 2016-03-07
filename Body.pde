abstract class Body {
  PVector position;
  float diameter;
  float mass;

  abstract void Update();
  abstract void Die();

  void Destroy(){
    toDestroy.add(this);
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
    //if (d < 100) {
      direction.mult(mass/(d*d));
//    } else {
//      direction.set(0,0);
//    }
    //how to make it go back to original position?
    return direction;
  }
  
  abstract void draw();
}

