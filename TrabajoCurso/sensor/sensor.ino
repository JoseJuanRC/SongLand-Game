  
int IR_SENSOR = 0;
int intSensorResult = 0;
float fltSensorCalc = 0; 

void setup() {
  Serial.begin(9600);
}

void loop() {
  intSensorResult = analogRead(IR_SENSOR);
  fltSensorCalc = (6787.0 / (intSensorResult - 3.0)) - 4.0; 
  
  Serial.println(fltSensorCalc); 
  
}
