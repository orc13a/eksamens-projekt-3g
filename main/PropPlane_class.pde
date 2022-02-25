class PropPlane extends Enemy {
  PropPlane(Player player, Level level, PApplet mainApp) {
    super(player, level, loadImage("enemyPropPlane.png"), mainApp);
    moveSpd = new PVector(3, 3);
    collisionRadius = 55;
    scorePoints = 100;
    engineSound = new SoundFile(mainApp, "12812__jilliancallahan__generic-prop-idle.wav");
    engineSound.amp(0.1);
    //engineSound.loop();
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
      //circle(0, -100, 10);
    popMatrix();
  }
  
  void shoot() {
    //newBullet();
  }
  
  void movement() {
    
  }
}
