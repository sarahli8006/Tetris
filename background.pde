public class Background {
  private int[][][] colors; 
  private int r, g, b;
  private int w;
  private int theX, theY;
  private int score;
  
  public Background(){
    colors = new int[12][24][3];
    w = width/24;
  }

  public void display() {
    for (int i = 0; i < 12; i++) {
      for (int j = 0; j < 24; j++) {
        r = colors[i][j][0];
        g = colors[i][j][1];
        b = colors[i][j][2];
        fill(r, g, b);
        rect(i*w, j*w, w, w);
        }
      }
    for (int i = 0; i < 24; i++) {
      if (checkLine(i)) {
        removeLine(i);
      }
    }
  }

  public void writeShape(Shape thing){
    for (int i = 0; i < 4; i++){
      theX = thing.selectShape[i][0];
      theY = thing.selectShape[i][1];//x and y coordinate of each block
//change each block's color to its assigned color
      colors[theX][theY][0] = thing.r;
      colors[theX][theY][1] = thing.g;
      colors[theX][theY][2] = thing.b;
    }
  }

  public boolean checkLine(int row){
    for(int j = 0; j < 12; j++){
      if(colors[j][row][0] == 0 && colors[j][row][1] == 0 && colors [j][row][2] == 0){
        return false;
      }   
    }
    return true;  
  }
  
  public void removeLine(int row){
      for(int i = 0; i < 12 ; i++){
        colors[i][row][0]=0;
        colors[i][row][1]=0;
        colors[i][row][2]=0;
      }
      dropLinesAbove(row);
  }
  
  public void dropLinesAbove(int row){
    score++;
     for(int r = row; r >= 1; r--){
       for(int j = 0; j < 12; j++){
         colors[j][r][0] = colors[j][r-1][0];
         colors[j][r][1] = colors[j][r-1][1];
         colors[j][r][2] = colors[j][r-1][2];
       }
     }
  }
}
