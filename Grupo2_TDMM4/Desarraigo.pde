class Desarraigoo {
  Elemento[] e = new Elemento[5]; //Vector de figuras/elementos

  Desarraigoo(PImage[] p, PImage[] a, PImage[] s) {
    //creo los objetos elementos
    for (int i=0; i < e.length; i++) {
      e[i] = new Elemento(p, a, s);
    }
  }

  void interaccion() {    
    for (int i=0; i < e.length; i++) {
      e[i].dibujar();
      e[i].reinicio();
    }
  }

  void seleccion() {
    for (int i=0; i < e.length; i++) {
      e[i].select();
    }
  }
}

//Elemento
class Elemento
{
  boolean seleccion = false;
  boolean paso = false;
  float tam = 60;
  float x = 0, y = 0;
  float tiempo = 0;
  int dirX = 1, dirY = -1;

  color tinteP, tinteA;
  PImage imagen;
  float lerping = 0.001;

  Paleta paletaP;
  Paleta paletaA;
  PImage mancha, mancha2;

  // imagen
  PImage imagenP[];
  PImage imagenA[];
  PImage splash[];
  int cant = 4;
  int cual = 0;
  int cual2 = 2;
  int cual3 = 1;

  //timer
  int time;
  int espera = 500;


  Elemento(PImage[] p, PImage[] a, PImage[] s) {
    imagenP = p;
    imagenA = a;
    splash = s;

    //pos
    y = random (tam, height-tam);
    x = random (width/2+100, width-tam);    


    paletaP = new Paleta( "tranquis4.png" ); //la paleta
    paletaA = new Paleta("intensos4.png");

    tinteP = paletaP.darUnColor(random(150, 255));
    tinteA = paletaA.darUnColor(random(90, 255));

    // timer
    time = millis();
  }

  //CAMBIO DE IMAGEN
  void cambio() {
    if (millis() - time >= espera) {
      cual = int(random(cant));
      cual2 = int(random(cant));
      cual3 = int(random(cant));
      time = millis();//also update the stored time
    }
  }

  void dibujar() {
    imageMode(CENTER);
    tint (tinteP);

    //dibujo si la figura no se alejó del grupo
    if (!paso) {  
      x = x + 1*dirX;
      y = y + 1*dirY;
      tam = 60;
      if (x <= width/2 || x >= width-tam/2 || y <= tam/2 || y >= height-tam/2 ) {
        dirX = int(random(-2, 2));
        if (dirX==0) {
          dirX = int(random(-2, 2));
        }
        dirY = int(random(-2, 2));
        if (dirY==0) {
          dirY = int(random(-2, 2));
        }
      }
      if (x < (width/2) || x > (width-tam/2) || y < tam/2 || y > height-tam/2 ) {
        dirX = dirX * -1;
        dirY = dirY * -1;
      }
      image(imagenP[cual], x, y);
    } else { //se alejó del grupo
      tint(tinteA);
      image (imagenA[cual2], x, y, tam, tam);
      tam = 45;
    }

    //Movimiento del elemento
    if ((seleccion)&&(!paso)) { //Si el elemento no se alejó del grupo
      x = mouseX;
      y = mouseY;
    } else if ((seleccion) && (paso) && (mouseX < width/2)) {
      x = mouseX;
      y = mouseY;
    }

    if (!seleccion) {
      image(splash[cual3], x, y);
    }

    if ((seleccion) && (mouseX <= width/2)) { //El elemento se alejó del grupo
      paso = true;
    } 

    cambio();

    //temporizador cuando el elemento se aleja del grupo
    if (paso) { 
      tiempo += 0.0166;
    }
  }

  void reinicio() {
    //Si pasa x cantidad de tiempo se reinicia el elemento
    if ((tiempo > 5) && (paso == true)) {
      seleccion = false;
      x -= random (0, 3);  
      y = y + random(-1, 3);
    }

    if ((x < 0-tam) && (tiempo > 10)) {
      paso = false;
      y = random (tam, height-tam);
      x = random (width/2+100, width-tam); 
      tiempo = 0;
    }
  }

  void select() { 
    int dista = int(dist(mouseX, mouseY, x, y));
    if (dista < tam) {
      seleccion = !seleccion;
    }
  }
}
