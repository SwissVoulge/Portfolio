class SmallProjectile implements MovingObjects {
  Position goal, pos;
  boolean atDestination = false;
  float xInc = 0;
  float yInc = 0;
  Animation smallWBCell = new Animation ("Cell", 10);

  SmallProjectile(float curPoX, float curPoY, float destX, float destY) {
    goal = new Position(destX, destY);
    pos = new Position(curPoX, curPoY);
    xInc = this.pos.getXInc(this.goal);
    yInc = this.pos.getYInc(this.goal);
  }


  public void move(float x, float y) {
    this.pos.setLoc(this.pos.x + xInc*2.4, this.pos.y + yInc*2.4);
  }
  public Position getPos() {
    return pos;
  }
  public boolean collision(Enemy enem) {
    if (pos.getDist(enem.getPos())<=20) {
      return true;
    } else {
      return false;
    }
  }

  public void display() {
    smallWBCell.display(pos.getX()-8, pos.getY()-8);
    if (pos.getDist(goal)<1) {
      atDestination = true;
    }
  }
  public boolean atDestination() {
    return atDestination;
  }
}