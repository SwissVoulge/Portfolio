class Unit implements MovingObjects{
  protected Position pos;
  protected int health;
  
  Unit(float x, float y){
    this.pos = new Position(x, y);
  }
  
  
  public void move(float x, float y){
    pos.setLoc(x,y);
  }
  public Position getPos(){
    return pos;
  }
  
  
  public boolean collision(Enemy enem){
    return false;
  }

  public void display(){}
  public void healthMutate(){}
}