public class ShowMusic
{
  PImage music;
  PImage birdie;
  boolean showBirdie;
  PFont font;
  String[] text;

  ShowMusic ()
  {
    Interactive.add( this ); // register it with the manager
    birdie = loadImage("birdie.png");
    showBirdie = true;
    font = createFont("Droid Sans", 18, true);
    text = new String[1];
    text[0] = "";
  }

  void load (String s)
  {
    music = loadImage(s);
    showBirdie = false;
    text = new String[1];
    text[0] = "";
  }

  void setText (String s)
  {
    text = loadStrings(s);
  }

  void draw()
  {
    if (music.width==-1 || showBirdie)
    {
      image (birdie, SIDEBAR_WIDTH, TOPBAR_HEIGHT, width-SIDEBAR_WIDTH, height-TOPBAR_HEIGHT);
      drawText();
    } else
    {
      float rescale = (width-SIDEBAR_WIDTH-(2*PADDING))*1.0/music.width;
      image (music, SIDEBAR_WIDTH+PADDING, TOPBAR_HEIGHT+PADDING, music.width*rescale, music.height*rescale);
    }
  }

  void drawText()
  {
    textFont(font);
    textSize(18);
    noStroke();
    fill(0);
    float y = TOPBAR_HEIGHT+PADDING;
    if (text.length>0)
    {
      for (int i=0; i<text.length; i++)
      {
        text(text[i], (SIDEBAR_WIDTH+width)*0.55, y);
        y += (textAscent()+textDescent())*1.5;
      }
    }
  }
}