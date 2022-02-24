class Bullet extends Component { 
  Bullet(PVector loc_, PVector vel_, Player p) {
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
  
  // Sætter data fra vectore til pos og spd
  // Se i Player class i newBullet()
  void pSet(PVector loc_, PVector vel_) {
    pos.set(loc_);
    spd.set(vel_);
  }
  
  // Denne kigger på om et skud er 100 ude for skærmen
  boolean isOutOfBounce(Bullet b) {
    // skudes pos - width/2, for at få det til at virke som om skudet kommer fra midten i flyet.
    // >=, <= width/2 +100 for at sige 100 ude fra skærmen
    if ((b.pos.x - width/2) >= (width/2 + 100) ||
        (b.pos.x - width/2) <= -(width/2 + 100) ||
        (b.pos.y - height/2) >= (height/2 + 100) ||
        (b.pos.y - height/2) <= -(height/2 + 100)) 
    {
      return true;
    } else {
      return false;
    }
  }
}
