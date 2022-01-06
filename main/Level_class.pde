class Level extends Component {
  PImage skyImage;
  
  int level = 1;
  
  ArrayList<Enemy> allEnemys = new ArrayList<Enemy>();

  Level() {
    skyImage = loadImage("skyRepeat.jpeg");
    pos = new PVector(0, 0);
    addEnemy();
  }

  void display() {
    pushMatrix();
      translate(pos.x, pos.y);
      createBackground();
      for (Enemy e : allEnemys) {
        e.display();
      }
    popMatrix();
  }
  
  void update(Player p) {
    updateWorld(p);
  }
  
  // Laver baggrunds himmlen
  void createBackground() {
    pushMatrix();
      // "Billdet" som bliver lavet af for-loops'ene er 61.200x61.200
      // Derfor rykker vi ind i midten af "billedet"
      translate(-30000,-30000);
      // x-aksen
      for (int x = 1; x <= 100; x++) {
        // y-aksen
        for (int y = 1; y <= 100; y++) {
          image(skyImage, x * skyImage.width, y * skyImage.height);
        }
      }
    popMatrix();
  }
  
  // Opdatere verdens placering alt efter spilleren
  void updateWorld(Player p) {
    PVector a = new PVector(mouseX, mouseY); // Vector fra 0,0 til musen
    a.sub(p.center); // trækker vektorne fra hinanden og skaber en vektor fra centrum af skærmen til musen.
    a.normalize(); // Laver a vektoren om til en enhedsvektor med længden 1
    
    // Så bruger vi vektoren i spillerens koordinatssystem
    pushMatrix();
      translate(p.center.x, p.center.y);
      // Flytter verden modsat af hvor spilleren flyver hen
      pos.x -= a.x * p.planeSpd;
      pos.y -= a.y * p.planeSpd;
    popMatrix();
  }
  
  void addEnemy() {
    Enemy e = new PropPlane();
    allEnemys.add(e);
  }
}
