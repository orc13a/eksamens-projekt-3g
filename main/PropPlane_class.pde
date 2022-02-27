class PropPlane extends Enemy {
  PropPlane(Player player, Level level, PApplet mainApp) {
    // Super er det samme som om at skrive forældreklassens konstruktør
    super(player, level, loadImage("enemyPropPlane.png"), mainApp);
    moveSpd = new PVector(3, 3);
    
    //denne fjendes specifikke "hitbox"
    collisionRadius = 55;
    
    //denne fjende types point for drab
    scorePoints = 100;
    engineSound = new SoundFile(mainApp, "12812__jilliancallahan__generic-prop-idle.wav");
    
    //styrer filens lydniveau
    engineSound.amp(0.1);
  }

  void display() {
    // Tegn alle skudene
    for (Bullet s : allBullets) {
      s.display();
    }
    
    //hver fjende har hvert sit koordinat system så deres billede rotere rundt om sig selv.
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    rotate(angle + radians(90));
    image(compImg, 0, 0, 50, 50);
    popMatrix();
  }
}
