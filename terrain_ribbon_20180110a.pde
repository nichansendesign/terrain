/*
hat tip to Daniel Shiffman 
 "Coding Challenge #11: 3D Terrain Generation with Perlin Noise"
*/
int cols;
int rows;
int scl = 120;  // [][][] longitudinal scaling (larger==smoother). (was 60)
int w = 3000;  // [][][] terrain/ribbon width.
int h = 250;  // [][][] depth of field visible (smaller==thinner ribbon).
int elevationMax = 800;  // [][][] max elevation from center. (was 800)
int elevationMin = -800;  // [][][] min elevation from center. (was-800)
int bgColor = 240;  // [][][] background color/tone.
float[][] terrain1;
float flying = 0;  // for keeping track of longitudinal position.
float flyingRate = 0.010;  // [][][] speed of flying.

void setup() {
  size(1000, 695, P3D);
  background(bgColor);  // background color/tone.
  frameRate(30);
  smooth(); 
  cols = w / scl;
  rows = h / scl;
  terrain1 = new float[cols][rows];  // make table representing terrain.
}  // close setup()

void draw() {  
  
  
  flying -= flyingRate;
  float yoff1 = flying;
  for (int y = 0; y < rows; y++) {
    float xoff1 = 0;
    float xoff2 = 0.5;
    float xoff3 = 0.25;
    for (int x = 0; x < cols; x++) {
      terrain1[x][y] = map(noise(xoff1, yoff1), 0, 1, elevationMin, elevationMax);
      xoff1 += 0.1;
    }  // close "for(x...)"
    yoff1 += 0.1;
  }  // close "for(y...)"


  background(bgColor);
  noStroke();
  fill(86, 189, 255);


  translate(width/2, height/2, -1000);  // centering the origin before rotation.
  rotateX(PI/2);

  translate(-w/2, -h/2);  // centering the creation.
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain1[x][y]);
      vertex(x*scl, (y+1)*scl, terrain1[x][y+1]);
    }  // close "for(x...)"
    endShape();
  }  // close "for(y...)"
  
  
}  // close draw()