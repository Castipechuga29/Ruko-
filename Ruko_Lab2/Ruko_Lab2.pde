// ==========================
// RUKO Y SU MANDADO
// PARTE 1: INTRO CON LA MAMÁ
// ==========================
import processing.sound.*;
// ESCENAS

int scene = -1; // Inicializamos scene en -1 para asegurar que no se ejecute una escena no deseada al inicio

// PARA EL TEXTO TIPO DIÁLOGO
String[] dialogues = {
  "Ruko: Al fin, con este computador voy a poder descargar el nuevo tetris",
  "Ruko: Lastima que es carisimo.",
  "Tendré que ir donde mi mejor amigo PiviGames...",
  "¡Oh no, mi computador se apagó!",
  "Reventator: JAJAJA, si quieres recuperar tu computador deberás vencerme en mi juego",
  
};
String[] tip1 = {

  "¡Logra desencriptar el código fuente de malicioso !",

  "Ruko: ¡Tendré que usar mis conocimientos informáticos!",

  "Malicioso: ¡NO TIENES ELECCION!",

  "Ruko: AYUDAAAA",

};
String[] dialoguesFinal = {

  "Ruko: ¡Al fin, mi computador!",

  "Loading...",

  "Ruko: Se está demorando un poco...",

  "Parece que se dañaron unos componentes",

  "Ruko: Bueno, de igual forma iba a cambiar de computador"

};
String[] dialogoVicio = {

  "¡Logra desencriptar el código fuente de malicioso !",

  "Ruko: ¡Tendré que usar mis conocimientos informáticos!",

  "Vicioso: ¡NO TIENES ELECCION!",

  "Ruko: AYUDAAAA",

};
String[] credit = {

  "Gassasin. (2017, February 28). 2D City tileset",

  "SANTIAGO. (2018, November).EJERCICIO PROCESSING - TRES EN RAYA.",
  
  "(Leaf on the Wind Animation, Rada Ursu, 2025).",
  
  "(Animation Game Vehicle Study Pixel Art, Pixininho, 2025).",
  
  "CraftPix.net 2D Game Assets",
  
  "(SHOPJEEN.com, 2021).",
  
  "(Khomchenko, 2024).",

};
ArrayList<Collectable> collectables;
int collectableCount = 0; // Contador de encomiendas
int currentDialogue = 0;
String displayedText = "";
int textIndex = 0;
int textTimer = 0;
int textSpeed = 1;
//int gameStartTime;
int gameOverFrame = -1;
//int tttEndTime;
//int timeLimit = 100 * 60; // 100 segundos * 60 frames/segundo
boolean tttPlayed = false;
int gameStartTime; // Renombramos para evitar confusión con startTime general
int elapsedGameSeconds = 0;
int timeLimitTTT = 15;
PImage flechaVolver;
PImage[] rukoFrames;
PImage[] carFrames;
PImage[] dogFrames;
PImage lv1;
PImage gameoverImage;
PImage lv2 ;
SoundFile soundCollect;
boolean soundsEnabled = false;
SoundFile soundIntro;      // Sonido para la escena intro   // Sonido al recoger coleccionables
SoundFile soundTransition;
// --- SPRITES DEL PERSONAJE MUJER ---
PImage mujerSpriteSheet;        // La hoja de sprites completa (Ye_Oldy_Girl_02.png)
PImage[] mujerFrames;           // Animación de caminata/corrida
PImage mujerSpriteQuieta;       // Frame Quieta
PImage mujerSpriteSaltando;     // Frame Saltando
PImage mujerAtaque;             // Frame de ataque (usaremos un frame de ataque de la hoja alterna)

// --- VARIABLES ACTUALES (SELECCIONADAS ALEATORIAMENTE) ---
PImage[] currentFrames;
PImage currentSpriteQuieto;
PImage currentSpriteSaltando;
PImage currentAtaque;

// --- DIMENSIONES DEL SPRITE (Ye_Oldy_Girl_02.png tiene frames de 16x16) ---
final int FRAME_WIDTH = 32;
final int FRAME_HEIGHT = 32;
int TTT_TRANSITION_SCENE = 8; // Define una nueva escena para la transición después del TTT
boolean showCubeTransition = false;
float cubeTransitionX;
float cubeTransitionY;
boolean facingRight = true;
int rukoFrameIndex = 0;
int rukoFrameTimer = 0;
PImage info1;
PImage menu;
PImage bolsa;
PImage tiempo;
PImage spriteQuieto;
PImage spriteSaltando;
PImage spriteQuietoPerro;
PImage bate;
PImage misterioso;
PImage spriteMamaFinal;
PImage spriteCompra;
PImage rukoAtaque;
PImage vidaSprite;
PImage palomaGround, palomaAir;
ArrayList<Pigeon> pigeons;

Player player;

// PARA CAMBIO DE IMAGENES DE LA MAMÁ QUE SE VA ACERCANDO
PImage[] momFrames;
int currentFrame = 0;
int frameTimer = 0;
int frameInterval = 60;
int esperaFinal = 0;
// FUENTE
PFont font;


//==BOTONES===
float boton1X, boton1Y, botonAncho, botonAlto;
float boton2X, boton2Y;
float boton3X, boton3Y;
float boton4X, boton4Y; // Nuevo botón para el Tres en Raya

