class Bullet extends Component {  
  Bullet(PVector loc_, PVector vel_) {
    pos = new PVector();
    spd = new PVector();
    
    pSet(loc_, vel_);
  }
  
  void display() {
    fill(0);
    ellipse(pos.x, pos.y, 5, 5);
  }
  
  void update() {
    pos.add(spd);
  }
  
  void pSet(PVector loc_, PVector vel_) {
    pos.set(loc_);
    spd.set(vel_);
  }
}
