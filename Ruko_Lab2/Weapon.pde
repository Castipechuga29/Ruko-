class Weapon {
  float x, y, w = 42, h = 42;

  Weapon(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    image(bate, x, y, w, 40);
  }
}
