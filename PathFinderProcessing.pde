Board bd;


void setup() {
  size(600, 600);
  bd = new Board(30, 30);
}

void draw() {
  bd.show();
  bd.checkInteraction();
}
