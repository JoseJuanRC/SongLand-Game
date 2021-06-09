import java.awt.Rectangle;
import java.util.List;
import java.util.LinkedList;

import processing.sound.*;

// Shader del terreno
PShader sh;

RecordManager recordManager;

Player player;

boolean isStroke;

// Puntos
List<SoundPoint> points;
float minPointsDistance = 100f;

// Score
int score = 0;
int totalPoints = 0;

// Check Time
int currentTime;
int lastCheckTime;
int totalTime;

SystemState systemState;

void setup() {
  size(1200, 800, P3D);

  setupCam();
  setupSensor();
  setupAudio();
  setupSurface();

  player = new Player();
  points = new LinkedList<SoundPoint>();

  sensorHeight = size /2; 

  loadShaders();

  systemState = SystemState.MENU;
  totalTime = 60;

  recordManager = new RecordManager("Record/topPlayers.csv"); 

  isStroke = false;
  noStroke();
}

void loadShaders() {
  sh = loadShader("shader_frag.glsl", "shader_vert.glsl");
  sh.set("u_resolution", float(width), float(height));

  sh.set("mountainTexture", loadImage("Textures/rock.png"));
  sh.set("waterTexture", loadImage("Textures/water.jpg"));
  sh.set("snowTexture", loadImage("Textures/snow.jpg"));
  sh.set("grassTexture", loadImage("Textures/grass.jpg"));
  sh.set("groundTexture", loadImage("Textures/ground.jpg"));
}

void draw() {

  switch (systemState) {
  case GAME :
    float waterTimeVariation = currentTime/30000.0;
    sh.set("u_time", waterTimeVariation);
    drawCam();
    String sensorValue = drawSensor();
    if (sensorValue != null) sensor(sensorValue);
    inGame();
    putImage();
    break;
  case PAUSE :
    translate(170, 110, 200);
    userInterface();
    break;
  case MENU :
    initMenu();
    break;
  case END :
    EndScreen();
    break;
  }
  if (systemState != SystemState.END && currentTime > totalTime*1000) {
    recordManager.readRecord();
    newTopPosition = recordManager.checkNewScore(score);
    systemState = SystemState.END;
  }
}

void inGame() {

  background(120);

  checkSoundManager();  
  generateSurface();

  pushMatrix();  
  rotateX(0.5);

  drawPoint();  
  player.drawPlayer();

  directionalLight(204, 204, 204, 0, 0, 1);

  shader(sh);

  rect(0, 0, width, height);


  shape(surface);
  resetShader();
  popMatrix();
  translate(170, 110, 200);
  noLights();
  userInterface();
}

void drawPoint() {
  fill(255, 255, 0);

  // Si uno ha llegado a la condición de ser eliminado lo borramos (altura -1)
  if (points.get(0).checkDelete())
    points.remove(0);

  // Dibujamos todos los puntos
  for (SoundPoint point : points) {

    // Comprobamos si tocamos algún punto
    if (point.checkScore(player)) score++;

    point.movePoint();

    fill(0);
    if (!point.scorePoint) drawHelpPoint(point);
  }
}

void drawHelpPoint(SoundPoint point) {
  pushMatrix();

  translate(width/2 - size/2 + point.getPosition().x, height/2 -size/4 + point.getPosition().y, 60);
  sphere(4);
  popMatrix();
}

void keyPressed() {
  if (key == 'r') reset();

  if (systemState != SystemState.END) {
    if (key == ' ') {
      if (systemState != SystemState.MENU)
        if (systemState == SystemState.PAUSE) {
          lastCheckTime = millis();
          systemState = SystemState.GAME;
        } else
          systemState = SystemState.PAUSE;
    }

    if (keyCode == ENTER) {
      if (systemState != SystemState.MENU) 
        systemState = SystemState.MENU;
      else {
        lastCheckTime = millis();
        systemState = SystemState.GAME;
      }
    }
  }
}


void keyReleased() {
  if (key == 'm') {
    if (isStroke) noStroke();
    else stroke(0);

    isStroke = !isStroke;
  }
}

void reset() {
  currentTime=0;
  systemState = SystemState.MENU;

  score = 0;
  totalPoints = 0;

  points.clear();
  player.resetPosition();
}
