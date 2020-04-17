class Map {
  
  public int nbStructuresRegister = listFiles("/str_lvl_1").length-1;
  public int nbStructuresGenerate = 10;
  public int safe = 1;
  public int pos[] = {0, 100};
  public PImage blocsSheet;
  PImage[] blocsTexture = new PImage[93];
  ArrayList<int[]> blocs = new ArrayList<int[]>();
  ArrayList<int[]> blocsNoCollide = new ArrayList<int[]>();
  ArrayList<int[]> blocsFloor = new ArrayList<int[]>();
  
  private int maxSameStr = 2;
  private int[] strcount = new int[nbStructuresRegister];
  private int lastStr = 0;

  Map()
  {
    registerStr("str_lvl_1/str_start.csv", false);
    for (int i = 0; i < nbStructuresGenerate; i++) {
      defineStr();
    }
    blocsSheet = loadImage("textures/blocs/blocsSheet.png");
    for (int y = 0; y < 93; y++)
    {
      blocsTexture[y] = blocsSheet.get(y*50, 0, 50, 50);
    }
  }

  void draw()
  {
    background(55, 115, 225);
    floorBloc();
  }

  void floorBloc()
  {
    for (int i = 0; i < blocs.size(); i++)
    {
      image(blocsTexture[blocs.get(i)[2]], blocs.get(i)[0], height - 150 - blocs.get(i)[1]); 
    }
    for (int i = 0; i < blocsFloor.size(); i++)
    {
      image(blocsTexture[blocsFloor.get(i)[2]], blocsFloor.get(i)[0], height - blocsFloor.get(i)[1]);
      if (blocsFloor.get(i)[2] == 0) image(blocsTexture[blocsFloor.get(i)[2]+1], blocsFloor.get(i)[0], height + 50 - blocsFloor.get(i)[1]); 
      else image(blocsTexture[blocsFloor.get(i)[2]], blocsFloor.get(i)[0], height + 50 - blocsFloor.get(i)[1]); 
    }
    for(int a =0; a < blocsNoCollide.size(); a++)
    {
      image(blocsTexture[blocsNoCollide.get(a)[2]], blocsNoCollide.get(a)[0], height - 150 - blocsNoCollide.get(a)[1]); 
    }
  }
  
  void registerStr(String tableName, boolean posC)
  {
    Table table = loadTable(tableName, "header");
    int real_col = 8;
    for (int row = 0; row < 10; row++)
    {
      for (int col = 1; col <= table.getColumnCount(); col++)
      {
        if (table.getRow(row).getInt("C"+col) != 0)
        {
          if (row == 9)
          {
            int[] str = new int[3];
            if(posC) str[0] = (col-1)*50 + pos[0];
            else str[0] = (col-1)*50;
            str[1] = 100;
            str[2] = table.getRow(row).getInt("C"+col)-1;
            blocsFloor.add(str);
          } else {
          int[] str = new int[3];
          if(posC) str[0] = (col-1)*50 + pos[0];
          else str[0] = (col-1)*50;
          str[1] = real_col*50;
          str[2] = table.getRow(row).getInt("C"+col)-1;
          if(str[2] >= 0)
            blocs.add(str);
          else {
           str[2] = str[2]*(-1)-2;
           blocsNoCollide.add(str);
          }}
        }
      }
      real_col--;
    }
    pos[0] += table.getColumnCount()*50;
  }

  void defineStr()
  {
    int number = int(random(1, nbStructuresRegister+1));
    while (strcount[number-1] >= maxSameStr || lastStr == number) {
      number = int(random(1, nbStructuresRegister+1));
    }
    registerStr("str_lvl_1/str"+number+".csv", true);
    strcount[number-1]++;
    lastStr = number;
  }
}
