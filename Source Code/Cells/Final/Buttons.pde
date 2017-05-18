class Buttons {
  int buttonX, buttonY, buttonW, buttonH;
  int buttonColor = color(255);

  Buttons(int button_X, int button_Y, int button_W, int button_H) {
    buttonX = button_X;
    buttonY = button_Y;
    buttonW = button_W;
    buttonH = button_H;
  }

  //Draws button if mouse is over button
  void buttonDraw() {
    if(isOver(mouseX, mouseY)) {
      stroke(0);
      strokeWeight(1);
    } else{
      noStroke();
    }
    
    rect(buttonX, buttonY, buttonW, buttonH);
  }

  //Checks mouseX and mouseY position
  boolean isOver(int x, int y) {
    return x > buttonX && x < buttonX + buttonW && y > buttonY && y < buttonY + buttonH;
  }

  boolean Clicked() {
    boolean mouseOver = isOver(mouseX, mouseY);
    return mouseOver;
  }
}