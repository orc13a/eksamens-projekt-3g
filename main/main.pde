TimePilotGame game;

void setup(){
  size(600, 800);
  
  game = new TimePilotGame();
}

void draw(){
  game.display();
}

void keyPressed() {
  game.key();
}
