class Heart {
  float x, y;
  boolean visible = true;
  int blinkTimer = 0;
  boolean isBlinking = false;

  Heart(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void startBlinking() {
    isBlinking = true;
    blinkTimer = 60; // dura 1 segundo a 60 FPS
  }

  void update() {
    if (isBlinking) {
      blinkTimer--;
      if (blinkTimer <= 0) {
        visible = false;
      }
    }
  }

  void display() {
    if (visible) {
      if (!isBlinking || (frameCount % 10 < 5)) {
        image(vidaSprite, x, y, 60, 60); // dibuja el sprite de vida
      }
    }
  }
}
