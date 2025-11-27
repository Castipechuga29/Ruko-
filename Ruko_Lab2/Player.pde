class Player {
  boolean moving = false;
  boolean jumping = false;
  float x, y, w, h;
  float vx = 0;
  float vy = 0;
  boolean onGround = false;
  int lives = 4;
  float speed = 8;

  Player() {
    w = 50;
    h = 70;
    x = 50;
    y = groundY - h;
  }

  void update() {
    // ——— Movimiento horizontal (Permite movimiento en el aire/diagonal) ———
    vx = 0; // Se resetea la velocidad cada frame
    moving = false;

    // Detecta la tecla presionada (donde sabemos que funciona) y establece vx
    if (keyPressed) {
      if (key == 'a' || key == 'A') {
        vx = -speed;
        if (x < 0) x = 0;
        facingRight = false;
      }
      if (key == 'd' || key == 'D') {
        vx = speed;
        if (x + w > width) x = width - w;
        facingRight = true;
      }
    }
    
    x += vx; // APLICAR VELOCIDAD HORIZONTAL (Funciona para el suelo y el aire)
    moving = (vx != 0 && onGround); // Determinar 'moving' para animación

    // ——— Lógica de Salto ELIMINADA de update() (Ahora solo en keyPressed)

    // ——— Gravedad y movimiento vertical ———
    vy += gravity;
    y += vy;

    // ——— Colisión con el suelo ———
    if (y + h >= groundY) {
      y = groundY - h;
      vy = 0;
      onGround = true;
      jumping = false;
    }
  }

// Nuevo método dentro de la clase Player
void jump() {
    // Si la gravedad está aplicada y onGround es verdadero, permite el salto
    if (onGround) {
      vy = -13; // Fuerza de salto
      onGround = false;
      jumping = true;
    }
}

  void display() {
        PImage spriteActual;
        
        // La animación debe usar el array currentFrames.
        if (isAttacking) {
            spriteActual = currentAtaque; // <-- CAMBIO
        } else if (jumping || !onGround) { // Usamos !onGround para capturar la caída también
            spriteActual = currentSpriteSaltando; // <-- CAMBIO
        } else if (!moving) {
            spriteActual = currentSpriteQuieto; // <-- CAMBIO
        } else {
            // Lógica de animación de caminata
            rukoFrameTimer++;
            if (rukoFrameTimer % 6 == 0) {
              // Usa currentFrames.length para que funcione con cualquier array
              rukoFrameIndex = (rukoFrameIndex + 1) % currentFrames.length; 
            }
            spriteActual = currentFrames[rukoFrameIndex]; // <-- CAMBIO
        }

        pushMatrix();
        translate(x + w / 2, y + h / 2);
        if (!facingRight) scale(-1, 1);
        imageMode(CENTER);
        
        // Usamos el tamaño w, h del jugador, independientemente del sprite
        image(spriteActual, 0, 0, w, h); 
        
        imageMode(CORNER);
        noTint();
        popMatrix();
    }

  boolean collidesWith(Object o) {
    if (o instanceof Car) {
      Car c = (Car) o;
      // Colisión AABB usando la hitbox reducida del auto
      return (x < c.getRight() && // Lado izquierdo de Ruko < Lado derecho de la hitbox del auto
              x + w > c.getLeft() &&  // Lado derecho de Ruko > Lado izquierdo de la hitbox del auto
              y < c.getBottom() && // Lado superior de Ruko < Lado inferior de la hitbox del auto
              y + h > c.getTop()); // Lado inferior de Ruko > Lado superior de la hitbox del auto
    } else if (o instanceof Dog) {
      Dog d = (Dog) o;
      return (x < d.x + d.w && x + w > d.x && y < d.y + d.h && y + h > d.y);
    } else if (o instanceof Weapon) {
      Weapon weap = (Weapon) o;
      return (x < weap.x + weap.w && x + w > weap.x && y < weap.y + weap.h && y + h > weap.y);
    } else if (o instanceof Collectable) {
      Collectable e = (Collectable) o;
      return (x < e.x + e.size && x + w > e.x && y < e.y + e.size && y + h > e.y);
    }
    return false;
  }

  boolean collidesWithCube(float cubeX, float cubeY, float cubeW, float cubeH) {
    return (x < cubeX + cubeW && x + w > cubeX && y < cubeY + cubeH && y + h > cubeY);
  }

  void takeDamage() {
    lives--;
    if (lives >= 0 && lives < hearts.size()) {
      hearts.get(lives).startBlinking();
    }
    println("¡Te hicieron daño! Vidas: " + lives);
  }
}
