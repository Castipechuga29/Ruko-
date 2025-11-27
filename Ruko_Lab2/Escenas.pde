PImage fondo;  // imagen del fondo para la intro

// ESCENA 0: INTRO
void drawIntroScene() {
  image(fondo, 0, 0, width, height);
  // Mostrar imagen de la mamá
  image(momFrames[currentFrame], width / 2 - 100, height / 2 - 150, 200, 200);

  // Diálogo tipo máquina de escribir
  if (frameCount % textSpeed == 0 && textIndex < dialogues[currentDialogue].length()) {
    displayedText += dialogues[currentDialogue].charAt(textIndex);
    textIndex++;
  }

  // Mostrar texto
  fill(255);
  rect(0, height - 100, width, 100); // cuadro de texto
  fill(0);
  text(displayedText, width / 2, height - 60);

  // Cambio de imagen cada cierto tiempo
  frameTimer++;
  if (frameTimer > frameInterval && currentFrame < momFrames.length - 1) {
    currentFrame++;
    frameTimer = 0;
  }
}


//ESCENA 4: FINAL
void drawFinalScene() {
  image(lv2, 0, 0, width, height);

  // Mostrar imagen de la mamá
  image(momFrames[currentFrame], width / 2 - 100, height / 2 - 150, 200, 200);

  // Diálogo tipo máquina de escribir para la escena final
  if (currentDialogue < dialoguesFinal.length) {
    if (frameCount % textSpeed == 0 && textIndex < dialoguesFinal[currentDialogue].length()) {
      displayedText += dialoguesFinal[currentDialogue].charAt(textIndex);
      textIndex++;
    }

    // Mostrar texto
    fill(255);
    rect(0, height - 100, width, 100); // cuadro de texto
    fill(0);
    text(displayedText, width / 2, height - 60);

    // Cambio de imagen cada cierto tiempo
    frameTimer++;
    if (frameTimer > frameInterval && currentFrame < momFrames.length - 1) {
      currentFrame++;
      frameTimer = 0;
    }

    // Pasar al siguiente diálogo
    if (textIndex >= dialoguesFinal[currentDialogue].length()) {
      if (currentDialogue < dialoguesFinal.length - 1) {
        if (frameCount % 60 == 0) { // Esperar 1 segundo entre diálogos
          currentDialogue++;
          displayedText = "";
          textIndex = 0;
        }
      }else {
        // Cuando se muestra el último diálogo, iniciar el contador de espera
        esperaFinal = 60; // 60 fotogramas = 1 segundo
      }
    }
  } else if (esperaFinal > 0) {
    // Decrementar el contador de espera
    esperaFinal--;
    // Cuando el contador llega a 0, cambiar a la escena final
    if (esperaFinal == 0) {
      scene = 5;
    }
  }
}
