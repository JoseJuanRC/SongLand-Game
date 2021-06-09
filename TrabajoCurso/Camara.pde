import processing.video.*;
import gab.opencv.*;

Capture cam;
OpenCV opencvFrontal;
        
PVector camSize;
PImage camImage;

void setupCam() {
  camSize = new PVector(200,140);
  
  int maxCamaraCheck = 0;
  // Camara
  while(maxCamaraCheck++<30) {
    try { 
      cam = new Capture(this, (int) camSize.x, (int) camSize.y);
      cam.start();
      break;
    } catch(IllegalStateException e) {}
  }
  
  opencvFrontal = new OpenCV(this, cam);
  opencvFrontal.useColor(RGB);
  opencvFrontal.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}


void drawCam() {
  
  try{
    if (cam.available()) 
      readCam();
  }catch(Exception e){
    println("Error al leer un frame de la cámara");
  }
  
}

void readCam() {
  cam.read();
  image(cam,0,0);
  opencvFrontal.loadImage(cam);
  opencvFrontal.flip(1);
  
  Rectangle[] faces = opencvFrontal.detect();
  camImage = opencvFrontal.getSnapshot();
  
  boolean facesDetected = faces.length>0;
  if (facesDetected) {
    Rectangle face = faces[0];
    checkPlayerMovement(face.x+face.width/2, face.y+face.height/2);
  }
}

void putImage() {
  if (camImage!=null)
    image(camImage,width/2 - camSize.x*1.25,0);
}

void checkPlayerMovement(int Xposition, int Yposition) {
  PVector dir = new PVector(Xposition-camSize.x/2, Yposition-camSize.y/2);
  dir.normalize();
  
  player.changeIncrementX((int) (dir.x*player.getPlayerVelocity()));
  player.changeIncrementY((int) (dir.y*player.getPlayerVelocity()));
}

     