// Colores de los botones
color colorBotonNormal = color(200);
color colorBotonHover = color(150);
color colorBoton1, colorBoton2, colorBoton3, colorBoton4, colorBoton5; // Color para el nuevo botón

// Textos de los botones
String textoBoton1 = "Iniciar";
String textoBoton2 = "Info";
String textoBoton3 = "Salir";
String textoBoton4 = "Creditos"; // Texto del nuevo botón
boolean estadoBoton1 = false;

// === VARIABLES PARA EL TRES EN RAYA ===
boolean showCube = false;    // ¿Mostrar el cubo?
boolean inMiniGame = false; // ¿Estamos en el minijuego?
int cellSizeTTT;
int[][] boardTTT; // Matriz para representar el tablero: 0 = vacío, 1 = jugador 1, 2 = jugador 2
int currentPlayerTTT; // 1 = jugador 1, 2 = jugador 2
boolean gameOverTTT;
String winnerTTT;
int gamesPlayedTTT = 0; // Contador de partidas jugadas
int maxGamesTTT = 3;   // Máximo de partidas a jugar
//==FINAL==
int THE_END_SCENE = 4; // Define un nuevo número para la escena de "The End"
int VICIOUS_SCENE = 7;
int gameOverTimer = 0;
int TIP_SCENE = 10;
int gameOverDuration = 180; // duración en frames (por ejemplo: 3 segundos si estás a 60fps)
boolean gameOverActive = false;




void setup() {
  setupSounds();
  size(800, 600);
  bate = loadImage("bate.png");
  misterioso = loadImage("Misterioso-0.png");
  spriteMamaFinal = loadImage("Mama.png");
  spriteCompra = loadImage("compras.png");
  rukoAtaque = loadImage("RukoAtaque.png");
  vidaSprite = loadImage("vida.png");
  frameRate(60);
  flechaVolver = loadImage("flecha.png");
  menu = loadImage("menu_2.gif");
  bolsa = loadImage("bag.png");
   tiempo = loadImage("tiempo.png");
  botonAncho = 150;
  botonAlto = 50;
  int espacioVertical = 70;
  boton1X = width / 2;
  boton1Y = height / 2 - espacioVertical * 1.5; // Ajustar posición
  boton2X = width / 2;
  boton2Y = height / 2 - espacioVertical * 0.5; // Ajustar posición
  boton4X = width / 2;
  boton4Y = height / 2 + espacioVertical * 0.5; // Posición del nuevo botón
  boton3X = width / 2;
  boton3Y = height / 2 + espacioVertical * 1.5; // Ajustar posición
  colorBoton1 = colorBotonNormal;
  colorBoton2 = colorBotonNormal;
  colorBoton3 = colorBotonNormal;
  colorBoton4 = colorBotonNormal;
  


  // Fuente
  font = createFont("Arial", 20);
  textFont(font);
  textAlign(CENTER);

  // Fondo
  fondo = loadImage("fondo1.jpg");
  lv2 = loadImage("lv_2.png");
  lv1 = loadImage("fondo.jpg");

  // Cargar imágenes reales de la mamá (acercamiento)
  momFrames = new PImage[3];
  momFrames[0] = loadImage("Bframe-0.png");
  momFrames[1] = loadImage("Bframe-2.png");
  momFrames[2] = loadImage("Bframe-4.png");
  palomaGround = loadImage("paloma1.png");
  palomaAir    = loadImage("paloma2.png");
  
  // Cargar sprites de palomas
  palomaGround = loadImage("paloma1.png");
  palomaAir    = loadImage("paloma2.png");
  
  // Inicializar lista de palomas
  pigeons = new ArrayList<Pigeon>();
  
  // Velocidad de vuelo (ahora más rápida)
  float speedMagnitude = 8;
  
  // Cinco palomas:
  //   - Tres arrancan desde el suelo hacia arriba (speed negativo)
  //   - Dos arrancan desde el aire hacia abajo (speed positivo)
  pigeons.add(new Pigeon(100, groundY - 40, -speedMagnitude));
  pigeons.add(new Pigeon(300, 0,             speedMagnitude));
  pigeons.add(new Pigeon(500, groundY - 40, -speedMagnitude));
  pigeons.add(new Pigeon(700, 0,             speedMagnitude));
  pigeons.add(new Pigeon(900, groundY - 40, -speedMagnitude));
  

  // Inicializar variables del Tres en Raya
  cellSizeTTT = 100; // Tamaño de las celdas para la ventana de 300x300
  boardTTT = new int[3][3];
  currentPlayerTTT = 1; // El jugador 1 comienza
  gameOverTTT = false;
  winnerTTT = "";
   try {
    soundCollect = new SoundFile(this, "collect.wav");
    soundCollect.amp(0.7);
    soundsEnabled = true;
    println("✓ Sonidos cargados correctamente");
  } catch (Exception e) {
    println("✗ No se pudieron cargar sonidos: " + e.getMessage());
    soundsEnabled = false;
  }
}
void setupSounds() {
  // Cargar los archivos de sonido (debes tener estos archivos en la carpeta data/)
  soundIntro = new SoundFile(this, "intro.mp3");
  soundCollect = new SoundFile(this, "collect.wav");
  soundTransition = new SoundFile(this, "transition.wav");
  
  // Opcional: ajustar volumen (0.0 a 1.0)
  soundIntro.amp(0.5);
  soundCollect.amp(0.7);
  soundTransition.amp(0.6);
}






