// This function draws the bounds of a component
void angleRect(float topLeftX, float topLeftY, float rectWidth, float rectHeight) {
  //strokeWeight(5);
  stroke(colorPalette[1]);
  
  float size = rectHeight / 10;
  float bottomRightX = topLeftX + rectWidth;
  float bottomRightY = topLeftY + rectHeight;
  
  // TopLeft
  line(topLeftX, topLeftY, topLeftX, topLeftY +  size);
  line(topLeftX, topLeftY, topLeftX + size, topLeftY);
  
  // TopRight
  line(bottomRightX, topLeftY, bottomRightX, topLeftY + size);
  line(bottomRightX, topLeftY, bottomRightX - size, topLeftY);
  
  //BottoLeft
  line(topLeftX, bottomRightY, topLeftX, bottomRightY - size);
  line(topLeftX, bottomRightY, topLeftX + size, bottomRightY);
  
  //BottomRight
  line(bottomRightX, bottomRightY, bottomRightX - size, bottomRightY);
  line(bottomRightX, bottomRightY, bottomRightX, bottomRightY - size);
}
