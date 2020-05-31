// This function draws the oscillator visualization
void drawSinusoid(float topLeftX, float topLeftY, float rectWidth, float rectHeight) {
  float center = topLeftY + rectHeight / 2;
  topLeftX += rectWidth * 0.05;
  rectWidth *= 0.90;  
  int numP = 256;
  float h = 0.9 * rectHeight / 2;
  noFill();
  float[] ys = new float[numP];
  float max = 0.0001;
  
  for (int i = 0; i < ys.length; ++i) {
    float a = i * TWO_PI / numP;
    
    float[] sins = { sin(1.0 * a), sin(2 * a),
                     sin(3 * a), sin(4 * a),
                     sin(5 * a), sin(6 * a),
                     sin(7 * a), sin(8 * a)
                   };
    
    float y = 0;
    for(int j = 0; j < sins.length; ++j) {
      y += h * sins[j] * amplitude[j];
    }
    ys[i] = h * y;
    if (abs(y) > max) max = abs(y);
  }
  
  beginShape();
  stroke(colorPalette[1]);
  for (int i = 0; i < ys.length; ++i) {
    float x = topLeftX + rectWidth * float(i) / numP; 
    vertex(x, center + ys[i]/max);
  }
  endShape();
}
