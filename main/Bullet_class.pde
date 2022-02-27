class Bullet extends Component {
  SoundFile bulletSound;

  Bullet(PVector loc_, PVector vel_, PApplet mainApp) {
    pos = new PVector();
    spd = new PVector();

    bulletSound = new SoundFile(mainApp, "353624__jofae__game-shot-light-gun.wav");
    bulletSound.amp(1);

    pSet(loc_, vel_);
  }

  void display() {
    fill(0);
    ellipse(pos.x, pos.y, 5, 5);
  }

  void update() {
    pos.add(spd);
  }

  // Sætter de værdier for position og hastighed fra spilleren.
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
  
  //Spiller lyd når man skyder
  void shoot() {
    bulletSound.play();
  }
}
