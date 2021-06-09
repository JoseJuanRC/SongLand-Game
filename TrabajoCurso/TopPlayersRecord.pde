import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class RecordManager {
  
  private String filename;
  private int[] topRecords;
  
  public RecordManager(String filename) {
    this.filename = filename;
  }
  
  public void readRecord() {
    BufferedReader reader;
    
    try {
      reader = createReader(filename);
            
      topRecords = new int[3];
      
      for (int i = 0; i<topRecords.length; i++) {
        topRecords[i] = Integer.parseInt(reader.readLine());
      }
      
      reader.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  private void saveRecord(){
    PrintWriter writer;
    
    try {
      writer = createWriter(filename);
            
      String data = "";
      for (int i = 0; i<topRecords.length; i++)
        data += topRecords[i] + "\n";
      
      
      writer.write(data);
      
      writer.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  public int[] getRecord() {
    return topRecords;
  }
  
  // Devuelve nueva posición en el ranking o -1 en caso contrario
  public int checkNewScore(int score) {
    int topIndex = -1;
    for (int i = 0; i<topRecords.length; i++)
      if (score>topRecords[i]) {
        topIndex = i;
        break;
      }
    
    // Movemos el array de records si encontramos una posicón mejor
    if (topIndex != -1) {
      for (int i = topRecords.length-1; i>topIndex; i--) {
        topRecords[i] = topRecords[i-1];
      }
      topRecords[topIndex] = score;
      saveRecord();
    }
    
    return topIndex;
  }
  
}