void drawVicioso() {
  image(fondo, 0, 0, width, height);

  // Mostrar imagen de la mamá
  image(momFrames[currentFrame], width / 2 - 100, height / 2 - 150, 200, 200);

  // Diálogo tipo máquina de escribir para la escena final
  if (currentDialogue < dialogoVicio.length) {
    if (frameCount % textSpeed == 0 && textIndex < dialogoVicio[currentDialogue].length()) {
      displayedText += dialogoVicio[currentDialogue].charAt(textIndex);
      textIndex++;
    }

    // Mostrar texto
    fill(255);
    rect(0, height - 100, width, 100); // cuadro de texto
    
    // === MODIFICACIÓN CLAVE A CONTINUACIÓN ===
    fill(0);
    textAlign(LEFT); // Temporalmente, alinea el texto a la izquierda
    textSize(20); // Ajusta el tamaño de texto si es necesario
    // Dibuja el texto con un margen izquierdo (por ejemplo, 20 píxeles)
    text(displayedText, 20, height - 60);
    // === FIN DE LA MODIFICACIÓN CLAVE ===

    // Cambio de imagen cada cierto tiempo
    frameTimer++;
    if (frameTimer > frameInterval && currentFrame < momFrames.length - 1) {
      currentFrame++;
      frameTimer = 0;
    }

    // Pasar al siguiente diálogo
    if (textIndex >= dialogoVicio[currentDialogue].length()) {
      if (currentDialogue < dialogoVicio.length - 1) {
        if (frameCount % 60 == 0) { // Esperar 1 segundo entre diálogos
          currentDialogue++;
          displayedText = "";
          textIndex = 0;
        }
      } else {
        scene = 3;
      }
    }
  }
}

// *** IMPORTANTE ***
// Después de la ejecución de drawVicioso, la función draw() sigue llamando a otras funciones.
// Como cambiaste la alineación a LEFT en drawVicioso(), es crucial restaurarla
// si otras escenas (como el menú principal) esperan que sea CENTER.
// Para asegurar que el resto del código funcione como antes, es buena práctica
// usar pushMatrix() y popMatrix() cuando cambias la configuración de dibujo, 
// o re-establecer textAlign(CENTER) al final de drawVicioso() si otras funciones 
// lo necesitan inmediatamente, o al comienzo de draw() o setup().
// Dado que en 'setup()' estableciste 'textAlign(CENTER);', vamos a reestablecerlo.

void drawVicioso_Final() {
  // ... (código modificado arriba)
  // ...
  // === RESTABLECER ALINEACIÓN ===
  textAlign(CENTER); // Reestablece la alineación a CENTER para el resto del código (ej. menú)
  // ... (código modificado arriba)
}
void drawTipScene() {
  // Puedes usar una imagen de fondo apropiada para un tip, o un color sólido.
  // Usaré el fondo general del nivel 1 como ejemplo.
  image(lv1, 0, 0, width, height); // Asumo lv1 está cargado

  // Cuadro de diálogo
  fill(0, 0, 0, 200); // Fondo oscuro semi-transparente
  rect(0, height - 120, width, 120);

  // Lógica de la máquina de escribir
  if (currentDialogue < tip1.length) {
    if (frameCount % textSpeed == 0 && textIndex < tip1[currentDialogue].length()) {
      displayedText += tip1[currentDialogue].charAt(textIndex);
      textIndex++;
    }

    // Mostrar texto
    fill(255);
    textSize(24);
    textAlign(LEFT, CENTER);
    text(displayedText, 50, height - 60, width - 100, 80);

    // Indicador de "ENTER" para pasar al siguiente
    if (textIndex >= tip1[currentDialogue].length()) {
      fill(255, 200, 0);
      textSize(18);
      textAlign(RIGHT);
      text("ENTER >>", width - 20, height - 20);
    }

    // Pasar al siguiente diálogo/escena (se maneja en keyPressed, ver paso 4)

  } else {
    // Si todos los diálogos han terminado, inicia el juego inmediatamente
    startGame();
    scene = 1; // Cambiar a la escena de Gameplay
  }
}
void loadMujerSprites() {
    // Cargar sprites individuales del personaje femenino
    // Necesitas 6 frames para la caminata (basado en las imágenes que proporcionaste)
    mujerFrames = new PImage[3]; 
    
    // SPRITE QUIETA (imagen 3, 4 o 5 - la que se ve más estática)
    mujerSpriteQuieta = loadImage("mujer_quieta.png");
    
    // SPRITES DE CAMINATA/CORRIDA (6 frames)
    // Asegúrate de nombrar tus archivos correctamente
    mujerFrames[0] = loadImage("mujer_walk_0.png");
    mujerFrames[1] = loadImage("mujer_walk_1.png");
    mujerFrames[2] = loadImage("mujer_walk_2.png");
    
    // SPRITE SALTANDO (imagen 6 o 8 - la que está en el aire)
    mujerSpriteSaltando = loadImage("mujer_saltando.png");
    
    // SPRITE DE ATAQUE (puedes usar la imagen 1 o 2 que muestra movimiento)
    mujerAtaque = loadImage("mujer_ataque.png");
}
void selectRandomCharacter() {
    int characterChoice = floor(random(2)); // 0 = Ruko, 1 = Mujer

    if (characterChoice == 0) {
        println("Personaje seleccionado: Ruko");
        currentFrames = rukoFrames;
        currentSpriteQuieto = spriteQuieto;
        currentSpriteSaltando = spriteSaltando;
        currentAtaque = rukoAtaque;
    } else {
        println("Personaje seleccionado: Mujer");
        currentFrames = mujerFrames;
        currentSpriteQuieto = mujerSpriteQuieta;
        currentSpriteSaltando = mujerSpriteSaltando;
        currentAtaque = mujerAtaque;
    }
}


