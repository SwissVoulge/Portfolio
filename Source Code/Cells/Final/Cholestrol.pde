class Cholestrol{
  int horizSize;
  boolean leftWall;
  int currentPos;
  public Cholestrol(boolean leftWall, int horizSize){
    this.leftWall = leftWall;
    this.horizSize = horizSize;
    currentPos = 0;
  }
  
  public void incrementPos(){
    currentPos++;
  }
  
  public void display(){
    if(leftWall){
      rect(-5,currentPos, horizSize, 10, 100);
    } else {
      rect(600-horizSize, currentPos, 605, 10, 100);
    }
  }
  
  
}