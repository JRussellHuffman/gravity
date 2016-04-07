public class Cursor { // What is this?
  PVector position;
  TuioCursor tuioCursor;
  int spawnTime;
  boolean dead;
  boolean isMouse = false;
  
  PVector velocity;
  float velocity_scale = .5;


  ArrayList<PVector> posHistory = new ArrayList<PVector>(); //used to calculate average position
  ArrayList<PVector> posDeltaHistory = new ArrayList<PVector>(); //used to calculate average position
  int lastUpdateTime = 0;

  int historyVals = 10; //how many position and rotation values to store for calculating a moving average (data smoothing)

  Cursor(TuioCursor c) {
    Init();
    setTuioCursor(c);
    UpdateFromTuio(c);
    cursorMap.put(c.getSessionID(), this);
  }

  Cursor() {
    Init();
    position = new PVector(mouseX, mouseY);
    isMouse = true;
  }

  void Init() {
    spawnTime = millis();
    dead = false;
    cursors.add(this);
    position = new PVector();
    velocity = new PVector(0,0);
        lastUpdateTime = millis();

  }

  void UpdateFromTuio(TuioCursor tuio) {
    position.x = tuio.getScreenX(width);
    position.y = tuio.getScreenY(height);
    // println(position);
  }


  void Update() {

    UpdatePosition();
            lastUpdateTime = millis();

  }

  void OnRemove() {
    cursors.remove(this);
    spawnComet(position, velocity);
    if (!isMouse)cursorMap.remove(tuioCursor.getSessionID());
  }

  void setTuioCursor(TuioCursor tCur) {
    tuioCursor = tCur;
    cursorMap.put(tCur.getSessionID(), this);
  }

  void spawnComet(PVector position, PVector velocity) {
   

    Comet newComet = new Comet(position, new PVector(velocity.x * velocity_scale, velocity.y * velocity_scale), 10);
  }

  public void UpdatePosition() {
    int deltaTime = millis()-lastUpdateTime;
    
   
    if (isMouse) {
      position.x = mouseX;
      position.y = mouseY;
    } else {
      position.x = tuioCursor.getScreenX(width);
      position.y = tuioCursor.getScreenY(height);
    }

    posHistory.add(new PVector(position.x, position.y));
    
    if(posHistory.size() > 1){
            posDeltaHistory.add(new PVector((posHistory.get(posHistory.size()-1)).x - (posHistory.get(posHistory.size()-2)).x,
                                            (posHistory.get(posHistory.size()-1)).y - (posHistory.get(posHistory.size()-2)).y));
                                            
    }
    else{
      //posDeltaHistory.add(new PVector(0,0));
    }

    while (posDeltaHistory.size() > historyVals) {
      posDeltaHistory.remove(0);
    }

    float avg_x = 0;
    float avg_y = 0;

    int numVals = min(posDeltaHistory.size (), historyVals);

      for (int i = 0; i < numVals; i++) {
      avg_x += posDeltaHistory.get(i).x;
      avg_y += posDeltaHistory.get(i).y;
    }

    velocity.x = avg_x/numVals;
    velocity.y = avg_y/numVals;  
  }

}