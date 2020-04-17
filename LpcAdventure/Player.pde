class Player 
{
  public int refHeight = 0;
  public int playerHeight = 75;
  public int playerWidth = 40;
  public boolean rightPressed, leftPressed, upPressed, sens = true;
  public float gravity = 2;
  public int jump = 0;
  public int animEnCours = 0;
  public int delaisAnim;
  public PVector location = new PVector(0, 0);
  public PVector velocity = new PVector(1, 1);
  public PImage spriteSheet;
  PImage[] perso= new PImage[37];
  boolean col = false;

  Player()
  {
    location.y = height - 150 - playerHeight;
    refHeight = height;
    spriteSheet = loadImage("Entites.png");

    for (int x = 0; x < 36; x++) {
      perso[x] = spriteSheet.get(x*16, 0, 16, 16);
      perso[x].resize(40, 75);
    }
  }

  void animation() {

    if (velocity.y > 0 || velocity.y < 0 || jump != 0) {
      animEnCours = 5;
    } else {
      if (velocity.x < 0 || velocity.x > 0) {
        if (delaisAnim == 2) {
          if (animEnCours < 4 && animEnCours != 0 && animEnCours != 5) {
            animEnCours++;
          } else {
            animEnCours = 1;
          }
        }
      } else {
        animEnCours = 0;
      }
    }
  }

  void draw() {
    location.y += height-refHeight;
    if (refHeight != height) {
      refHeight = height;
    }
    background(55, 115, 225);
    rect(0, height - 100, width, 100);
    if (delaisAnim < 2)
      delaisAnim ++;
    else 
    delaisAnim = 0;
    animation();
    if(sens)
      image(perso[animEnCours], location.x, location.y);
    else
      image(perso[animEnCours+30], location.x, location.y);  
    Velocity();
    move();
  }

  boolean isUpPressed() {
    return upPressed;
  }
  boolean isLeftPressed() {
    return leftPressed;
  }
  boolean isRightPressed() {
    return rightPressed;
  }

  boolean colBlocXForward()
  {
    int x = int(location.x);
    int y = int(location.y);
    for (int i = 0; i < map.blocs.size(); i++)
    {
      if (x+playerWidth+1 > map.blocs.get(i)[0] && x+playerWidth+1 < map.blocs.get(i)[0]+50)
      {
        if ((y<= height - 150 - map.blocs.get(i)[1]+50 && y>= height - 150 - map.blocs.get(i)[1])
          ||(y+playerHeight<= height - 150 - map.blocs.get(i)[1]+50 && y+playerHeight>= height - 150 - map.blocs.get(i)[1]))
        {
          return true;
        }
      }
    }
    return false;
  }

  boolean colBlocXBackward()
  {
    int x = int(location.x);
    int y = int(location.y);
    for (int i = 0; i < map.blocs.size(); i++)
    {
      if (x > map.blocs.get(i)[0] && x < map.blocs.get(i)[0] +50)
      {
        if ((y<= height - 150 - map.blocs.get(i)[1]+50 && y>= height - 150 - map.blocs.get(i)[1])
          ||(y+playerHeight<= height - 150 - map.blocs.get(i)[1]+50 && y+playerHeight>= height - 150 - map.blocs.get(i)[1]))
        {
          return true;
        }
      }
    }
    return false;
  }

  boolean colBlocYTop()
  {
    int x = int(location.x);
    int y = int(location.y);
    for (int i = 0; i < map.blocs.size(); i++)
    {
      if (y-1<= height - 150 - map.blocs.get(i)[1]+50 && y-1>= height - 150 - map.blocs.get(i)[1])
      {
        if ((x > map.blocs.get(i)[0] && x+1 < map.blocs.get(i)[0]+50)
          ||(x+playerWidth > map.blocs.get(i)[0] && x+playerWidth < map.blocs.get(i)[0]+50))
        {
          return true;
        }
      }
    }
    return false;
  }

  boolean colBlocYBottom()
  {
    int x = int(location.x);
    int y = int(location.y);
    if (y+playerHeight+1 > height - 100) return true;
    for (int i = 0; i < map.blocs.size(); i++)
    {
      if (y+playerHeight+1<= height - 150 - map.blocs.get(i)[1]+50 && y+playerHeight+1>= height - 150 - map.blocs.get(i)[1])
      {
        if ((x > map.blocs.get(i)[0] && x+1 < map.blocs.get(i)[0]+50)
          ||(x+playerWidth > map.blocs.get(i)[0] && x+playerWidth < map.blocs.get(i)[0]+50))
        {
          jump = 0;
          return true;
        }
      }
    }
    return false;
  }

  void move()
  {
    for (int i = 0; i < velocity.x; i++)
    {
      if (!colBlocXForward()) {
        if (location.x < width/2) location.x++;
        else 
        {
          for (int b = 0; b < map.blocs.size(); b++)
          {
            map.blocs.get(b)[0]--;
          }
          for(int u = 0; u < map.blocsNoCollide.size(); u++)
          {
            map.blocsNoCollide.get(u)[0]--;
          }
        }
      } else {
        velocity.x = 0;
      }
    }
    for (int i = 0; i > velocity.x; i--)
    {
      if (!colBlocXBackward()) {
        if (location.x < width/2) location.x--;
        else 
        {
          for (int b = 0; b < map.blocs.size(); b++)
          {
            map.blocs.get(b)[0]++;
          }
          
          for(int u = 0; u < map.blocsNoCollide.size(); u++)
          {
            map.blocsNoCollide.get(u)[0]++;
          }
        }
      } else {
        velocity.x = 0;
      }
    }
    for (int i = 0; i > velocity.y; i--)
    {
      if (!colBlocYTop()) location.y--;
      else velocity.y = 0;
    }
    for (int i = 0; i < velocity.y; i++)
    {
      if (!colBlocYBottom()) location.y++;
      else velocity.y = 0;
    }
    for (int i = 0; i < gravity; i++)
    {
      if (velocity.y> 0 && colBlocYBottom()) velocity.y = 0;
      else if (!colBlocYBottom() && velocity.y < 20) velocity.y++;
    }
  }

  void Velocity() {
    if (isUpPressed()) {
      upPressed = false;
      if (colBlocYBottom()) {
        velocity.y -= 20; 
        jump = 1;
      } else if(jump == 1){
        velocity.y -= 20; 
        jump = 2;
      }
    }

    if (isLeftPressed()) {
      sens = false;
      if (velocity.x > 0) velocity.x = 1;
      if (velocity.x > -10) { //Tant que sa vitesse X est supérieur à 0
        velocity.x -= 1; //On baisse sa vitesse
      }
    }

    if (isRightPressed()) {
      sens = true;
      if (velocity.x < 0)velocity.x=-1;
      if (velocity.x < 10) {
        velocity.x += 1;
      }
    }

    if (isRightPressed() == false && isLeftPressed()== false) {
      if (sens) {
        if (velocity.x < 1) {
          velocity.x = 0;
        }
        if (velocity.x > 0) {
          velocity.x -= 2;
        }
      } else { 
        if (velocity.x > -1) {
          velocity.x = 0;
        }
        if (velocity.x < 0) {
          velocity.x += 2;
        }
      }
    }
  }
}
