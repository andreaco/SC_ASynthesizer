// Shading Settings

boolean shaderApply = true;
PShader vhs;

void applyShader() {
  vhs.set("iGlobalTime", millis() / 1000.0);
  surface.setTitle("FPS " + nf(int(frameRate), 2));
  filter(vhs);
  tables.filter(vhs);
}
