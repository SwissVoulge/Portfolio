interface MovingObjects{
  public void move(float x, float y);
  public Position getPos();
  public boolean collision(Enemy enem);
  public void display();
}