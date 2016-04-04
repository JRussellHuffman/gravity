class Comet extends Body {

  Comet(PVector pos, PVector vel, float diameter) {
        BodyInit();

    position = pos;
    velocity = vel;
    this.diameter = diameter;
    allComets.add(this);
  }

  void Update() {
<<<<<<< HEAD
=======
        //println(position);

>>>>>>> origin/master
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
    
     for(Star star : allStars){
       if(dist(position.x, position.y, star.position.x, star.position.y) <= (diameter + star.diameter)/2){
         Destroy();
       }
     }
    
    for (Comet other : allComets) {
      if (other == this) continue;
      //check for collision
      if(dist(other.position.x, other.position.y, this.position.x, this.position.y) < (other.diameter/2 + this.diameter/2)){
            //float overlap = ( other.diameter/2 + this.diameter/2) - dist(other.position.x, other.position.y, this.position.x, this.position.y); 
            Comet larger = this;
            Comet smaller = other;
      if (diameter < other.diameter) {
          smaller = this;
          larger = other;
        }  
        
        float areaSwapped = PI * smaller.diameter * smaller.diameter - PI * (smaller.diameter - 1) * (smaller.diameter - 1); // area of outermost pixel ring;
        smaller.diameter --;
        
        float larger_area = PI * larger.diameter * larger.diameter;
        larger_area += areaSwapped;
        larger.diameter = sqrt(larger_area/PI);
        
             
             
              
      }
      
      
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
      }
      
    }
  }

  void move() {
    position.add(velocity);
  }

  void applyGravity() {
    for(Star star : allStars){
    PVector gravity = star.gravityAt(position);
    velocity.add(gravity);
    }
  }
  
  void tail() {
    float distanceFromStar = 0;
    PVector direction;
    for(Star star : allStars){
      distanceFromStar = dist(position.x, position.y, star.position.x, star.position.y);
       
      direction = new PVector(position.x - star.position.x, position.y - star.position.y);
      direction.normalize();      
      fill(185, 234, 255, 15);
      //draw several ellipse to show effect
      for (int i = 4; i < 12; i++) {
        ellipse(position.x+(direction.x*((i-5)*500/distanceFromStar)), position.y+(direction.y*((i-5)*500/distanceFromStar)), 5/distanceFromStar*i*100, 5/distanceFromStar*i*100);
      }
    }
    
  }

  void draw() {
    if (diameter > 15) {
      fill(220,(255/(diameter/10)),(240/(diameter/10)), 100);
      ellipse(position.x, position.y, diameter+5, diameter+5);
      image(planet, position.x, position.y, diameter, diameter);
    } else {
      tail();
      //fill(220,(255/(diameter/10)),(240/(diameter/10)));
      fill(220, 255,240);
      ellipse(position.x, position.y, diameter, diameter);
    }
  }
}
