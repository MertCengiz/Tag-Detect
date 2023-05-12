void setup(){
  size(1200,600);
  translate(width /2 , height /2);
  background(150, 110, 50);
  parseFile();
}

class Locator{
  
  float x;
  float y;
  float rotz;
  float azimuth;
  
  Locator(String xIn, String yIn, String rotzIn, String azimuthIn){
    x = float(xIn);
    y = float(yIn);
    rotz = float(rotzIn);
    azimuth = float(azimuthIn);
  }
  
  float findAngle(){
    return ((rotz + azimuth) % 360);
  }
}
