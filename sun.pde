class Star extends Body {
  TuioObject tobj;
  
  Star(TuioObject blurp){
    diameter = 400;
    mass = 4000;
    tobj = blurp;
    UpdateFromTuio(blurp);
        BodyInit();

  }
  
  void Update(){
    UpdateFromTuio(tobj);
    draw();
  }
  
  void Die(){
  super.Die();
  }
  void draw(){
    ellipseMode(CENTER);
    ellipse(position.x, position.y, diameter, diameter);
  }
  
  void UpdateFromTuio(TuioObject tuio){
    position = new PVector(tuio.getScreenX(width), tuio.getScreenY(height));
  }
}