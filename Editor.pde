import static javax.swing.JOptionPane.*;

public class EditorMap {
  int nbTexture = 94;
  File csvImport;
  PImage blocsSheet, pen, eraser, export, importPng, up, down;
  PImage[] blocsTexture = new PImage[nbTexture];
  int[][] blocAt=new int[5][9];
  int[][] blocListAt=new int[5][ceil(nbTexture/5)+1];
  String[] blocList = {"herbe", "terre", "pierre", "pierre moussue", "brique", "bloc noir", "bloc bleu foncé", "bloc marron", "bloc cyan", "bloc gris foncé", "bloc vert foncé", "bloc bleu clair", "bloc vert clair", "bloc magenta", "bloc orange", "bloc rose", "bloc violet", "bloc rouge", "bloc gris clair", "bloc blanc", "bloc jaune", "paille", "échelle", "bûche", "planche", "sable", "grès", "feuilles", "lampe off", "lampe on"};
  int cnt = 0;
  int blocSelected = 0;
  boolean delete = false;
  int hauteur = 1;
  int largeur = 1;
  int scroll;
  boolean maxScroll;
  long drawSuccess=0L;
  String name;

  EditorMap()
  {
    this.hauteur = int(showInputDialog("Hauteur"));
    this.largeur = int(showInputDialog("Largeur"));
    blocAt=new int[largeur+1][hauteur+1];
    blocsSheet = loadImage("textures/editor/editorBlocsSheet.png");
    eraser = loadImage("textures/editor/gomme.png");
    pen = loadImage("textures/editor/crayon.png");
    export= loadImage("textures/editor/valider.png");
    importPng = loadImage("textures/editor/import.png");
    up =loadImage("textures/editor/Up.png");
    down =loadImage("textures/editor/Down.png");
    scroll = 0;
    maxScroll = false;
    for (int y = 0; y < nbTexture; y++)
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
    image(importPng, width/2+68+34+32, 15, 32, 32);
    image(up, width-45, height/2-16, 32, 32);
    image(down, width-45, height/2+16, 32, 32);
    for (int col = 0; col < largeur; col++) {
      for (int row = 0; row < hauteur; row++) { 
        if (Integer.valueOf(blocAt[col][row]) != null) {
          if (blocAt[col][row] >=0)
            image(blocsTexture[blocAt[col][row]], col*(width/2/largeur), row*(height/hauteur), (width/2/largeur)+2, height/hauteur);
          else {
            tint(255, 0, 0, 255);
            image(blocsTexture[blocAt[col][row]*(-1)], col*(width/2/largeur), row*(height/hauteur), width/2/largeur, height/hauteur);
            tint(255);
          }
        } else {
          blocAt[col][row] = 0;
        }
      }
    }
    int increment = 0;
    for (int row = 0; row < 8; row++)
    {
      for (int col = 0; col < 5; col++)
      {


        fill(255);
        text("Choississez le bloc à placer, et le mode (effacer/placer)", width/2+width/5, height/9.5-(height/50));  
        if (increment+1+scroll*5 < nbTexture) {
          image(blocsTexture[increment+1+scroll*5], (width/2)*1.1+col*(width/12), row*height/9.5+(height/10), width/15-2, height/9.5-2);
          maxScroll = false;
        } else {
          maxScroll = true;
        }
        blocListAt[col][row] = increment+1+scroll*5;
        increment++; 

        if (!delete) {
          fill(180);
          text("Mode édition", width/2+width/5, height/9.5-40);
        } else {
          fill(120);
          text("Mode gomme", width/2+width/5, height/9.5-40);
        }
      }
    }
    
    if((System.currentTimeMillis()/1000L)-drawSuccess < 5)
    {
      fill(0,155,50);
      text("Fichier "+name+".csv exporté avec succès", width/2+width/5, height/9.5-40-20);  
    }
  }
  void mouseDragged()
  {

    if (overBloc() != null)
    {
      int[] colrow = overBloc();
      int col =colrow[0];
      int row = colrow[1];
      if (!delete)
      {
        if (mouseButton == LEFT) {
          blocAt[col][row] = blocSelected;
        } else {
          blocAt[col][row] = blocSelected*(-1);
        }
      } else {
        blocAt[col][row] = 0;
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
        if (mouseButton == LEFT) {
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

    if (mouseX >= width-45 && mouseX <= width-45+32)
    {
      if (mouseY >= height/2-16 && mouseY <= height/2-16+32)
      {
        if (scroll > 0)
          scroll--;
      }
    }

    if (mouseX >= width-45 && mouseX <= width-45+32)
    {
      if (mouseY >= height/2+16 && mouseY <= height/2+16+32)
      {
        if (!maxScroll)
          scroll++;
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
    selectInput("Choississez le fichier .csv à importer", "fileSelected", null, this);
  }

  void fileSelected(File selection) {
    if (selection == null) {
      println("Fenetre fermée ou fichier introuvable");
    } else {
      Table table = loadTable(selection.getAbsolutePath(), "header");
      hauteur = table.getRowCount();
      largeur = table.getColumnCount();
      blocAt=new int[largeur+1][hauteur+1];
      for (int row = 0; row < hauteur; row++)
      {
        for (int col = 1; col < largeur ; col++)
        {
          blocAt[col][row] = table.getRow(row).getInt("C"+col);
        }
      }
    }
  }

  void exportCsv()
  {

    name = showInputDialog("Entrez le nom du fichier");
    Table table = new Table();
    for (int i=0; i<largeur; i++) {
      table.addColumn("C"+(i+1));
    }

    for (int row=0; row<hauteur; row++)
    {
      TableRow newRow = table.addRow();
      for (int col=1; col<largeur+1; col++)
      {
        newRow.setInt("C"+col, blocAt[col-1][row]);
      }
    }
    drawSuccess = System.currentTimeMillis()/1000L;
    saveTable(table, name+".csv");
  }





  int[] overBloc()
  {
    for (int col = 0; col < largeur; col++) {
      for (int row = 0; row < hauteur; row++) {
        if (mouseX >= col*(width/2/largeur) && mouseX <= col*(width/2/largeur)+(width/2/largeur))
        {
          if (mouseY >= row*(height/hauteur) && mouseY <= row*(height/hauteur)+(height/hauteur))
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
      for (int row = 0; row < 8; row++) {
        if (mouseX >= (width/2)*1.1+col*(width/12) && mouseX <= (width/2)*1.1+col*(width/12)+width/15-2)
        {
          if (mouseY >=row*height/9.5+(height/10) && mouseY <= row*height/9.5+(height/10)+height/9.5-2)
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
