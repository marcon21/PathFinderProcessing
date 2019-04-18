public class Box {
  int x, y;
  float xsize, ysize;
  State state;
  
  
  public Box(int x, int y, float xsize, float ysize) {  
    this.x = x;
    this.y = y;
    this.xsize = xsize;
    this.ysize = ysize;
    this.state = State.EMPTY;
  }

  public void show() {
    if (state == State.EMPTY) {
      fill(240);
    } else if (state == State.WALL) {
      fill(0);
    } else if (state == State.START) {
      fill(0, 0, 255);
    } else if (state == State.END) {
      fill(255, 0, 0);
    } else if (state == State.VISITED) {
      fill(255, 102, 102);
    } else if (state == State.CHOOSED) {
      fill(30, 144, 255);
    }
    
    rect(x*xsize, y*ysize, xsize, ysize);
  }
  
  public void setState(State newState) {
    state = newState;
  }
  
  public State getState() {
    return state;
  }
  
  @Override
  public String toString() {
    return "x: "+x+" y: "+y;
  }
  
  
  
  
}
