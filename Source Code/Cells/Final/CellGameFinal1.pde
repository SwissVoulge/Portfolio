Player play;
Enemy enemy;

Buttons button1, instr, quit, toStart;

import ddf.minim.*;

AudioPlayer player;
Minim minim;

Animation myAnimation, smallWBCell, bacteria, ebola, smallPox, rota, virus;
private ArrayList<Animation> enemGraph;
private boolean moveOn = false;
Cholesterol testBlock;
Cholesterol[] walls;
int music = 0;
public ArrayList<Enemy> enemies;
public ArrayList<SmallProjectile> projectiles;
final int FRAMES = 60;
private int stage, backLoc;
final int BOXSIZE = 32;
int time, time2, timeToMult, bactMultTime, projSize, currTime, enemSize, playLevel, moveUpWalls = 0, wait=500;
PImage titleScreen, instScreen, gameOver, winGame;
private ArrayList<PImage> levelIntros;

void setup() {
  size(600, 800);
  frameRate(FRAMES);

  titleScreen = loadImage("TitleScreen.png");
  gameOver = loadImage("GameOver.png");
  instScreen = loadImage("InstructionScreen.png");
  winGame = loadImage("WinGame.png");

  enemies = new ArrayList<Enemy>();
  enemies.add(new Enemy(550, 500, 5));

  play = new Player(width/2, height/2);
  projectiles = new ArrayList<SmallProjectile>();

  //new minim class
  minim = new Minim(this);

  //Insert Level Screens into the ArrayList
  levelIntros = new ArrayList<PImage>();
  levelIntros.add(loadImage("Ecoli.png"));
  levelIntros.add(loadImage("SmallPox.png"));
  levelIntros.add(loadImage("Rota.png"));
  levelIntros.add(loadImage("Virus.png"));
  levelIntros.add(loadImage("Ebola.png"));

  //Buttons for title screen
  button1 = new Buttons(150, 399, 300, 50);
  instr = new Buttons(150, 478, 300, 50);
  quit = new Buttons(150, 554, 300, 51);

  //Button in instruction screen
  toStart = new Buttons(150, 630, 300, 50);

  //Get images
  myAnimation = new Animation("WhiteBloodCell", 10);
  smallWBCell = new Animation ("Cell", 10);
  bacteria = new Animation("Bacteria", 4);
  smallPox = new Animation("Smallpox", 15);
  virus = new Animation("Virus", 4);
  rota = new Animation("Rota", 4);
  ebola = new Animation("TheWorm", 13);

  //Start music
  setMusic(0);

  //Populate EnemiesGraph with enemy images
  enemGraph = new ArrayList<Animation>();
  enemGraph.add(bacteria);
  enemGraph.add(smallPox);
  enemGraph.add(rota);
  enemGraph.add(virus);
  enemGraph.add(ebola);

  cursor(CROSS);
  smooth();
  textSize(12);
  fill(255);

  //Timing for game
  time = millis();
  time2 = millis();
  stage = 0;
  backLoc = 0;
  //testBlock = new Cholesterol(true, 75,0);
  rectMode(CORNER);

  //Instantiate the walls
  walls = new Cholesterol[40];
  for (int i=0; i<walls.length; i+=2) {
    walls[i] = new Cholesterol(0-height/walls.length*i);
    walls[i+1] = new Cholesterol( -60 - height/walls.length*i);
  }
  stage = 1;
  playLevel = -1;
}

