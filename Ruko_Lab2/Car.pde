class Car {
  float x, y, w = 120, h =90 ;
  float speed = 3;
  int frame = 0;
  float ajusteY = 30;  // desplazar sprite más abajo
  float hitboxReduction = 30; 

  Car(float startX) {
    x = startX;
    y = groundY - h + ajusteY;  // colocar más cerca del suelo
  }

  void update() {
    x -= speed;
    if (x < -w) x = width + random(300, 500);
    frame = (frame + 1) % carFrames.length;
  }

  void display() {
    image(carFrames[frame], x, y, w, h);
  }
   float getLeft() {
    return x + hitboxReduction;
  }

  float getRight() {
    return x + w - hitboxReduction;
  }

  float getTop() {
    return y + hitboxReduction/2;
  }

  float getBottom() {
    return y + h - hitboxReduction/2;
  }

}
