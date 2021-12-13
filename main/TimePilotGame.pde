class TimePilotGame {

  Level currentlevel;
  Player player;
  int score;

  boolean showMainmenu = false;
  boolean showGame = true;

  TimePilotGame() {
    surface.setTitle("Time Pilot"); // Sætter titlen på program vinduet
    frameRate(60);
    
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
  }

  // Tegner main menu
  void mainmenu() {
  }

  // Køre spillet, placer ting i spillet
  void run() {
    clear();
    background(100);
    player.display();
  }

  // Opdatere spillet ting til deres nye position
  void update() {
  }

  // Kigger på hvilke taster der bliver klikket 
  void key() {
  }

  void mouse() {
  }
}
