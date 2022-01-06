class Player extends Component {
  int hpLevel = 100;

  float A = 0;
  float angle = 0;
  float planeSpd = 5; 
  
  PVector center;
  PVector mouse;
  PVector bulletSpd;

  ArrayList<Bullet> allBullets = new ArrayList<Bullet>();

  Player() {
    center = new PVector(width/2, height/2);
    bulletSpd = new PVector();
    mouse = new PVector();
    
    createPlayer();
  }

  void display() {
    for (Bullet s : allBullets) {
      s.display();
    }

    pushMatrix();
    translate(width/2, height/2);
    rotate(angle + radians(90));
    image(compImg, 0, 0, 70, 100);
    popMatrix();
  }

  void update() {
    direction();
    
    for (Bullet s : allBullets) {
      s.update();
    }
  }

  void direction() {
    mouse = new PVector(mouseX, mouseY);
    mouse.sub(center);
    angle = mouse.heading();
  }

  void shoot() {
    if (keyPressed && frameCount % 3 == 0) {
      if (key == ' ') {
         newBullet();
      }
    }
  }
  
  void newBullet() {    
    bulletSpd.set(mouseX, mouseY, 0);
    bulletSpd.sub(center);
    bulletSpd.setMag(5);
    
    Bullet b = new Bullet(center, bulletSpd);
    allBullets.add(b);
  }

  // Laver en spiller
  void createPlayer() {
    compImg = loadImage("player/player-u.png");
  }
}
