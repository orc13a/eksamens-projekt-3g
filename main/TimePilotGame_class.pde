class TimePilotGame {
  SoundFile themeSong;
  
  Level currentLevel;
  Player player;
  
  int score;

  boolean showMainmenu = false;
  boolean showGame = true;
  boolean isGameOver = false;
  
  PFont pressStart2D; 

  TimePilotGame(PApplet mainApp) {
    surface.setTitle("Time Pilot"); // Sætter titlen på program vinduet
    frameRate(60);
    
    player = new Player(mainApp);
    currentLevel = new Level(player, mainApp);
    //currentLevel.currentPlayer = player;
    
    themeSong = new SoundFile(mainApp, "517524__mrthenoronha__8-bit-game-theme-2.wav");
    
    pressStart2D = createFont("PressStart2P-Regular.ttf", 12);
  }

  void display() {
    // Spillet bruger dem her
    textAlign(LEFT);
    rectMode(CENTER);
    imageMode(CENTER);
    
    textFont(pressStart2D);
    
    // Hvis spillet køre skal man ikke se main menu
    if (showMainmenu == false && showGame == true && isGameOver == false) {
      run();
      update();
    } else {
      mainmenu();
    }
    
    if (isGameOver == true && showMainmenu == false) {
      gameOverScreen();
    }
    
    // Sætter til default
    textAlign(LEFT);
    rectMode(CORNER);
    imageMode(CORNER);
  }

  // Tegner main menu
  void mainmenu() {
  }

  // Køre spillet, placer ting i spillet
  void run() {
    noCursor();
    clear();
    
    currentLevel.display();
    player.display();
    currentLevel.update(player);
    player.shoot();
  }

  // Opdatere spillet ting til deres nye position
  void update() {
    player.update();
    
    if (player.hp <= 0) {
      gameOverScreen();
    }
  }

  // Kigger på hvilke taster der bliver klikket 
  void key() {
    //player.shoot();
  }

  void mouse() {
  }
  
  void gameOverScreen() {
    isGameOver = true;
    fill(0);
    rect(width / 2, height / 2, width, height);
    fill(255);
    textSize(32);
    textAlign(CENTER);
    text("GAME OVER", width / 2, 100);
    textSize(22);
    
    text("SCORE", width / 2, 175);
    text(currentLevel.score, width / 2, 210);
    
    text("HIGHSCORE", width / 2, 300);
    text("000000", width / 2, 335);
    textAlign(LEFT);
    
    if (player.playerDeadGameOverSound.isPlaying() == false && themeSong.isPlaying() == false) {
      themeSong.loop();
    }
  }
}
