class Player extends Component {
  int hpLevel = 100;
  
  float A = 0;
  float angle = 0;

  Player() {
    createPlayer();
  }

  void display() {
    update();
    direction();
    pushMatrix();
      println(degrees(angle));
      translate(width/2, height/2);
      rotate(angle + radians(90));
      image(compImg, 0, 0, 70, 100);
    popMatrix();
  }
  
  void update() {
    //direction();
  }

  void direction() {
    PVector center = new PVector(width/2, height/2);
    PVector mouse = new PVector(mouseX, mouseY);
    
    mouse.sub(center);
    angle = mouse.heading();
    
    
    //stroke(255);
    //line(width/2, height/2, width/2, height/2 - 100); // Lodret linje
    //line(width/2, height/2, mouseX, mouseY); // Vandrette linje
    //line(width/2, height/2 - 100, mouseX, mouseY); // Linje der forbinder de 2
    
    //float c = dist(width/2, height/2, width/2, height/2 - 100);
    //float b = dist(width/2, height/2, mouseX, mouseY);
    //float a = dist(width/2, height/2 - 100, mouseX, mouseY);
    
    //angle = cos(((c*c)+(b*b)-(a*a))/2*b*c);
    //println(angle);
  }
  
  void shoot() {
    
  }

  // Laver en spiller
  void createPlayer() {
    compImg = loadImage("player/player-u.png");
  }
}
