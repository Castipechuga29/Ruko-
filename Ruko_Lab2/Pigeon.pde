class Pigeon {
  float x, y, w = 40, h = 40;
  float speed;                // velocidad actual (positiva = hacia abajo, negativa = hacia arriba)
  float flySpeed;             // velocidad de vuelo original (constante)
  boolean waiting = false;    // ¿está esperando en el suelo?
  int groundTimer = 0;        // momento en que tocó el suelo
  final int GROUND_DELAY = 2000; // espera en milisegundos

  Pigeon(float x, float y, float speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.flySpeed = speed;
  }

  void update() {
    // Si estamos en espera en el suelo, comprobamos si ya pasaron los 2 segundos
    if (waiting) {
      if (millis() - groundTimer >= GROUND_DELAY) {
        // Fin de la espera: volver a volar hacia arriba
        speed = -abs(flySpeed);
        waiting = false;
      }
      return; // no movemos la paloma mientras espera
    }

    // Movimiento vertical normal
    y += speed;

    // Rebote en cielo
    if (y <= 0) {
      y = 0;
      speed = abs(flySpeed);
    }
    // Detención y espera en suelo
    else if (y + h >= groundY) {
      y = groundY - h;
      speed = 0;
      waiting = true;
      groundTimer = millis();
    }
  }

  void display() {
    // Mientras espera en el suelo, o siempre que speed == 0, usamos palomaGround
    if (waiting || speed == 0) {
      image(palomaGround, x, y, w, h);
    } else {
      image(palomaAir, x, y, w, h);
    }
  }
}
