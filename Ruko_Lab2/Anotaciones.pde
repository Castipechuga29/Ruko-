/*setup()
Esta función se ejecuta una sola vez al inicio. Sirve para configurar el entorno inicial del juego: se define el tamaño de la pantalla, el frameRate (cuántas veces se dibuja por segundo), se carga la fuente para el texto, y se crean las imágenes de la mamá usando colores generados (no imágenes reales). Estas imágenes se guardan en un arreglo que luego se usará para simular la animación de acercamiento.

drawIntroScene()
Esta función se encarga de mostrar la escena de introducción con la mamá hablando. Se muestra una imagen de fondo (de la mamá), el texto del diálogo se escribe letra por letra como si fuera una máquina de escribir, y también se cambia de imagen cada cierto tiempo para simular que la mamá se acerca. Es la escena narrativa del inicio.

startGame()
Esta función se llama cuando empieza el juego como tal (fase de acción). Inicializa al personaje Ruko, los autos, los perros enemigos, los corazones (vidas) y también coloca un arma en el escenario. Básicamente, prepara todos los objetos que se van a usar en la jugabilidad.

drawGameplay()
Esta función se ejecuta constantemente cuando el juego está en marcha. Dibuja todo: el fondo, el suelo, el arma (si no ha sido recogida), los autos, los perros, los corazones y al personaje. También gestiona las colisiones: si Ruko choca con un carro o perro, pierde vida; si tiene un arma y ataca a un perro, lo elimina. Además, detecta si se ha llegado a un punto clave en el juego y revisa si el jugador ha muerto.

keyPressed()
Esta función detecta cuándo se presiona una tecla. En la escena de introducción, al presionar ENTER se avanza en el diálogo. En la escena del juego, si Ruko tiene el arma y se presiona la barra espaciadora, se activa el ataque. También controla el salto (W) y movimiento lateral (A y D) dentro de la clase Player.

draw()
Es la función principal de dibujo que se ejecuta en cada frame. Según la escena actual (intro, juego o game over), llama a la función correspondiente (drawIntroScene(), drawGameplay() o muestra la pantalla de fin de juego).

Clase Player
Define todo lo relacionado con Ruko: su posición, velocidad, vida, tamaño y cómo se mueve. Tiene funciones para actualizar su posición, mostrarlo en pantalla, detectar colisiones con otros objetos, y reducir vidas si recibe daño.

Clase Car
Define los carros que aparecen como obstáculos. Tiene propiedades de posición y velocidad, una función para actualizar su movimiento (se mueven hacia la izquierda y reaparecen al final) y una función para dibujarlos.

Clase Dog
Define a los perros enemigos. Tiene posición y tamaño, y una función para mostrarlos. No se mueven ni atacan, pero causan daño si Ruko los toca (a menos que tenga arma y ataque).

Clase Weapon
Define el arma que Ruko puede recoger. Solo tiene posición y tamaño, y una función para mostrarla en pantalla.

Clase Heart
Representa las vidas del jugador. Cada corazón se dibuja como una forma de corazón con dos círculos y un triángulo. Se muestran en la parte superior de la pantalla y se actualizan según cuántas vidas tenga Ruko. */


/*momFrames[]
Es un arreglo que guarda varias imágenes de la mamá. No son imágenes como archivos, sino que se dibujan con código. Se usan para simular que la mamá se está acercando poco a poco en la escena de introducción (tipo animación).

currentMomFrame
Guarda el número de imagen actual de la mamá que se debe mostrar en pantalla. Se va actualizando cada cierto tiempo para que parezca que la mamá se mueve.

momFrameDelay
Sirve para controlar cuántos frames deben pasar antes de cambiar a la siguiente imagen de la mamá. Esto evita que la animación se vea muy rápida.

momFrameCounter
Es como un contador de frames. Aumenta en cada fotograma para saber cuándo es el momento de cambiar la imagen de la mamá.

font
Es la fuente de texto que se usará en el juego (para que el texto se vea con un estilo especial, tipo pixel art).

momLines[]
Es un arreglo de cadenas de texto. Cada una representa una línea del diálogo que dice la mamá en la introducción.

currentLine
Es un número que indica cuál línea del diálogo se está mostrando en ese momento.

displayedText
Es el texto que ya ha sido escrito en pantalla (letra por letra). Va creciendo poco a poco, como si fuera una máquina de escribir.

charIndex
Indica cuántas letras del texto ya han sido mostradas. Se usa para agregar una letra nueva por cada cierto tiempo.

textSpeed
Controla cada cuántos frames se debe mostrar una nueva letra del texto (para que no aparezcan todas de golpe).

textTimer
Es otro contador que se incrementa con cada frame. Se reinicia cada vez que se muestra una nueva letra.

scene
Define en qué parte del juego estamos:

0 → Introducción (la mamá hablando)

1 → Juego en acción

2 → Pantalla de "Game Over"

player
Es un objeto de la clase Player, que representa a Ruko. Guarda toda su información: posición, vidas, movimiento, etc.

cars[]
Arreglo que guarda varios objetos tipo Car, que son los carros que se mueven en el juego y pueden dañar a Ruko.

dogs[]
Arreglo de objetos tipo Dog. Son enemigos que están en el suelo. Si Ruko los toca sin arma, pierde vida. Si tiene arma y ataca, los elimina.

hearts[]
Arreglo que guarda objetos tipo Heart. Cada uno representa una vida de Ruko y se dibujan arriba en pantalla. Se van quitando cuando pierde vidas.

weapon
Es un objeto de tipo Weapon, que representa un arma que Ruko puede recoger. Solo aparece una vez en el escenario.

hasWeapon
Es una variable booleana (true o false) que indica si Ruko ya recogió el arma. Si es true, puede atacar a los enemigos.

isAttacking
También es booleana. Se vuelve true cuando Ruko presiona la barra espaciadora para atacar. Dura unos segundos.

attackDuration
Dice cuántos frames dura el ataque. Después de eso, isAttacking vuelve a ser false.

attackTimer
Cuenta los frames desde que empezó el ataque. Se reinicia cada vez que se ataca.

floorHeight
Define la altura del suelo en el juego. Sirve para saber dónde deben estar parados Ruko, los perros y los carros.*/
