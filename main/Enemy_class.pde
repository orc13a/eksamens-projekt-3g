class Enemy extends Component {
  Player currentPlayer;
  Level currentLevel;

  float angle = 0;
  float targetAngle = 0;

  boolean hasBeenFreezed = false;

  PVector targetSaved = new PVector(0, 0);
  PVector moveSpd = new PVector(0, 0);

  Enemy(Player player, Level level, PImage img) {
    currentPlayer = player;
    currentLevel = level;
    compImg = img;
    pos = new PVector(200, 200);
    vel = new PVector();
  }

  void display() {
  }

  void update() {
    if (isToCloseToPlayerCheck() == true && hasBeenFreezed == false) {
      hasBeenFreezed = true;
    }

    if (isToCloseToPlayerCheck() == true && hasBeenFreezed == true) {
      //PVector p = new PVector(-currentLevel.pos.x, -currentLevel.pos.y);
      //p.sub(pos);
      //p.normalize();
      //targetSaved = p;
      movement(targetSaved);
      //hasBeenFreezed = false;
    } else {
      if (isToCloseToPlayerCheck() == false && hasBeenFreezed == true) {
        
      }
      direction();
    }
  }

  void direction() {
    //if (isToCloseToPlayerCheck() == false) {
    //  PVector p = new PVector(-currentLevel.pos.x, -currentLevel.pos.y);
    //  p.sub(pos);
    //  p.normalize();
    //  targetSaved = p;
    //  movement(p);
    //  angle = p.heading();
    //}

    PVector p = new PVector(-currentLevel.pos.x, -currentLevel.pos.y);
    p.sub(pos);
    p.normalize();
    targetSaved = p;
    movement(p);
    targetAngle = p.heading();
    if (hasBeenFreezed == false) {
      angle = targetAngle;
    }

    //if (isToCloseToPlayerCheck() == false) {
    //PVector p = new PVector(-currentLevel.pos.x, -currentLevel.pos.y);
    //p.sub(pos);
    //p.normalize();
    //targetSaved = p;
    //movement(p);
    //angle = p.heading();
    //} else {
    //  hasBeenFreezed = true;
    //  movement(targetSaved);
    //}
  }

  boolean isToCloseToPlayerCheck() {
    float distToPlayer = dist(this.pos.x, this.pos.y, -currentLevel.pos.x, -currentLevel.pos.y);

    if (distToPlayer <= 150) {
      return true;
    } else {
      return false;
    }
  }

  void turn() {
    if (hasBeenFreezed == true) {
    }
  }

  void shoot() {
  }

  void movement(PVector target) {
    this.pos.x += target.x * moveSpd.x;
    this.pos.y += target.y * moveSpd.y;
  }
}
