TimePilotGame game;

void setup(){
  size(600, 800);
  smooth(8);
  
  game = new TimePilotGame();
}

void draw(){
  game.display();
}

void keyPressed() {
  game.key();
}
