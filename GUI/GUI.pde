// Harmonics Controls Arrays
int harmonicsSize = 8;
float[] amplitude, release, attack;

// Parameters
float[] parameters = {0.5, 0.0, 0.1, 0.5};
final int
  PAR_VOL = 0,
  PAR_DW = 1,
  PAR_RS = 2,
  PAR_PAN  = 3;

// Colors
color[] colorPalette = {
    //color(39, 74, 81),
    color(29,72,134),
    color(69, 64, 200),
    color(20,199,198),
    color(113,28,145),
    color(19,39,58),
};
final int
  COL_AMP = 0,
  COL_ATK = 1,
  COL_REL = 2,
  COL_ON  = 3,
  COL_OFF = 4;
  
// GUI State
int guiState;
final int 
  STATE_AMP = 0,
  STATE_ATK = 1,
  STATE_REL = 2,
  STATE_ALL = 3;

// Presets
float[] preset1Amplitude, preset1Attack, preset1Release;
float[] preset2Amplitude, preset2Attack, preset2Release;

// Font
PFont customFont;

void settings() {
  // Processing settings
  
  size(1200, 600, P2D);
  smooth(24);
}

void setup() {
  // aestethic settings
  customFont = createFont("Elianto-Regular.ttf", 20);
  vhs = loadShader("vhs_wobble.glsl");
  vhs.set("iResolution", float(width), float(height));
  
  
  // Loading page
  background(0);
  textFont(customFont);
  text("LOADING . . .", width/2, height/2);
  
  
  // OSC Settings
  
  //String SCHAMACHIADDRESS = "25.53.229.113";
  //oscP5 = new OscP5(this, SCHAMACHIADDRESS, 57120, NetP5.UDP);
  netAddress = new NetAddress("127.0.0.1", 57120);
  oscP5 = new OscP5(this, 57120);
  //netAddress = new NetAddress("127.0.0.1", 57120);
  
  // Controls
  amplitude = new float[harmonicsSize];
  release   = new float[harmonicsSize];
  attack    = new float[harmonicsSize];

  preset1Amplitude = new float[] {0.8, 0.4, 0.3, 0.1, 0, 0, 0, 0};   
  preset1Attack    = new float[] {0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001};
  preset1Release   = new float[] {0.2, 0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1};

  preset2Amplitude = new float[] {0.9, 0.7, 0.5, 0.2, 0.1, 0.05, 0, 0};
  preset2Attack    = new float[] {0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001};
  preset2Release   = new float[] {0.2, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1, 0.01};
  
  // Table GUI Position and INIT  
  int m = 20; // margin
  masterTable = new SliderTable (m, height * 0.35, width * 0.3 - 2*m, height * 0.35 - 2*m, 4, 1);
  singleTable = new SliderTable (width * 0.3 + m, m, width * 0.7 - 2*m, height * 0.7 - 2*m, harmonicsSize, 1);
  presetTable = new SliderTable (width * 0.3 + m, m, width * 0.7 - 2*m, height * 0.7 - 2*m, harmonicsSize, 3);
  tables = createGraphics(width, height);
  
  
  // CP5 configuration
  cp5Init();
}




void draw() {
  if (frameCount == 1) {
    //Workaround on CP5 loading time
    amplitude();
    frameRate(20);
  }
  
  // BG
  background(10, 10, 25);
  // Draw Controls
  cp5.draw();
  
  // Begin Tables Canvas
  tables.beginDraw();
  tables.clear();
  
  // Master Controls Table
  masterTable.drawSubSliders (parameters, 0, colorPalette[1]);
  masterLabelsAndValues();
  
  // Harmonic Controls Table
  switch (guiState) {
    case STATE_AMP:
      singleTable.drawSubSliders (amplitude, 0, colorPalette[COL_AMP]);
      break;
    case STATE_ATK:
      singleTable.drawSubSliders (attack, 0, colorPalette[COL_ATK]);
      break;
    case STATE_REL:
      singleTable.drawSubSliders (release, 0, colorPalette[COL_REL]);
      break;
    case STATE_ALL:
      presetTable.drawSubSliders (amplitude, 0, colorPalette[COL_AMP]);
      presetTable.drawSubSliders (attack,    1, colorPalette[COL_ATK]);
      presetTable.drawSubSliders (release,   2, colorPalette[COL_REL]);
      break;
  }
  
  // Oscillator Draw
  drawSinusoid(20, 20, masterTable.tableWidth, masterTable.tableHeight - 40);
  
  // Oscillator draw Control Bounds
  angleRect(20, 20, masterTable.tableWidth, masterTable.tableHeight - 40);
  // Harmonic Controls Table
  angleRect(singleTable.topLeftX - 20, singleTable.topLeftY, singleTable.tableWidth + 20, singleTable.tableHeight);
  // Master Controls Draw
  angleRect(masterTable.topLeftX, masterTable.topLeftY, masterTable.tableWidth, masterTable.tableHeight + 20);

  // End Canvas
  tables.endDraw();
  image(tables, 0, 0, width, height);
  
  // Separation Line
  stroke(20);
  line(0, height * 0.77, width, height * 0.77);
  
  // OSC Send
  sendArrayOSC("/harmonics", amplitude);
  sendArrayOSC("/attack", attack);
  sendArrayOSC("/release", release);
  sendArrayOSC("/param", parameters);
  
  // Shading
  if (shaderApply) {
    applyShader();
  }
}
