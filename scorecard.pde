public class Scorecard
{
  float x, y, w, h;
  Integrator ix;
  Integrator[] starxi;
  float[] starx;
  float center;
  PFont font;
  int stars;
  PImage star;
  boolean active;
  float targets[] = {0.2, 0.4, 0.55, 0.7, 0.9 };
  float score;

  Scorecard(float x, float y, float w, float h)
  {
    Interactive.add( this ); // register it with the manager
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    ix = new Integrator(width);
    font = createFont("Helvetica", 24, true);
    star = loadImage("star1.png");
    center = x + w/2;
    active = false;
    score = 0;
    starx = new float[5];
    starxi = new Integrator[5];
    for (int i=0; i<5; i++)
    {
      starxi[i] = new Integrator(width,0.8,map(i,0,4,0.1,0.05));
      starx[i] = map(i, -1, 6, x, x+w);
    }
  }

  void setScore (float f)
  {
    score = f;
    stars = numStars(score);
    println("stars: "+stars);
    for (int i=0; i<stars; i++)
    {
      starxi[i].value = width;
      starxi[i].target(starx[i]);
    }
    active = true;
  }

  private int numStars (float score)
  {
    int stars = 0;
    for (int i=0; i<targets.length; i++)
    {
      if (score >= targets[i]) stars = i+1;
    }
    return stars;
  }

  void draw()
  {
    ix.update();
    if (active)
    {
      ix.target(x);
    } else ix.target(width+PADDING);
    if (ix.value < width)
    {
      center = ix.value + w/2;
      strokeWeight(2);
      stroke(0);
      fill(255);
      rect(ix.value, y, w, h, 10);
      strokeWeight(1);
      noStroke();
      fill(0);
      textFont(font);
      textSize(24);
      textAlign(CENTER);
      text("Latido Score", center, y+48);
      textAlign(LEFT);
      
      for (int i=0; i<stars; i++)
      {
        starxi[i].update();
        image(star,starxi[i].value,y+100);
      } 
    }
  }
}