class Desigualdad {
  //figuras
  float x[] = new float[5];
  float y[] = new float[5];
  boolean elegido[] = new boolean [5];
  int elegidoActual;
  //look
  int tam = 60;
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
  //
  PImage imagenP2[];
  PImage imagenP3[];
  PImage imagenA2[];
  PImage imagenA3[];
  PImage imagenP4[];
  // movimiento
  float velP = 1;
  float dirX[] = new float[5];
  float dirY[] = new float[5];
  float velR = 2;
  float posMouseX;
  float posMouseY;
  boolean estoyAgresiva=false;

  Desigualdad(PImage[] p, PImage[] a, PImage[] s) {
    imagenP = p;
    imagenA = a;
    splash = s;

    //IMAGENES EXTRAS
    imagenP2 = new PImage [4];
    imagenP2[0] = loadImage("mancha redonda.png");
    imagenP2[1] = loadImage("mancha redonda2.png");
    imagenP2[2] = loadImage("mancha redonda3.png");
    imagenP2[3] = loadImage("mancha redonda4.png");
    imagenP3 = new PImage [4];
    imagenP3[0] = loadImage("mancha redonda.png");
    imagenP3[1] = loadImage("mancha redonda2.png");
    imagenP3[2] = loadImage("mancha redonda3.png");
    imagenP3[3] = loadImage("mancha redonda4.png");
    imagenP4 = new PImage [4];
    imagenP4[0] = loadImage("mancha redonda.png");
    imagenP4[1] = loadImage("mancha redonda2.png");
    imagenP4[2] = loadImage("mancha redonda3.png");
    imagenP4[3] = loadImage("mancha redonda4.png");
    imagenA2 = new PImage [4];
    imagenA2[0] = loadImage("mancha agresiva.png");
    imagenA2[1] = loadImage("mancha agresiva2.png");
    imagenA2[2] = loadImage("mancha agresiva3.png");
    imagenA2[3] = loadImage("mancha agresiva4.png");
    imagenA3 = new PImage [4];
    imagenA3[0] = loadImage("mancha agresiva.png");
    imagenA3[1] = loadImage("mancha agresiva2.png");
    imagenA3[2] = loadImage("mancha agresiva3.png");
    imagenA3[3] = loadImage("mancha agresiva4.png");
    for (int i=0; i<4; i++) {
      imagenP2[i].filter( INVERT );
      imagenP2[i].resize(30, 30);
      imagenP3[i].filter( INVERT );
      imagenP3[i].resize(40, 40);
      imagenA2[i].filter( INVERT );
      imagenA2[i].resize(80, 80);
      imagenA3[i].filter( INVERT );
      imagenA3[i].resize(160, 160);
      imagenP4[i].filter( INVERT );
      imagenP4[i].resize(160, 160);
    }

    // PALETA AGRESIVA
    paletaA = new color[cant];
    paletaA[0] = #FF001B;
    paletaA[1] = #0033CA;
    paletaA[2] = #00DD1F;
    paletaA[3] = #BA0000;

    // timer
    time = millis();

    //pos iniciales
    for (int i=0; i<4; i++) {
      x[i] = random(tam, width-tam); 
      y[i] = random(height/2 + 110, height-tam);
    }
    x[4] = 100; 
    y[4] = 200;

    //
    velP = 1;
    velR = 1;
    int num[] = {-1, 1};
    for (int i = 0; i < 5; i++) {
      dirX[i] = num[int(random(num.length))];  
      dirY[i] = num[int(random(num.length))];
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

  void _pobre(float x_, float y_, boolean elegido_, int cualSoy) {
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    tint(#FAE950);
    if (!elegido_) {
      image(splash[cual], x_, y_);
    }

    //tamaño
    if ( (y[cualSoy] <=320)) {
      tint(#f3a111);
      image(imagenP[cual], x_, y_);
    }
    if ( y[cualSoy] >= 370) {
      tint(#FAE950);
      image(imagenP2[cual], x_, y_);
    } else if (y[cualSoy] >= 320) {
      tint(#f3a111);
      image(imagenP3[cual], x_, y_);
    } 

    popStyle();
    popMatrix();
  }

  void _rico(float x_, float y_, boolean elegido_) {
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    tint(paletaA[0]);

    //tamaño
    for (int i=0; i<4; i++) {

      if (y[i] <= 320) {
        estoyAgresiva=true;
        x[4] = lerp(x[4], x[i], 0.05);
        //x[4] = x[i];
        y[4] = lerp(y[4], y[i] - 110, 0.05);
        y[4] = y[i] - 110;
      }
    }
    if (!estoyAgresiva) {
      image(imagenP4[cual], x_, y_);
    } else {         
      image(imagenA3[cual], x_, y_);
    }

    estoyAgresiva=false;

    popStyle();
    popMatrix();
  }

  void interaccion() {
    posMouseX=mouseX;
    posMouseY=mouseY;
    for (int i=0; i<4; i++) {
      if (elegido[i]) {
        //noCursor();
        if ( posMouseY <=height/2 - 20) {
          x[i] = mouseX;
          y[i] = height/2 - 20;
        } else {
          x[i] = mouseX;
          y[i] = mouseY;
        }
      } else {
        // elegido[i] = false;
        cursor();
        if (y[i] <= height/2 + 100) {
          y[i] = y[i] + 0.5;
        } else {
          x[i]= x[i] + velP*dirX[i];
          y[i]= y[i] + velP*dirY[i];
          if (x[i] >= width || x[i] <= tam/2) {
            dirX[i] = dirX[i]*-1;
          }
          if (y[i] >= height || y[i] <= height/2 + 100) {
            dirY[i] = dirY[i]*-1;
          }
        }
      }
    }

    //ESTO ES TODO LO QUE INCUMBE AL SEÑOR PODEROSO

    if (elegido[4]) {
      //noCursor();
      x[4] = mouseX;
      y[4] = mouseY;
    } else {
      cursor();
      //print("help ", dirX[i]);
      x[4]= x[4] + velR*dirX[4];
      y[4]= y[4] + velR*dirY[4];
      if (x[4] >= width -50 || x[4] <= tam/2) {
        dirX[4] = dirX[4]*-1;
      }
      if (y[4] >= height/2 || y[4] <= tam/2) {
        dirY[4] = dirY[4]*-1;
      }
    }

    cambio();
    _pobre(x[0], y[0], elegido[0], 0);
    _pobre(x[1], y[1], elegido[1], 1);
    _pobre(x[2], y[2], elegido[2], 2);
    _pobre(x[3], y[3], elegido[3], 3);
    _rico(x[4], y[4], elegido[4]);
  }

  void seleccion() {
    float minDista = 50;
    for (int i=0; i<4; i++) {
      genDista = dist(mouseX, mouseY, x[i], y[i]);
      if (genDista < minDista) {
        minDista = genDista;
        elegidoActual = i;
      }
    }
    if (minDista < 49) {
      elegido[elegidoActual] = !elegido[elegidoActual];
    }
  }


  //// fin de la clase
}
