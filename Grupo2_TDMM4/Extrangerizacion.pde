class Extrangerizacion {
  // usuario
  float x = 0;
  float y = 0;
  float tam = 60;
  float dir = 1;
  boolean izquierda = true;
  // otro1
  float x1 = 0;
  float y1 = 0;
  float dir1[] = new float [4];
  // otro 2
  float x2 = 0;
  float y2 = 0;
  // imagen
  PImage imagenP[];
  PImage splash[];
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
  float xH[] = new float [4];
  float xV[] = new float [4];
  float dir2[] = new float [4];
  float pos = 0;

  Extrangerizacion(PImage[] p, PImage[] s) {
    imagenP = p;
    splash = s;

    // PALETA AGRESIVA
    paletaA = new color[cant];
    paletaA[0] = #FF001B;
    paletaA[1] = #0033CA;
    paletaA[2] = #00DD1F;
    paletaA[3] = #BA0000;

    // timer
    time = millis();
    int num[] = {-1, 1};
    for (int i= 0; i<4; i++) {
      xH[i] = random(tam, width/2-tam);
      xV[i] = random(tam, height-tam);
      dir1[i] = num[int(random(num.length))];
      dir2[i] = num[int(random(num.length))];
    }
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

  void _usuario(float a, float b) {
    pushMatrix();
    translate(a, b);
    tint(#00D4E9);
    imageMode(CENTER);
    image(imagenP[cual2], x, y);
    if (elegido) {
      if (mouseX >= width/2+(tam*2)) {
        izquierda = false;
      } else {
        izquierda = true;
      }
    }
    if (!elegido) {
      pushStyle();
      tint(#00D4E9);
      imageMode(CENTER);
      image(splash[cual3], x, y);
      popStyle();
      if (izquierda) {
      } else {
      }
    }
    popMatrix();
  }

  void _usuario_(float a, float b) {
    pushMatrix();
    tint(#00D4E9);
    imageMode(CENTER);
    image(imagenP[cual2], a, b);
    if (izquierda) {
      //_h();
    } else {
      //_v();
    }
    if (elegido) {
      if (mouseX >= width/2+tam) {
        izquierda = false;
      } else{
        izquierda = true;
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

  void _otro_izq_(float a, float b) {
    pushMatrix();
    tint(#42B488);
    imageMode(CENTER);
    image(imagenP[cual], a, b);
    popMatrix();
  }

  void _otro_der_(float a, float b) {
    pushMatrix();
    tint(#FAE950);
    imageMode(CENTER);
    image(imagenP[cual], a, b);
    popMatrix();
  }

  void interaccion() {
    genDista = dist(mouseX, mouseY, genX, genY);
    if (elegido) {
      if (izquierda) {
        genX = mouseX;
        genY = pos;
      } else {
        genY = mouseY;
        genX = pos;
      }
    } else {
      if (izquierda) {
        genX = lerp(genX,xH[3],0.5);
      } else {
        genY = lerp(genY,xV[3],0.05);
      }
      cursor();
    }
    //MOVIMIENTO HORIZONTAL
    for (int i = 0; i <4; i++) {
      xH[i] = xH[i] + (1*dir1[i]); 
      if (xH[i] > width/2-tam/2 || xH[i] < tam/2) {
        dir1[i] = dir1[i] * -1;
      }
      xV[i] = xV[i] + (1*dir2[i]); 
      if (xV[i] > height-tam/2 || xV[i] < tam/2) {
        dir2[i] = dir2[i] * -1;
      }
    }
    _otro_izq_(xH[0], width/6);
    _otro_izq_(xH[1], (width/6)*2);
    _otro_izq_(xH[2], (width/6)*3);
    _otro_izq_(xH[3], (width/6)*4);

    //MOVIMIENTO VERTICAL

    _otro_der_((width/2), xV[0]);
    _otro_der_((width/10)*7, xV[1]);
    _otro_der_((width/10)*8, xV[2]);
    _otro_der_((width/10)*9, xV[3]);
    cambio();
    _usuario_(genX, genY);

    if (pmouseX > width/2+tam && mouseX < width/2+tam) {
      pos = mouseY;
    } 
    if (pmouseX < width/2+tam && mouseX > width/2+tam) {
      pos = mouseX;
    }
  }








  //// fin de la clase
}
