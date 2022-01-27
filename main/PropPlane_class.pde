class PropPlane extends Enemy {
  PropPlane(Player player, Level level) {
    super(player, level, loadImage("enemyPropPlane.png"));
    moveSpd = new PVector(3, 3);
  }
  
  void display() {
    pushMatrix();
      translate(this.pos.x, this.pos.y);
      if (hasBeenFreezed = false) {
        rotate(angle + radians(90));
      } else {
        
      }
      image(compImg, 0, 0, 50, 50);
    popMatrix();
  }
  
  void shoot() {
    
  }
  
  void movement() {
    
  }
}
