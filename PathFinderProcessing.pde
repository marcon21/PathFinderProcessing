Board bd;


void setup() {
  size(1200, 800);
  bd = new Board(90, 60, 15);
}

void draw() {
  bd.show();
  thread("checkInteraction");
}

void checkInteraction() {
  bd.checkInteraction();
}
