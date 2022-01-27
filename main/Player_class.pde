class Player extends Component {
  int hpLevel = 100;

  float A = 0;
  float angle = 0;
  float planeSpd = 5; 

  PVector center; // Center er der hvor spilleren (flyet) er på skærmen
  PVector mouse;
  PVector bulletSpd; // Bullet speed

  // Holder alle skudene
  ArrayList<Bullet> allBullets = new ArrayList<Bullet>();

  Player() {
    center = new PVector(width/2, height/2);
    bulletSpd = new PVector();
    mouse = new PVector();

    createPlayer();
  }

  void display() {
    // Tegn alle skudene
    for (Bullet s : allBullets) {
      s.display();
    }

    // Ryk spillerns koordinatssystem ind så origo bliver til midten af vinduet
    pushMatrix();
      translate(width/2, height/2);
      rotate(angle + radians(90));
      image(compImg, 0, 0, 40, 60); // compImg -> Component class
    popMatrix();
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
    if (keyPressed && frameCount % 7 == 0) {
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

    Bullet b = new Bullet(center, bulletSpd);
    allBullets.add(b);
  }

  // Laver en spiller
  void createPlayer() {
    compImg = loadImage("player/player-u.png");
  }
}
