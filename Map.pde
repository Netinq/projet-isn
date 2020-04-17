class Map {
  public int nbStructures = 10;
  public int safe = 1;
  public int pos[] = {100, 100};
  public PImage blocsSheet;
  PImage[] blocsTexture = new PImage[30];
  ArrayList<int[]> blocs = new ArrayList<int[]>();
  ArrayList<int[]> blocsNoCollide = new ArrayList<int[]>();

  Map()
  {
    for (int i = 0; i < nbStructures; i++) {
      defineStr();
      pos[0] += 250;
    }
    blocsSheet = loadImage("blocsSheet.png");
    for (int y = 0; y < 30; y++)
    {
      blocsTexture[y] = blocsSheet.get(y*50, 0, 50, 50);
    }
  }

  void draw()
  {
    floorBloc();
  }

  void floorBloc()
  {
    for (int i = 0; i < blocs.size(); i++)
    {
      image(blocsTexture[blocs.get(i)[2]], blocs.get(i)[0], height - 150 - blocs.get(i)[1]); 
    }
    for(int a =0; a < blocsNoCollide.size(); a++)
    {
      image(blocsTexture[blocsNoCollide.get(a)[2]], blocsNoCollide.get(a)[0], height - 150 - blocsNoCollide.get(a)[1]); 
    }
  }

  void defineStr()
  {
    switch(int(random(1, nbStructures+0)))
    {
    case 1:
      int[][] str_reg = new int[9][5];
      Table table = loadTable("str_lvl_1/str1.csv", "header");
      int real_col = 8;
      for (int row = 0; row < 9; row++)
      {
        for (int col = 1; col < 6; col++)
        {
          if (table.getRow(row).getInt("C"+col) != 0)
          {

            int[] str = new int[3];
            str[0] = (col-1)*50 + pos[0];
            str[1] = real_col*50;
            str[2] = table.getRow(row).getInt("C"+col)-1;
            if(str[2] >= 0)
              blocs.add(str);
            else {
             str[2] = str[2]*(-1)-2;
             blocsNoCollide.add(str);
            } 
          }
        }
        real_col--;
      }
      break;
    case 2:
      int[][] str_reg2 = new int[9][5];
      Table table2 = loadTable("str_lvl_1/str2.csv", "header");
      int real_col2 = 8;
      for (int row = 0; row < 9; row++)
      {
        for (int col = 1; col < 6; col++)
        {
          if (table2.getRow(row).getInt("C"+col) != 0)
          {

            int[] str = new int[3];
            str[0] = (col-1)*50 + pos[0];
            str[1] = real_col2*50;
            str[2] = table2.getRow(row).getInt("C"+col)-1;
            if(str[2] >= 0)
              blocs.add(str);
            else {
             str[2] = str[2]*(-1)-2;
             blocsNoCollide.add(str);
            } 
          }
        }
        real_col2--;
      }
      break;
    case 3:
      int[][] str_reg3 = new int[9][5];
      Table table3 = loadTable("str_lvl_1/str3.csv", "header");
      int real_col3 = 8;
      for (int row = 0; row < 9; row++)
      {
        for (int col = 1; col < 6; col++)
        {
          if (table3.getRow(row).getInt("C"+col) != 0)
          {

            int[] str = new int[3];
            str[0] = (col-1)*50 + pos[0];
            str[1] = real_col3*50;
            str[2] = table3.getRow(row).getInt("C"+col)-1;
            if(str[2] >= 0)
              blocs.add(str);
            else {
             str[2] = str[2]*(-1)-2;
             blocsNoCollide.add(str);
            } 
          }
        }
        real_col3--;
      }
      break;
    case 4:
      int[][] str_reg4 = new int[9][5];
      Table table4 = loadTable("str_lvl_1/str4.csv", "header");
      int real_col4 = 8;
      for (int row = 0; row < 9; row++)
      {
        for (int col = 1; col < 6; col++)
        {
          if (table4.getRow(row).getInt("C"+col) != 0)
          {

            int[] str = new int[3];
            str[0] = (col-1)*50 + pos[0];
            str[1] = real_col4*50;
            str[2] = table4.getRow(row).getInt("C"+col)-1;
            if(str[2] >= 0)
              blocs.add(str);
            else {
             str[2] = str[2]*(-1)-2;
             blocsNoCollide.add(str);
            } 
          }
        }
        real_col4--;
      }
      break;
    case 5:
      int[][] str_reg5 = new int[9][5];
      Table table5 = loadTable("str_lvl_1/str5.csv", "header");
      int real_col5 = 8;
      for (int row = 0; row < 9; row++)
      {
        for (int col = 1; col < 6; col++)
        {
          if (table5.getRow(row).getInt("C"+col) != 0)
          {

            int[] str = new int[3];
            str[0] = (col-1)*50 + pos[0];
            str[1] = real_col5*50;
            str[2] = table5.getRow(row).getInt("C"+col)-1;
            if(str[2] >= 0)
              blocs.add(str);
            else {
             str[2] = str[2]*(-1)-2;
             blocsNoCollide.add(str);
            }     
          }
        }
        real_col5--;
      }
      break;
    }
  }
}
