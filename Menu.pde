class Menu {
  
  public Game game;
  private Button start, editor;
  private PImage background_img = loadImage("textures/backgrounds/startup_background_little.png");
  
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
    game = new Game(1, 1);
    game.start();
  }
  
  void launch_editor()
  {
    
    editorMap = new EditorMap();
    status = 2;
  }
}

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
