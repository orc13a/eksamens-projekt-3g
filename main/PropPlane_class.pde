class PropPlane extends Enemy {
  PropPlane(Player player, Level level) {
    super(player, level, loadImage("enemyPropPlane.png"));
    moveSpd = new PVector(3, 3);
    collisionRadius = 55;
  }
  
  void display() {
    // Tegn alle skudene
    for (Bullet s : allBullets) {
      s.display();
    }
    
    pushMatrix();
      translate(this.pos.x, this.pos.y);
      rotate(angle + radians(90));
      image(compImg, 0, 0, 50, 50);
    popMatrix();
  }
  
  void shoot() {
    newBullet();
  }
  
  void movement() {
    
  }
}
