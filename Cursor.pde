public class Cursor {
  PVector position;
  TuioCursor tuioCursor;
  int spawnTime;
  boolean dead;
  boolean isMouse = false;

  Cursor(TuioCursor c) {
    Init();
    setTuioCursor(c);
    UpdateFromTuio(c);
    cursorMap.put(c.getSessionID(), this);
  }
  
  Cursor(){
    Init();
    position = new PVector(mouseX, mouseY);
    isMouse = true;
  }

  void Init() {
    spawnTime = millis();
    dead = false;
    cursors.add(this);
    position = new PVector();
  }

  void UpdateFromTuio(TuioCursor tuio) {
    position.x = tuio.getScreenX(width);
    position.y = tuio.getScreenY(height);
       // println(position);

  }
  
  
  void Update(){
    if(isMouse){
      position.x = mouseX;
      position.y = mouseY;
    }

  }

  void OnRemove() {
        cursors.remove(this);
    spawnComet((int)position.x, (int)position.y);
    if(!isMouse)cursorMap.remove(tuioCursor.getSessionID());
  }

  void setTuioCursor(TuioCursor tCur) {
    tuioCursor = tCur;
    cursorMap.put(tCur.getSessionID(), this);
  }
  
  void spawnComet(int x, int y) {
    int startX = x;
    int startY = y;
    
    int intensityX = 5;
    int intensityY = 5;
    
    float randomX = random(startX-5,startX+5);
    float randomY = random(startY-5,startY+5);
    float randomVelocityX = random (intensityX*-1, intensityX);
    float randomVelocityY = random (intensityY*-1, intensityY);
    
    Comet newComet = new Comet(new PVector(randomX, randomY), new PVector(randomVelocityX, randomVelocityY), 10);
  }
}

