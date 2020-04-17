public class EditorMap {

  File csvImport;
  PImage blocsSheet, pen, eraser, export,importPng;
  PImage[] blocsTexture = new PImage[31];
  int[][] blocAt=new int[5][9];
  int[][] blocListAt=new int[5][6];
  String[] blocList = {"herbe", "terre", "pierre", "pierre moussue", "brique", "bloc noir", "bloc bleu foncé", "bloc marron", "bloc cyan", "bloc gris foncé", "bloc vert foncé", "bloc bleu clair", "bloc vert clair", "bloc magenta", "bloc orange", "bloc rose", "bloc violet", "bloc rouge", "bloc gris clair", "bloc blanc", "bloc jaune", "paille", "échelle", "bûche", "planche", "sable", "grès", "feuilles", "lampe off", "lampe on"};
  int cnt = 0;
  int blocSelected = 0;
  boolean delete = false;

  EditorMap()
  {
    blocsSheet = loadImage("editorBlocsSheet.png");
    eraser = loadImage("gomme.png");
    pen = loadImage("crayon.png");
    export= loadImage("valider.png");
    importPng = loadImage("import.png");
    for (int y = 0; y < 31; y++)
    {
      blocsTexture[y] = blocsSheet.get(y*50, 0, 50, 50);
    }
  }

  void draw()
  {
    background(41, 39, 39);
    image(pen, width/2+34, 15, 32, 32);
    image(eraser, width/2+34+34, 15, 32, 32);
    image(export, width/2+68+34, 15, 32, 32);
    image(importPng,width/2+68+34+32,15,32,32);
    
    for (int col = 0; col < 5; col++) {
      for (int row = 0; row < 9; row++) { 
        if (Integer.valueOf(blocAt[col][row]) != null) {
          if(blocAt[col][row] >=0)
            image(blocsTexture[blocAt[col][row]], 2+col*width/15, row*height/9.5, width/15-2, height/9.5-2);
          else {
            tint(255,0,0,255);
            image(blocsTexture[blocAt[col][row]*(-1)], 2+col*width/15, row*height/9.5, width/15-2, height/9.5-2);
            tint(255);
          }          
        } else {
          blocAt[col][row] = 0;
        }
      }
    }
    int increment = 0;
    for (int col = 0; col < 5; col++)
    {
      for (int row = 0; row < 6; row++)
      {

        fill(255);
        text("Choississez le bloc à placer, et le mode (effacer/placer)", width-(width/2), height/9.5-(height/50));
        image(blocsTexture[increment+1], (width/15)*col+(width/2), row*height/9.5+(height/10), width/15-2, height/9.5-2);
        blocListAt[col][row]=increment+1;
        increment++; 

        if (!delete) {
          fill(180);
          text("Mode édition", width/2-(width/10), height/9.5-40);
        } else {
          fill(120);
          text("Mode gomme", width/2-(width/10), height/9.5-40);
        }
      }
    }
  }

  void mouseClicked()
  {
    overOutil();
    if (overBloc() != null)
    {
      int[] colrow = overBloc();
      int col =colrow[0];
      int row = colrow[1];
      if (!delete)
      {
        if(mouseButton == LEFT) {
          blocAt[col][row] = blocSelected;
        } else {
          blocAt[col][row] = blocSelected*(-1);       
        }
      } else {
        blocAt[col][row] = 0;
      }
    }

    if (overListeBloc() != null)
    {
      int[] colrow = overListeBloc();
      int col =colrow[0];
      int row = colrow[1];
      blocSelected = blocListAt[col][row];
    }
    if (menu_return.back.hover())
    {
      status =0;
    }
  }

  void overOutil()
  {
    if (mouseX >= width/2+34 && mouseX <= width/2+32+34)
    {
      if (mouseY >= 15 && mouseY <= 47)
      {
        delete = false;
      }
    }

    if (mouseX >= width/2+34+34 && mouseX <= width/2+66+34)
    {
      if (mouseY >= 15 && mouseY <= 47)
      {
        delete = true;
      }
    }

    if (mouseX >= width/2+68+34 && mouseX <= width/2+100+34)
    {
      if (mouseY >= 15 && mouseY <= 47)
      {
        exportCsv();
      }
    }
    
    if (mouseX >= width/2+68+34+32 && mouseX <= width/2+68+34+32+32)
    {
      if (mouseY >= 15 && mouseY <= 47)
      {
        importCsv();
      }
    }
  }
  
  void importCsv()
  {
    selectInput("Choississez le fichier .csv à importer", "fileSelected",null,this);
  }
  
  void fileSelected(File selection) {
    if (selection == null) {
      println("Fenetre fermée ou fichier introuvable");
    } else {
      Table table = loadTable(selection.getAbsolutePath(), "header");
      for (int row = 0; row < 9; row++)
      {
        for (int col = 1; col < 6; col++)
        {
          blocAt[col][row] = table.getRow(row).getInt("C"+col);
        }
      }
    }
    
  }
  
  void exportCsv()
  {
    Long name = System.currentTimeMillis();
    Table table = new Table();
    for (int i=1; i<6; i++) {
      table.addColumn("C"+i);
    }

    for (int row=0; row<9; row++)
    {
      TableRow newRow = table.addRow();
      for (int col=1; col<6; col++)
      {
        newRow.setInt("C"+col, blocAt[col-1][row]);
      }
    }

    saveTable(table, name+".csv");
  }





  int[] overBloc()
  {
    for (int col = 0; col < 5; col++) {
      for (int row = 0; row < 9; row++) {
        if (mouseX >= 2+col*width/15 && mouseX <= 2+col*width/15+width/15-2)
        {
          if (mouseY >= row*height/9.5-10 && mouseY <= row*height/9.5+height/9.5-2)
          {
            int returning[] = {col, row};
            return returning;
          }
        }
      }
    }
    return null;
  }

  int[] overListeBloc()
  {
    for (int col = 0; col < 5; col++) {
      for (int row = 0; row < 6; row++) {
        if (mouseX >= (width/15)*col+(width/2) && mouseX <= (width/15)*col+(width/2)+(width/15-2))
        {
          if (mouseY >= row*height/9.5+(height/10) && mouseY <= row*height/9.5+(height/10)+(height/9.5-2))
          {
            int returning[] = {col, row};
            return returning;
          }
        }
      }
    }
    return null;
  }
}
