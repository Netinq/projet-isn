class Crab 
{
  public int refHeight = 0;
  public int playerHeight = 40;
  public int playerWidth = 30;
  public boolean rightPressed, leftPressed, upPressed, sens = true;
  public float gravity = 2;
  public int animEnCours = 0;
  public int delaisAnim;
  public boolean tryJump = false;
  public PVector location = new PVector(0, 5);
  public PVector velocity = new PVector(1, 1);
  public PImage spriteSheet;
  public int jump=0;
  PImage[] crabAnim= new PImage[2];
  boolean col = false;

  Crab()
  {
    location.y = height - 150 - playerHeight;
    refHeight = height;
    spriteSheet = loadImage("textures/entities/entities.png");
    delaisAnim = 0;
    crabAnim[0] = spriteSheet.get(10*16, 0, 16, 16);
    crabAnim[0].resize(40, 30);
    crabAnim[1] = spriteSheet.get(11*16, 0, 16, 16);
    crabAnim[1].resize(40, 30);
  }

  void animation()
  {
    if (delaisAnim > 3)
    {
      delaisAnim = 0;
      if (animEnCours ==1)
        animEnCours = 0;
      else
        animEnCours = 1;
    } else {
      delaisAnim++;
    }
  }

  void draw() {

    animation();
    image(crabAnim[animEnCours], location.x, location.y);

    gravity();
    movement();
    positionUpdate();

  }
  void jump()
  {
    velocity.y+= -2;  
  }
  void gravity()
  {
    if(!colBlocYBottom())
    {
      velocity.y++;
    } else {
      velocity.y = 0;
      jump = 0;
    }
  }
  void positionUpdate()
  {
    if (player.location.x > width/2) {
        location.x+=-player.velocity.x+velocity.x;
    } else {
      location.x+= velocity.x;
      location.y+= velocity.y;
    }
  }
  
  void movement()
  {
    if (wall())
    {
      velocity.x=0;
      if(jump<2)
      {
        jump();
        jump++;
      } else {
        sens=!sens;      
      }
    } else {
      if(sens)
      {
        if(velocity.x < 5)
          velocity.x++;
      } else {
        if(velocity.x > -5)
          velocity.x--;
      }
    }
  }
  boolean wall()
  {
    if (sens)
    {
      return colBlocXForward();
    } else {
      return colBlocXBackward();
    }
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
          return true;
        }
      }
    }
    return false;
  }
}
