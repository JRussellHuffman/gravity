class Star extends Body {
  public TuioObject tobj;
  boolean isFake; //used for debugging without reactivision
  PImage image;
  PImage nebula;
  int lifeOfStar;
  float completeLifeOfStar;
  int explosionX;
  int explosionY;
  float neutronRotate;
  StarType type;
  int massDifference;

  Star(TuioObject tuioObj) {
    
    BodyInit();
    //println("new star");
    diameter = star.width-15;
    mass = 4000;
    lifeOfStar = 50;
    explosionX = 0;
    explosionY = 0;
    neutronRotate = 1;
    image = star;
    nebula = nebulaBlue;
    tobj = tuioObj;
    UpdateFromTuio(tuioObj);
    allStars.add(this);
    starMap.put(tuioObj.getSessionID(), this);
    CreateFromTuio(tuioObj);
  } 
  
  
  Star(PVector pos, int diameter, int mass, PImage image) {
    BodyInit();
    isFake = true;
    this.position = pos;
    this.diameter = diameter;
    this.mass = mass;
    this.image = image;
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
    println("star die");
    allStars.remove(this); // Gets rid of the gravity of the star but leaves the image (when used alone).
    if (!isFake)starMap.remove(tobj.getSessionID());
    super.Die(); // Destroys the image of the star but leaves the gravity (when used alone).
  }

  void draw() { // Add here all the details that go with the star
    
    textAlign(CENTER);
    text(lifeOfStar, position.x, position.y - 120);

    if(lifeOfStar >= 1){ // Normal star after being stamped
      
      lifeOfStar -= 1;
      
      completeLifeOfStar += 0.09;
      diameter = image.width + completeLifeOfStar;
      imageMode(CENTER);
      image(image, position.x, position.y, image.width + completeLifeOfStar + massDifference, image.height + completeLifeOfStar + massDifference);
      if(lifeOfStar <= 100) { // Need to fix with Blue stars
        image = redGiant;
        if(type == StarType.YELLOW){
          massDifference = 0;  
        } else if (type == StarType.RED_DWARF) {
          massDifference = -60;  
        } else if (type == StarType.BLUE) {
          massDifference = 100;  
        }
      }
            
    } else if(lifeOfStar == 0){ // Death of the star
      
//      this.Destroy(); This destroys the object.
      
      if(type == StarType.YELLOW){ // Supernova
      
        image(nebula, position.x, position.y, 5 + explosionX, 2 + explosionY);
        diameter = 0;
        mass = 0;
          if(explosionX < 700){
            explosionX += 10;
            explosionY += 5;
        }
        
    } else if(type == StarType.RED_DWARF){ // Neutron Star

//        ellipse(position.x + 10, position.y, 10, 10);

        pushMatrix(); 
        imageMode(CENTER);
        translate(position.x, position.y);
        rotate(radians(neutronRotate));
        image(neutronStar,0 ,0, 30, 30); 
        neutronRotate += 30;
        popMatrix();
        
        
        
        image = neutronStar;
        diameter = 30;
        mass = 3000; 
        
      } else if (type == StarType.BLUE){ // Black Hole
        image(blackHole, position.x, position.y, 100, 100);
        image = blackHole;
        diameter = 100;
        mass = 10000; 
      }
        
    }

  }

  void UpdateFromTuio(TuioObject tuio) {
    position.x = tuio.getScreenX(width);
    position.y = tuio.getScreenY(height);
  }
  
  void CreateFromTuio(TuioObject tuio){
    type = StarType.YELLOW;
    if(idToType.containsKey(tuio.getSymbolID())){
      type = idToType.get(tuio.getSymbolID()); 
      println(type);
    } else {
      println("idToType does not have key " + tuio.getSymbolID());
    }
    
    switch(type){ 
      
      case YELLOW:
        mass = 3000;
        diameter = star.width;
        image = star;
        nebula = nebulaBlue;
        lifeOfStar = 400;
      break;
      case RED_DWARF:
        mass = 6000;
        diameter = redDwarf.width;
        image = redDwarf;
        nebula = nebulaYellow;
        lifeOfStar = 600;
      break;
      case BLUE:
        mass = 9000;
        diameter = blueStar.width;
        image = blueStar;
        nebula = nebulaPurple;
        lifeOfStar = 200;
      break;
      default:
      break;
    
    }
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