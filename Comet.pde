class Comet extends Body {
  PVector velocity;

  Comet(PVector pos, PVector vel, float diameter) {
    position = pos;
    velocity = vel;
    this.diameter = diameter;
    allComets.add(this);
    BodyInit();
  }

  void Update() {
    collide();
    applyGravity();
    move();
    this.draw();
  }
  
  void Die(){
    allComets.remove(this);
    super.Die();

  }

  void collide() {
    
    for(Planet planet : allPlanets){
      if(dist(position.x, position.y, planet.position.x, planet.position.y) <= (diameter + planet.diameter)/2){
        Destroy();
      }
    }
    
    for (Comet other : allComets) {
      if (other == this) continue;
      float dx = other.position.x - this.position.x;
      float dy = other.position.y - this.position.y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = other.diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = position.x + cos(angle) * minDist;
        float targetY = position.y + sin(angle) * minDist;
        float ax = (targetX - other.position.x) * spring;
        float ay = (targetY - other.position.y) * spring;
        velocity.x -= ax;
        velocity.y -= ay;
        other.velocity.x += ax;
        other.velocity.y += ay;
        if (diameter >= other.diameter) {
          other.diameter -=1;
          diameter +=1;
        } else {
          diameter -=1;
          other.diameter +=1;
        }
      }
    }
  }

  void move() {
    position.add(velocity);
  }

  void applyGravity() {
    for(Planet planet : allPlanets){
    PVector gravity = planet.gravityAt(position);
    velocity.add(gravity);
    }
  }

  void draw() {
    fill(255, 200);
    ellipse(position.x, position.y, diameter, diameter);
  }
}