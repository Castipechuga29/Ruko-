class Collectable {
  float x, y = 20;
  float size = 20;
  boolean collected = false;

  Collectable(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
   if (!collected) {
     image(spriteCompra, x, y, 27, 27);
   }
 }


  boolean isCollectedBy(Player player) {
    if (!collected && player.collidesWith(this)) {
      collected = true;
      return true;
    }
    return false;
  }
}
