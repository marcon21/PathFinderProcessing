public class Board {
  Box[][] board;
  int w, h, t;
  float xsize, ysize;
  Box startBox, endBox;
  boolean discovered;
 
  public Board(int w, int h, int t) {
    this.w = w;
    this.h = h;
    this.t = t;
    this.discovered = false;
    board = new Box[w][h];
    
    xsize = width / w;
    ysize = height / h;
    
    for(int x = 0; x < w; x++){
      for(int y = 0; y < h; y++){
        board[x][y] = new Box(x, y, xsize, ysize);
      }  
    }
  }
  
  public void reset() {
    for(int x = 0; x < w; x++){
      for(int y = 0; y < h; y++){
        board[x][y] = new Box(x, y, xsize, ysize);
      }  
    }
    discovered = false;
  }
  
  public void show() {
    for(int x = 0; x < w; x++){
      for(int y = 0; y < h; y++){
        board[x][y].show();
      }  
    }
  } 
  
  public Box isPresent(State state) {
    for(int x = 0; x < w; x++){
      for(int y = 0; y < h; y++){
        if (board[x][y].getState() == state) {
          return board[x][y];
        }
      }  
    }
    return null;
  }
  
  public void changeState(int x, int y, State newState) {
    if (newState == State.END || newState == State.START) {
      Box b = isPresent(newState);
      if (b != null) {
        b.setState(State.EMPTY);
      }
    }
    board[x][y].setState(newState);
  }
  
  public void checkInteraction() {
    if (keyPressed && (key == 'r' || key == 'R')) {
        reset();
    }
      
    if (mouseX < width && mouseY < height && !discovered) {
      int xp = floor(mouseX / ysize);
      int yp = floor(mouseY / xsize);
      
      if (mousePressed && (mouseButton == RIGHT || (mouseButton == LEFT && keyCode == CONTROL))) {
        changeState(xp, yp, State.EMPTY);
      } else if (mouseButton == LEFT && mousePressed) {
        changeState(xp, yp, State.WALL);
      }
       
      if (keyPressed && (key == 's' || key == 'S')) {
        changeState(xp, yp, State.START);
      } else if (keyPressed && (key == 'e' || key == 'E')) {
        changeState(xp, yp, State.END);
      } else if (keyPressed && key == ENTER) {
        findPath();
      }
    }
  }
  
  public void findPath() {
    startBox = isPresent(State.START);
    endBox = isPresent(State.END);
 
    if (startBox != null && endBox != null) {
      if (discovered == false){
        discovered = true;
        println("Searching...");
        chooseNeighbor(startBox);
      }
    } else {
      println("You must define a starting point and a ending point!");
    }
  }
  
  private void chooseNeighbor(Box box) {
    boolean end = false;
    ArrayList<Box> visitedBoxs = new ArrayList<Box>();
    Box scoreBox = box;
    Box choosedBox = null;
  
    while (end == false) {
      float min = Float.POSITIVE_INFINITY;
      if (choosedBox == scoreBox) {
        visitedBoxs.remove(choosedBox);
        scoreBox = nearestBox(visitedBoxs);
      }
      choosedBox = scoreBox;
      //println(choosedBox);
      delay(t);
      
      for (int x = -1; x < 2; x++) { 
        for (int y = -1; y < 2; y++) { 
          Box n = board[choosedBox.x + x][choosedBox.y + y];
          if (!(x == 0 && y == 0) && n.getState() != State.CHOOSED) {
            if (n.getState() != State.WALL){
              if (n.x == endBox.x && n.y == endBox.y) {
                println("founded!");
                end = true;
                min = -1;
                scoreBox = n;
              }
              
              if (n.getState() == State.EMPTY) {
                n.setState(State.VISITED);
                visitedBoxs.add(n);

              }
              
              float g = 1;
              float f = distanceToEndBox(n);
              
              if (abs(x) == abs(y)) {
                g = sqrt(1 + 1);
              }
              
              if (g + f < min) {
                min = g + f;
                scoreBox = n;
              }
            }
          }
        }
      }
      scoreBox.setState(State.CHOOSED);
    }
    scoreBox.setState(State.END); 
  }
  
  private float distanceToEndBox(Box box) {
    float deltax = box.x - endBox.x;
    float deltay = box.y - endBox.y;
    return sqrt(deltax * deltax + deltay * deltay);
  }
  
  public Box nearestBox(ArrayList<Box> boxs) {
    float min = Float.POSITIVE_INFINITY;
    Box winningBox = null;
    
    for(Box b: boxs) {
      float d = distanceToEndBox(b);
      if (d < min) {
        min = d;
        winningBox = b;
      }
    }
    
    return winningBox;
  
  }
  
  
  
  
  
  
  
  
  
  
}
