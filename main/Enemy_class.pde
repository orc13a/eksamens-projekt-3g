class Enemy extends Component {
  Player currentPlayer;
  Level currentLevel;
  
  float angle = 0;
  
  PVector moveSpd = new PVector(0, 0);
  
  Enemy(Player player, Level level, PImage img) {
    currentPlayer = player;
    currentLevel = level;
    compImg = img;
    pos = new PVector(100, 100);
    vel = new PVector();
  }
  
  void display() {
    
  }
  
  void update() {
    direction();
  }
  
  void direction() {
    PVector p = new PVector(-currentLevel.pos.x, -currentLevel.pos.y);
    p.sub(pos);
    p.normalize();
    follow(p);
    angle = p.heading();
  }
  
  void follow(PVector target) {
  
  }
  
  void shoot() {
    
  }
  
  void movement() {
    
  }
}
