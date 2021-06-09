PShape surface;

int size = 500;
int terrainIncrement = 20;
int[][] heightMatrix;

void setupSurface() {  
  int matrixSize = size/terrainIncrement;
  heightMatrix = new int[matrixSize+1][matrixSize+1];
  
}

void generateSurface() {
  pushMatrix();
  surface = createShape(); 
  surface.translate(width/2-size/2, height/2-size/4);
  
  surface.beginShape(TRIANGLE);
  
  updateHeightMatrix();
  
  for (int i = 0; i<size; i+=terrainIncrement)
    for (int j = 0; j<size; j+=terrainIncrement) {
      
      surface.vertex(i, j, heightMatrix[i/terrainIncrement][j/terrainIncrement]);
      surface.vertex(i, j+terrainIncrement, heightMatrix[i/terrainIncrement][(j+terrainIncrement)/terrainIncrement]);
      surface.vertex(i + terrainIncrement, j, heightMatrix[(i+terrainIncrement)/terrainIncrement][j/terrainIncrement]);
      
      surface.vertex(i+terrainIncrement, j, heightMatrix[(i+terrainIncrement)/terrainIncrement][j/terrainIncrement]);
      surface.vertex(i, j+terrainIncrement, heightMatrix[i/terrainIncrement][(j+terrainIncrement)/terrainIncrement]);
      surface.vertex(i +terrainIncrement, j+terrainIncrement, heightMatrix[(i+terrainIncrement)/terrainIncrement][(j+terrainIncrement)/terrainIncrement]);
    }
    
  
  surface.endShape(CLOSE);
  popMatrix();
}

void updateHeightMatrix() {
  
  initHeight();
  
  updateEachPoint();
}

void initHeight() {
  for (int i= 0; i< heightMatrix.length; i++)
    for (int j= 0; j< heightMatrix[i].length; j++)
      heightMatrix[i][j] = -1;
}

void updateEachPoint() {
  for (SoundPoint point : points) {
  
    PVector pos = point.getPosition();
    
    int xPosition = (int) pos.x / terrainIncrement;
    int yPosition = (int) pos.y / terrainIncrement;
  
    int sizeMultiplier = 3;
    int sizeSubMatrix = (int) (point.getWidth()*sizeMultiplier);
    
    for (int row = -sizeSubMatrix; row <= sizeSubMatrix; row++) 
      for (int col = -sizeSubMatrix; col <= sizeSubMatrix; col++) {
        if (xPosition+row < heightMatrix.length && xPosition+row >=0 && 
            yPosition+col < heightMatrix[0].length && yPosition+col >=0) {
              
          int heightValue =  (int) (point.getWidth() * pos.z / (max(distanceBetweenPoints(0,0, row, col),point.getWidth())));
          
          if (heightValue > heightMatrix[xPosition+row][yPosition+col])
            heightMatrix[xPosition+row][yPosition+col] = heightValue;
        }
      }
  }
}

float distanceBetweenPoints(int x1, int y1, int x2, int y2) {
  return sqrt(pow(x1-x2,2)+pow(y1-y2,2));
}