// ==========================
// FASE 2 COMPLETA - CON ARMAS, PERROS Y SALTO
// ==========================

Player ruko;
ArrayList<Car> cars;
ArrayList<Dog> dogs;
ArrayList<Heart> hearts;
Weapon weapon;

float gravity = 0.8;
float groundY = 500;
int damageCooldown = 0;
boolean weaponAcquired = false;
boolean isAttacking = false;
int attackTimer = 0;

int triggerEventX = 730; // Punto donde aparecerá el tipo

void startGame() {
  // Cargar sprites
  gameoverImage = loadImage("gameover.jpg");
  spriteQuieto = loadImage("Ruko-0.png");
  spriteSaltando = loadImage("RukoSaltando.png");
  spriteQuietoPerro = loadImage("Malicioso.png");


  rukoFrames = new PImage[6];
  for (int i = 0; i < 6; i++) {
    rukoFrames[i] = loadImage("Bframe-" + i + ".png");
  }
  // 1. Asegúrate de que TODOS los sprites (Ruko y Mujer) están cargados
    //    (Debes llamar a loadMujerSprites() aquí o antes si no lo has hecho)
    loadMujerSprites(); 

    // 2. Crear el objeto Player
    ruko = new Player(); 
    
    // 3. Ejecutar la selección y asignar los sprites al objeto Ruko (Player)
    selectRandomCharacter();
  cars = new ArrayList<Car>();
  for (int i = 0; i < 3; i++) {
    cars.add(new Car(width + i * 400));
  }
  dogs = new ArrayList<Dog>();
  for (int i = 0; i < 2; i++) {
    dogs.add(new Dog(700 + i * 400));
  }
  hearts = new ArrayList<Heart>();
  for (int i = 0; i < 4; i++) {
    hearts.add(new Heart(20 + i * 65, 10));
  }
  collectables = new ArrayList<Collectable>();
  collectables.add(new Collectable(200, groundY - 40));
  collectables.add(new Collectable(400, groundY - 60));
  collectables.add(new Collectable(600, groundY - 80));
  collectableCount = 0; // Reiniciar el contador al iniciar el juego

  weapon = new Weapon(600, groundY - 20);

  
  


  carFrames = new PImage[4];
  for (int i = 0; i < 4; i++) {
    carFrames[i] = loadImage("sonbad_" + i + ".png");
  }

  dogFrames = new PImage[3];
  for (int i = 0; i < 2; i++) {
    dogFrames[i] = loadImage("malicioso_" + i + ".png");
  }
 gameStartTime = millis(); // Iniciar el contador al comenzar el juego
  println("ha comenzado");
}

void drawGameplay() {
  image(lv1, 0, 0, width, height);
  int l = 0;

  // Piso
  fill(150);
  rect(0, groundY, width, height - groundY);

  // Arma
  if (!weaponAcquired) {
    weapon.display();
    if (ruko.collidesWith(weapon)) {
      weaponAcquired = true;
    }
  }
  // Coleccionables
  for (int i = collectables.size() - 1; i >= 0; i--) {
    Collectable c = collectables.get(i);
    c.display();
    if (c.isCollectedBy(ruko)) {
      collectableCount++;
      collectables.remove(i); // Eliminar el coleccionable recogido de la lista
    }
  }

  // Autos
  for (Car car : cars) {
    car.update();
    car.display();
    if (damageCooldown == 0 && ruko.collidesWith(car)) {
      ruko.takeDamage();
      damageCooldown = 60;
    }
  }

  // Perros
  for (int i = dogs.size() - 1; i >= 0; i--) {
    Dog dog = dogs.get(i);
    dog.update();
    dog.display();

    if (ruko.collidesWith(dog)) {
      if (weaponAcquired && isAttacking) {
        dogs.remove(i);
      } else if (damageCooldown == 0) {
        ruko.takeDamage();
        damageCooldown = 60;
      }
    }
  }

  // Ruko
  ruko.update();
  ruko.display();

  // Vidas
  for (int i = 0; i < hearts.size(); i++) {
    hearts.get(i).update(); // actualizar parpadeo
    hearts.get(i).display(); // dibujar sprite
  }

  // Mostrar contador de coleccionables
  
// Posicionar debajo de los corazones

  if (damageCooldown > 0) damageCooldown--;
  if (isAttacking) {
    attackTimer--;
    if (attackTimer <= 0) isAttacking = false;
  }

  if (ruko.x > triggerEventX && !showCube && !inMiniGame) {
  l = l + 1;
  lv1 = loadImage("lv_" + l + ".png");
  
  ruko.x = 0;
  println("¡Llegaste al punto del tipo misterioso!");
  

  showCube = true;  // Activar el cubo cuando se cumple la condición
  //Para que aparescan las encomiendas en el segundo nivel
  collectables.add(new Collectable(150, groundY - 60));
    collectables.add(new Collectable(350, groundY - 80));
    collectables.add(new Collectable(550, groundY - 40));
}


  if (ruko.lives <= 0) {
    scene = 99;
  }
}



