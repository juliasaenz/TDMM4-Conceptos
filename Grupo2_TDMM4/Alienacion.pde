class Alienacion {
  // usuario
  float tam = 60;
  int cual = 0;
  int cant = 4;
  boolean cerca = false;
  // posicion de los npc
  float x0[] = new float[4];
  float y0[] = new float[4];
  float dirX[] = new float[4];
  float dirY[] = new float[4];
  // imagen
  PImage imagenP[];
  PImage imagenA[];
  PImage splash[];
  color paletaA[];
  //timer
  int time;
  int espera = 500;
  //GENERAL
  float genX = 80;
  float genY = height/2;
  float genDista;
  boolean elegido = false;

  float dir = 1;
  boolean actualizar = false;


  Alienacion(PImage[] p, PImage[] a, PImage[] s) {
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

    //
    noStroke();

    //posiciones de otros
    x0[0] = 469;
    y0[0] = 334;
    x0[1] = 400;
    y0[1] = 335;
    x0[2] = 520;
    y0[2] = 400;
    x0[3] = 434;
    y0[3] = 430;

    //direcciones de otros
    int num[] = {-1, 1};
    for (int i = 0; i < 4; i++) {
      dirX[i] = num[int(random(num.length))];  
      dirY[i] = num[int(random(num.length))];
    }
  }


  //CAMBIO DE IMAGEN
  void cambio() {
    if (millis() - time >= espera) {
      cual = int(random(cant));
      time = millis();//also update the stored time
    }
  }

  //USUARIO
  void _usuario(float x_, float y_) {
    cursor();
    imageMode(CENTER);

    if (!elegido) { //No es elegido
      imageMode(CENTER);
      if ((x_ < (width/2)/2)) {
        tint(#0033ca);
        image(imagenA[cual], x_, y_);
      } else if (x_ < (width/2)) {
        if (time % 2 == 0) {
          tint(#67d7ad);
          image(imagenA[cual], x_, y_);
        } else {
          actualizar = false;
          tint(#67d7ad);
          image(imagenP[cual], x_, y_);
        }
      } else {
        actualizar = true;
        tint(#faec6a);
        image(imagenP[cual], x_, y_);
      }

      image(splash[cual], x_, y_);
    } else { //Es elegido

      if ((x_ < (width/6))) {
        tint(#0033ca);
        image(imagenA[cual], x_, y_);
      } else if (x_ < (width/2-tam/2)) {
        if (time % 2 == 0) {
          tint(#67d7ad);
          image(imagenA[cual], x_, y_);
        } else {
          tint(#67d7ad);
          image(imagenP[cual], x_, y_);
        }
      } else {
        tint(#faec6a);        
        image(imagenP[cual], x_, y_);
      }
    }
  }

  //NPC
  void _otro(float a, float b) {
    pushStyle();
    tint(#faec6a);
    imageMode(CENTER);
    image(imagenP[cual], a, b);
    popStyle();
  }

  void interaccion() {
    // selección
    genDista = dist(mouseX, mouseY, genX, genY);
    if (elegido) {
      //noCursor();
      genX = mouseX;
      genY = mouseY;
    } 

    cambio();
    _movimiento();
    _usuario(genX, genY);
    if ((genX >= width/2) && (actualizar)) {
      genX = genX + 1*dir;
      genY = genY + 1*dir;
      println("x = ", genX);
      if (genX < (width/2) || genX > (width-tam/2) || genY < tam/2 || genY > height-tam/2 ) {
        dir = dir * -1;
      }
    }


    _otro(x0[0], y0[0]);
    _otro(x0[1], y0[1]);
    _otro(x0[2], y0[2]);
    _otro(x0[3], y0[3]);
  }



  void reseteo() {
    cerca = false;
    genX = 80;
    genY = height/2;
  }

  void _movimiento() {
    for (int i=0; i<4; i++) {
      x0[i] = x0[i]+  1*dirX[i];
      y0[i] = y0[i]+  1*dirY[i];

      if ( x0[i] > width-tam/2 || x0[i] < width/2) {
        dirX[i] = dirX[i] * -1;
      }
      if ( y0[i] > height-tam/2 || y0[i] < tam/2) {
        dirY[i] = dirY[i] * -1;
      }
    }
  }
  //FIN DE CLASE
}
