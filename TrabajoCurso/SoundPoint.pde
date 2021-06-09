
public class SoundPoint {

  private PVector position;

  private float zIncrement = 0.4f;
  private float widthSize;
  private float colliderRadius;
  
  public boolean scorePoint;
  
  public SoundPoint(int xPos, int yPos) {
    position = new PVector(xPos, yPos, 1);
    widthSize = random(0.5,2.0);
    scorePoint = false;
    colliderRadius = 4f;
  }

  public PVector getPosition() {
    return this.position;
  }
  
  public float distanceBetweenPoints(SoundPoint point) {
    return position.dist(point.getPosition());
  }
  
  public void movePoint() {
    if (position.z > 50 && zIncrement>0) {
      zIncrement = -zIncrement;
    }
    
    position.z+=zIncrement*40/frameRate;
  }
  
  public boolean checkDelete() {
    return position.z < -1;
  }
  
  public float getWidth() {
    return widthSize;
  }
  
  public boolean checkScore(Player player) {
    // Si ya ha anotado con este punto no realizaremos ninguna comprobación
    if (scorePoint) return false;
    
    // Comprobar si la bola esta dentro del punto actual
    float distance = (new PVector(position.x,position.y)).dist(player.getPosition());
    
    boolean inside = distance < colliderRadius + player.getRadius();
     
    if (inside)
      scorePoint = true;
    
    return inside;
  }
}
