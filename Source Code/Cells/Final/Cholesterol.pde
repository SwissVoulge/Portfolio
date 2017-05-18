class Cholesterol{
  int horizSize, vertSize, xLoc;
  boolean leftWall, doneDamage;
  int currentPos;
  public Cholesterol(int currentPos){
    
    this.horizSize = (int) random(60,120);
    this.vertSize = (int) random(40,60);
    this.xLoc = (int) random(0,450);
    this.currentPos = currentPos;
    doneDamage = false;
  }
  
  public void incrementPos(){
    currentPos++;
  }
  
  public void display(){
    //if(leftWall){
    //  rect(-5,currentPos, horizSize, 10, 100);
    //} else {
    //  rect(600-horizSize, currentPos, 605, 10, 100);
    //}
    fill(#F3E175);
    rect(xLoc, currentPos, horizSize, vertSize, 100);
    fill(255);
    
    if(currentPos>height){
      currentPos-=height+40;
      doneDamage = false;
      this.horizSize = (int) random(60,120);
      this.vertSize = (int) random(40,60);
      this.xLoc = (int) random(0,600);
    }
  }
  
  public boolean withinBounds(Position playerLoc){
    
      if(playerLoc.getX() > xLoc &&  playerLoc.getX()<horizSize+xLoc && playerLoc.getY() > currentPos && playerLoc.getY() < currentPos+vertSize){
        doDamage();
        return true;
      } else {
        return false;
      }

  }
  
  public void doDamage(){
    if(!doneDamage){
      play.fail();
      doneDamage = true;
    } else {
      
    }
  }
  
}