Board bd;

void setup() {
  size(1200, 900);
  bd = new Board(80, 60, 5);
}

void draw() {
  bd.show();
  thread("checkInteraction");
}

void checkInteraction() {
  bd.checkInteraction();
}