void initTTT() {
  cellSizeTTT = 100; // Tamaño de las celdas para la ventana de 300x300
  boardTTT = new int[3][3];
  currentPlayerTTT = 1; // El jugador 1 comienza
  gameOverTTT = false;
  winnerTTT = "";
}

void drawTTTGrid() {
  stroke(100, 200, 250);
  for (int i = 1; i < 3; i++) {
    line(i * cellSizeTTT, 0, i * cellSizeTTT, 300);
    line(0, i * cellSizeTTT, 300, i * cellSizeTTT);
  }
}

void drawTTTBoard() {
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
      int x = col * cellSizeTTT + cellSizeTTT / 2;
      int y = row * cellSizeTTT + cellSizeTTT / 2;
      if (boardTTT[row][col] == 1) {
        drawTTTCircle(x, y);
      } else if (boardTTT[row][col] == 2) {
        drawTTTCross(x, y);
      }
    }
  }
}

void drawTTTCircle(int x, int y) {
  noFill();
  stroke(255, 0, 0);
  strokeWeight(5);
  ellipse(x, y, cellSizeTTT * 0.6, cellSizeTTT * 0.6);
}

void drawTTTCross(int x, int y) {
  stroke(0, 0, 255);
  strokeWeight(5);
  line(x - cellSizeTTT * 0.3, y - cellSizeTTT * 0.3, x + cellSizeTTT * 0.3, y + cellSizeTTT * 0.3);
  line(x + cellSizeTTT * 0.3, y - cellSizeTTT * 0.3, x - cellSizeTTT * 0.3, y + cellSizeTTT * 0.3);
}

void mousePressedTTT() {
  if (!gameOverTTT) {
    // Ajustar las coordenadas del ratón según la traslación del tablero
    int adjustedMouseX = mouseX - (width / 2 - 150);
    int adjustedMouseY = mouseY - (height / 2 - 150);

    int col = adjustedMouseX / cellSizeTTT;
    int row = adjustedMouseY / cellSizeTTT;

    if (col >= 0 && col < 3 && row >= 0 && row < 3 && boardTTT[row][col] == 0) {
      boardTTT[row][col] = currentPlayerTTT;
      if (checkWinTTT(currentPlayerTTT)) {
        gameOverTTT = true;
        winnerTTT = (currentPlayerTTT == 1) ? "Vicioso" : "Ruko";
        if (currentPlayerTTT == 1) { // Si gana el jugador rojo (asumimos que el jugador es azul)
          if (collectableCount > 0) {
            collectableCount--;
            println("¡Ruko perdió una encomienda! Total: " + collectableCount);
          } else {
            println("¡Ruko no tiene encomiendas para perder!");
          }
        }
      } else if (isBoardFullTTT()) {
        gameOverTTT = true;
        winnerTTT = "Empate";
      } else {
        currentPlayerTTT = (currentPlayerTTT == 1) ? 2 : 1; // Cambiar de jugador
      }
    }
  } else {
    // Reiniciar el juego solo si no se ha alcanzado el límite
    if (gamesPlayedTTT < maxGamesTTT) {
      resetGameTTT();
    } else {
      println("Se han jugado el máximo de partidas de Tres en Raya.");
      if (collectableCount < 4) {
        println("¡Ruko no tiene suficientes coleccionables (mínimo 7)! Game Over.");
        scene = 99; // Terminar el juego si no tiene suficientes coleccionables
      } else {
        // Reiniciar el índice del diálogo final
        currentDialogue = 0;
        displayedText = ""; // También es buena idea reiniciar el texto mostrado
        textIndex = 0;      // Y el índice del carácter
        // Cambiar la escena a la de "The End"
        scene = 8;
      // Inicializar las variables necesarias para esta nueva escena
      ruko.x = 50; // Resetear la posición de Ruko (ajusta si es necesario)
      showCubeTransition = true; // Mostrar el cubo en esta escena
      cubeTransitionX = 700; // Posición del cubo (ajusta si es necesario)
      cubeTransitionY = 400;
        // Opcionalmente, podrías resetear el contador de partidas aquí si quisieras que
        // al volver al menú principal se pudiera volver a jugar 3 veces.
        // gamesPlayedTTT = 0;
      }
    }
  }
}

boolean checkWinTTT(int player) {
  // Verificar filas
  for (int i = 0; i < 3; i++) {
    if (boardTTT[i][0] == player && boardTTT[i][1] == player && boardTTT[i][2] == player) return true;
  }
  // Verificar columnas
  for (int i = 0; i < 3; i++) {
    if (boardTTT[0][i] == player && boardTTT[1][i] == player && boardTTT[2][i] == player) return true;
  }
  // Verificar diagonales
  if (boardTTT[0][0] == player && boardTTT[1][1] == player && boardTTT[2][2] == player) return true;
  if (boardTTT[0][2] == player && boardTTT[1][1] == player && boardTTT[2][0] == player) return true;
  return false;
}

