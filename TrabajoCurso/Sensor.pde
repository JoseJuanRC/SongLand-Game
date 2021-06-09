
import processing.serial.*;

Serial myPort;
int sensorHeight;

void setupSensor(){
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

String drawSensor(){
  String sensorValue = null;
  if (myPort.available() > 0){  
    sensorValue = myPort.readStringUntil('\n');
  }
  return sensorValue;
}

void sensor(String sensorValue){
  float maxSensorHeight = 15;
  float minSensorHeight= 8;
  
  float currentSensorValue;
  try{
    currentSensorValue = Float.parseFloat(sensorValue);
  }catch(NumberFormatException e){ 
    currentSensorValue = 0f;
  }
  
  if(currentSensorValue < maxSensorHeight && currentSensorValue > minSensorHeight){
      sensorHeight = (int) map(currentSensorValue, minSensorHeight, maxSensorHeight, 6*terrainIncrement, size-6*terrainIncrement);
  }
}
