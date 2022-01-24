class Enemy extends Component {
  Player currentPlayer;
  
  float angle = 0;
  
  Enemy(Player player, PImage img) {
    currentPlayer = currentPlayer;
    compImg = img;
    pos = new PVector(0, 0);
    vel = new PVector();
  }
  
  void display() {
    
  }
  
  void update() {
    direction();
  }
  
  void direction() {
    PVector pPos = currentPlayer.pos; 
    //mouse = new PVector(mouseX, mouseY);
    //mouse.sub(center);
    //angle = mouse.heading();
    
  }
  
  void shoot() {
    
  }
  
  void movement() {
    
  }
}
