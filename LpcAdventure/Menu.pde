class Menu_return {
  Button back;
  Menu_return()
  {
    back = new Button(width-75, 5, 30, 70, 20, "MENU", color(255, 255, 255, 150), color(255, 255, 255, 200), createFont("Arial Bold", 15), color(45, 45, 45));
  }
  void draw()
  {
    back.draw();
  }
  void mouseClicked()
  {
    if (back.hover()) status = 0;
  }
}

class Menu {
  Button start, editor;
  PImage background_img = loadImage("startup_background_little.png");
  Menu() {
    start = new Button((width/2 - 130), (height/2-50), 75, 250, 47, "START", color(72, 232, 124, 240), color(72, 232, 124, 200), createFont("Arial Bold", 25), color(255, 255, 255));
    editor = new Button((width/2 - 55), (height/2+35), 25, 100, 17, "editor", color(255, 193, 73, 240), color(255, 193, 73, 200), createFont("Arial", 15), color(255, 255, 255));
  }
  void draw()
  {
    background_img.resize(width, height);
    background(background_img);
    editor.draw();
    start.draw();
  }
  void mouseClicked()
  {
    if (start.hover()) launch_game();
    if (editor.hover())launch_editor();
  }

  void launch_game()
  {
    map = new Map();
    player = new Player();
    crab = new Crab(player);
    status = 1;
  }
  void launch_editor()
  {
    editorMap = new EditorMap();
    status = 2;
  }
}

class Button {
  int x, y, bheight, bwidth, btheight;
  String label;
  color bcolor, bhcolor, fcolor;
  PFont font;
  Button(int x, int y, int bheight, int bwidth, int btheight, String label, color bcolor, color bhcolor, PFont font, color fcolor) {
    this.x = x;
    this.y = y;
    this.bheight = bheight;
    this.bwidth = bwidth;
    this.btheight = btheight;
    this.label = label;
    this.bcolor = bcolor;
    this.bhcolor = bhcolor;
    this.fcolor = fcolor;
    this.font = font;
  }
  void draw() {
    fill(bcolor);
    noStroke();
    if (hover()) {
      fill(bhcolor);
    }
    rect(x, y, bwidth, bheight, 5);
    fill(fcolor);
    textFont(font);
    text(label, x + ((bwidth/2)-(textWidth(label)/2)), y + btheight);
  }
  boolean hover() {
    if (mouseX >= x && mouseY >= y && mouseX <= x + bwidth && mouseY <= y+bheight) return true;
    else return false;
  }
}
