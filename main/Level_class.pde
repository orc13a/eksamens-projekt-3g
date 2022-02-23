class Level extends Component {
  PImage skyImage;

  Player currentPlayer;

  int level = 1;

  ArrayList<Enemy> allEnemys = new ArrayList<Enemy>();
  ArrayList<Enemy> allEnemysRemove = new ArrayList<Enemy>();

  Level() {
    skyImage = loadImage("skyRepeat.jpeg");
    pos = new PVector(0, 0);
    //addEnemy();
  }

  Level(Player p) {
    currentPlayer = p;
    skyImage = loadImage("skyRepeat.jpeg");
    pos = new PVector(0, 0);
    //addEnemy();
  }

  void display() {
    pushMatrix();
    translate(width/2, height/2); // Origo til midten af vinduet
    translate(pos.x, pos.y); // Flytter verden i for hold til spilleren

    createBackground();
    
    allEnemys.removeAll(allEnemysRemove);
    
    for (Enemy e : allEnemys) {
      //circle(e.pos.x, e.pos.y, 75);
      //println(e.pos);
      e.display();
    }

    //circle(0, 0, 10);

    //translate(-pos.x, -pos.y);
    //println(pos);
    //println('-');
    //circle(0, 0, 100);
    popMatrix();
  }

  void update(Player p) {
    updateWorld(p);
    //for (Enemy e : allEnemys) {
    //  e.bulletCollion();
    //}

    addEnemys();

    pushMatrix();
    translate(width/2, height/2); // Origo til midten af vinduet
    translate(pos.x, pos.y); // Flytter verden i for hold til spilleren

    for (Enemy e : allEnemys) {
      e.collision();
      e.bulletCollion();
      e.update();
    }
    popMatrix();
  }

  // Laver baggrunds himmlen
  void createBackground() {
    pushMatrix();
    // "Billdet" som bliver lavet af for-loops'ene er 61.200x61.200
    // Derfor rykker vi ind i midten af "billedet"
    translate(-30000, -30000);
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

  void addEnemys() {
    int maxEnemyes = int(level * 10);

    if (allEnemys.size() <= maxEnemyes && frameCount % 25 == 0) {
      for (int i = 0; i <= maxEnemyes; i++) {
        Enemy e = new PropPlane(currentPlayer, this);
        allEnemys.add(e);
      }
    }
  }

  void removeEnemy(Enemy e) {
    //if (allEnemys.size() > 0) {
    //  int index = allEnemys.indexOf(e);
      
    //  ArrayList<Enemy> toRemove = new ArrayList<Enemy>();
    //  for (String str : allEnemys) {
    //    if (someCondition) {
    //      toRemove.add(str);
    //    }
    //  }
    //  myArrayList.removeAll(toRemove);
    //}
  }
}
