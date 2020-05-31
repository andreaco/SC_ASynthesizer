// CP5 Library Buttons
import controlP5.*;

// Control P5
ControlP5 cp5;
Knob vol_knob;
Knob dry_wet;
Knob room_size;
Knob pan_knob;

Button preset1Button;
Button preset2Button;

Button mod_amp;
Button mod_attack;
Button mod_release;
Button mod_allState;


void cp5Init() {
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  int h = height / 15;
  int w = width / 12;
  
  preset1Button = cp5.addButton("preset1")
    .setSwitch(false)
    .setPosition(width * 0.1 - w/2, height * 0.85)
    .setWidth(w)
    .setHeight(h)
    .setColorBackground(color(100, 100, 100))
    .setColorActive(color(50, 150, 150))
    .activateBy(ControlP5.RELEASE);

  preset2Button = cp5.addButton("preset2")
    .setSwitch(false)
    .setPosition(width * 0.20 - w/2, height * 0.85)
    .setWidth(w)
    .setHeight(h)
    .setColorBackground(color(100, 100, 100))
    .setColorActive(color(50, 150, 150))
    .activateBy(ControlP5.RELEASE);

  mod_amp = cp5.addButton("amplitude")
    .setSwitch(false)
    .setPosition(width * 0.40 - w/2, height * 0.85)
    .setWidth(w)
    .setHeight(h)
    .setColorBackground(color(100, 100, 100))
    .setColorActive(color(50, 150, 150))
    .activateBy(ControlP5.RELEASE);


  mod_attack = cp5.addButton("attack")
    .setSwitch(false)
    .setPosition(width * 0.55 - w/2, height * 0.85)
    .setWidth(w)
    .setHeight(h)
    .setColorBackground(color(100, 100, 100))
    .setColorActive(color(50, 150, 150))
    .activateBy(ControlP5.RELEASE);
    
  mod_release = cp5.addButton("release")
    .setSwitch(false)
    .setPosition(width * 0.70 - w/2, height * 0.85)    
    .setWidth(w)
    .setHeight(h)
    .setColorBackground(color(100, 100, 100))
    .setColorActive(color(50, 150, 150))
    .activateBy(ControlP5.RELEASE);
    
  mod_allState = cp5.addButton("all")
    .setSwitch(false)
    .setPosition(width * 0.85 - w/2, height * 0.85)
    .setWidth(w)
    .setHeight(h)
    .setColorBackground(color(100, 100, 100))
    .setColorActive(color(50, 150, 150))
    .activateBy(ControlP5.RELEASE);
    
    
    
    // MouseOver
    cp5.setColorForeground(color(100, 100, 200));
    
    //Click
    cp5.setColorActive(color(100, 100, 200));
    mod_amp.setColorActive     (color(colorPalette[COL_AMP], 255));
    mod_attack.setColorActive  (color(colorPalette[COL_ATK], 255));
    mod_release.setColorActive (color(colorPalette[COL_REL], 255));
    mod_allState.setColorActive(color(colorPalette[COL_ON],  255));
    PFont p = createFont("Elianto-Regular.ttf", 10);
    ControlFont font = new ControlFont(p);
    cp5.setFont(font);
    cp5.setColorValueLabel(0);
}

int off = 100;
// CP5 Buttons functions
void amplitude() {
  guiState = STATE_AMP;
  
  mod_amp.setColorBackground     (color(colorPalette[COL_AMP], 255));
  mod_attack.setColorBackground  (color(colorPalette[COL_ATK], off));
  mod_release.setColorBackground (color(colorPalette[COL_REL], off));
  mod_allState.setColorBackground(color(colorPalette[COL_ON],  off));
}

void attack() {
  guiState = STATE_ATK;
    
  mod_amp.setColorBackground(color(colorPalette[COL_AMP],     off));
  mod_attack.setColorBackground(color(colorPalette[COL_ATK],  255));
  mod_release.setColorBackground(color(colorPalette[COL_REL], off));
  mod_allState.setColorBackground(color(colorPalette[COL_ON], off));
}

void release() { 
  guiState = STATE_REL;
  
    
  mod_amp.setColorBackground(color(colorPalette[COL_AMP],     off));
  mod_attack.setColorBackground(color(colorPalette[COL_ATK],  off));
  mod_release.setColorBackground(color(colorPalette[COL_REL], 255));
  mod_allState.setColorBackground(color(colorPalette[COL_ON], off));
}

void all() { 
  guiState = STATE_ALL;
  
    
  mod_amp.setColorBackground(color(colorPalette[COL_AMP],     off));
  mod_attack.setColorBackground(color(colorPalette[COL_ATK],  off));
  mod_release.setColorBackground(color(colorPalette[COL_REL], off));
  mod_allState.setColorBackground(color(colorPalette[COL_ON], 255));
}

void preset1() {
  all();
  amplitude  = preset1Amplitude.clone();
  release    = preset1Release.clone();
  attack     = preset1Attack.clone();
}

void preset2() {
  all();
  amplitude = preset2Amplitude.clone();
  release   = preset2Release.clone();
  attack    = preset2Attack.clone();
}
