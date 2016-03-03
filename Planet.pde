class Planet extends Body {
  
  Planet(PVector pos, float diameter, float mass){
    position = pos;
    this.diameter = diameter;
    this.mass = mass;
    allPlanets.add(this);
        BodyInit();

  }
  
  void Update(){
    this.draw();
  }
  
  void Die(){
    allPlanets.remove(this);
    super.Die();
  }
  
  void draw(){
    imageMode(CENTER);
        image(planet, position.x, position.y); 

  }
}