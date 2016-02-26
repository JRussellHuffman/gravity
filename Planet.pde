class Planet extends Body {
  
  Planet(PVector pos, float diameter, float mass){
    position = pos;
    this.diameter = diameter;
    this.mass = mass;
    allPlanets.add(this);
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