void draw() {
  spawnEnemies();

  if (stage == -1) {

    image(gameOver, 0, 0);
    fill(0);
    textSize(24);
    text(play.getScore(), 336, 565);
    player.pause();
  }

  if (stage == 0) {
    image(instScreen, 0, 0);
  }

  if (stage == 1) {
    fill(255);
    background(255);
    //button1.buttonDraw();
    image(titleScreen, 0, 0);
  }

  if (stage == 2) {
    if (!moveOn) {
      backLoc++;

      //Used for tiling the wall
      if (backLoc>BOXSIZE) {
        backLoc = 0;
      }
      background(120);

      //Tile wall
      PImage tile = loadImage("bvTile.png");
      for (int i = -32 + backLoc; i<height+65; i+=32)
      {
        for (int q = 0; q<width+65; q+=32)
        {
          image(tile, q, i);
        }
      }

      //Make player move
      play.display();
      play.move();

      //testBlock.display();
      //testBlock.incrementPos();

      //Make the walls move
      for (Cholesterol c : walls) {
        c.display();
        c.incrementPos();
        c.withinBounds(play.getPos());
      }

      //Get sizes
      projSize = projectiles.size();
      enemSize = enemies.size();

      //Display and move projectiles
      for (SmallProjectile p : projectiles) {
        p.display();
        p.move(0, 0);
      }

      //Move enemies around
      for (Enemy p : enemies) {
        p.display();
        p.move(play);
      }

      //Spawn Enemies
      spawnEnemies();

      //Test if small white blood cell hits the enemy or goes to destination
      for (int i=0; i<projSize; i++) {
        boolean keepGoing = true;

        if (keepGoing) {
          if (projectiles.get(i).xInc > 800)
          {
            projectiles.remove(i);
            projSize--;
            keepGoing = false;
          }
          if (projectiles.get(i).xInc < -50)
          {
            projectiles.remove(i);
            projSize--;
            keepGoing = false;
          }
          if (projectiles.get(i).yInc > 800)
          {
            projectiles.remove(i);
            projSize--;
            keepGoing = false;
          }
          if (projectiles.get(i).yInc < -50)
          {
            projectiles.remove(i);
            projSize--;
            keepGoing = false;
          }
          for (int j = 0; j<enemSize; j++) {
            try {
              projectiles.get(i);
              enemies.get(j);
              if (projectiles.get(i).collision(enemies.get(j))) {
                projectiles.remove(i);
                enemies.remove(j);
                projSize--;
                enemSize--;
                keepGoing = false;
                play.neutInfect();
              }
              // }
            } 
            catch(IndexOutOfBoundsException e) {
              projSize--;
              System.out.println("Help");
            }
          }
        }
      }





      //Test if enemies hit the player and decrement health from player and eliminate
      //enemy
      for (int i=0; i<enemSize; i++) {
        if (enemies.get(i).atDestination) {
          enemies.remove(i);
          enemSize--;
          play.fail();
        }
      }

      //Prevent Player from going over boundaries
      if (play.getPos().getX()>584) {
        play.pos.setLoc(584, play.getPos().getY());
      } else if (play.getPos().getX()<16) {
        play.pos.setLoc(16, play.getPos().getY());
      }

      if (play.getPos().getY()>784) {
        play.pos.setLoc(play.getPos().getX(), 784);
      } else if (play.getPos().getY()<16) {
        play.pos.setLoc(play.getPos().getX(), 16);
      }

      //Code to display health bar
      fill(0+2.5*(100-play.returnHealth()), 255-2.5*(100-play.returnHealth()), 0);
      rect(0, 0, width-6*(100-play.returnHealth()), 10);

      //Display Score
      fill(0, 0, 0);
      text("Score: " + play.getScore(), 10, 10);

      fill(255);
      if (play.returnHealth()<=0) {
        stage = -1;
      }
    }

    //Move to the next level
    if (millis()-time2>120000) {
      moveOn = true;
      time2 = millis();
      currTime = millis();
    }


    //Code to push info screen on and then move to next level.
    if (moveOn) {

      background(255);
      if (playLevel < 4) {
        image(levelIntros.get(playLevel+1), 0, 0);
      
      //if(playLevel <5){
      if (millis()-currTime>7000) {
        nextLevel();
        moveOn = false;
      }
     // }
      }
      else{
        nextLevel();
      }
    }
  }
  
  if(stage == 3){
    image(winGame,0,0);
    fill(0);
    textSize(24);
    text(play.getScore(), 336, 565);
  }
  
}

void keyPressed() {
  if (keyCode == LEFT || key == 'a') {
    play.L = true;
  }
  if (keyCode == DOWN || key == 's') {
    play.D = true;
  }
  if (keyCode == UP || key == 'w') {
    play.U = true;
  }
  if (keyCode == RIGHT || key == 'd') {
    play.R = true;
  }
  //Code for testing for incrementing levels
  if (stage ==2) {
    if (key == 'p' && playLevel <=3) {
      moveOn = true;
      currTime = millis();
    }
  }
}
void keyReleased() {
  if (keyCode == LEFT || key == 'a') {
    play.L = false;
  }
  if (keyCode == DOWN || key == 's') {
    play.D = false;
  }
  if (keyCode == UP || key == 'w') {
    play.U = false;
  }
  if (keyCode == RIGHT || key == 'd') {
    play.R = false;
  }
}

void mousePressed() {
  if (stage != 1 && stage != 0) {
    if (millis() - time >= wait) {
      play.fire();
      time = millis();
    }
  }
}

void mouseClicked() {
  if (button1.Clicked() && stage == 1)
  {
    stage += 1;
    projectiles.add(new SmallProjectile(0, 0, -1, -1));
    time2 = millis();
    moveOn = true;
  }
  if (instr.Clicked() && stage == 1)
  {
    stage = 0;
  }
  if (quit.Clicked() && stage == 1) {
    System.exit(0);
  }
  if (toStart.Clicked() && (stage == 0 || stage == -1 || stage == 3)) {
    stage = 1;
    music = 0;
    setup();
  }
}

void nextLevel() {
  if (playLevel<6) {
    //noLoop();
    //int timeNow = millis();

    //while (millis()-timeNow<5000) {
    //  background(255);
    // image(levelIntros.get(0), 0, 0);
    // //rect(0,0,width,height);
    //}
    playLevel++;
    player.pause();
    music++;
    setMusic(music);
    for (int i=0; i<walls.length; i+=2) {
      walls[i] = new Cholesterol(0-height/walls.length*i);
      walls[i+1] = new Cholesterol( -60 - height/walls.length*i);
    }
    play.setHealth(100);
    play.setPos(width/2, height/2);
    enemies.clear();
    enemies.add(new Enemy(0, 0, 6));
    projectiles.clear();

    projectiles.add(new SmallProjectile(0, 0, -1, -1));
    projSize = 0;
    enemSize = 0;
    //moveOn = false;
    //loop();
  }
  if (playLevel >=5) {
    stage =3;
  }
}
void setMusic (int track) {
    if(track<6){
    player = minim.loadFile("stage" + track + ".mp3", 1024);
    player.play();
  }
}

void spawnEnemies() {
  bactMultTime = 2000-(200*playLevel);
  if (millis() - timeToMult > bactMultTime) {

    timeToMult = millis();


    int spawnLoc = (int) random(1, 5);
    switch(spawnLoc) {

    case 1: 
      enemies.add(new Enemy(0, 0, 1));
      break;
    case 2: 
      enemies.add(new Enemy(0, width, 1));
      break;
    case 3: 
      enemies.add(new Enemy(height, 0, 1));
      break;
    case 4: 
      enemies.add(new Enemy(width, height, 1));
      break;
    }
  }
}