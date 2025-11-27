class Dog {
  boolean activo = false;
  float x, y, w = 50, h = 50;
  int frame = 0;

  Dog(float startX) {
    x = startX;
    y = groundY - h;
  }

  void update() {
    if (ruko == null) return; // protección
    if (dist(x, y, ruko.x, ruko.y) < 200) {
      activo = true;
      if (ruko.x > x) x += 1.5;
      else x -= 1.5;
    }
    if (activo && dogFrames != null && dogFrames.length > 0) {
      frame = (frame + 1) % dogFrames.length;
    }
  }

  void display() {
    if (!activo) {
      if (spriteQuietoPerro != null) image(spriteQuietoPerro, x, y, w, h);
    } else {
      if (dogFrames != null && dogFrames.length > 0 && dogFrames[frame] != null) {
        image(dogFrames[frame], x, y, w, h);
      }
    }
  }
}
