Player player;
Crab crab;
EditorMap editorMap;
Map map;
Menu menu;
Menu_return menu_return;
Game game;

int status = 0;

//INITIALISATION DU JEU
void settings()
{
  size(1000, 700, P3D);
}

void setup()
{
  frameRate(30);
  menu = new Menu();
  menu_return = new Menu_return();
}

void draw()
{
  if (status == 0)
  {
    menu.draw();
  }
  else if (status == 1)
  {
    map.draw();
    crab.draw();
    player.draw();
    menu_return.draw();
  } 
  else if (status ==2)
  {
    editorMap.draw();
    menu_return.draw();
  }
}

void keyReleased() {
  if (status == 1) {
    switch(keyCode) {
    case RIGHT:
      player.rightPressed = false;
      break;
    case LEFT:
      player.leftPressed = false;
      break;
    }
  }
}

void keyPressed() {
  if (status == 1) {
    if (keyCode == UP || keyCode == 32) {
      player.upPressed = true;
    }
    if (keyCode == LEFT) {
      player.rightPressed = false;
      player.leftPressed = true;
    }    
    if (keyCode == RIGHT) {
      player.leftPressed = false;
      player.rightPressed = true;
    }
  }
}
void mouseDragged()
{
  if (status == 2) editorMap.mouseDragged();
}
void mouseClicked() {
  if (status == 0) menu.mouseClicked();
  else if (status == 1) menu_return.mouseClicked();
  else if (status == 2) editorMap.mouseClicked();
}
