class firstAid extends Component {
  firstAid() {
    pos = new PVector();
    compImg = loadImage("First-Aid-Kit-PNG-Free-Image.png");
  }
  
  void display() {
    image(compImg, pos.x, pos.y, 50, 50);
  }
  
  void spawn() {
    pos.x = random(-1500, 1500);
    pos.y = random(-1500, 1500);
  }
}
