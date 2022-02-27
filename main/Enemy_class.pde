class Enemy extends Component {
  //PApplet er navnet på hovedklassen af hele processing programmet
  //Hoved klassen skal bruges alle de steder hvor der skal bruges lydfiler.
  PApplet mainAppObj;
  
  //currentplayer referere til Player objektet.
  Player currentPlayer;
  
  //currentLevel referere til den nuværende levels objekt.
  Level currentLevel;
  
  //Variabler der holder på lydfiler.
  SoundFile hitSound;
  SoundFile engineSound;
  
  //Det antal point man får tillagt alt efter hvilken fjende man skyder ned.
  int scorePoints = 0;
  
  //vinkel fjenden peger-
  float angle = 0;
  
  //Gemt vinkel for når flyet kommer for tæt på spilleren, og kommer ind i freezZoneRadius.
  float targetAngle = 0;
  
  //Den radius omkring spilleren som en fjende har, hvor fjenden vil stoppe med at følge efter spilleren.
  float freezZoneRadius = random(250, 500);
  
  //Fjendernes "hitbox"
  float collisionRadius = 0;
  
  //Variable til at tjekke om fjende har været inde i FreezZoneRadius.
  boolean hasBeenFreezed = false;

  PVector targetSaved = new PVector(0, 0);
  PVector moveSpd = new PVector(0, 0);
  PVector newH = new PVector(0, 0);
  PVector bulletSpd; // Bullet speed
  
  //Holder på fjendens skud.
  ArrayList<Bullet> allBullets = new ArrayList<Bullet>();

  Enemy(Player player, Level level, PImage img, PApplet mainApp) {
    mainAppObj = mainApp;
    currentPlayer = player;
    currentLevel = level;
    compImg = img;
    hitSound = new SoundFile(mainAppObj, "270325__littlerobotsoundfactory__hit-02.wav");
    hitSound.amp(0.5);
    pos = new PVector(getStartPosX(), getStartPosY());
    vel = new PVector();
    bulletSpd = new PVector();
  }

  void display() {
    //overrides af underklasserne
  }

  void update() {
    turn();
    
    //Disse if statements Tjekker om fjenden er inde i Freeze Radius og gemmer dens retning i freezeZone, samt når den er ude igen.
    if (isToCloseToPlayerCheck() == true && hasBeenFreezed == false) {
      hasBeenFreezed = true;
    }

    if (isToCloseToPlayerCheck() == true && hasBeenFreezed == true) {
      movement(targetSaved);
    }

    if (isToCloseToPlayerCheck() == false && hasBeenFreezed == true) {
      if (angle != targetAngle) {  
        movement(targetSaved);
        turn();
      } else {
        hasBeenFreezed = false;
      }
    }

    if (isToCloseToPlayerCheck() == false && hasBeenFreezed == false) {
      direction();
    }

    for (Bullet s : allBullets) {
      s.update();
    }
    
    //Dette for-loop sletter fjendes skud når de kommer et bestemt stykke væk fra fjenden.½½
    for (int i = 0; i < allBullets.size(); i++) {
      Bullet b = allBullets.get(i);
      float d = dist(pos.x, pos.y, b.pos.x, b.pos.y);
      if (d > 100) {
        allBullets.remove(i);
      }
    }
  }
  
  //Vi bestemmer hvilken retning fjenderne skal kigge i, og så gør denne funktion at fjenden følger efter spilleren.
  void direction() {
    PVector p = new PVector(-currentLevel.pos.x, -currentLevel.pos.y);
    p.sub(pos);
    p.normalize();
    targetSaved = p;
    movement(p);
    targetAngle = p.heading();
    if (hasBeenFreezed == false) {
      angle = targetAngle;
    }
  }
  
  //Tjekker om fjenden er inde for FreezeRadius.
  boolean isToCloseToPlayerCheck() {
    float distToPlayer = dist(this.pos.x, this.pos.y, -currentLevel.pos.x, -currentLevel.pos.y);

    if (distToPlayer <= freezZoneRadius) {
      return true;
    } else {
      return false;
    }
  }
  
  //metode til at få fjenden til at ligne den drejer rundt (ps virker ikke lige nu)
  void turn() {
    if (angle > targetAngle) {
      angle -= radians(moveSpd.x);
    }
    if (angle < targetAngle) {
      angle += radians(moveSpd.x);
    }
  }
  
  //metode der rykker på fjenden.
  void movement(PVector target) {
    this.pos.x += target.x * moveSpd.x;
    this.pos.y += target.y * moveSpd.y;
  }
  
  //funktion der giver fjende tilfældig x koordinat til hvor den starter
  float getStartPosX() {
    float x1 = random(-width, -width - 100);
    float x2 = random(width, width + 100);

    int picked = int(random(0, 2));

    return picked == 0 ? x1 : x2;
  }
  
  //funktion der giver fjende tilfældig y koordinat til hvor den starter
  float getStartPosY() {
    float y1 = random(-height, -height - 100);
    float y2 = random(height, height + 100);

    int picked = int(random(0, 2));

    return picked == 0 ? y1 : y2;
  }
  
  //metode der kigger om spilleren og fjenden flyver ind i hinanden.
  void collision() {
    float d = dist(this.pos.x, this.pos.y, -currentLevel.pos.x, -currentLevel.pos.y);

    if (d < collisionRadius || d < currentPlayer.collisionRadius) {
      hitSound.play();
      currentLevel.allEnemysRemove.add(this);
      currentPlayer.gotHit();

      if (currentPlayer.hp <= 0) {
        engineSound.stop();
      }
    }
  }
  
  //metode der tjekker om spillerens skud rammer fjenden.
  void bulletCollion() {
    PVector savedPosE = new PVector(this.pos.x, this.pos.y);

    pushMatrix();
    translate(-(width/2), -(height/2));
    translate(-currentLevel.pos.x, -currentLevel.pos.y);  

    for (Bullet b : currentPlayer.allBullets) {
      savedPosE.x += (width/2) + currentLevel.pos.x;
      savedPosE.y += (height/2) + currentLevel.pos.y;


      float d = dist(savedPosE.x, savedPosE.y, b.pos.x, b.pos.y);

      if (d < collisionRadius) {
        currentLevel.enemysKilledProcent += 1;
        currentLevel.score += scorePoints;

        hitSound.play();
        currentLevel.allEnemysRemove.add(this);

        currentPlayer.allBulletsRemove.add(b);
        break;
      }
    }

    popMatrix();
  }
}
