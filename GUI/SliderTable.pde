PGraphics tables;
SliderTable presetTable, singleTable, masterTable;

// This object encapsulates the sliders control logic
public class SliderTable {
  public float topLeftX, topLeftY, tableWidth, tableHeight;
  public int numSliders;
  public int numSubSliders;
  public float subSliderSize;
  
  public SliderTable (float topLeftX, float topLeftY, float tableWidth, float tableHeight, int numSliders, int numSubSliders) {
    this.topLeftX = topLeftX;
    this.topLeftY = topLeftY;
    this.tableWidth  = tableWidth;
    this.tableHeight = tableHeight;
    
    this.numSliders = numSliders;
    this.numSubSliders = numSubSliders;
    
    this.subSliderSize = tableWidth / (numSliders * numSubSliders);
    
  }
  
  
  public void drawSubSliders (float[] array, int subSliderIndex, color sliderColor) {
    if (array.length != numSliders) println("Array and table sizes don't match");
    else if (subSliderIndex < 0 || subSliderIndex >= numSubSliders) println("SubSliderIndex out of range");
    else {
      float relativeYPos = (mouseY - topLeftY) / tableHeight;
      float subSliderOffset = (subSliderIndex * subSliderSize);
      float startY = topLeftY;
      float endY   = topLeftY + tableHeight;
      
      for (int i = 0; i < numSliders; ++i) {
        float startX = topLeftX + i * subSliderSize * numSubSliders + subSliderOffset;
        float endX   = startX + subSliderSize;
        
        if (mousePressed && isInRange(mouseX, startX, endX) && isInRange(mouseY, startY, endY)) {
          array[i] = 1 - relativeYPos;
          array[i] = constrain(array[i], 0, 1);
        }
        
        tables.fill(sliderColor);
        tables.noStroke();
        
        float m = subSliderSize * 3 / 5;
        tables.rect(startX + m, 20 + topLeftY + (tableHeight - 40) * (1 - array[i]), subSliderSize - 2*m, (tableHeight - 40) * array[i], 10, 10, 10, 10);
        
        if(subSliderIndex == 0)
          tables.stroke(40);
        else 
          tables.stroke(10);
        
        if(i != 0)
          tables.line(startX, topLeftY + 20, startX, topLeftY + tableHeight - 20); 
      }
    }
  }
  
  
  private boolean isInRange(float mousePos, float min, float max) {
    return mousePos > min && mousePos < max;
  }
}
