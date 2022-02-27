class Player extends Component {
  PApplet mainAppObj;

  SoundFile jetEngine;
  SoundFile hitSound;
  SoundFile explosionSound;
  SoundFile playerDeadGameOverSound;

  int hp = 3;

  float A = 0;
  float angle = 0;
  float planeSpd = 5;
  float collisionRadius = 60;

  PVector center; // Center er der hvor spilleren (flyet) er på skærmen
  PVector mouse;
  PVector bulletSpd; // Bullet speed

  // Holder alle skudene
  ArrayList<Bullet> allBullets = new ArrayList<Bullet>();
  ArrayList<Bullet> allBulletsRemove = new ArrayList<Bullet>();

  Player(PApplet mainApp) {
    mainAppObj = mainApp;

    center = new PVector(width/2, height/2);
    bulletSpd = new PVector();
    mouse = new PVector();

    jetEngine = new SoundFile(mainAppObj, "324311__kgunessee__plane-engine-loop.wav");
    jetEngine.amp(0.3);
    // jetEngine.loop();

    hitSound = new SoundFile(mainAppObj, "517664__devern__8-bit-cannon.wav");

    explosionSound = new SoundFile(mainAppObj, "270325__littlerobotsoundfactory__hit-02.wav");

    playerDeadGameOverSound = new SoundFile(mainAppObj, "533034__evretro__8-bit-game-over-sound-tune.wav");

    createPlayer();
  }

  void display() {
    allBullets.removeAll(allBulletsRemove);

    // Ryk spillerns koordinatssystem ind så origo bliver til midten af vinduet
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle + radians(90));
    image(compImg, 0, 0, 40, 60); // compImg -> Component class
    popMatrix();

    // Tegn alle skudene
    for (Bullet s : allBullets) {
      s.display();
    }
  }

  void update() {  
    direction();

    // Update alle skudene
    for (Bullet s : allBullets) {
      s.update();
    }

    // Kigger hvert skud igennem og ser om det er ude for skærmen
    // Hvis ja, slet fra array'en
    for (int i = 0; i < allBullets.size(); i++) {
      Bullet b = allBullets.get(i);
      if (b.isOutOfBounce(b) == true) {
        allBullets.remove(i);
      }
    }
  }

  // Udregner vejen spilleren kigger med musen
  void direction() {
    mouse = new PVector(mouseX, mouseY);
    mouse.sub(center);
    angle = mouse.heading();
  }

  // Til at skyde
  void shoot() {
    if (keyPressed && frameCount % 9 == 0) {
      if (key == ' ') {
        newBullet();
      }
    }
  }

  // Opret nyt skud
  void newBullet() {    
    bulletSpd.set(mouseX, mouseY, 0);
    bulletSpd.sub(center); // trækker vektorne fra hinanden og skaber en vektor fra centrum af skærmen til musen.
    bulletSpd.setMag(18); // Sætter størrelsen af den vektoren og aka skudets hastighed

    Bullet b = new Bullet(center, bulletSpd, mainAppObj);
    allBullets.add(b);
    b.shoot();
  }

  // Laver en spiller
  void createPlayer() {
    compImg = loadImage("player/player-u.png");
  }

  void gotHit() {
    hitSound.play();
    hp--;

    if (hp <= 0) {
      jetEngine.stop();

      explosionSound.play();
      playerDeadGameOverSound.play();
    }
  }
}
