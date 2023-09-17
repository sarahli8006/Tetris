//initialize vars in classes
Grid playarea;
Shape shape, onDeckShape;
Background bg;
PImage img; 

//set window size and create new from each class
void setup() {
  size(720,720);
  playarea = new Grid();
  shape = new Shape();
  shape.isActive = true; //shape is active when it is created
  onDeckShape = new Shape();
  bg = new Background();
  img = loadImage("HelloKittyImageforJava.png");
  img.resize(200, 200);
  textSize(40);
}

//calls methods
void draw() {
  background(247,197,223);
  bg.display();
  playarea.display();

  if (shape.gameOver(bg) == false){
    drawShapes();//
  }
  else{
    text("Game Over!", width/2 + 85, height - 500);
  }
  image(img, 500, 325);
  fill(0);
  textSize(20);
  text("Press left and right arrows to move left", width/2 + 20, height - 160);
  text("and right. Press up arrow to rotate.", width/2 + 20, height - 130);
  text("Press down arrow to move down. Press", width/2 + 20, height - 100);
  text("spacebar to fast drop. The game ends if", width/2 + 20, height - 70);
  text("a block is in the top two rows. Have fun!", width/2 + 20, height - 40);
  fill(255);
  textSize(40);
  text("Score: " + bg.score, width/2 + 105, height - 430);
}

//imprint shape
void drawShapes() {
  shape.display();
  onDeckShape.showOnDeck();

  if(shape.checkBack(bg)){
    shape.gravity();
  }
  else{
    shape.isActive = false;
  }
  
  if (!shape.isActive) {
    bg.writeShape(shape); //imprint block on bottom if block isn't active
    shape = onDeckShape;
    shape.isActive = true;
    onDeckShape = new Shape();
  }
}

//run while certain keys are pressed
void keyPressed() {
  if(keyCode == RIGHT) {
    shape.moveShape("RIGHT");
  }
  if(keyCode == LEFT) {
    shape.moveShape("LEFT");
  }
  if(keyCode == DOWN) {
    shape.moveShape("DOWN");
  }
  if (keyCode == ' ') {
    for (int i = 0; i<30; i++) {
      if (shape.checkBack(bg) == true&&shape.checkBorder("DOWN")== true) {
     shape.speedDrop(); 
      }
      else { 
    shape.isActive = false;
      }   
}
}
}

//run while certain keys are released
void keyReleased() {
  if (keyCode == UP) {
    shape.rotate();
    shape.rotate();
  }

  shape.turnCount++;
}
