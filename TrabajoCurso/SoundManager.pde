Amplitude nivel;

void setupAudio() {
  AudioIn IN = new AudioIn(this, 0);
  
  //Lanza captura
  IN.start();
  
  // Analizador de amplitud
  nivel = new Amplitude(this);

  // Asocia entrada y analizadores
  nivel.input(IN);
}

void checkSoundManager() {
  // Obtiene valor entre 0 y 1 en base al nivel
  float volume = nivel.analyze();
  
  //Asocia ancho de rectángulo al nivel del volumen
  
  int volumeWidth = int(map(volume, 0, 0.1, 6*terrainIncrement, size-6*terrainIncrement));

  volumeWidth = min(volumeWidth,size-6*terrainIncrement);
  
  SoundPoint point = new SoundPoint(volumeWidth, sensorHeight);
  
  // Control de distancías entre cimas
  if (points.isEmpty() || point.distanceBetweenPoints(points.get(points.size() - 1)) > minPointsDistance) {
    points.add(point);
    totalPoints++;
  }
}
