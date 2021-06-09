
public class Player{
  
  private PShape ufo;
  
  private PVector playerPosition;

  private int playerVelocity;
  private int playerIncrementX, playerIncrementY;
  
  private float colliderRadius;
  
  public Player() {
    
    ufo = loadShape("Objetos/UFO/source/ufo4.obj");
    ufo.rotateX(radians(90));
    
    PImage UFOTexture = loadImage("Textures/naveTexture.jpg");
    ufo.setTexture(UFOTexture);
  
    playerPosition = new PVector(size/2, size/2);
    playerIncrementX = 0;
    playerIncrementY = 0;
    
    playerVelocity = 3;
    colliderRadius = 12f;
  }
  
  public void drawPlayer() {
    pushMatrix();
    
    playerPosition.x+=playerIncrementX*40/frameRate;
    playerPosition.y+=playerIncrementY*40/frameRate;
    
    playerPosition.x = min(max(playerPosition.x, 0), size);
    playerPosition.y = min(max(playerPosition.y, 3*terrainIncrement), size - 4*terrainIncrement);
    translate(width/2-size/2 + playerPosition.x, height/2-size/4 + playerPosition.y, 60);
    
    shape(ufo);
    
    popMatrix();
  }
  
  public void changeIncrementX(int newIncrement) {
    playerIncrementX = newIncrement;
  }
  
  public void changeIncrementY(int newIncrement) {
    playerIncrementY = newIncrement;  
  }
  
  public int getPlayerVelocity() {
    return playerVelocity;
  }
  
  public float getRadius() {
    return colliderRadius;
  }
  
  public PVector getPosition() {
    return playerPosition;
  }
  
  public void resetPosition() {
    playerPosition.x = size/2;
    playerPosition.y = size/2;
  }
}
