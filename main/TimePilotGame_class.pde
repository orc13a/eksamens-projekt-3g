class TimePilotGame {
  PApplet mainAppObj;

  SoundFile themeSong;
  SoundFile waveCompletedSound;

  Level currentLevel;
  Player player;

  Table highscoreTable;

  int score;
  int highscore = 0;

  boolean showMainmenu = true;
  boolean showGame = false;
  boolean isGameOver = false;
  boolean showPlayAgianText = true;
  boolean isWaveCompleted = false;
  boolean playWaveCompletedSound = true;

  PFont pressStart2D; 

  TimePilotGame(PApplet mainApp) {
    mainAppObj = mainApp;

    surface.setTitle("Time Pilot"); // Sætter titlen på program vinduet
    frameRate(60);

    player = new Player(mainAppObj);
    currentLevel = new Level(player, highscoreTable, mainAppObj);
    //currentLevel.currentPlayer = player;

    themeSong = new SoundFile(mainAppObj, "517524__mrthenoronha__8-bit-game-theme-2.wav");
    waveCompletedSound = new SoundFile(mainAppObj, "518308__mrthenoronha__world-clear-8-bit.wav");

    pressStart2D = createFont("PressStart2P-Regular.ttf", 12);

    try {
      highscoreTable = loadTable("highscores.csv", "headers");
    } 
    catch(Exception e) {
      createCsvHighscoreFile();
    }
  }

  void display() {
    // Spillet bruger dem her
    textAlign(LEFT);
    rectMode(CENTER);
    imageMode(CENTER);

    textFont(pressStart2D);

    if (frameCount % 60 == 0) {
      if (showPlayAgianText == true) {
        showPlayAgianText = false;
      } else {
        showPlayAgianText = true;
      }
    }

    // Hvis spillet køre skal man ikke se main menu
    if (showMainmenu == false && showGame == true && isGameOver == false && isWaveCompleted == false) {
      run();
      update();
    } else {
      mainmenu();
    }

    if (isGameOver == true && showMainmenu == false) {
      gameOverScreen();
    }
    
    if (isWaveCompleted == true && showMainmenu == false) {
      waveCompletedScreen();
    }

    // Sætter til default
    textAlign(LEFT);
    rectMode(CORNER);
    imageMode(CORNER);
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
      isGameOver = true;
    }
    
    if (currentLevel.enemysKilledProcent == currentLevel.waveKillsNeeded) {
      isWaveCompleted = true;
    }
  }

  // Kigger på hvilke taster der bliver klikket 
  void key() {
    if (keyCode == ENTER && showMainmenu == true) {
      themeSong.stop();
      player.jetEngine.loop();
      showMainmenu = false;
      showGame = true;
    }

    if (keyCode == ENTER && isGameOver == true) {
      if (player.playerDeadGameOverSound.isPlaying() == true) {
        player.playerDeadGameOverSound.stop();
      }
      themeSong.stop();
      player = new Player(mainAppObj);
      currentLevel = new Level(player, highscoreTable, mainAppObj);
      isGameOver = false;
      showGame = true;
    }
  }

  void mouse() {
  }

  void mainmenu() {
    if (themeSong.isPlaying() == false && showMainmenu == true) {
      themeSong.loop();
    }

    fill(0);
    rect(width / 2, height / 2, width, height);
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text("TIME PILOT", width / 2, 100);
    textSize(22);

    text("HIGHSCORE", width / 2, 300);
    text("000000", width / 2, 335);

    textSize(18);

    text("Start spil", width / 2, height - 200);
    pressStartText();

    text("Escape for quit", 25, height - 40);
  }

  void gameOverScreen() {
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
    //TableRow row = highscoreTable.getRow(0);

    //text(row.getInt("hightscore"), width / 2, 335);

    textSize(18);

    text("Spil igen", width / 2, height - 200);
    pressStartText();

    text("Escape for quit", 25, height - 40);

    if (player.playerDeadGameOverSound.isPlaying() == false && themeSong.isPlaying() == false) {
      themeSong.loop();
    }
  }

  void pressStartText() {
    textAlign(CENTER);

    textSize(18);

    if (showPlayAgianText == true) {
      text("PRESS ENTER", width / 2, height - 160);
    }

    textSize(12);
    textAlign(LEFT);
  }

  void createCsvHighscoreFile() {
    highscoreTable = new Table();
    highscoreTable.addColumn("highscore", Table.INT);
    TableRow newRow = highscoreTable.addRow();
    newRow.setInt("hightscore", 0);

    saveTable(highscoreTable, "data/highscores.csv");

    highscoreTable = loadTable("highscores.csv", "headers");
  }

  void saveHighscore() {
    TableRow newRow = highscoreTable.addRow();
    newRow.setInt("hightscore", 0);
    saveTable(highscoreTable, "data/highscores.csv");
  }

  void waveCompletedScreen() {
    player.jetEngine.stop();
    
    if (playWaveCompletedSound == true) {
      waveCompletedSound.play();
      playWaveCompletedSound = false;
    }
    
    fill(0);
    rect(width / 2, height / 2, width, height);
    fill(255);
    textSize(34);
    textAlign(CENTER);
    text("WAVE completed", width / 2, 100);
    textSize(16);
    text("Loading next wave...", width / 2, height/2);
    textSize(12);
    textAlign(LEFT);
  }
}