boolean isBoardFullTTT() {
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
      if (boardTTT[row][col] == 0) return false;
    }
  }
  return true;
}

void displayTTTInfo() {
  fill(0);
  textSize(20);
  textAlign(CENTER);
  if (!gameOverTTT) {
    text("Turno de: " + (currentPlayerTTT == 1 ? "Vicioso" : "Ruko"), width / 2, height - 30);
  } else {
    if (!winnerTTT.equals("Empate")) {
      text("¡Ganador: " + winnerTTT + "!", width / 2, height - 60);
      if (winnerTTT.equals("Vicioso")) {
        textSize(16);
        text("Ruko perdió un coleccionable.", width / 2, height - 40);
      }
    } else {
      text("¡Empate!", width / 2, height - 60);
    }
    textSize(16);
    if (gamesPlayedTTT < maxGamesTTT) {
      text("Haz clic para reiniciar", width / 2, height - 30);
    } else {
      if (collectableCount < 5) {
        text("¡No son suficientes encomiendas! Fin del juego.", width / 2, height - 30);
      } else {
        text("Máximo de partidas alcanzado. ¡Continúa la aventura!", width / 2, height - 30);
      }
    }
  }
  

  // Botón de volver al menú
  
}

void resetGameTTT() {
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
      boardTTT[row][col] = 0;
    }
  }
  currentPlayerTTT = 1;
  gameOverTTT = false;
  winnerTTT = "";
  gamesPlayedTTT++; // Incrementar el contador de partidas
  println("Partidas jugadas: " + gamesPlayedTTT);
}

void drawTTTScene() {
  background(255);
  pushMatrix();
  translate(width / 2 - 150, height / 2 - 150); // Centrar el tablero
  drawTTTGrid();
  drawTTTBoard();
  popMatrix();
  displayTTTInfo();
}
void drawTTTTransitionScene() {
  image(lv2, 0, 0, width, height); // Puedes usar el mismo fondo del gameplay
   // Dibujar y actualizar palomas
  for (Pigeon p : pigeons) {
    p.update();
    p.display(); // Dibuja en pantalla cada frame
    // Detección de colisión manual
    if (ruko.x < p.x + p.w && ruko.x + ruko.w > p.x &&
        ruko.y < p.y + p.h && ruko.y + ruko.h > p.y) {
      scene = 99; // Game Over
    }
  }
  // Piso
  fill(150);
  rect(0, groundY, width, height - groundY);

  // Ruko
  ruko.update();
  ruko.display();

  // Cubo de transición
  if (showCubeTransition) {
  image(spriteMamaFinal, cubeTransitionX, cubeTransitionY + 5, 60, 100); // Mostrar sprite mamá

  if (ruko.collidesWithCube(cubeTransitionX, cubeTransitionY + 5, 60, 100)) {
    println("¡Ruko tocó a la mamá al final!");
    currentDialogue = 0;
    displayedText = "";
    textIndex = 0;
    scene = 4; // Escena de diálogo final
    showCubeTransition = false;
  }
}


  // Si por alguna razón Ruko se cae, podrías tener una condición de Game Over aquí también
  if (ruko.lives <= 0) {
    scene = 99;
  }
}
// ==========================
// TECLAS
// ==========================

  void mousePressed() {
  // Detecta si se ha hecho clic en algún botón SOLO si la escena es -1 (menú principal)
  if (scene == -1) {
    if (mouseX > boton1X - botonAncho / 2 && mouseX < boton1X + botonAncho / 2 &&
        mouseY > boton1Y - botonAlto / 2 && mouseY < boton1Y + botonAlto / 2) {
     println("¡Hiciste clic en el botón 1!");
      displayedText = ""; // Reiniciar displayedText antes de la intro
      textIndex = 0;       // Reiniciar el índice del texto
      currentDialogue = 0; // Reiniciar el diálogo
      scene = 0; // Establece la escena a 0
      // No es necesario un switch aquí, simplemente llama a la función directamente
    } else if (mouseX > boton2X - botonAncho / 2 && mouseX < boton2X + botonAncho / 2 &&
               mouseY > boton2Y - botonAlto / 2 && mouseY < boton2Y + botonAlto / 2) {
      println("¡Hiciste clic en el botón 2!");
      scene = 2;
    } else if (mouseX > boton3X - botonAncho / 2 && mouseX < boton3X + botonAncho / 2 &&
               mouseY > boton3Y - botonAlto / 2 && mouseY < boton3Y + botonAlto / 2) {
      println("¡Hiciste clic en el botón 3!");
      scene = 99;
    } else if (mouseX > boton4X - botonAncho / 2 && mouseX < boton4X + botonAncho / 2 &&
               mouseY > boton4Y - botonAlto / 2 && mouseY < boton4Y + botonAlto / 2) {
      println("¡Hiciste clic en el botón 4!");
      scene = 6;
      
    }
  }

  // Detectar clic en el tablero del Tres en Raya solo si la escena es la correcta
  if (scene == 3) {
    mousePressedTTT();
  }
}


