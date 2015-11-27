PImage ship;
PImage shield;
PImage thruster;
PImage rcsr,rcsl,rcsf;
int testP;
SpaceShip hawk = new SpaceShip();
double directP;

boolean wPressed,aPressed,sPressed,dPressed,jump,stopping;
boolean lStrafe,rStrafe,wThrust,sThrust;
//your variable declarations here
public void setup() 
{
  //background(0);
  size(900,900);
  testP = 450;
  ship = loadImage("AerospaceFighter.png"); //Reference http://hpashkov.deviantart.com/art/Furious-Hawk-VTOL-Fighter-concept-359613617
  shield = loadImage("Shield.png"); //Shields From FTL:Faster Than Light copyright Subset Games 2012
  thruster = loadImage("ThrusterMain.png"); //Main engine Thruster x2
  rcsr = loadImage("RCS_right.png");
  rcsl = loadImage("RCS_left.png");
  rcsf = loadImage("RCS_forward.png");
  ship.resize(100,102);
  shield.resize(116,148);
  thruster.resize(9,40);
  rcsr.resize(20,20);
  rcsl.resize(20,20);
  rcsf.resize(20,20);
  wPressed = false;
  aPressed = false;
  sPressed = false;
  dPressed = false;
  stopping = false;
  jump = false;
  lStrafe = false;
  rStrafe = false;
  wThrust = false;
  sThrust = false;
}
public void draw() 
{
  background(0);
  directP = hawk.getPointDirection()+90;
  if(directP > 360){
    directP = 0;
  }
  if(directP <= 0){
    directP = 360;
  }
  hawk.show();
  hawk.move();
  if(wPressed == true){
    hawk.accelerate(0.1);
  }else if(sPressed){
    hawk.accelerate(-0.1);
  }
  if(aPressed == true){
    hawk.turn(-3);
  }else if(dPressed == true){
    hawk.turn(3);
  }
  if(stopping == true){
    if(hawk.getDirectionX() > 0.1 && directP < 180){
      hawk.setDirectionX(hawk.getDirectionX() - 0.1);
      sThrust = true;
    }else if(hawk.getDirectionX() > 0.1 && directP > 180){
      hawk.setDirectionX(hawk.getDirectionX() - 0.1);
      wThrust = true;
      sThrust = false;
    }
    else if(hawk.getDirectionX() < -0.1 && directP < 180){
      hawk.setDirectionX(hawk.getDirectionX() + 0.1);
      wThrust = true;
    }else if(hawk.getDirectionX() < -0.1 && directP > 180){
      hawk.setDirectionX(hawk.getDirectionX() + 0.1);
      wThrust = false;
      sThrust = true;
    }else{
      hawk.setDirectionX(0);
      wThrust = false;
      sThrust = false;
    }
    if(hawk.getDirectionY() > 0.1){
      hawk.setDirectionY(hawk.getDirectionY() - 0.1);
      lStrafe = true;
    }else if(hawk.getDirectionY() < -0.1){
      hawk.setDirectionY(hawk.getDirectionY() + 0.1);
      rStrafe = true;
    }else{
      hawk.setDirectionY(0);
      rStrafe = false;
      lStrafe = false;
    }
  }
  System.out.println(hawk.getPointDirection()+90);
  //hawk.setPointDirection((int)(1+hawk.getPointDirection()));
}
class SpaceShip extends Floater  
{   
  SpaceShip(){
    myCenterX = 450;
    myCenterY = 450;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x){
    myCenterX = x;
  }
  public int getX(){
    return (int)myCenterX;
  }
  public void setY(int y){
    myCenterY = y;
  }
  public int getY(){
    return (int)myCenterY;
  }
  public void setDirectionX(double x){
    myDirectionX = x;
  }
  public double getDirectionX(){
    return (double)myDirectionX;
  }
  public void setDirectionY(double y){
    myDirectionY = y;
  }
  public double getDirectionY(){
    return (double)myDirectionY;
  }
  public void setPointDirection(int degrees){
    myPointDirection = degrees;
  }
  public double getPointDirection(){
    return (double)myPointDirection;
  }

  public void show(){
    translate((float)myCenterX, (float)myCenterY);
    double dRaisins = (myPointDirection+90)*Math.PI/180;
    rotate((float)dRaisins);
    if(wThrust == true){ //Main Engines
      image(thruster,3,12);
      image(thruster,-11,12);
    }
    if(sThrust == true){ //Retro Rockets
      image(rcsf,37,-18);
      image(rcsf,-56,-18);
      image(rcsf,0,-45);
      image(rcsf,-19,-45);
    }
    if(aPressed == true){ //Rotate counterclockwise Reaction control
      image(rcsr,0,-60);
      image(rcsl,-20,14);
    }
    if(dPressed == true){ //Rotate clockwise Reaction control
      image(rcsr,1,13);
      image(rcsl,-19,-60);
    }
    if(lStrafe == true){
      image(rcsr,1,13);
      image(rcsr,0,-60);
    }
    if(rStrafe == true){
      image(rcsl,-19,-60);
      image(rcsl,-20,14);
    }
    image(ship,-49.5,-59);
    image(shield,-57.5,-73);

    rotate(-(float)dRaisins);
    translate(-(float)myCenterX, -(float)myCenterY);
    stroke(255,0,0);
  }
}

public void keyPressed(){
  if(key == 'w' || keyCode == UP){
    wPressed = true;
    wThrust = true;
  }
  if(key == 'a' || keyCode == LEFT){
    aPressed = true;
  }
  if(key == 's' || keyCode == DOWN){
    sPressed = true;
    sThrust = true;
  }
  if(key == 'd' || keyCode == RIGHT){
    dPressed = true;
  }
  if(key == 'q'){
    lStrafe = true;
  }
  if(key == 'e'){
    rStrafe = true;
  }
  if(key == 'c'){
    stopping = true;
  }
  if(key == ' '){
    jump = true;
  }
}
public void keyReleased(){
  if(key == 'w' || keyCode == UP){
    wPressed = false;
    wThrust = false;
  }
  if(key == 'a' || keyCode == LEFT){
    aPressed = false;
  }
  if(key == 's' || keyCode == DOWN){
    sPressed = false;
    sThrust = false;
  }
  if(key == 'd' || keyCode == RIGHT){
    dPressed = false;
  }
  if(key == 'q'){
    lStrafe = false;
  }
  if(key == 'e'){
    rStrafe = false;
  }
  if(key == 'c'){
    stopping = false;
    wThrust = false;
    sThrust = false;
    lStrafe = false;
    rStrafe = false;
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
    double dRadians = myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void turn (int nDegreesOfRotation)   
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

