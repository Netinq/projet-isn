class Game {
  
  public int level, lifes;
  
  Game(int level, int lifes)
  {
    this.level = level;
    this.lifes = lifes;
  }
  
  void start()
  {
    map = new Map();
    crab = new Crab();
    player = new Player();
    status = 1;
  }
  
  void stop()
  {
    status = 0;
  }
  
  void dead()
  {
    //TODO
  }
  
  void winLevel()
  {
    //TODO
  }
  
  void winGame()
  {
    //TODO
  }
}
