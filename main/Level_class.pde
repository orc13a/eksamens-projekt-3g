class Level extends Component {
  PImage skyImage;
  
  Level() {
    skyImage = loadImage("sky.jpeg");
    pos = new PVector(0, 0);
  }
  
  void display() {
    pushMatrix();
      translate(pos.x, pos.y);
      image(skyImage, width / 2, height / 2);
      circle(10, 10, 10);
    popMatrix();
  }
  
  void update(Player p) {
    PVector a = new PVector(mouseX, mouseY);
    a.sub(p.center);
    a.normalize();
    pushMatrix();
      translate(p.center.x, p.center.y);
      pos.x -= a.x * p.planeSpd;
      pos.y -= a.y * p.planeSpd;
      //println(a);
    popMatrix();
  }
}
