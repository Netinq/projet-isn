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
