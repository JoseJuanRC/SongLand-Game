int newTopPosition;

void initMenu() {
  
  textAlign(CENTER);
  background(0);
  fill(255);
  textSize(90); 
  text("Welcome to Songland!", width/2, height/6);
  
  
  textAlign(LEFT);  
  textSize(26); 
  text("Player1:\n - Move your head to translate your UFO and get points in mountains peak\n\n" +
        "Player2:\n - Talk and use the sensor to modify the terrain", width/10, height/3);
  textSize(20); 
  text("Special keys:\n- m: Display or hide stroke", width/10, height/1.5);
  
  
  
  textAlign(CENTER);  
  textSize(24); 
  fill(255,200,100);    
  text("Press enter to play", width/2, height/1.2); 
}


void EndScreen() {
  textAlign(CENTER);
  
  background(0);
  fill(255);
  textSize(30); 
  
  String recordString = "";
  
  int[] recordsValue = recordManager.getRecord();
  
  for(int i = 0; i<recordsValue.length; i++)
    recordString+=(i+1) + ":  " + recordsValue[i] + "\n";
    
  if (newTopPosition == -1)
    recordString += "\nSorry, try again\nYour score is " + score;
  else
    recordString += "\nNew record: Position " + (newTopPosition+1);
    
  textSize(90); 
  text("End Game", width/2, height/6); 
  
  textSize(30);   
  text("Top score: \n"+recordString, width/2, height/3); 
  
  textSize(24); 
  fill(255,200,100);  
  
  text("Press r to reset", width/2, height/1.2); 
}

void userInterface() {
  textAlign(LEFT);
  fill(0,75);
  
  rect(0,0,200 ,100, // Cordenadas del rectangulo
        0, 0, 50, 0); // Circunferencia en esquina

  rect(700,0,840 ,100, // Cordenadas del rectangulo
        0, 0, 0, 50); // Circunferencia en esquina
        
  textSize(20); 
  fill(255);

  if (systemState == SystemState.GAME)  {
    currentTime += millis()-lastCheckTime;
    lastCheckTime = millis();
  }
  text("Time: " + (totalTime-currentTime/1000) + "\nScore: " + score + "/" + totalPoints, 15, 40); 
  
  text("Menu: Enter\nPause: Space", 720, 40); 
    
  if (systemState == SystemState.PAUSE) {
    textSize(25); 
    text("Pause", 380, 100);
  }
  
}
