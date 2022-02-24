class Enemy extends Component {
  Player currentPlayer;
  Level currentLevel;

  float angle = 0;
  float targetAngle = 0;
  float freezZoneRadius = random(250, 500);
  float collisionRadius = 0;

  boolean hasBeenFreezed = false;

  PVector targetSaved = new PVector(0, 0);
  PVector moveSpd = new PVector(0, 0);
  PVector newH = new PVector(0, 0);
  PVector bulletSpd; // Bullet speed
  
  ArrayList<Bullet> allBullets = new ArrayList<Bullet>();

  Enemy(Player player, Level level, PImage img) {
    currentPlayer = player;
    currentLevel = level;
    compImg = img;
    pos = new PVector(getStartPosX(), getStartPosY());
    vel = new PVector();
    bulletSpd = new PVector();
  }

  void display() {
  }

  void update() {
    turn();
    shoot();
    
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
    
    for (int i = 0; i < allBullets.size(); i++) {
      Bullet b = allBullets.get(i);
      float d = dist(pos.x, pos.y, b.pos.x, b.pos.y);
      if (d > 100) {
        allBullets.remove(i);
      }
    }
  }

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

  boolean isToCloseToPlayerCheck() {
    float distToPlayer = dist(this.pos.x, this.pos.y, -currentLevel.pos.x, -currentLevel.pos.y);

    if (distToPlayer <= freezZoneRadius) {
      return true;
    } else {
      return false;
    }
  }

  void turn() {
    if (angle > targetAngle) {
      angle -= radians(moveSpd.x);
    }
    if (angle < targetAngle) {
      angle += radians(moveSpd.x);
    }
  }

  void getTargetAngle() {
    PVector p = new PVector(-currentLevel.pos.x, -currentLevel.pos.y);
    p.sub(pos);
    p.normalize();
    targetAngle = p.heading();
  }

  void movement(PVector target) {
    this.pos.x += target.x * moveSpd.x;
    this.pos.y += target.y * moveSpd.y;
  }

  float getStartPosX() {
    float x1 = random(-width, -width - 100);
    float x2 = random(width, width + 100);

    int picked = int(random(0, 2));

    return picked == 0 ? x1 : x2;
  }

  float getStartPosY() {
    float y1 = random(-height, -height - 100);
    float y2 = random(height, height + 100);

    int picked = int(random(0, 2));

    return picked == 0 ? y1 : y2;
  }

  void collision() {
    //line(this.pos.x, this.pos.y, -currentLevel.pos.x, -currentLevel.pos.y);

    float d = dist(this.pos.x, this.pos.y, -currentLevel.pos.x, -currentLevel.pos.y);

    if (d < collisionRadius || d < currentPlayer.collisionRadius) {
      currentLevel.allEnemysRemove.add(this);
      currentPlayer.gotHit();
    }
  }
  
  void bulletCollion() {
    PVector savedPosE = new PVector(this.pos.x, this.pos.y);
    
    pushMatrix();
    translate(-(width/2), -(height/2));
    translate(-currentLevel.pos.x, -currentLevel.pos.y);  
    
    for (Bullet b : currentPlayer.allBullets) {
      savedPosE.x += (width/2) + currentLevel.pos.x;
      savedPosE.y += (height/2) + currentLevel.pos.y;
      
      //line(savedPosE.x, savedPosE.y, b.pos.x, b.pos.y);
      float d = dist(savedPosE.x, savedPosE.y, b.pos.x, b.pos.y);
      
      if (d < collisionRadius) {
        currentLevel.allEnemysRemove.add(this);
        currentPlayer.allBulletsRemove.add(b);
        break;
      }
    }
    
    popMatrix();
  }
  
  void newBullet() {
    bulletSpd.set(targetSaved.x, targetSaved.y, 0);
    bulletSpd.sub(pos); // trækker vektorne fra hinanden og skaber en vektor fra centrum af skærmen til musen.
    bulletSpd.setMag(18); // Sætter størrelsen af den vektoren og aka skudets hastighed

    Bullet b = new Bullet(pos, bulletSpd);
    allBullets.add(b);
  }
  
  void shoot() {
    
  }
}
