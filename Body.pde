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
  
  abstract void draw();
}