void keyPressed() {
  // Lógica de Salto para la escena de Gameplay (scene 1)
  if (scene == 1) {
    if (ruko != null) {
      if (key == 'w' || key == 'W') {
        ruko.jump();
      }
    }
  }
  
  if (scene == 1 && weaponAcquired && key == ' ') {
    isAttacking = true;
    attackTimer = 3;
  }

  // MODIFICADO: Agregar sonido al cambiar de escena
  if (scene == 0 && key == ENTER) {
    if (textIndex >= dialogues[currentDialogue].length()) {
      if (currentDialogue < dialogues.length - 1) {
        currentDialogue++;
        displayedText = "";
        textIndex = 0;
      } else {
        // Detener sonido de intro
        soundIntro.stop();
        // Reproducir sonido de transición
        soundTransition.play();
        
        currentDialogue = 0;
        displayedText = "";
        textIndex = 0;
        scene = TIP_SCENE;
      }
    }
  }
  
  if (scene == TIP_SCENE && key == ENTER) {
    if (textIndex >= tip1[currentDialogue].length()) {
      if (currentDialogue < tip1.length - 1) {
        currentDialogue++;
        displayedText = "";
        textIndex = 0;
      } else {
        // Reproducir sonido de transición
        soundTransition.play();
        
        currentDialogue = 0;
        displayedText = "";
        textIndex = 0;
        startGame();  
        scene = 1;
      }
    }
  }

  if (scene == 4 && key == ENTER) {
    if (textIndex >= dialoguesFinal[currentDialogue].length()) {
      if (currentDialogue < dialoguesFinal.length - 1) {
        currentDialogue++;
        displayedText = "";
        textIndex = 0;
      } else {
        // Reproducir sonido de transición al final
        soundTransition.play();
        scene = 5;
      }
    }
  }

  if (scene == 6 && key == ENTER) {
    if (textIndex >= credit[currentDialogue].length()) {
      if (currentDialogue < credit.length - 1) {
        currentDialogue++;
        displayedText = "";
        textIndex = 0;
      }
    }
  }
}
// Detener todos los sonidos (útil para game over o menú)
void stopAllSounds() {
  if (soundIntro != null && soundIntro.isPlaying()) soundIntro.stop();
  if (soundCollect != null && soundCollect.isPlaying()) soundCollect.stop();
  if (soundTransition != null && soundTransition.isPlaying()) soundTransition.stop();
}
void info() {
  info1 = loadImage("info2.png");
  image(info1, 0, 0, width, height);
  image(flechaVolver, 20, 20, 50, 50); // dibujar flecha de volver
  if (mousePressed && mouseX > 20 && mouseX < 70 && mouseY > 20 && mouseY < 70) {
    scene = -1; // volver al menú principal
  }
}
void resetToMenu() {
  scene = -1;         // Volver al menú principal
  gameOverFrame = -1; // Resetear flag
  tttPlayed = false;
  collectableCount = 0;
}
void credit(){
  image(flechaVolver, 20, 20, 50, 50); // dibujar flecha de volver
  if (mousePressed && mouseX > 20 && mouseX < 70 && mouseY > 20 && mouseY < 70) {
    displayedText = "";
    textIndex = 0;
    currentDialogue = 0;
    scene = -1; // volver al menú principal
  }
if (frameCount % textSpeed == 0 && textIndex < credit[currentDialogue].length()) {
    displayedText += credit[currentDialogue].charAt(textIndex);
    textIndex++;
  }

  // Mostrar texto
  fill(255);
  rect(0, height - 100, width, 100); // cuadro de texto
  fill(0);
  text(displayedText, width / 2, height - 60);
  
  //Cambio de imagen cada cierto tiempo
  frameTimer++;
  if (frameTimer > frameInterval && currentFrame < momFrames.length - 1) {
    currentFrame++;
    frameTimer = 0;
    
    // Pasar al siguiente diálogo
    if (textIndex >= credit[currentDialogue].length()) {
      if (currentDialogue < credit.length - 1) {
        if (frameCount % 60 == 0) { // Esperar 1 segundo entre diálogos
          currentDialogue++;
          displayedText = "";
          textIndex = 0;
        }
      }
  }
}
}
void updateGameElapsedTime() {
  if (gameStartTime != 0) { // Asegurarse de que el juego ha comenzado
    int currentTime = millis();
    elapsedGameSeconds = (currentTime - gameStartTime) / 1000;
  }
}
// ==========================
// DIBUJADO
// ==========================
void draw() {
  background(220);
   // Verificar el temporizador si el juego ha comenzado y el TTT ha terminado
  if (gameStartTime > 0) {
    updateGameElapsedTime();
  }

  switch (scene) {
    case 0:
      drawIntroScene();
      break;
      case 10: // Nueva escena
      drawTipScene();
      break;
    case 1:
      drawGameplay();
      image(bolsa, 10, 10 + (hearts.size() * 10), 70, 70);
  fill(0);
  textSize(30);
  text("X" + collectableCount, 100, 45 + (hearts.size() * 10)+5); // Posicionar debajo de los corazones
  updateGameElapsedTime();
  image(tiempo, 10, 60 + (hearts.size() * 10), 70, 70);
  fill(0);
  textSize(30);
  text("X" + elapsedGameSeconds, 100, 100 + (hearts.size() * 10)+5); // Posicionar debajo de los corazones
  if(elapsedGameSeconds >= 100){
  scene = 99;
  }
      if (showCube) {
         image(misterioso, 700, 405, 60, 100);  // Mostrar solo el sprite del tipo
           // Detectar colisión con el sprite
      if (ruko.collidesWithCube(700, 350, 60, 100)) {
           println("¡Entraste al minijuego de Tres en Raya!");
          currentDialogue = 0; // Reiniciar el diálogo del Vicioso
          displayedText = "";
          textIndex = 0;
         scene = VICIOUS_SCENE; // Cambiar a la escena del Vicioso
         showCube = false; // Ocultar el sprite después de la colisión
       }
    }
    break;
    case 2:
      info();
      break;
    case 3:
      drawTTTScene();
      break;
      case 6:
     credit();
      break;
      case 7:
      drawVicioso();
      break;
      case 8:
      drawTTTTransitionScene();
      image(bolsa, 10, 10 + (hearts.size() * 10), 70, 70);
  fill(0);
  textSize(30);
  text("X" + collectableCount, 100, 45 + (hearts.size() * 10)+5); // Posicionar debajo de los corazones
  updateGameElapsedTime();
  image(tiempo, 10, 60 + (hearts.size() * 10), 70, 70);
  fill(0);
  textSize(30);
  text("X" + elapsedGameSeconds, 100, 100 + (hearts.size() * 10)+5); // Posicionar debajo de los corazones
  if(elapsedGameSeconds >= 100){
  scene = 99;
  }
      break;
   case 99:
     image(gameoverImage, 0, 0, width, height);
     // Registrar el momento en que entramos por primera vez en Game Over
     if (gameOverFrame < 0) {
        gameOverFrame = frameCount;
     }

    // Esperar al menos 3 segundos (180 frames a 60fps)
     if (frameCount - gameOverFrame >= 180) {
      if (keyPressed) {
        resetToMenu(); // solo permitir volver al menú después del tiempo mínimo
       }
    }
   break;

    case -1: // Caso para el menú principal
      image(menu, 0, 0, width, height);
      // Dibuja el primer botón
      fill(colorBoton1);
      rect(boton1X - botonAncho / 2, boton1Y - botonAlto / 2, botonAncho, botonAlto, 10);
      fill(0);
      text(textoBoton1, boton1X, boton1Y + 5);

      // Dibuja el segundo botón
      fill(colorBoton2);
      rect(boton2X - botonAncho / 2, boton2Y - botonAlto / 2, botonAncho, botonAlto, 10);
      fill(0);
      text(textoBoton2, boton2X, boton2Y + 5);

      // Dibuja el tercer botón
      fill(colorBoton3);
      rect(boton3X - botonAncho / 2, boton3Y - botonAlto / 2, botonAncho, botonAlto, 10);
      fill(0);
      text(textoBoton3, boton3X, boton3Y + 5);

      // Dibuja el cuarto botón (Tres en Raya)
      fill(colorBoton4);
      rect(boton4X - botonAncho / 2, boton4Y - botonAlto / 2, botonAncho, botonAlto, 10);
      fill(0);
      text(textoBoton4, boton4X, boton4Y + 5);
      
      // Botón de Créditos
     

      // Detecta el "hover"
      if (mouseX > boton1X - botonAncho / 2 && mouseX < boton1X + botonAncho / 2 &&
          mouseY > boton1Y - botonAlto / 2 && mouseY < boton1Y + botonAlto / 2) {
        colorBoton1 = colorBotonHover;
      } else {
        colorBoton1 = colorBotonNormal;
      }

      if (mouseX > boton2X - botonAncho / 2 && mouseX < boton2X + botonAncho / 2 &&
          mouseY > boton2Y - botonAlto / 2 && mouseY < boton2Y + botonAlto / 2) {
        colorBoton2 = colorBotonHover;
      } else {
        colorBoton2 = colorBotonNormal;
      }

      if (mouseX > boton3X - botonAncho / 2 && mouseX < boton3X + botonAncho / 2 &&
          mouseY > boton3Y - botonAlto / 2 && mouseY < boton3Y + botonAlto / 2) {
        colorBoton3 = colorBotonHover;
      } else {
        colorBoton3 = colorBotonNormal;
      }

      if (mouseX > boton4X - botonAncho / 2 && mouseX < boton4X + botonAncho / 2 &&
          mouseY > boton4Y - botonAlto / 2 && mouseY < boton4Y + botonAlto / 2) {
        colorBoton4 = colorBotonHover;
      } else {
        colorBoton4 = colorBotonNormal;
      }
      // Detecta el "hover" para el quinto botón ("Créditos")
      
      break;
      case 4: // Nueva escena para "The End"
      drawFinalScene();
      break;
      case 5:
      background(0); // Fondo negro
      fill(255);
      textSize(48);
      textAlign(CENTER, CENTER);
      text("The End", width / 2, height / 2);
      textSize(20);
      text("Gracias por jugar", width / 2, height / 2 + 50);
      break;
      
    default:
      // Si scene no coincide con ningún caso específico, no dibujar nada más.
      break;
  }
}
