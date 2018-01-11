/*
hat tip to Daniel Shiffman 
 "Coding Challenge #11: 3D Terrain Generation with Perlin Noise"
*/
int cols;  // columns for our terrain array.
int rows;  // rows for our terrain array.
int scl = 120;  // [][][] longitudinal scaling (larger==smoother). (was 60)
int w = 3000;  // [][][] terrain/ribbon width.
int h = 250;  // [][][] depth of field visible (smaller==thinner ribbon).
int elevationMax = 800;  // [][][] max elevation from center. (was 800)
int elevationMin = -800;  // [][][] min elevation from center. (was-800)
int bgColor = 240;  // [][][] background color/tone.
float[][] terrain1;  // first array for "terrain."
float flying = 0;  // for keeping track of longitudinal position.
float flyingRate = 0.010;  // [][][] speed of flying.

void setup() {
  size(1000, 695, P3D);
  background(bgColor);  // draw background color/tone.
  frameRate(30);
  smooth(); 
  cols = w / scl;  // scale the width to set number of columns for terrain array.
  rows = h / scl;  // scale the height(depth) to set number of rows for terrain array.
  terrain1 = new float[cols][rows];  // make table representing our terrain ribbon.
}  // close setup()

void draw() {  
  
  
  flying -= flyingRate;
  float yoff1 = flying;  // y-offset, for keeping track where we are, longitudinally.
  for (int y = 0; y < rows; y++) {
    float xoff1 = 0;  // x-offset, for keeping track where we are, laterally.
    float xoff2 = 0.5;  // for 2nd of multiple ribbons.
    float xoff3 = 0.25;  // for 3rd of multiple ribbons.
    for (int x = 0; x < cols; x++) {
      terrain1[x][y] = map(noise(xoff1, yoff1), 0, 1, elevationMin, elevationMax);
      xoff1 += 0.1;
    }  // close "for(x...)"
    yoff1 += 0.1;
  }  // close "for(y...)"


  background(bgColor);  // draw background over previous frame.
  noStroke();
  fill(86, 189, 255);  // color of terrain.


  translate(width/2, height/2, -1000);  // centering the origin before rotation.
  rotateX(PI/2);  // rotate the creation so we're looking at the edge.

  translate(-w/2, -h/2);  // centering the creation.
  for (int y = 0; y < rows-1; y++) {  // for every row...
    beginShape(TRIANGLE_STRIP);  // ...start a surface...
    for (int x = 0; x < cols; x++) {  // ...and continue for every column...
      vertex(x*scl, y*scl, terrain1[x][y]);  // ...draw 3d points of our terrain...
      vertex(x*scl, (y+1)*scl, terrain1[x][y+1]);  // ...connect those points to adjacent points...
    }  // close "for(x...)"
    endShape();  // stop the surface for this row.
  }  // close "for(y...)"
  
  
}  // close draw()