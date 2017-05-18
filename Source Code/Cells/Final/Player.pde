class Player extends Unit{
  
  private boolean L = false;
  private boolean R = false;
  private boolean U = false;
  private boolean D = false;
  private int movement = 3;
  private int score;
  Player(float x, float y){
    super(x,y);
    health = 100;
    score = 0;
  }
  
  public void fire(){
    projectiles.add(new SmallProjectile(pos.getX(), pos.getY(),mouseX, mouseY) );
  }
  
  public void fail(){
    health-=10;
  }
  
  public void setScore(int score){
    this.score = score;
  }
  
  public int returnHealth(){
    return health;
  }
  
  public void setHealth(int health){
    this.health = health;
  }
  
  public void control(){}
  public void display(){
    myAnimation.display(pos.getX()-16, pos.getY()-16);
  }
  public void move()
  {
    int xDelta = 0;
    int yDelta = 0;
    if (U)
    {
      yDelta -= movement;
    }
    if (D)
    {
      yDelta += movement;
    }
    if (L)
    {
      xDelta -= movement;
    }
    if (R)
    {
      xDelta += movement;
    }
    if (abs(xDelta)+abs(yDelta) > 4)
    {
      if (xDelta>1)
      {
        xDelta -= 1;
      } else
      {
        xDelta += 1;
      }
      if (yDelta>1)
      {
        yDelta -= 1;
      } else
      {
        yDelta += 1;
      }
    }
    this.pos.adjustX(xDelta);
    this.pos.adjustY(yDelta);
  }
  public void setPos(float x, float y){
    pos.setLoc(x,y);
  }
  
  public void neutInfect(){
    score += 10;
  }
  
  public int getScore(){
    return score;
  }
  
  
}