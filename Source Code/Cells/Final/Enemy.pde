class Enemy extends Unit{
  int timeToMultiply;
  boolean atDestination = false;
  Enemy(float x, float y, int timeToMultiply){
    super(x,y);
    this.timeToMultiply = timeToMultiply;
  }
  public void move(Player play){
    Position playPos = play.getPos();
    pos.moveCloser(playPos);
    if(play.getPos().getDist(pos)<30){
       atDestination = true;
    }
  }
  
  public void display(){
    enemGraph.get(playLevel).display(pos.getX()-16, pos.getY()-16);
  }
  
  public boolean atDestination(){
    return atDestination;
  }
  
  public void makeBabies(){
    enemies.add(new Enemy(pos.getX()+10,pos.getY()+10,this.timeToMultiply));
  }
}