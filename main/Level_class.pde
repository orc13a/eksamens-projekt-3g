class Level extends Component {
  PApplet mainAppObj;
  
  //Henter baggrunds billede.
  PImage skyImage;
  
  //se enemy class.
  Player currentPlayer;
  
  //variable for hvilket niveau man er på (der er kun et level lige nu)
  int level = 1;
  
  //holder på rundens score
  int score = 0;
  
  // Hvor mange man har dræbt
  int enemysKilledProcent = 0;
  
  // Hvor mange man skal dræbe for at vinde level
  int waveKillsNeeded = 20;
  
  //arraylister der holder alle fjender og alle fjender der skal fjernes
  ArrayList<Enemy> allEnemys = new ArrayList<Enemy>();
  
  //vi skal have remove ellers så opstår der modification error
  ArrayList<Enemy> allEnemysRemove = new ArrayList<Enemy>();
  
  //Vi har overloading af konstruktør.
  Level(PApplet mainApp) {
    mainAppObj = mainApp;

    skyImage = loadImage("skyRepeat.jpeg");
    pos = new PVector(0, 0);
  }

  Level(Player p, PApplet mainApp) {
    mainAppObj = mainApp;

    currentPlayer = p;
    skyImage = loadImage("skyRepeat.jpeg");
    pos = new PVector(0, 0);
  }

  void display() {
    pushMatrix();
    translate(width/2, height/2); // Origo til midten af vinduet
    translate(pos.x, pos.y); // Flytter verden i for hold til spilleren

    createBackground();

    allEnemys.removeAll(allEnemysRemove);

    for (Enemy e : allEnemys) {
      e.display();
    }

    popMatrix();
    
    //tilføjer grafisk tekst og score
    fill(0);
    rect((width/2), 55, width, 110);
    fill(255);
    text("SCORE: " + score, 20, 30);
    text("HIGHSCORE", width/2 - 55, 30);
    text("HP: " + currentPlayer.hp, 20, 90);
    text("LEVEL: 1", width - 115, 90);

    fill(0);
    rect((width/2), height - 50, width, 100);
    fill(255);
    text("WAVE: ", 25, height - 25);
    stroke(255);
    //Laver procentbar over hvor mange man mangler at dræbe.
    for (int i = 0; i <= (waveKillsNeeded - enemysKilledProcent); i++) {
      rect(100 + (5 * i), height - 32, 5, 10);
    }
    noStroke();
  }

  void update(Player p) {
    updateWorld(p);

    addEnemys();

    pushMatrix();
    translate(width/2, height/2); // Origo til midten af vinduet
    translate(pos.x, pos.y); // Flytter verden i for hold til spilleren

    for (Enemy e : allEnemys) {
      e.bulletCollion();
      e.collision();
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
  
  //metode der sørger for at tilføje fjender hver 2 sekund.
  void addEnemys() {
    int maxEnemyes = int(level * 10);

    if (frameCount % 120 == 0) {
      if (allEnemys.size() <= maxEnemyes) {
        Enemy e = new PropPlane(currentPlayer, this, mainAppObj);
        allEnemys.add(e);
      }
    }
  }
}
