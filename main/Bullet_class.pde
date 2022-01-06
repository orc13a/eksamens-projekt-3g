class Bullet extends Component {  
  Bullet(PVector loc_, PVector vel_) {
    pos = new PVector();
    spd = new PVector();
    
    pSet(loc_, vel_);
  }
  
  void display() {
    fill(255);
    ellipse(pos.x, pos.y, 5, 5);
  }
  
  void update() {
    pos.add(spd);
  }
  
  // Sætter data fra vectore til pos og spd
  // Se i Player class i newBullet()
  void pSet(PVector loc_, PVector vel_) {
    pos.set(loc_);
    spd.set(vel_);
  }
}
