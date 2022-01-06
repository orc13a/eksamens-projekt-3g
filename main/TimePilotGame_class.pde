class TimePilotGame {
  Level currentLevel;
  Player player;
  
  int score;

  boolean showMainmenu = false;
  boolean showGame = true;
  
  float globalMoveX, globalMoveY;

  TimePilotGame() {
    surface.setTitle("Time Pilot"); // Sætter titlen på program vinduet
    frameRate(60);
    
    currentLevel = new Level();
    player = new Player();
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
    
    textAlign(LEFT);
    rectMode(CORNER);
    imageMode(CORNER);
  }

  // Tegner main menu
  void mainmenu() {
  }

  // Køre spillet, placer ting i spillet
  void run() {
    //noCursor();
    clear();
    currentLevel.display();
    
    player.display();
    
    currentLevel.update(player);
    
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
