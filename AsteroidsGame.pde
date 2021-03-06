SpaceShip Earth;
ArrayList <Asteroid> lotsRocks = new ArrayList <Asteroid>();
Star [] galaxy;
ArrayList <Bullet> bobs = new ArrayList <Bullet>();

public void setup() 
{
  size(500,500);
  background(0);
  Earth = new SpaceShip();
  galaxy = new Star[150];
  for(int i = 0; i < galaxy.length; i++)
  {
    galaxy[i] = new Star();
  }
  for(int i = 0; i < 5; i++)
  {
    lotsRocks.add(new Asteroid());
  }
}

public void draw() 
{
  background(0);
  Earth.show();
  Earth.move();
  //Stars
  for(int i = 0; i < galaxy.length; i++)
  {
    galaxy[i].show();
  }
  //Asteroids
  for(int i = 0; i < lotsRocks.size(); i++)
  {
    lotsRocks.get(i).show();
    lotsRocks.get(i).move();
  }
  //Bullets
  for(int i = 0; i < bobs.size(); i++)
  {
    bobs.get(i).show();
    bobs.get(i).move();
    if((bobs.get(i).getX() > width-10) || (bobs.get(i).getY() > height-10) || (bobs.get(i).getX() < 10) || (bobs.get(i).getY() < 10))
       bobs.remove(i);
       break;
  }
  //find distance between spaceship and asteroids 
  for(int i=0; i< lotsRocks.size(); i++)
  {
    float d = dist(Earth.getX(), Earth.getY(), lotsRocks.get(i).getX(), lotsRocks.get(i).getY());
    if(d < 20)
    {
      lotsRocks.remove(i);
      break;
    }
    //find distance between asteroids and bullets
    for(int r = 0; r < bobs.size(); r++)
    {
       float m = dist(lotsRocks.get(i).getX(), lotsRocks.get(i).getY(), bobs.get(r).getX(), bobs.get(r).getY());
       if(m < 20)
       {
         lotsRocks.remove(i);
         bobs.remove(r);   
         break;
       }  
    }
  }
}

class Star
{
  private int myX, myY;
  public Star()
  {
    myX = (int)(Math.random()*500);
    myY = (int)(Math.random()*500);
  }
  public void show()
  {
    ellipse(myX, myY, 3, 3);
  }
}

class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
    corners = 3;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -8;
    xCorners[1] = 16;
    yCorners[1] = 0;
    xCorners[2] = -8;
    yCorners[2] = 8;
    myColor = 255;
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0; 
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x) {myCenterX=x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY=y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX=x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY=y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection=degrees;}
  public double getPointDirection() {return (int)myPointDirection;}
}

class Asteroid extends Floater
{
  private int rotSpeed;
  public Asteroid()
  {
    if(Math.random() < .5)
      rotSpeed = 1;
    else
      rotSpeed = -1;
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -11;
    yCorners[0] = -8;
    xCorners[1] = 7;
    yCorners[1] = -8;
    xCorners[2] = 13;
    yCorners[2] = 0;
    xCorners[3] = 6;
    yCorners[3] = 10;
    xCorners[4] = -11;
    yCorners[4] = 8;
    xCorners[5] = -5;
    yCorners[5] = 0;
    myColor = 255;
    myCenterX = (int)(Math.random()*500);
    myCenterY = (int)(Math.random()*500);
    myDirectionX = (int)(Math.random()*3); 
    myDirectionY = (int)(Math.random()*3);
    myPointDirection = 0;
  }
  public void setX(int x) {myCenterX=x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY=y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX=x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY=y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection=degrees;}
  public double getPointDirection() {return (int)myPointDirection;}
 
  public void move()
  {
    rotate(rotSpeed);
    super.move();
  }
}

class Bullet extends Floater
{
  public Bullet(SpaceShip Earth)
  {
    myCenterX = Earth.getX();
    myCenterY = Earth.getY();
    myPointDirection = Earth.getPointDirection();
    double dRadians = myPointDirection * (Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + Earth.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + Earth.getDirectionY();
  }

  public void setX(int x) {myCenterX=x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY=y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX=x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY=y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection=degrees;}
  public double getPointDirection() {return (int)myPointDirection;}
  
  public void show()
  {
    ellipse((int)myCenterX, (int)myCenterY, 20, 20);
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)     
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

public void keyPressed()
{
   if(key == 'h')
   {
     Earth.setDirectionX(0);
     Earth.setDirectionY(0);
     Earth.setX((int)(Math.random()*500));
     Earth.setY((int)(Math.random()*500));
   }
   if(key == 'a')
   {
    Earth.setDirectionX(Math.random()*10);
   }
   if(key == 'e')
   {
    Earth.setPointDirection((int)Earth.myPointDirection-5);
   }
   if(key == 'r')
   {
    Earth.setPointDirection((int)Earth.myPointDirection+5);
   }
   if(key == ' ')
   {
    bobs.add(new Bullet(Earth));
   }
}
