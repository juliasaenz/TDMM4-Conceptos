class Enfermedad {
  Otros[] otroEnf = new Otros[4];
  float xA, yA;
  int colisiones = 0;

  // usuario
  float tam = 60;
  float x = width/2, y = height/2;
  float x_, y_;
  float r = 0.0;
  float vel = 0.5, opacidad;

  boolean crece = false;

  boolean enferma = false;
  boolean enf2 = false;
  boolean seleccion= false;

  float time, espera = 500;
  float tiempo = 0;

  // imagen
  PImage imagenP[];
  PImage imagenA[];
  PImage splash[];
  color paletaA[];
  int cant = 4;
  int cual = 0;
  int cual2 = 2;
  int cual3 = 1;

  float dx;
  float dy;

  Enfermedad(PImage[] p, PImage[] a, PImage[] s) {
    imagenP = p;
    imagenA = a;
    splash = s;

    // PALETA AGRESIVA
    paletaA = new color[cant];
    paletaA[0] = #FF001B;
    paletaA[1] = #0033CA; 
    paletaA[2] = #00DD1F;
    paletaA[3] = #BA0000;

    // timer
    time = millis();

    //otros
    for (int i=0; i < otroEnf.length; i++) {
      otroEnf[i] = new Otros();
    }
  }

  void cambio() {
    if (millis() - time >= espera) {
      cual = int(random(cant));
      cual2 = int(random(cant));
      cual3 = int(random(cant));
      time = millis();//also update the stored time
    }
  }

  void usuario() {
    imageMode(CENTER);
    //println(dx);
    x += dx * vel;
    y += dy * vel;
    if (seleccion) {
      float targetX = mouseX;
      float targetY = mouseY;
      dx = targetX - x;
      dy = targetY - y;
    } else { 
      pushStyle();
      if (enferma) {
        tint(#76c3a6);
      } else {
        tint (#0c8637);
      }
      image (splash[cual3], x, y);
      popStyle();
    }


    if (enferma == true) {
      enf2 = true;
    }
    if (tiempo > 6) {
      enf2 = false;
      enferma = false;
      dx=0;
      dy=0;
      tiempo = 0;
    }


    if (enf2 == true) {   
      vel = 0.02;
      pushStyle();
      tint(#76c3a6);
      image (imagenP[cual], x, y);
      popStyle();
      reloj();
    } else {  

      pushStyle();
      tint(#0c8637);
      image (imagenA[cual2], x, y);
      popStyle();
      if (vel < 0.8) {
        vel = vel + 0.005;
      }
    }

    cambio();
  }

  void select() { 
    int dista = int(dist(mouseX, mouseY, x, y));
    if (dista < 100) {
      seleccion = !seleccion;
    }
  }

  void reloj() {
    tiempo += 0.0166;
    if (tiempo >= 7) {
      tiempo = 0;
    }
  }

  void enfermar(boolean enf_)
  {
    enferma = enf_;
  }

  boolean getEnfermedad() {
    return enf2;
  }

  float getPositionX() {
    return x;
  }

  float getPositionY() {
    return y;
  }

  void interaccion() {
    xA = enf.getPositionX();
    yA = enf.getPositionY();

    enf.usuario();

    for (int i=0; i < otroEnf.length; i++) {
      otroEnf[i].dibujar();
      if (otroEnf[i].colisionaEnf(x, y)) {
        colisiones++;
      }
      if (otroEnf[i].colisiona(x, y) && (enf.getEnfermedad() == true)) {
        //println(i);
        otroEnf[i].setEnfermedad();
      }
    }

    if (colisiones > 0) {
      enf.enfermar(true);
      colisiones = 0;
    } else {
      //enf.enfermar(false);
    }
  }
}

/// OTROS ///
///
///
/// OTROS ///

class Otros
{
  float x, x_, y, y_, tam = 70;
  float tiempo = 0;
  float tDebilidad;
  int dirX = 1;
  int dirY = 1;

  boolean enferma = false;
  boolean enferma_ = false;

  color tinteP, tinteA;
  PImage imagen;

  PImage mancha, mancha2;

  // imagen
  PImage imagenP[];
  PImage imagenA[];
  PImage splash[];
  int cant = 4;
  int cual = 0, cual2 = 2, cual3 = 1;

  //timer
  int time;
  int espera = 500;


  /////////////////////////OTROOOOOSSSSSSSSSSSSSSSS/////////////



  Otros() {
    y = random (100, height-200);
    x = random (100, width-100); 
    x_ = x;
    y_ = y;

    tDebilidad = random (5, 15);
    rectMode(CENTER);

    // IMAGENES PASIVAS
    imagenP = new PImage [cant];
    imagenP[0] = loadImage("mancha redonda.png");
    imagenP[1] = loadImage("mancha redonda2.png");
    imagenP[2] = loadImage("mancha redonda3.png");
    imagenP[3] = loadImage("mancha redonda4.png");

    // IMAGENES AGRESIVAS
    imagenA = new PImage [cant];
    imagenA[0] = loadImage("mancha agresiva.png");
    imagenA[1] = loadImage("mancha agresiva2.png");
    imagenA[2] = loadImage("mancha agresiva3.png");
    imagenA[3] = loadImage("mancha agresiva4.png");

    for (int i = 0; i < cant; i++) {
      imagenP[i].filter( INVERT );
      imagenA[i].filter( INVERT );
    }

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

  void dibujar()
  {
    //println(mouseY);
    if (x <= 10 || x >= 740 || y <= 10 || y >= 580 ) {
      dirX = int(random(-2, 2));
      while (dirX==0) {
        dirX= int(random(-2, 2));
      }
      dirY = int(random(-2, 2));
      while (dirY==0) {
        dirY= int(random(-2, 2));
      }
    }

    //println("enferma: ", enferma);
    if (enferma) {
      if ( x>0 && x<width && y>0 && y<height) {
        x = x + 0.2*dirX;
        y = y + 0.2*dirY;
      }
      pushStyle();
      tint(#76c3a6);
      image(imagenP[cual2], x, y);
      popStyle();
    } else {
      if ( x>0 && x<width && y>0 && y<height) {
        x = x + 1*dirX;
        y = y + 1*dirY;
      }
      pushStyle();
      tint(#0c8637);
      image(imagenA[cual], x, y);
      popStyle();
    }

    reloj();    
    cambio();
  }

  void reloj() {
    tiempo += 0.0166;
    if (tiempo >= tDebilidad) {
      enferma = !enferma;
      tiempo = 0;
    }
  }

  boolean colisiona (float xx, float yy) {
    if ((xx < x+tam/2) && (xx > x-tam/2) && (yy > y-tam/2) && (yy < y+tam/2)) {
      return true;
    } else {
      return false;
    }
  }

  boolean colisionaEnf (float xx, float yy) {
    if ((xx < x+tam/2) && (xx > x-tam/2) && (yy > y-tam/2) && (yy < y+tam/2) && (enferma == true)) {
      return true;
    } else {
      return false;
    }
  }

  void setEnfermedad() {
    enferma = true;
  }
}
