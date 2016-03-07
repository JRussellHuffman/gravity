class Grid {
  
  int diameter;
  PVector gravInfluence;
  PVector springBack;
 
  Grid(float xin, float yin, int din) {
    diameter = din;
    gravInfluence = new PVector(xin, yin);
    springBack = new PVector(xin, yin);
  }
  
//  PVector gravityPushBack(PVector otherPos) {
//    PVector direction = new PVector(gravInfluence.x - otherPos.x, gravInfluence.y - otherPos.y);
//    direction.normalize();
//    float d = dist(otherPos.x, otherPos.y, gravInfluence.x, gravInfluence.y);
//    direction.mult(mass/(d*d));
//    return direction;
//  }
 
  void applyGravity() {
    for(Planet planet : allPlanets){
      PVector gravity = planet.gridGrav(gravInfluence);

        gravInfluence.add(gravity);

      if(dist(gravInfluence.x, gravInfluence.y, planet.position.x, planet.position.y) <= (diameter + planet.diameter)/2){
        gravInfluence.x = springBack.x;
        gravInfluence.y = springBack.y;
      } 
    }
  }
  
  void keepShape () {
    
  }
  
  void display() {
    fill(255);
    ellipse(gravInfluence.x, gravInfluence.y, diameter, diameter);
  }
  
}

