class Star extends Body {
  public TuioObject tobj;
  boolean isFake; //used for debugging without reactivision


  Star(TuioObject blurp) {
        BodyInit();

    //println("new star");
    diameter = star.width-15;
    mass = 4000;
    tobj = blurp;
    UpdateFromTuio(blurp);
    allStars.add(this);
    starMap.put(blurp.getSessionID(), this);
  }
  
  
  Star(PVector pos, int diameter, int mass) {
        BodyInit();

    isFake = true;
    this.position = pos;
    this.diameter = diameter;
    this.mass = mass;
    allStars.add(this);
  }

  void Update() {
    if(isFake){
      checkHover();
    }
    else{
    UpdateFromTuio(tobj);
    }
    
    draw();
  }

  void Die() {
    //println("star die");
    allStars.remove(this);
    if (!isFake)starMap.remove(tobj.getSessionID());

    super.Die();
  }

  void draw() {
    imageMode(CENTER);
        image(star, position.x, position.y); 

    
  }

  void UpdateFromTuio(TuioObject tuio) {
    position.x = tuio.getScreenX(width);
    position.y = tuio.getScreenY(height);
  }
  
  void checkHover () {
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
  
  
}

