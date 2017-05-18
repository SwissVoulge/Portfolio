class Position {
  private float x, y;
  Position(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public void setLoc(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public void adjustX(int increment)
  {
    this.x += increment;
  }
  Position getLoc() {
    return this;
  }
  public void adjustY(int increment)
  {
    this.y += increment;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public boolean samePos(Position other) {
    if (this.x == other.getX() && this.y == other.getY()) {
      return true;
    } else {
      return false;
    }
  }
  public float getXInc (Position other)
  {
    float otX = other.getX();
    float otY = other.getY();
    float xShift = 0;
    float angle = atan((otY-this.y)/(otX-this.x));
    if (this.x < otX) {
      xShift = 1;
    } else if (this.x == otX) {
      xShift = 0;
    } else {
      xShift = -1;
    }
    return 2*xShift*abs(cos(angle));
  }
  public float getYInc (Position other)
  {
    float otY = other.getY();
    float otX = other.getX();
    float yShift = 0;
    float angle = atan((otY-this.y)/(otX-this.x));
    if (this.y > otY) {
      yShift = -1;
    } else if (this.y == otY) {
      yShift = 0;
    } else {
      yShift = 1;
    }
    return 2*yShift*abs(sin(angle));
  }
  public void moveCloser (Position other) {
    this.setLoc(this.x + 1.5*getXInc(other), this.y + 1.5*getYInc(other));
  }


  public float getDist(Position other) {
    float distX = this.x-other.getX();
    float distY = this.y-other.getY();
    float distAbs = sqrt(sq(distX)+sq(distY));
    return distAbs;
  }
}