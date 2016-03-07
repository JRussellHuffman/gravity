class Planet extends Body {
  
  Planet(PVector pos, float diameter, float mass){
    position = pos;
    this.diameter = diameter;
    this.mass = mass;
    allPlanets.add(this);
  }
  
  void checkhover () {
    PVector mousePos = new PVector(mouseX, mouseY);
    float dis = dist(position.x, position.y, mousePos.x, mousePos.y);
      if ( dis < 60) {
        isOver = true;
      } else {
        isOver = false;
      }
      
      if (release && isOver) {
        position.x = mouseX;
        position.y = mouseY;
      }
      //println(isOver);
  }
  
  void Update(){
    this.draw();
  }
  
  void Die(){
    allPlanets.remove(this);
  }
  
  void draw(){
    imageMode(CENTER);
        image(planet, position.x, position.y); 

  }
}

