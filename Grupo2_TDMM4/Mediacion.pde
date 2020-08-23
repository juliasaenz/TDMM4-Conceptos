class Mediacion {
  // usuario
  float x = 0;
  float y = 0;
  float tam = 60;
  float dir = 1;
  boolean izquierda = true;
  // otro1
  float x1 = 0;
  float y1 = 0;
  float dir1 = 1;
  // otro 2
  float x2 = 0;
  float y2 = 0;
  float dir2 = 1;
  // imagen
  PImage imagenP[];
  PImage splash[];
  PImage imagenA[];
  color paletaA[];
  int cant = 4;
  int cual = 0;
  int cual2 = 2;
  int cual3 = 1;
  //timer
  int time;
  int espera = 500;
  //GENERAL
  float genX = 100;
  float genY = 100;
  float genDista;
  boolean elegido = false;
  // NUEVO
  float xH = 90;
  float pos = 0;
  float vel = 1;
  boolean paz = false;

  Mediacion(PImage[] p, PImage[]a, PImage[] s) {
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

  void _usuario_(float a, float b) {
    pushMatrix();
    tint(#00D4E9);
    imageMode(CENTER);
    image(imagenP[cual2], a, b);
    if (izquierda) {
      _h();
    } else {
      _v();
    }
    if (elegido) {
      if (mouseX <= width/2) {
        izquierda = true;
      } else {
        izquierda = false;
      }
    }
    if (!elegido) {
      pushStyle();
      tint(#00D4E9);
      imageMode(CENTER);
      image(splash[cual3], a, b);
      popStyle();
    }
    popMatrix();
  }

  void _otro(float a, float b, color colorcito, PImage img) {
    pushMatrix();
    tint(colorcito);
    imageMode(CENTER);
    image(img, a, b);
    popMatrix();
  }

  void interaccion() {
    genDista = dist(mouseX, mouseY, genX, genY);
    if (elegido) {
      genY = mouseY;
      genX = mouseX;
    } else {
      cursor();
    }
    //MOVIMIENTO HORIZONTAL
    xH = xH + (vel*dir1); 
    if (xH > width/2-tam/2 || xH < tam/2) {
      dir1 = dir1 * -1;
    }
    //velocidad
    PImage cualImg = imagenP[cual];
    float dista = dist(xH, (width-xH), 0, 0);
    color coli = paletaA[0];
    color cold = paletaA[1];
    println("distaaaa", dista);
    if (!paz) {
      if (dista < 660) {
        vel = 6;
        cualImg = imagenA[cual];
      } else {
        vel = 4;
        cualImg = imagenP[cual];
        //cold = #FAE950;
        //coli = #42B488;
      }
    }
    if ( width/2-tam < genX && genX < width/2+tam) {
      paz = true;
      vel = 1;
      xH = lerp(xH,width/2-tam,0.05);
      cualImg = imagenP[cual];
    } else {
      paz = false;
    }
    //izq
    _otro(xH, width/6, coli, cualImg);
    _otro(xH, (width/6)*2, coli, cualImg);
    _otro(xH, (width/6)*3, coli, cualImg);
    _otro(xH, (width/6)*4, coli, cualImg);
    //der
    _otro((width -xH), width/6, cold, cualImg);
    _otro((width -xH), (width/6)*2, cold, cualImg);
    _otro((width -xH), (width/6)*3, cold, cualImg);
    _otro((width -xH), (width/6)*4, cold, cualImg);

    cambio();
    _usuario_(genX, genY);
  }

  void _h () {
  }

  void _v() {
  }




  //// fin de la clase
}
