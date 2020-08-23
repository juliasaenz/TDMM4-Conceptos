class Vanidad {
  // usuario
  int x[] = new int [4];
  int y[] = new int [4];
  float tam = 60;
  int zoom = 60;
  int cual = 0;
  int d_ = 100;
  int cant = 4;
  boolean cerca = false;
  // posicion de los npc
  float x0[] = new float[4];
  float y0[] = new float[4];
  float dir1[] = new float [4];
  float dir1Y[] = new float [4];
  // imagen
  PImage imagenP[];
  PImage imagenA[];
  PImage splash[];
  color paletaA[];
  //timer
  int time;
  int espera = 500;
  //GENERAL
  float genX = 100;
  float genY = 100;
  float genDista;
  boolean elegido = false;


  Vanidad(PImage[] p, PImage[] a, PImage[] s) {
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
    x[0] = -30;
    y[0] = -30;
    x[1] = -30;
    y[1] = 30;
    x[2] = 30;
    y[2] = 30;
    x[3] = 30;
    y[3] = -30;

    //posiciones de otros
    x0[0] = 469;
    y0[0] = 134;
    x0[1] = 200;
    y0[1] = 335;
    x0[2] = 120;
    y0[2] = 300;
    x0[3] = 434;
    y0[3] = 230;

    int num[] = {-1, 1};
    for (int i = 0; i < 4; i++) {
      dir1[i] = num[int(random(num.length))];  
      dir1Y[i] = num[int(random(num.length))];
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
    pushStyle();
    pushMatrix();
    translate(x_, y_);
    beginShape();  
    if (cerca) {
      tint(paletaA[cual]);
      texture(imagenA[cual]);
    } else {
      tint(#00D4E9);
      texture(imagenP[cual]);
    }
    vertex(x[0], y[0], 0, 0);
    vertex(x[1], y[1], imagenA[cual].width, 0);
    vertex(x[2], y[2], imagenA[cual].width, imagenA[cual].height);
    vertex(x[3], y[3], 0, imagenA[cual].height);
    endShape();
    popMatrix();
    popStyle();
    if (!elegido) {
      pushStyle();
      tint(#00D4E9);
      imageMode(CENTER);
      image(splash[cual], x_, y_);
      popStyle();
    }
  }

  //NPC
  void _otro(float a, float b) {
    pushMatrix();
    pushStyle();
    tint(#00D4E9);
    imageMode(CENTER);
    image(imagenP[cual], a, b);
    popStyle();
    popMatrix();
  }

  void interaccion() {
    genDista = dist(mouseX, mouseY, genX, genY);
    if (elegido) {
      //noCursor();
      genX = mouseX;
      genY = mouseY;
    } else {
      cursor();
    }
    cambio();
    _vanidoso();
    _usuario(genX, genY);
    _otro(x0[0], y0[0]);
    _otro(x0[1], y0[1]);
    _otro(x0[2], y0[2]);
    _otro(x0[3], y0[3]);

    for (int i=0; i<4; i++) {
      x0[i] = x0[i] + (1*dir1[i]);
      y0[i] = y0[i] + (1*dir1Y[i]);
      if (x0[i] > width-tam/2 || x0[i] < tam/2) {
        dir1[i] = dir1[i] * -1;
      }
      if (y0[i] > height-tam/2 || y0[i] < tam/2) {
        dir1Y[i] = dir1Y[i] * -1;
      }
    }
  }

  //VANIDAD
  void _vanidoso() {
    float dista0 = dist(genX, genY, x0[0], y0[0]);
    float dista1 = dist(genX, genY, x0[1], y0[1]);
    float dista2 = dist(genX, genY, x0[2], y0[2]);
    float dista3 = dist(genX, genY, x0[3], y0[3]);
    //println(dista0, dista1, dista2, dista3);
    if ((dista0 <d_ || dista1 <d_ || dista2 <d_ || dista3<d_)) {
      cerca = true;
      espera = 150;
      if ( x[0] >= -60) {
        x[0]--;
        y[0]--;
        x[1]--;
        y[1]++;
        x[2]++;
        y[2]++;
        x[3]++;
        y[3]--;
      }
    } else if ((dista0 >d_ || dista1 >d_ || dista2 >d_ || dista3>d_)) {
      cerca = false;
      espera = 500;
      if ( x[0] <= -30) {
        x[0]++;
        y[0]++;
        x[1]++;
        y[1]--;
        x[2]--;
        y[2]--;
        x[3]--;
        y[3]++;
      }
    }
  }


  //FIN DE CLASE
}
