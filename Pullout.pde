class Pullout {
  
  float xpos;
  float ypos;
  int increment;
  String text;
 
  Pullout(float xin, float yin, String textIn) {
    xpos = xin;
    ypos = yin;
    increment = 0;
    text = textIn;
  }
  
  void update(float newX, float newY){
    if (increment < 150){
      render(newX, newY);
    }
    addIncrement();
  }
  
  void addIncrement () {
    increment ++;
  }
  
  
  void render(float xpos, float ypos) {
    pushStyle();
    fill(0);
    stroke(255);
    strokeWeight(1);
    line(xpos, ypos, xpos+50, ypos-50);
    line(xpos+50, ypos-50, xpos+150, ypos-50);
    rect(xpos+70, ypos-150, 200, 100);
    fill(0);
    stroke(0);
    increment ++;
    textAlign(LEFT);
    fill(255);
    textSize(16); 
    text(text, xpos + 90, ypos - 120); 
    popStyle();
  }
  
}