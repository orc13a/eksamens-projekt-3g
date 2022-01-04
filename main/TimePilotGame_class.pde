class TimePilotGame {
  Level currentlevel;
  Player player;
  
  int score;

  boolean showMainmenu = false;
  boolean showGame = true;
  
  PImage skyImage;
  
  float globalMoveX, globalMoveY;

  TimePilotGame() {
    surface.setTitle("Time Pilot"); // Sætter titlen på program vinduet
    frameRate(60);
    
    player = new Player();
    
    skyImage = loadImage("sky.jpeg");
  }

  void display() {
    textAlign(CENTER);
    rectMode(CENTER);
    imageMode(CENTER);
    
    // Hvis spillet hvis man ikke skal se main menu
    if (!showMainmenu && showGame) {
      this.run();
      this.update();
    } else {
      this.mainmenu();
    }
  }

  // Tegner main menu
  void mainmenu() {
  }

  // Køre spillet, placer ting i spillet
  void run() {
    noCursor();
    clear();
    image(skyImage, width / 2, height / 2);
    player.display();
    player.shoot();
  }

  // Opdatere spillet ting til deres nye position
  void update() {
    player.update();
  }

  // Kigger på hvilke taster der bliver klikket 
  void key() {
    //player.shoot();
  }

  void mouse() {
  }
}
