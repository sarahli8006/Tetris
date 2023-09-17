class Shape {
  //tetris shapes
  private int[][] square = {{0,0}, {1,0}, {0,1}, {1,1}};
  private int[][] line = {{0,0}, {1,0}, {2,0}, {3,0}};
  private int[][] tshape = {{0,1}, {1,0}, {1,1}, {1,2}};
  private int[][] leftL = {{0,0}, {1,0}, {2,0}, {2,1}};
  private int[][] rightL = {{0,0}, {1,0}, {2,0}, {0,1}};
  private int[][] actualS = {{0,1}, {1,1}, {1,0}, {2,0}};
  private int[][] inverseS = {{0,0}, {1,0}, {1,1}, {2,1}};
  
  private int[][] selectShape, startShape;
  private int r, g, b, turnCount;
  private boolean isActive;
  private float w; //width

  private int counter; //gravity counter

  private int theX, theY;
  //creating different shapes
  public Shape(){
    w = width/24;
    int randNum = (int) random(7);
    switch(randNum){
      case 0: //pastel purple
        selectShape = square;
        r = 222;
        g = 167;
        b = 241;
        break;
      case 1: //pastel blue
        selectShape = line;
        r = 153;
        g = 204;
        b = 255;
        break;
      case 2: //pastel yellow
        selectShape = tshape;
        r = 255;
        g = 255;
        b = 153;
        break;
      case 3: //white
        selectShape = leftL;
        r = 255;
        g = 255;
        b = 255;
        break;
      case 4: //sketchy pastel blue
        selectShape = rightL;
        r = 169;
        g = 255;
        b = 255;
        break;
      case 5: //darker pastel purple
        selectShape = actualS;
        r = 204;
        g = 128;
        b = 255;
        break;
       case 6: //pastel green
        selectShape = inverseS;
        r = 193;
        g = 225;
        b = 193;
        break;
    }

    startShape = selectShape; 
  }
  //show shapes
  public void display(){
    fill(r,g,b);
    for(int i = 0; i < 4; i++){
      rect(selectShape[i][0] * w, selectShape[i][1] * w, w, w);
    }
  }
  //tells player what the next block is
  public void showOnDeck(){
    fill(247,197,223);
    rect(width/2, 0, width/2, height);
    text("Next Block:", width/2 + 90, 150);
    fill(255,255,255);
    textSize(40);
    text("Next Block:", width/2 + 90, 100);
    fill(r,g,b);
    for(int i = 0; i < 4; i++){
      rect(selectShape[i][0] * w + width/2 + 140, selectShape[i][1] * w + 150, w, w);
    }
  }
  //the block keeps dropping at a set speed
  public void gravity(){
    if(counter%30 == 0){//number represents fall speed
      moveShape("DOWN");
    }
    counter++;
  }
  //limit the block so it can't move outside of the left and right borders
  public boolean checkBorder (String direction){
    switch(direction){
      case "RIGHT":
        for(int i = 0; i < 4; i++) {
          if(selectShape[i][0] > 10){
            return false;
          }
        }
        break;
      case "LEFT":
        for(int i = 0; i < 4; i++) {
          if(selectShape[i][0] < 1){
            return false;
          }
        }
        break;
      case "DOWN":
        for(int i = 0; i < 4; i++) {
          if(selectShape[i][1] > 22){
            isActive = false; //shape is not active once it reaches bottom
            return false;
          }
        }
        break;
    }
    return true;
  }
  //moves the shaoe left, right, and down based on user interaction
  public void moveShape (String direction) {

    if(checkBorder(direction) == true){
      
    if (direction == "RIGHT") {
      for(int i = 0; i < 4; i++) {
        selectShape[i][0]++;
      }
    }
    if (direction == "LEFT") {
      for(int i = 0; i < 4; i++) {
        selectShape[i][0]--;
      }
    }
    if (direction == "DOWN") {
      for(int i = 0; i < 4; i++) {
        selectShape[i][1]++;
      }
    }
      
    }  
  }

  public void shiftDown(){
    for(int i = 0; i < 4; i++){
        selectShape[i][1]--;
    }
  }

 
 public void speedDrop() {
   for (int i = 0; i < 4; i++) {
     selectShape[i][1]++;
     }
 }

  public boolean gameOver(Background b) {
    for (int i = 0; i < 3; i++) {
      for (int ii = 0; ii < 12; ii++){
        for (int iii = 0; iii < 2; iii++){
          if (b.colors[ii][iii][i] != 0){
            return true;
          }
        }
      }
    }
    return false;
  }
  
  
  public boolean checkBack(Background b){

    for(int i = 0; i < 4; i++){
      theX = selectShape[i][0];
      theY = selectShape[i][1];
      if(theX >= 0 && theX < 12 && theY >= 0 && theY < 23){
        for(int ii = 0; ii < 3; ii++){
          if (b.colors[theX][theY + 1][ii] != 0){
            return false;
          }
        }
      }
    }
      return true;
  }
  
  public void rotate() {
    if (selectShape != square){
    int[][] rotated = new int[4][2];
    if (turnCount%4 == 0) {
    for (int i=0; i<4; i++) {
      rotated[i][0] = startShape[i][1] - selectShape[1][0];
      rotated[i][1] = -startShape[i][0] - selectShape[1][1];
    }
    }
    if (turnCount%4 == 1) {
    for (int i=0; i<4; i++) {
      rotated[i][0] = -startShape[i][0] - selectShape[1][0];
      rotated[i][1] = -startShape[i][1] - selectShape[1][1];
    }
    }
    if (turnCount%4 == 2) {
    for (int i=0; i<4; i++) {
      rotated[i][0] = -startShape[i][1] - selectShape[1][0];
      rotated[i][1] = startShape[i][0] - selectShape[1][1];
    }
    }
    if (turnCount%4 == 3) {
    for (int i=0; i<4; i++) {
      rotated[i][0] = startShape[i][0] - selectShape[1][0];
      rotated[i][1] = startShape[i][1] - selectShape[1][1];
    }
    }
    selectShape = rotated; 
    }
  }
}
